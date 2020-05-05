Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6370C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D9B206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="doZmY9Xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgEEEBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgEEEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:01:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA69C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:01:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q124so431043pgq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fX+wHjDnbtvEkbbVe2K/ppkZQlF0JTMhhwiYwZiHruM=;
        b=doZmY9XxEuZl1yzo+blKvEuGksayzqeE2OAKNN0mF76DL6R0CrL75vtszNR4kDzPyW
         4GEREd5uYoerxfbJSi4kbGiHtp9dKhMwE3I7zjjEorWnm8Dj/vrkXc1V8tlEWlX3YY9P
         Qb6DJuLF66dcjaD/xB/cOn7IqyTVNpGm/HaVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fX+wHjDnbtvEkbbVe2K/ppkZQlF0JTMhhwiYwZiHruM=;
        b=YmDF8dbXvf07f9VDuCVqpEIVy+TwiaLgZL1ufsTic3WdZuho947PbsduBudYkIQYxm
         vI04srD87YfUkBxWfvDFhuYb2ZjQB/Cz06onoNSJUgnw2nyX/Z/p/Krf9VPFj3JCEpRO
         gP0gvFazaPDRa2Vg7YYSmY1+nEoYJfgMRtbEAp53w8Pf/gsp6KWWdq05fJvOtRh8E0k6
         t0ejVT8Li3x7wNmbDIXMclFlHSO30O6EW4a8FIiO5BX4ksXhAdl6ZWm8ItgfsjpbuHI2
         7Xii8PaRN+HPu3LhWwanBIyyTzwe3Ef4mV1SZMgk4VIAq0Fnj4YALi2wmX7op/jRZlbM
         5M9A==
X-Gm-Message-State: AGi0Pub45NrS0YBGUDsGnJXGlj0Yq7aZDge7dY+/+FCLqOvp9ioLRs/M
        PtQw0/4U6CWJvwvFSUKkNjQXV/+OaGA=
X-Google-Smtp-Source: APiQypKM9NF4PxwZF3k6P93G5Qq80LCDj9yb7AloapK0ymyBsN163/1s0pe5MmUpsS7vgZq1MO+WEw==
X-Received: by 2002:aa7:9683:: with SMTP id f3mr1280844pfk.278.1588651291099;
        Mon, 04 May 2020 21:01:31 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id s44sm481696pjc.28.2020.05.04.21.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 21:01:30 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
X-Google-Original-From: Eizan Miyamoto <eizan@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@google.com>, eizan@chromium.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/5] [media] mtk-mdp: handle vpu_wdt_reg_handler() errors during probe
Date:   Tue,  5 May 2020 14:00:46 +1000
Message-Id: <20200505125042.v1.3.Ieebc5dcb6dcc116119a570f14786ba47c9007ec8@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200505040048.132493-1-eizan@google.com>
References: <20200505040048.132493-1-eizan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup to better handle errors during MDP probe.

Signed-off-by: eizan@chromium.org
Signed-off-by: Eizan Miyamoto <eizan@google.com>
---

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index c20ac7681c6f..f974242663dc 100644
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
+		goto err_wdt_reg;
+	}
 
 	platform_set_drvdata(pdev, mdp);
 
@@ -206,6 +210,8 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 
 err_set_max_seg_size:
 
+err_wdt_reg:
+
 err_m2m_register:
 	v4l2_device_unregister(&mdp->v4l2_dev);
 
-- 
2.26.2.526.g744177e7f7-goog

