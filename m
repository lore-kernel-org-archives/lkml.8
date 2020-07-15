Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F7C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C1E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoZeCokh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgGOI0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgGOI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so1528015wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zTw93zoLeDrW9YVUykvWKpkCsGvq1SvpdvOV91LIDI=;
        b=PoZeCokh14NVCVrG+W6OCssjbdxlYt+BY2RPI8eovLbhPzaLoVu6hY0++nOStWvk7G
         AC5m93nmVlLOGmyl+yyOzhE20jZByNmfhTjC3f1OsE+xOaSFhOEZD1adMHSUY86nUcdq
         003S8WLfCC4kJUQP3B7nLpwZLoeL5quxpYHznQprltVCVB12xkwl1x6YvqBSR6n+AvvB
         J+eTnxP7lytE9JrfPxVYJ8Bsd1LHlvRP6P3N0Qlk+cD+UXDt4V9NfWmwaf8F2Bq4MSZ2
         NpHfQwClEX7SFhVB8TSaoxSOf1g6l4dy6IsfsJoDadjfzaKDqNqTFIWTX6+6I08pYoo4
         qDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zTw93zoLeDrW9YVUykvWKpkCsGvq1SvpdvOV91LIDI=;
        b=YI/+8dcz4XEErARVBVV7zNYvZ6JgEdTE7G5/CBSk2boCjtcDH6HeknzgyUIRl1JBBE
         8bIkJq5PlEudRkgoRP7hkNGHfD+AbGCoppZRhCw0TfyLqz9/0Vkqgw6fU/bAgnyjLJ7z
         xe7Xe2wHgTuKYt8DVvT1jdT8HBVnCAriSsq3tjjEuJ3wY2f9FrvMbF8fmr7RJzhRet+Q
         Jxfk9jVcd7ZarElCOGzT2DxNgcnRux41JUZ0jaHM4zRwo9O5CKzvXFh8qQZ7Boss2l5Q
         Mp8t0d7NkskmJfECht66TkdHuBVHUJyZLkuDc+Hkmf9NMx4WBX8YNmThv8RouWN5Sm3p
         MDZw==
X-Gm-Message-State: AOAM531zt6VjnZKxAFDoGXkBpcXHWSSeW0euG9OcWPIAYUysc/1W7csf
        ygtcyzP68eAZWI8/z+FSVnFKog==
X-Google-Smtp-Source: ABdhPJw4NEwvaYTKWQAiVObRyn0jstQiDGELTMaVFiiY+4cxedHvwQNYAgmxqV/UHsTrTKosES/Miw==
X-Received: by 2002:adf:9062:: with SMTP id h89mr9316099wrh.285.1594801609515;
        Wed, 15 Jul 2020 01:26:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: [PATCH v2 09/13] cpufreq: acpi-cpufreq: Mark sometimes used ID structs as __maybe_unused
Date:   Wed, 15 Jul 2020 09:26:30 +0100
Message-Id: <20200715082634.3024816-10-lee.jones@linaro.org>
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

 drivers/cpufreq/acpi-cpufreq.c:1004:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
 997 | static const struct x86_cpu_id acpi_cpufreq_ids[] = {
 | ^~~~~~~~~~~~~~~~
 drivers/cpufreq/acpi-cpufreq.c:997:32: warning: ‘acpi_cpufreq_ids’ defined but not used [-Wunused-const-variable=]
 619 | static const struct acpi_device_id processor_device_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Andy Grover <andrew.grover@intel.com>
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Denis Sadykov <denis.m.sadykov@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 6b3d8355c8dea..65bdedcc7f142 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -993,14 +993,14 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-static const struct x86_cpu_id acpi_cpufreq_ids[] = {
+static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
 	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
 
-static const struct acpi_device_id processor_device_ids[] = {
+static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, },
 	{ACPI_PROCESSOR_DEVICE_HID, },
 	{},
-- 
2.25.1

