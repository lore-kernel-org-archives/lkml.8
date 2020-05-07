Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B212C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427E32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uw9tkn4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEGKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgEGKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:24:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA513C061A41
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 03:24:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so1904535plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/Mk9PnpQZ4xKWEBXlLMDvhktcZ9bgwGO85pTWBmd1Q=;
        b=Uw9tkn4tmqYAbTMf70CLe39oO9q1CC6aVjLT1Rme6khxLYX4hxUID3ZnvBSZGakv5P
         cGKuKJqk2HPHbQ4P1iQd69NwgL2xHQejKzAHF3MGaRFbXyURliEk1oHrAxQepDxSyXed
         VFbE4tH2UIH74TV9w+cRWY5I37BG/H1vO1EhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/Mk9PnpQZ4xKWEBXlLMDvhktcZ9bgwGO85pTWBmd1Q=;
        b=pLmHcz2WzFnIMff9o/ThjdE/oB2opGNSPn+xYkTHMgopj5ydhI7aySgkIVmrZWccct
         rH1Nf7HAY8E9f7VfrzvHs4EJA72EggvaigoIQZcs5+l1m7BGf/BeFRtvuqKeHEefB2zh
         gGXOl/OYLpSeMwhDUIWR2qXKG8hHY08cyP1mIttyJVoutJrPbY4jbZwzAXjW86BW+bEG
         V3tM9b1zgUHjL0esyzLqQCGmLwpV8HemmPnkenZ8RZouP+NHCEVPL5W6SEJUfrK67ebh
         UfFLbzVj3uzm3eXkTp1fgve1TPXbo+5Xd/t0Y2tiETvIQ1gbjZUIdwLE6wWzEHHqyIvn
         IQDA==
X-Gm-Message-State: AGi0PubSKfRSmS1KUCmJpmuuWo5VjmczAcgMWCfuopOzbXfLsnTyz66F
        D+iDNIAipDRfu/1N0lVK+/ys0Ld9c0k=
X-Google-Smtp-Source: APiQypIfdyYf1DVe2NADcLWJNyPuVcmkF60Nyz26uFMfQ6Htik4/hMklktg3MMP3+ePUbdo+ebw1vA==
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr2742862pjr.114.1588847088130;
        Thu, 07 May 2020 03:24:48 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id a138sm4514903pfd.32.2020.05.07.03.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:24:47 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/5] [media] mtk-mdp: handle vpu_wdt_reg_handler() errors during probe
Date:   Thu,  7 May 2020 20:23:46 +1000
Message-Id: <20200507202337.v3.3.Ia8efd7905e2fcfc81f547e27a51f06373624b3da@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200507102345.81849-1-eizan@chromium.org>
References: <20200507102345.81849-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup to better handle errors during MDP probe.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2:
- remove unnecessary error handling labels in favor of err_m2m_register

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 9b24b8d46eb7..17d155219ba2 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -188,8 +188,12 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 	}
 
 	mdp->vpu_dev = vpu_get_plat_device(pdev);
-	vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, mdp,
-			    VPU_RST_MDP);
+	ret = vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, mdp,
+				  VPU_RST_MDP);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register reset handler\n");
+		goto err_m2m_register;
+	}
 
 	platform_set_drvdata(pdev, mdp);
 
-- 
2.26.2.526.g744177e7f7-goog

