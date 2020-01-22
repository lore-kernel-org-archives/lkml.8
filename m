Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D634C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED8D24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685659;
	bh=lNwvgoE/PBtC0RiZuyLt2rKFKfMXnJYmrTD/qeV7Iio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EzfLa4mDro2k6xuxDf6px/ON7Q6uNcrJOrEnCc4qseGSi3ZK6BGrgQhXnU2L6WHtJ
	 U+8926AKwTPvVxsRBpN2lTNEOha6X3b9h8wPe3w/qtPvcrnow5+FW5BsnqGNIKLn6m
	 5SX08aHNHY6kdLpwy5VJ5cSQPYBOZArmunDJBwas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgAVJeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgAVJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0CF24673;
        Wed, 22 Jan 2020 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685650;
        bh=lNwvgoE/PBtC0RiZuyLt2rKFKfMXnJYmrTD/qeV7Iio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1H5pLXvJMdeupj3q21MliQeUMthHNlOu81qTYORnNxTf+uKftNlf0lBgK+wf9/LM
         q0W13BbKP4lLZvD268/TVRtx6jD1/uARw1X9JDJY5yvZDMpK8smtZbAtNbZrAEL9f2
         acyUfXtdrqBh/8AYS6+9WGGCM2P7O+AEhtdkr1Qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 24/97] cifs: Adjust indentation in smb2_open_file
Date:   Wed, 22 Jan 2020 10:28:28 +0100
Message-Id: <20200122092800.048406188@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 7935799e041ae10d380d04ea23868240f082bd11 upstream.

Clang warns:

../fs/cifs/smb2file.c:70:3: warning: misleading indentation; statement
is not part of the previous 'if' [-Wmisleading-indentation]
         if (oparms->tcon->use_resilient) {
         ^
../fs/cifs/smb2file.c:66:2: note: previous statement is here
        if (rc)
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 592fafe644bf ("Add resilienthandles mount parm")
Link: https://github.com/ClangBuiltLinux/linux/issues/826
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -69,7 +69,7 @@ smb2_open_file(const unsigned int xid, s
 		goto out;
 
 
-	 if (oparms->tcon->use_resilient) {
+	if (oparms->tcon->use_resilient) {
 		nr_ioctl_req.Timeout = 0; /* use server default (120 seconds) */
 		nr_ioctl_req.Reserved = 0;
 		rc = SMB2_ioctl(xid, oparms->tcon, fid->persistent_fid,


