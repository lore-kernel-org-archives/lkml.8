Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DAC433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF732065D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF1a1WZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgGRJUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9153C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:20:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so6563874pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0LdVF4Wtif0/2NJuxoxJqSPIuVVPOku/Ym0I0U/TYRQ=;
        b=qF1a1WZqxZb+/GM7u9xwaCK8MPhe+9C27Lg/Z1kC+uAUQJEk1giMzh9GDXGvCzcWJP
         mcblQmc75BaJmzdim//KiDAJjR17Xo5NkB1n2ow3GpFxPtbppz3XeFm9jD8pOJqNdDVI
         ncI7ZTIsdeviSOEx+9hneHaYxHa+xjwMPWbae938fTO1XxFvuZqdZB4gxs2aMcsT49at
         w6Uaw/hbDDn+JKCrv2cGXfRGhXL2C6noOqF9R5HcethWFAN36B3HFejrh6rVgVYJp8HK
         Sf3sPg4MCDRJL4Ty1d7WeSu52f3wt7x6eY7PYznwL3DxR4OFKT91qPSues7/DAk2oHt4
         wMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LdVF4Wtif0/2NJuxoxJqSPIuVVPOku/Ym0I0U/TYRQ=;
        b=M3MYZDJ/yxRtBdCYJMJQH5HXH9D6ANBL/smFL5f5ZVGgprBM0i8qjIKjE74pWMREse
         En/J16KTomUdOV52fY79O/uLCpo1LUxw1neJhSeWVLhEoyCy+72Ty0pCtPQcPevyd1tl
         S0JfTXfI49JZVHgZLNv398DE7SiMpT4hra+DPD+05YPzEerBAj2/Jb1TGNhJSwg6UANs
         SQzthIXCT9o+bU3CA2pmaewV74WGTXQdjJeOPDKwHx4aMDeqCAQ7hf73D5kaETW37lFo
         ANMhvlt1F+DnDeT6Lb06KfznWm/J9bMWlylEHswDzKBs6evCNtUQbicUCU9ofwripNaY
         kEdw==
X-Gm-Message-State: AOAM5312mKSv0o08CHDEe0fskd2eTIghPaFhqAfMXkxIdSkf8VfwzXHh
        NRHcByR4eFBdSu7YGcbaqwk=
X-Google-Smtp-Source: ABdhPJzXlgDDgAarFKF/M3MQ/+1yvjbOWQ2P7FE4Yd0ZiZlwbj5GhM+qTN7HOgWFj8IVulEyyltn5A==
X-Received: by 2002:a63:6486:: with SMTP id y128mr11297854pgb.82.1595064024179;
        Sat, 18 Jul 2020 02:20:24 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:23 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v6 04/10] clk: actions: Add MMC clock-register reset bits
Date:   Sat, 18 Jul 2020 14:49:28 +0530
Message-Id: <1595063974-24228-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes from v4:
        * Reordered it from 03/10 to 04/10.
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

