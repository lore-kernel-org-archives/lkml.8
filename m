Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217A2206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="SJTSV2+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFHUoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFHUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733DC0A88B4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:17 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv17so9014916qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acHevj3wQIcryhB7O2ZRO4PATF9eIWbo+G1WRkznV+0=;
        b=SJTSV2+Z6VNkFlhdlnWtITIVaf5vYoqSYKr/f34664q6R+QXXEV+tgRZ1FHi/+E000
         Me6yk+QNbCBGelQ4P8PI20FbKZAZLoNFWmZ3HZE4EqK4iuDEH60ryY2dISsf9y3argHu
         UMPAB4Swt6oUhedie/XcWLz2KkFOcXE+6wCHKUGd2O9Tq444VcZvSUQc8hYhHY1pn3NX
         GQ/Crp3r1oq3LYlCpjCS9HmMuxEiEK9ZKef+xUVC+ih5B+N98Y8rB9YafCduk4sQKpit
         m1kjz5WQ6UsujVM0dfRYbpOYlCQLsp+Ps7L+DqkjqhiCv+PUA2Fc3tPXduqWNHZnTe7s
         ExJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acHevj3wQIcryhB7O2ZRO4PATF9eIWbo+G1WRkznV+0=;
        b=FHr4irVoV5ppzEiGu9YiaKR5fu0VrSuktpSyGTO0tRC7u7NCMPQqAl04bPydT1Q/ig
         Qh2QZipoOcV4RyF3+0IGda8C+jl0gQS6tlFNhegPFZ806W6ZwV9hCsO3oizNev5MctBE
         7K7lw3fTQT848JsMyeSa67gVhw7IetfH2xKTzetWTMGr9zOqmozGBgm3+9rQ55uCJMbm
         Fz05VNM+Xk72n/0Wys8KXlY27VKqrqIdkeNH9ck/OrBZQs4wqvyZ/YUCMnfgq8mqE7TA
         rL+p3x2Z9gUMTcpNBGdw+ACzXjpQTTKOl/oREBoX8gyxK5WUU1TnFXVWre3sOwef04TJ
         wMAQ==
X-Gm-Message-State: AOAM533c5qQpurVZm/sMzPAsukXRcK6R5t1jdPc9QZ/AlgdUVSdAM/NT
        48DOT3KnfFmHMmL1xyemQP9h9A==
X-Google-Smtp-Source: ABdhPJzOla+D8EOOeekqVt/wBj46R/nJoH0uM20TvTKVjJNwP4MBDNiTWp7yPIFrDtsJ9VawFCxsyA==
X-Received: by 2002:ad4:5668:: with SMTP id bm8mr549681qvb.248.1591649056614;
        Mon, 08 Jun 2020 13:44:16 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:16 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] soundwire: qcom: enable CPU interrupts for mmio devices
Date:   Mon,  8 Jun 2020 16:43:46 -0400
Message-Id: <20200608204347.19685-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
References: <20200608204347.19685-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the CPU to receive interrupts.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index ac81c64768ea..58ffb46e0d64 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -34,6 +34,7 @@
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
 #define SWRM_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_INTERRUPT_CLEAR					0x208
+#define SWRM_INTERRUPT_CPU_EN					0x210
 #define SWRM_CMD_FIFO_WR_CMD					0x300
 #define SWRM_CMD_FIFO_RD_CMD					0x304
 #define SWRM_CMD_FIFO_CMD					0x308
@@ -325,6 +326,12 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
 			SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
 			SWRM_COMP_CFG_ENABLE_MSK);
+
+	/* enable CPU IRQs */
+	if (ctrl->mmio) {
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
+				SWRM_INTERRUPT_STATUS_RMSK);
+	}
 	return 0;
 }
 
-- 
2.26.1

