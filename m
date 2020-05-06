Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FCC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3641120735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ej7fOABB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEFFuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbgEFFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:50:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F04C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:50:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so450364pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POceMM7hG1Wtztbcwf3G6dremJIzPAmuZKv3zO2DdE0=;
        b=Ej7fOABBLfr1SN0apV87KeMrwvbvxDU3i1UCROPXswmo0RGviza3edMx/g/ub/mlAC
         6gOfyEncqNbhatR7uPY4Kb7OwU8Zwz7gAo4mNkPj8DQ0s+PW5zKLJGuglOQOv971ivPm
         cm6gxqpNX715Mxq650ozR+wi9DzQEuEU2gZ9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POceMM7hG1Wtztbcwf3G6dremJIzPAmuZKv3zO2DdE0=;
        b=azg4DiWqLi7x30Jgvuf3UEe1FAo/9iUWlL0kAshUx7TeWFSR56+YW+DoPCGopS95Eo
         A6ymeMj8ABcOYEQSOWptZlZP3n200qY3G04ZzkTpYafo1wLi+3B6QdXsA1MsJJslgqhn
         cKoXO5b32tuuf7pmWxBP0zO+/hxMpfiS8P3fffP1/tjtM3idVxTXrcHVtqXRBhdEs830
         fESkTNsy4n+H9qpa+cU7x3ZrPuVS3OqJ4VyiQOPx110smllVlbRULUd+bqoK/bnX0XFV
         Rd3ihPrvMawBePkVzLgzEzsqrVzgtqWHL5fW1Tfe1gmPXRzmPQWrEfnWlEj1EfP4Y/lo
         fFNA==
X-Gm-Message-State: AGi0PuZuIPEiYEOmA8A6waEC2b4vInH5vvrBSkWSZNlQyT/Zc0oAsqhm
        dAz+ebi4C+MJ1LA9NMZFQYwkibLIsCc=
X-Google-Smtp-Source: APiQypLs34OzIA/qNT4zrjxM2MJ+J7wyvZaKQQqG+9wBc94UWI+Z0oBDVEUVVCUVLxdScKVA338gbg==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr6772243pff.310.1588744220983;
        Tue, 05 May 2020 22:50:20 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id f30sm3870470pje.29.2020.05.05.22.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 22:50:20 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/5] [media] mtk-mdp: handle vb2_dma_contig_set_max_seg_size errors during probe
Date:   Wed,  6 May 2020 15:49:17 +1000
Message-Id: <20200506154832.v2.2.If340fa06d86053aaea25841b36741fe69c3126dd@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506054920.109738-1-eizan@chromium.org>
References: <20200506054920.109738-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup to better handle errors during MDP probe.

Signed-off-by: eizan@chromium.org
Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

Changes in v1:
- remove unnecessary error handling labels in favor of err_m2m_register

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index aeaed2cf4458..9b24b8d46eb7 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -193,7 +193,11 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mdp);
 
-	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	ret = vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
+		goto err_m2m_register;
+	}
 
 	pm_runtime_enable(dev);
 	dev_dbg(dev, "mdp-%d registered successfully\n", mdp->id);
-- 
2.26.2.526.g744177e7f7-goog

