Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E639C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FF52078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr683qhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgFIKSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:17:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A431C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 03:17:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so10074193pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GaViz1C7phajEC01jHhddMW7VzXhQ3Zl5PNkL37o/YE=;
        b=lr683qheUJhLXvT0Shdk8NNrX2sIZgyJd5/S737Hi3D+5RtHGzASLEQff9fZH9tVf+
         r6bp8ckEz5po2xObkxJeV4cSt9CdLHNL0ynnGbjxYMs9IcWUj1Jam8qdcROYuZyMt2ii
         Z7sSW7WxzUpOERLH+b7+bm1cnAgm7+LiwktXx6s1zfNAUF9ADLl+HsEtq29OOLVIKIMg
         SsCxYSyIL38MeSmIbA/8jGYufg/9v6woVnz/rr72wFPQ82rFh6hsEYLF650j79OtZX+y
         lwWlWJ4J7/BUlmAs5k5JhcnA/a64Wf8TGFnst2b3klZzwgZcYe5Dr07rToLbXNkbVsk8
         Qunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GaViz1C7phajEC01jHhddMW7VzXhQ3Zl5PNkL37o/YE=;
        b=cRsjrxUTnbUuOAnYkHLuDmt2kqMMhScxioxY2OBUrdnTAaT6765FTmViuQ2d3O6pfQ
         3lpQABRrJW3TcYAkSBZSgUA4GIyQaKFPIx72nTLXGv1AZVuJCRvy8pzNrgMUhi+zBdKc
         kidsWko+/DfUS5pGWjODAMufi0Z9N9ftYMHqG6ApQoPOrO7jLXLbtLB8ZPFygdC6eWvs
         7n3hSPR84phsCub+mRkbR2t6EWQT2g64RKbu5SN1cmcG6MOTR4otbbAJnbZ9GSfOpRAJ
         e8f62e0i//vZ8pKiqBm6vqs+597a+C+7H/6T3g4uW4qAg6AEHcLL7S/DAGQVcOdBJjFr
         bK/g==
X-Gm-Message-State: AOAM533yaEhsWpL0rZpZd44aatrbeNYWXdkK/aldDjP8uLerOJqyYrSF
        nH2CH2fxaXSU4NW9RdnnWrI=
X-Google-Smtp-Source: ABdhPJzDTr7NdhFSHN9qc74QCMb1dDEOcethACVE2tEEA7eddP78bWgBXRKbzA3ZXb33/1N5MaIGSg==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr24013563pfn.183.1591697865815;
        Tue, 09 Jun 2020 03:17:45 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:17:45 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 03/10] clk: actions: Add MMC clock-register reset bits
Date:   Tue,  9 Jun 2020 15:47:03 +0530
Message-Id: <1591697830-16311-4-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes from v3:
	* NO change.
Changes from v2:
        * No change.
Changes from v1:
        * No change.
Changes from RFC:
        * No change.
---
 drivers/clk/actions/owl-s700.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index a2f34d13fb54..cd60eca7727d 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
 	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
 	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
 	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
+	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
+	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
 	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
 	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
 	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
-- 
2.7.4

