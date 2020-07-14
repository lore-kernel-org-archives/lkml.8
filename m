Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD250C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B2A222C8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjP2GZD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGNOvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgGNOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DEDC08C5E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so22189743wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4FLx3muVHP2pCB5GbFp6A725ffqNGbokYtDZodR17k=;
        b=qjP2GZD7DEKVihUDEr8DOQw2jWLp1ateuBsMjM0zK6Bb2UqoHJmPYlUHozDy416wNM
         WrAuxkpdR4itLlHHdt6zK11R6J+YF3H2X9qJZ66q2VApdxJKRjggHHHabWQwZw7hB96T
         QWs5bcfcqHQm4RaN+IvzHqT8YkR/SDeIgCjE/O23h5GB6yX7uF3f+mu5tH4VFffzfF2E
         fIKqvH4tnupS9kNadhZE35Og9MwXuvniL9jmbgbMP0p9qLqc/WadErfR6kfmfJxcmI4T
         vuRdQt4/I+wCmwLpf95BYtk6T5qUhTEM2vcn+XQP1s8jt4AyNsu7U5RSJOLSG0O1B47Q
         SZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4FLx3muVHP2pCB5GbFp6A725ffqNGbokYtDZodR17k=;
        b=IbNOCnw9z6wr3h9Z1cP8eUuHH+Drwctuf+vvmWAbKgvJGFjgZs7NaHDrVTJnvoru6D
         jCBuko4AztE5JRvJRJHxI8gz7MDALgNhw1OwhGujJKw+39Da5F9ptxdniWzAIrg+yWNe
         SnTdVNByjZBxVQi/1lVAK2IM/uckDQKAsycIjlyfn20lVEnAHNKT3mOHdslDJnaLUsNi
         5VvbAh09nNdLIwkPcxk3VhDT92TRJoYxCRJMnyEFz6b/3RDd4yHBt7r6XL+Nj+sWMy9B
         uTXf2qvRZuH52V20rlRe7qh1AqqUeoKik1FJ1aHPj/CjD96jFqynD86Kq3liImfoEzWP
         yX9Q==
X-Gm-Message-State: AOAM533E6jnJg8mnarC38QYntwxsL7DNRbL8SSNQRZ86c49xy5FLaNFb
        gf7gVQrJuGYewf/9ggPk/b2EFw==
X-Google-Smtp-Source: ABdhPJyQdxIA4lIDbDulsvOs0NZhV4S0UZCnh86sCShA7ZRuRfPhL4qVQmpdKI2T4VJMz3HcRktgOA==
X-Received: by 2002:adf:8442:: with SMTP id 60mr6633538wrf.276.1594738264728;
        Tue, 14 Jul 2020 07:51:04 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Matthew Garrett <mjg@redhat.com>,
        Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH 11/13] cpufreq: pcc-cpufreq: Remove unused ID structs
Date:   Tue, 14 Jul 2020 15:50:47 +0100
Message-Id: <20200714145049.2496163-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't see them being used anywhere and the compiler doesn't complain
that they're missing, so ...

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
 619 | static const struct acpi_device_id processor_device_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Matthew Garrett <mjg@redhat.com>
Cc: Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 5789fe7a94bd3..99cf8b78c032a 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -616,13 +616,6 @@ static void __exit pcc_cpufreq_exit(void)
 	free_percpu(pcc_cpu_info);
 }
 
-static const struct acpi_device_id processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
-
 MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
 MODULE_VERSION(PCC_VERSION);
 MODULE_DESCRIPTION("Processor Clocking Control interface driver");
-- 
2.25.1

