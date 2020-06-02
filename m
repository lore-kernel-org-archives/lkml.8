Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACE8206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq2Hkgkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBRgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFBRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:36:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE088C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:36:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m1so5403146pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uce1GUg/yeAXqzZgy16vemL5SREKQhoWq++yzE0HX/k=;
        b=Xq2HkgktcbP09b447MRSywQnvS/ELe+9AihIJrcVVuSVUy55gNXjhQr7/8rqMwt0Vq
         Ur9ztyYu7A4/EYgrHVPyu77LTe1Zlfa05TswMKF3CwTmqiOYkbOliwwgbhrf0zFtsU0Q
         95tbh/amSpR5VYzUaZi2b3cXSv4T/gO3azZvbx1uGQp8QzR2aDoQTDkDANhBeVPkU6Tq
         MlEglM6NM/UddT0W/FY5ai/n20C+g6KIWaJThwXeUOaq41/Vrc8nZhYPo2oEXRppjZVC
         6NFNvfrVNyCScTlPkMmGyaVkwyrAUctbo3uRKpVlHnU1ZswKvoBnAqfOA3LgbqUv4ytq
         58ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uce1GUg/yeAXqzZgy16vemL5SREKQhoWq++yzE0HX/k=;
        b=sYqh0zKByrP4Megi215qup09+sAokLdGa2Ot8VC/Sb6goYjHf/LOwgfYnq6IgKhfEE
         ZVxis+JhLgNfd2sS+j6mxxFLoZbAO5LOgnlGHbY0cVEGcSzRg5u0Vp+x66Wt2spm6nPP
         lI+CBVcv19FflrM8gOKUDo/+Nwj9Hjh3ouveF4dUrE1isBs8OYAmV0fxAAwtSOsQReVH
         GEgDHhqIYRKgRvyc5i2quCFLUfM1Zgq/kyDYGBanxadFnkYMh/ovrUJueUt690AUvQIx
         hmwHM3a6Ytd52Z45xE9cF+xcFJgow/VjiG6+dOZgg+lPBIWtC7H0GOs0bWLPpknQs1Xu
         8TPQ==
X-Gm-Message-State: AOAM533QznKuYEkBnRvi+IVk5hLBzhMDuid+QXDE1d4XKeFyhrU00PA3
        8OGabqe0EWF6D7aKvA0pitI=
X-Google-Smtp-Source: ABdhPJzojgq3mk4y99SD0KUo/tv5azMA07TY6lAMuLSGuWWXOIsLruARqyvangOgvctSu8ulNVAw2Q==
X-Received: by 2002:aa7:80d0:: with SMTP id a16mr28203334pfn.188.1591119380338;
        Tue, 02 Jun 2020 10:36:20 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.35.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:36:19 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 03/10] clk: actions: Add MMC clock-register reset bits
Date:   Tue,  2 Jun 2020 23:03:05 +0530
Message-Id: <1591119192-18538-4-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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

