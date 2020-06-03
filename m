Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1102053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXGkfR/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgFCJZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgFCJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:25:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F6C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:25:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so1331219pgb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9GWHN/DvK6JVin1rcNjThobH5dDbmXKSSUaeKlXzRE=;
        b=vXGkfR/7XSismMTy2xpUY5NzSV5dRMg7Guk1ZLQycKkPBte420Yl461lMIv/rglXKh
         w4il0wt8H6u5mGEF8JOzcWDpDIQauqQBF5XK7V+X7Q8ijutPrNAxUElJTbjfstPLLq29
         a8xzgCZGiK6K7QcxTlfOsI9ezP1PmXcn9ADWOaFeMXco2LIBgvGBEBZE3ZK782mUyJm1
         U9pEifOCdt5b8+46i0+Rf4sSaMk8Pji9J/TlxZcafoR3Luj+ltt+lx13AwdwgmKeSgH/
         O6janjDQ7zW+cPm3/nTTIDbDZk0xScqllUC+VgMJtvcQe68+ZxdKmltNxbU+VngFsjlK
         UTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9GWHN/DvK6JVin1rcNjThobH5dDbmXKSSUaeKlXzRE=;
        b=kpOJIQCGntmelDj7uzhHWGsWQCW4RQ7A4Rqh32rPMZlciH9TnPIgTjv2UkLNy/T7zZ
         Flp1Fx/bxxC/1dKvBG88SRptyl/2n6qW1jYqM48fWOp5yTSk3nGIWOsISDKyae9WDwMK
         Nu2pWLuJRu2VE+btHs7VZr0nIJ0sGK4cqcS3MQuzdTfxRVRboDtIcGIPMtKdIMwaLRn4
         UySyoH6sR4DhDVJ80fMFPbAx+2bV69pr4JaYWzdQjg/vzBVui42K3BJ7clsZYvSwr/KB
         EKQb6sYleLwV6cqyDVNVGPsKDqG2v+PmgsTeiMQitDJkWqD6kUDoX0fDYJliEmN5EVTq
         y2Bg==
X-Gm-Message-State: AOAM530+4ZnbBk1s1FOYKxmzINDYc9nig3vrkPv0nydKiKq0GPvjFZt1
        R2KoNA7my7ysTIHvuEh/RHs=
X-Google-Smtp-Source: ABdhPJxQJFUYXkI0isRKjX5Mhc1Yo7lqwg+c3t7XD2aFMg2edgicu2ExjwQ4hRDFq6zPrhjSBucpuw==
X-Received: by 2002:a63:4b55:: with SMTP id k21mr28425585pgl.46.1591176309952;
        Wed, 03 Jun 2020 02:25:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h21sm1945710pjz.6.2020.06.03.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:25:09 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Helt <krzysztof.h1@wp.pl>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ALSA: es1688: Add the missed snd_card_free()
Date:   Wed,  3 Jun 2020 17:24:59 +0800
Message-Id: <20200603092459.1424093-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_es968_pnp_detect() misses a snd_card_free() in a failed path.
Add the missed function call to fix it.

Fixes: a20971b201ac ("ALSA: Merge es1688 and es968 drivers")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/isa/es1688/es1688.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index ff3a05ad99c0..64610571a5e1 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -267,8 +267,10 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 		return error;
 	}
 	error = snd_es1688_probe(card, dev);
-	if (error < 0)
+	if (error < 0) {
+		snd_card_free(card);
 		return error;
+	}
 	pnp_set_card_drvdata(pcard, card);
 	snd_es968_pnp_is_probed = 1;
 	return 0;
-- 
2.26.2

