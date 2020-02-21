Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5ACC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326B720578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274174;
	bh=+y4TUkxDaRyUqP3FAdHw8MSgA1dwvEyfRjGmLs+5+nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmzifu+f8NRb19VlsnVWp0uy51dSdKpI5d2Ye2edmXymwwP9/zbVraobSEOKd0FH/
	 LqeX9J5/RPI85ydklfcKPxYHq3CftyeYPDwPicdSRk52gWOyqenNncsQXMaSghfRwa
	 7T8wZKU6sW1ildKnDx51OdNXhPuO4dDdibxHcncY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbgBUIgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731966AbgBUIGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:06:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A9120722;
        Fri, 21 Feb 2020 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272396;
        bh=+y4TUkxDaRyUqP3FAdHw8MSgA1dwvEyfRjGmLs+5+nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKvBH8UphmeiM7uFYKu0qGplZDVu8ZAKJCGcoJGro0gjn3GdE/Z3NPA1DD4pfDmlC
         a6HkbNf0Nux681b10qHZtTONLOv22A+xY3TEcmWOn9DSNruKo9PyeGRzamF5QRt/XL
         m8q+AqwVSv/tPXZYmaIdMxCCZTA7IcQOVBRFG6x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 127/344] reiserfs: Fix spurious unlock in reiserfs_fill_super() error handling
Date:   Fri, 21 Feb 2020 08:38:46 +0100
Message-Id: <20200221072400.397314867@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 4d5c1adaf893b8aa52525d2b81995e949bcb3239 ]

When we fail to allocate string for journal device name we jump to
'error' label which tries to unlock reiserfs write lock which is not
held. Jump to 'error_unlocked' instead.

Fixes: f32485be8397 ("reiserfs: delay reiserfs lock until journal initialization")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index d127af64283e3..a6bce5b1fb1dc 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1948,7 +1948,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		if (!sbi->s_jdev) {
 			SWARN(silent, s, "", "Cannot allocate memory for "
 				"journal device name");
-			goto error;
+			goto error_unlocked;
 		}
 	}
 #ifdef CONFIG_QUOTA
-- 
2.20.1



