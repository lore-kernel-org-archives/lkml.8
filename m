Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DC0C433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D2522205
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6daXhKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgGNOv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgGNOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA4C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so22197447wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ov8mkUGBo3MkEAlxc2kYHhcoEYaszqjEJyXig/T1tiI=;
        b=t6daXhKQWGdOTczm6qL35xc0fppGdojfryPU3Yy+9b2M42Lz9lDVXu8Z+oQPer8/wn
         66lWCuWHscF79MDsDWoRINbL+J3DI3JwRywYtB3y/yDN2fYApJvODwK9fVhtnK1i5TrR
         6PwVmrMyZL9diMFGKxmlNMcb/U/bTKAABaKdcywqnPyqnVG8Qf3AUAoJpdZ/2pUkQHF/
         JNbL4G/kUrCSGBLIjO7xXY9Eqm4CKdYlM/6mJNq99ZnUxi1hI/38z3KoHgnowKzwqcF5
         DuKh916+E7/PuxfrO02rdsDIELOoLKt8hH+gN8cgun3vPBAXSTxr4R8r6rhWs+4/y9qb
         Zpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ov8mkUGBo3MkEAlxc2kYHhcoEYaszqjEJyXig/T1tiI=;
        b=qqKc4gm4SqufaoA5hVVtSQpCpSZk/T0W4U4EHJ7QOpS+bhOaDF+yilnYYJspq5g+K+
         XF6I7vT+dVD5JMyoIHJrJcl4r+rO1/aEiTGuVjbVv1S9TlbFztlPhLSBLSoT4ES9UQk+
         2biurIoNzu2HmaROH5J5/1bpNM+3y9NCUsVQ2//9rQuWB1uw9tET4GwFiEV1TyeFwnWs
         AxJdVZ4NSCl2DtSxSn+16wbt2l/r5zicb6ZegzvNxEL61qikkfLAtHK5Ono4VevbZqku
         efccsi+8RJL6scFgx1Evj4+zoZGdrT+PWN9FSekklRlpaiezR6oSUxKyzgXlYElsG9cb
         iG8A==
X-Gm-Message-State: AOAM533NqQbwTC/0FHgkZ9VQAA6CNcPvE8ooezmlmEEOy7sJjV03nmhv
        P0whMs5w0XlGuByVUkJoHsshsw==
X-Google-Smtp-Source: ABdhPJwXO/T/LF1NI7ZgnyJQbsl2c1EL4iDXIFBRbgGKB7Pv7E0G1E9GvN5Ys7i50Jv2Wiu8MXJf4g==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr5883468wro.375.1594738262394;
        Tue, 14 Jul 2020 07:51:02 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Date:   Tue, 14 Jul 2020 15:50:45 +0100
Message-Id: <20200714145049.2496163-10-lee.jones@linaro.org>
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
 drivers/cpufreq/acpi-cpufreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d38a693b48e03..fc68f13352695 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -995,18 +995,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-static const struct x86_cpu_id acpi_cpufreq_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
-
-static const struct acpi_device_id processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
-
 MODULE_ALIAS("acpi");
-- 
2.25.1

