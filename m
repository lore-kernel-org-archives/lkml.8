Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE90C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD4720842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341815;
	bh=jy5JOodwvlwm7Ucf+eZv1S4++d87MwsN5hfxCWrT4X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=faHmvdhFK1RWVY5LuekRKZs8dZLXCg1GjTbOkVV01EullbO+cIhb6HY4eLeI7Rr35
	 X0LXsikh+JyD791ZazYUm/NksduWqq5tiXJ8RRPyeta6CPuTl8VOcbQgTrB2TY+SxS
	 Dzjh0ilDSMw24tW8ePAxpYrMDJbS0ZoCZl8u2gVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBJMfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgBJMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077FF214DB;
        Mon, 10 Feb 2020 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338102;
        bh=jy5JOodwvlwm7Ucf+eZv1S4++d87MwsN5hfxCWrT4X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSbDyinGB93lgV2wgKWp2t42QI6MxgGfFWfKltOIG9OlfTCLqF9jV6qLO5Bk10LNl
         JwesnzWVdKtVSMYCT2nUJBgmylMyX2K4UfqRZpQXGV7tu34YQblnaEz52soFhvgwfY
         v2l0h2LbhtDguXWDOz5f4MgUPi35P7S0GEuLYFjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Gjenero <boris.gjenero@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/195] ovl: fix lseek overflow on 32bit
Date:   Mon, 10 Feb 2020 04:31:00 -0800
Message-Id: <20200210122305.999066195@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a4ac9d45c0cd14a2adc872186431c79804b77dbf ]

ovl_lseek() is using ssize_t to return the value from vfs_llseek().  On a
32-bit kernel ssize_t is a 32-bit signed int, which overflows above 2 GB.

Assign the return value of vfs_llseek() to loff_t to fix this.

Reported-by: Boris Gjenero <boris.gjenero@gmail.com>
Fixes: 9e46b840c705 ("ovl: support stacked SEEK_HOLE/SEEK_DATA")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 0bd276e4ccbee..fa5ac5de807c5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -149,7 +149,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
-	ssize_t ret;
+	loff_t ret;
 
 	/*
 	 * The two special cases below do not need to involve real fs,
-- 
2.20.1



