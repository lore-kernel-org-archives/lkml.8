Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C830FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC20205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443598;
	bh=qj738WDBC0aPmVgUGzbHzuFqg5rI+Vr66qfUowkVNMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rchqyHpJgInDwioZGYnu4gREV+nRc+xvrxpv59VDm810fuqlpV38w6i7VAVmepEOr
	 H3xnQ/0dqVUSbPKqp8m3b/mX5BfgpGjiO8waWHADBrZul7SSKIa8ObLgX5SsjGEVbY
	 T4aT+A3Nsdkpuc914+0hZHl45L+Oc7c29TVZ3RLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgCQLNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgCQLNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E05E205ED;
        Tue, 17 Mar 2020 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443591;
        bh=qj738WDBC0aPmVgUGzbHzuFqg5rI+Vr66qfUowkVNMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1i2hrSC8IgZT72ehX946RDJ8d1f1FaxtZB9HGx/eB5YXQAd6nC4moXq+NfqAuR/q
         oAaYgMf9r8jZTqTHrOS1u/G6PKEMQJP99JjpV8TyYZnAmQWr8+CB18C/9IXxZXrSTo
         scckVLoWpIJyd6B1FhgUE5EDqaWrQUw4aIwQlw8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@kernel.org
Subject: [PATCH 5.5 097/151] gfs2_atomic_open(): fix O_EXCL|O_CREAT handling on cold dcache
Date:   Tue, 17 Mar 2020 11:55:07 +0100
Message-Id: <20200317103333.348437132@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 21039132650281de06a169cbe8a0f7e5c578fd8b upstream.

with the way fs/namei.c:do_last() had been done, ->atomic_open()
instances needed to recognize the case when existing file got
found with O_EXCL|O_CREAT, either by falling back to finish_no_open()
or failing themselves.  gfs2 one didn't.

Fixes: 6d4ade986f9c (GFS2: Add atomic_open support)
Cc: stable@kernel.org # v3.11
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1248,7 +1248,7 @@ static int gfs2_atomic_open(struct inode
 		if (!(file->f_mode & FMODE_OPENED))
 			return finish_no_open(file, d);
 		dput(d);
-		return 0;
+		return excl && (flags & O_CREAT) ? -EEXIST : 0;
 	}
 
 	BUG_ON(d != NULL);


