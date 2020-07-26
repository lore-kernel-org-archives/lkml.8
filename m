Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54224C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A25E2076A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEa1dPIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGZFHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 01:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgGZFHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 01:07:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A088BC0619D2;
        Sat, 25 Jul 2020 22:07:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b25so9919550qto.2;
        Sat, 25 Jul 2020 22:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=4fBbTXl0es9SI3RqVvzZLJMaeaB5Sye+SLS57bBCWEQ=;
        b=gEa1dPISUTZ4vnR9iujU0mYuDOKP6FYT5i36LpU2njvmiEJJuY96e28Jcn7jXLQLuv
         FU+1J6h4PvCEZlz/HYlsevsMABM2Ob/QQq8OSBC3Oj+rSOSl2Tfx6u6hMWWa4lr7coFV
         E5UgQLcBPJ2VCIbs+F5uiAPo0dxZtOQDQDccDP9DKlgRDrfOmls2lCJ/Gu8OU/sC5gO/
         43jSFsQRrg2RxQUolhHvvoKN0ZBMrYO4EBQUnlD45ga3ZurPYXE/UzdCV2vy4nmPDv5e
         VTwtbdGAif7CCsrBp0FSagPrxQv8cMjCy8mHPVmyD0DPDEMtVQrqdmgHqEobN+xGQ7QB
         Uu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4fBbTXl0es9SI3RqVvzZLJMaeaB5Sye+SLS57bBCWEQ=;
        b=XqcURIVPtXsAZQzyUFn8q4s9toOGzoa4U4Hf8yreIctKfqWrj9DCJPgPIp+7ObiU4o
         jXvBTANP9FZO/zdi5bak0/VOhai61HovPRcoNjLoCraspkQdE5XDdyoZS03SZzh6QI1y
         d/Sk2Mw6jD5cEzBLKOrbXCnvebRP+yQmMj8oBaziEOoMdT0wGbyhJIMOtm2dAK5/6CEp
         f8de4gnV8IvDQcOeICbfe6ZEM2yz0eygbo5ZV6FzFoPgYd1Bb5HS9JKW6ALSb4CR1Re0
         Ffpdwf8rgvYR7md4/qEKjlKpKtkzL2gGGFyk0LQy5TCDOq/3FPHjmNJoHQroxkq2v9sp
         SOfw==
X-Gm-Message-State: AOAM531URVwzD95Fl9ufOw/xwv7Gocglo7BUzNHAi1UfSvnXiKC+H/mx
        yjSKTWsgRPQdLfZSQNmJ9vMZVioWwJ9pkA==
X-Google-Smtp-Source: ABdhPJzVLYO1jw5cwaoddiKoAy8nGvr24KNbXCFB88quHOGR8Gv8ZnKamOxuPgsfretq9pBCjof/XQ==
X-Received: by 2002:aed:3947:: with SMTP id l65mr3946373qte.374.1595740042255;
        Sat, 25 Jul 2020 22:07:22 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:159c:94c1:6e96:1b7e])
        by smtp.googlemail.com with ESMTPSA id t127sm13031881qkc.100.2020.07.25.22.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 22:07:21 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Nathan Chancellor <natechancellor@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [video/fbdev] fb_flashcursor: Remove redundant null check
Date:   Sun, 26 Jul 2020 01:07:00 -0400
Message-Id: <20200726050713.9461-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ops cannot be NULL as its being accessed later without
checks. Remove the redundant NULL check. 

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e2a490c5ae08..9551f40c6d14 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -401,7 +401,7 @@ static void fb_flashcursor(struct work_struct *work)
 	if (ret == 0)
 		return;
 
-	if (ops && ops->currcon != -1)
+	if (ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !con_is_visible(vc) ||
-- 
2.17.1

