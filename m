Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED3C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6A320663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCdybl3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgGOI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgGOI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84546C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so1427568wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCQLIBPnltOFRS++BAxztAHTwj2wSWnOs3LHnUsG1Vw=;
        b=MCdybl3Gw37G1Bq/aJP5Pe/EbpLyiPirff+C0yH74i5zHU8WcFuucv4pc/ZhtSSWEb
         ttmjNt5ZOBIvwTOM+6NTPRrCdWBMnzyTvyBLIj9ihMHFxmoMVzIWV6oDuc6y7Ddiatc+
         odBn85hD3ytXmPY/VclQxhIvmv+JEXhZ/+C/UmsSczSruP7d2KHaPnrQXUuIKYHaVTle
         aqGRE6kd+T5yIuyJ7NE9pl8ssXT3aL++/ogfFrPvX97pp8CLI1PSDK5sv11Crmh69/s8
         cdeR7g8HxgeKnBP4l2E4bI0m07BfB8de3Xn+NIPTWcrVc0fTiXnI3i5b1Bf+irA6SiuL
         z/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCQLIBPnltOFRS++BAxztAHTwj2wSWnOs3LHnUsG1Vw=;
        b=e7a/badaXUjg2FcGDzyM8LntezZCzeplx9Z7n6hC8TMVQrI7RFHeS+aegPdOg6BR8k
         V2yCdxCVV52Rmt9PIyNEri0nMYLbWqMnO64TWf6NLcFAb9BxXAeUXY5x77y/dZV//aym
         LdDoZx4dGRfNgQiwQfQWBOj0r+bfm48OwD7u8CqqqlbSqTVlxAMY0tsW/goQOrzvj1Kx
         GIpvfSsrkMeBhaG8Gz8PIXAeIj22DdkmINZhHKVK8nOCZFVZEV+tYNJnp6fLLcG+923W
         2TIH9wIR0qdTcDYCxUwORVc2ciANF3ltZuG3d02RZDR2CRSVjbxzgSA/eG27r88YKa05
         Se0Q==
X-Gm-Message-State: AOAM5302l8Xp8Qj3mlmNdpyy0fIPXYT6MOQaK5wJdGaAcUtonk1Zl5Eb
        LqZnXb/Ctq4kq71sc7GYRh9UBA==
X-Google-Smtp-Source: ABdhPJxlua+SYa5MMQ296pyJ156z28xC7KELszStrbytWumw2AI+ZT38OsX9kXDGi5NnDOmPRNNLBQ==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr9955251wru.411.1594801612237;
        Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Matthew Garrett <mjg@redhat.com>,
        Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH v2 11/13] cpufreq: pcc-cpufreq: Mark sometimes used ID structs as __maybe_unused
Date:   Wed, 15 Jul 2020 09:26:32 +0100
Message-Id: <20200715082634.3024816-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used when MODULE is not defined.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
 619 | static const struct acpi_device_id processor_device_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Matthew Garrett <mjg@redhat.com>
Cc: Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 5789fe7a94bd3..9f3fc7a073d07 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -616,7 +616,7 @@ static void __exit pcc_cpufreq_exit(void)
 	free_percpu(pcc_cpu_info);
 }
 
-static const struct acpi_device_id processor_device_ids[] = {
+static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, },
 	{ACPI_PROCESSOR_DEVICE_HID, },
 	{},
-- 
2.25.1

