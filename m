Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8905C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33932074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd5D+k03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgDTSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDTSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:19:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483D4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:19:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so4258762plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=idNzN2pm7FEPN1n487Ax7LSZYU5+9Uhm24wE5AT9T4s=;
        b=Vd5D+k03lqQVldIAukk7ZSeEk3nNjGfLlRkJtZcPLZa1qUfbt3YNor+uzJPtjhDEdK
         siCEfcbX5/HSKmYiXqG/Dp0Z+kOqWn5OXn5OAls/y+r1Fh8h7HiQrhSig3OkH7/jBFNR
         X00tFwMEKdkCgynoNQ2UzSmdN8ShZotARmEbxM/brXav5nNLOLIXywDh17aaFbG6Fl2R
         dS7/NspoKF5bHe05Bp+zwCcaYv4YZHhCHIHd/2xJALdFt5fvQf8aMvDguHmzrgZ7edf7
         Ovi9Byyy9yXeTW13Qb8eM9Wxfha0gyXwnMoKrmelBbGjVwDZcZbxMvpZjAWm64MKU1c5
         +XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idNzN2pm7FEPN1n487Ax7LSZYU5+9Uhm24wE5AT9T4s=;
        b=NIIsU5Zq4MmP7CXUskxPImclrAFRql+3rTMh4V8/XTFnafXlGYoK52eOyE21/nCvSw
         sPlbs7ET+WB1N8Yx7GGoSCNIU8PcOWCemVpPAgVvoeCW74QizA8CKe9p9ZwbR2blNDaq
         npDFXVbakDZcFUykfISnK7eog8/3dVGRV7+fmDjCN6dtQfAXUctgM3PtI7s6JFnv3KPZ
         WlyacsFiklqmQR2PpSVdWDTLYMNN8tLhozIcQy6bN3v2K7/azxPaGhvA3BT5NFG2h7Zn
         S7cEgMNNOu7HsoGGRtuDJsIDVhiKDXCsjpo2JCMeJ67gCbvLD/PLlMR052fdirXB+UTH
         iAgA==
X-Gm-Message-State: AGi0PuabZjQMvUf8ULopgkWzhnrgWn7bMx+g7vc0A3p2neomPQjDOJP6
        abTtDJ2Nxxronzlnf+g8N1M=
X-Google-Smtp-Source: APiQypIa5no58EAZMdGt72lHrrO+ZVAYnEQIiK1hn+NTjKtEri8J0x2+rKim+soaz3PrHXk1Fg2vPQ==
X-Received: by 2002:a17:90a:f0c6:: with SMTP id fa6mr783307pjb.5.1587406782749;
        Mon, 20 Apr 2020 11:19:42 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.233.24])
        by smtp.gmail.com with ESMTPSA id x66sm146331pfb.173.2020.04.20.11.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 11:19:42 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     adaplas@gmail.com, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video/fbdev/riva: Remove dead code
Date:   Mon, 20 Apr 2020 23:57:24 +0530
Message-Id: <1587407244-32574-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are dead code since 3.15. These can be removed forever if no
plan to use it further.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/riva/riva_hw.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 0601c13..08c9ee4 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1343,24 +1343,6 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
 /*
  * Load fixed function state and pre-calculated/stored state.
  */
-#if 0
-#define LOAD_FIXED_STATE(tbl,dev)                                       \
-    for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
-        chip->dev[tbl##Table##dev[i][0]] = tbl##Table##dev[i][1]
-#define LOAD_FIXED_STATE_8BPP(tbl,dev)                                  \
-    for (i = 0; i < sizeof(tbl##Table##dev##_8BPP)/8; i++)            \
-        chip->dev[tbl##Table##dev##_8BPP[i][0]] = tbl##Table##dev##_8BPP[i][1]
-#define LOAD_FIXED_STATE_15BPP(tbl,dev)                                 \
-    for (i = 0; i < sizeof(tbl##Table##dev##_15BPP)/8; i++)           \
-        chip->dev[tbl##Table##dev##_15BPP[i][0]] = tbl##Table##dev##_15BPP[i][1]
-#define LOAD_FIXED_STATE_16BPP(tbl,dev)                                 \
-    for (i = 0; i < sizeof(tbl##Table##dev##_16BPP)/8; i++)           \
-        chip->dev[tbl##Table##dev##_16BPP[i][0]] = tbl##Table##dev##_16BPP[i][1]
-#define LOAD_FIXED_STATE_32BPP(tbl,dev)                                 \
-    for (i = 0; i < sizeof(tbl##Table##dev##_32BPP)/8; i++)           \
-        chip->dev[tbl##Table##dev##_32BPP[i][0]] = tbl##Table##dev##_32BPP[i][1]
-#endif
-
 #define LOAD_FIXED_STATE(tbl,dev)                                       \
     for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
         NV_WR32(&chip->dev[tbl##Table##dev[i][0]], 0, tbl##Table##dev[i][1])
-- 
1.9.1

