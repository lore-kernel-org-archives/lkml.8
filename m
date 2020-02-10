Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F361C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3542080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341411;
	bh=9dOv/7AJnUDYJu5R96yrbsT6yC+tIg/gjrVajwFjjis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UaeKrwp+5s1LptZngsh/7QxG3z9g0aNBGmUDZgWqe//Dkvdx0YQkxROAMR/uqGbAH
	 w60NKBuIF6+Mdajtpq8Dq7YJpD3RcaJ2s7goT1nP9p4VD5TZvubP6g8bho0NjNsCeo
	 BrMOGuyReF7wuG51LfN1GvM1CZwvh5TfdwqDHV/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgBJNaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgBJMgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:15 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1653C215A4;
        Mon, 10 Feb 2020 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338175;
        bh=9dOv/7AJnUDYJu5R96yrbsT6yC+tIg/gjrVajwFjjis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rl2EjrXDw5SqFW5ym4OSnyttqUqTfuWQCBSFQpqH415uNUSmSPl+2aKdk7NfzG/N6
         UCmyQzK/Xe6YR3hzA0hXY8M4UmFBK8ktQhJGqNRzQ0GeruW3OBJJM/g0cqv2vCCkzo
         GzQ7jbZppJLGYyIrSaDzp9FrZixaR4JIv5QEd+gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 161/195] nfsd: Return the correct number of bytes written to the file
Date:   Mon, 10 Feb 2020 04:33:39 -0800
Message-Id: <20200210122321.005028469@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 09a80f2aef06b7c86143f5c14efd3485e0d2c139 upstream.

We must allow for the fact that iov_iter_write() could have returned
a short write (e.g. if there was an ENOSPC issue).

Fixes: d890be159a71 "nfsd: Add I/O trace points in the NFSv4 write path"
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1016,6 +1016,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0)
 		goto out_nfserr;
+	*cnt = host_err;
 	nfsdstats.io_write += *cnt;
 	fsnotify_modify(file);
 


