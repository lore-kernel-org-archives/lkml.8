Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC65C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8C82469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bCPsH6yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgB0Xbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:31:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36580 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Xbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:31:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so460595pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vTq1zaq3w8Ey6IwphJFu7diB+CHCXa5rJo8d7um3eyc=;
        b=bCPsH6yEV8hJb/Ba4aHx8v1uGGmP02xuAjwb//xfBW6ZzW/wROl8Exi/EqQRUIGIaM
         yLJbkdDCS6AruH8qOLFd+4NhLYC7IBZCOt/NaGUE8TnXztnq8HHfS4a2HD0zNDa0QNax
         RZ+0D8OY/3StZCHhuEgIpXCh+/Q9jtDL4VVD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vTq1zaq3w8Ey6IwphJFu7diB+CHCXa5rJo8d7um3eyc=;
        b=FquwQPQ1jHT3nxicgMtcJJ2ESiXKMRbrPNXdj+XgQQnYvlhoExeGzl0vEa6LCkGRWz
         zkwswY7ZGZXY4jMywm8ZkjfwtbK+k4/wehgXJEqci2gD2BzYWcIpI6sn7gEeD1JkQ8/S
         BYvzlLUr257hWhyQIn2djp/FqUuM9cln6KUeAjHEnnJqYnwL7MskZcmnO2BbdnNY3U9w
         Pek4dcRKkAI2SpSA2B4Jp3UnTZfFeTaPntD6v8YJNF4WevPaIEAdRsu8QQpfltHK12l2
         goLgDZ4Ir0P7T68qiPcD5Q5qoeEA587lXFBxGZ/5av67j+ZcYaAdO2NKvfT6Z+QZymhX
         Gbwg==
X-Gm-Message-State: APjAAAXqQUhfBoKTSkcPlvsDmOsUX4ljLTdNT6Nbm6S2wrBNSiC4yLWa
        EjqbbikfTFGV6GoC/qXO4/gSJA==
X-Google-Smtp-Source: APXvYqwZMfxDqYwISreaoCB9cTBcDytS+qwBtP1hvQSul6wGP/JiK9bR2BH7Z7Dc4SwsinKmQyGJGw==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr1094642plp.251.1582846305185;
        Thu, 27 Feb 2020 15:31:45 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d69sm9223820pfd.72.2020.02.27.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:31:44 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] exec: remove comparision of variable i_size of type loff_t against SIZE_MAX
Date:   Thu, 27 Feb 2020 15:31:33 -0800
Message-Id: <20200227233133.10383-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparision of (i_size > SIZE_MAX).
i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index db17be51b112..16c229752f74 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -919,7 +919,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+	if (max_size > 0 && i_size > max_size) {
 		ret = -EFBIG;
 		goto out;
 	}
-- 
2.17.1

