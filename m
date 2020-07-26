Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF36C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66116204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6tMLNPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgGZFU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 01:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgGZFU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 01:20:57 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2DC0619D2;
        Sat, 25 Jul 2020 22:20:56 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so1108589qvw.1;
        Sat, 25 Jul 2020 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=10G3Z7zc2hpC9xFkXBhwCWtTHJ66WyVHYUrUeWXwqKc=;
        b=M6tMLNPmHDwRPfUV/IcFUmlGGdPnUDIJGtLFqruOJH7NnHWLTk1cw4HxXlnFBwh4K1
         g/yT+XHVjAcliIlb83NW843FatIudzqZ5kOFuTdbe6jF3auvR+aYkC6qPoliSDXoaxyk
         Y1DS0Mg1uPEVk5hJae6iSEWZyLH7GbB9YsO+zYldksunAUV8viyeTbjp3ZtqyCn0r2FY
         BZpHH5axCbqggTHuvzQQAYi1mC9PQ2SDVJOU4eVT8WSQbDoeqVnaVe7jC2kUBgkfLCj+
         /o5Z+OmSCmovhr/qByM3tPIiWDoMKEvhivDScza+wYRgayCxMscK5i4bAN/F5O+KjAT7
         zwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=10G3Z7zc2hpC9xFkXBhwCWtTHJ66WyVHYUrUeWXwqKc=;
        b=U7kLkIi+Y+XnW8xYfDWEurlN9ckpafeJ63jaop2xqWK4W1KZHJyOIPKQdL8SF6yyg8
         nhRzWbpYNBBKO0egNJv22bHoWsDLAxX0bq99RcgUlZb6UMMZ+Qt8YI/JqthUGKuxWiYN
         F87qEAimHHOKJmohm95z397EueoK1O2hegvMduJPKGmrnAWEKDEMNfkQpbpePBR10AeC
         CJpKHjQ5Kfs1TPsESU2tMTE4GdkyZbl7oGSDUqOpVBUiMIy9nUkWZWtwfHwAkZYBqONB
         ip3Z6R8lTEbXYzzReOskWbrJwZhgq1nZQcQv7oN3i5PNFUM+dSSvSAv8W2xfkFvMYsBg
         F47w==
X-Gm-Message-State: AOAM530y6daCu8hvsR/uq050GxCiS5pQQJwgy+hasI1d2ghYsLVABvqj
        SkxIAOEvyQh3UMqEqyH2aDg=
X-Google-Smtp-Source: ABdhPJwNOivgw43Vn9IA5nLTrZOB3NaVskEB1shd7sPm43WXFeLNIjFckNZ1t5DJKuOlDAzRNs9P1g==
X-Received: by 2002:a0c:ffc6:: with SMTP id h6mr12098268qvv.251.1595740856028;
        Sat, 25 Jul 2020 22:20:56 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:159c:94c1:6e96:1b7e])
        by smtp.googlemail.com with ESMTPSA id t65sm13364129qkf.119.2020.07.25.22.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 22:20:55 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [video/fbdev] mbxfb_remove: fix null pointer dereference
Date:   Sun, 26 Jul 2020 01:20:45 -0400
Message-Id: <20200726052047.9856-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mbxfb_debugfs_remove() accesses fbi->par without NULL check,
hence do the NULL check in the caller mbxfb_remove().

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/video/fbdev/mbx/mbxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 6dc287c819cb..515c0cda1994 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -1012,11 +1012,10 @@ static int mbxfb_remove(struct platform_device *dev)
 
 	write_reg_dly(SYSRST_RST, SYSRST);
 
-	mbxfb_debugfs_remove(fbi);
-
 	if (fbi) {
 		struct mbxfb_info *mfbi = fbi->par;
 
+		mbxfb_debugfs_remove(fbi);
 		unregister_framebuffer(fbi);
 		if (mfbi) {
 			if (mfbi->platform_remove)
-- 
2.17.1

