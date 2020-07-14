Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7396C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C210421D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kw0j6YyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGNOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgGNOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7173DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so22195941wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYBUe5BwYsr/R2phlHidQsm6+vzt4cxxnkc0JimKqEE=;
        b=kw0j6YyJsiIk2n3yX5+GkWGHEPOb5rpZONh1AHETutb3Im0RIS6q17btR7I5qt+Y3G
         Cr1hhv/Kwb4+WIS0DNHRjmc1aw52YDL0xbevlEKg7TJLPfD4wiKMTStgnlv9QSESRuy2
         ud15ingoco58gPEiG8JkpQosiAAkovGqjbIlBoloUt9rOcx2anemoSqTP2ATqz6NrUQt
         tulqxTx3pqJ1mnmLEsWngWkqghXlkZjKVXZb6FZTVVe+ZC2J0MR1r2jQ+V86qR4QnhyQ
         LWrTAK+0ruiFBAkkrUIWJlkdAkSpEDrtau+/OBkjXFh5ifl7sURfmnAjGYLKjcVCRWk7
         J80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYBUe5BwYsr/R2phlHidQsm6+vzt4cxxnkc0JimKqEE=;
        b=Ex77a/pUezBN7FoCc1f/dvrLeEu3PK5IHGKmborRZyCNPZCDYXhxf0XHGYZMfmss7p
         QOy/jQAPOD76S166gMeF8Rkd+RU4yhsdadn08EWb1E+vDYNvgHDzk6GZoOBQWIbBPQkR
         FCjyfncQtv7f0kkQjTsoSjkDChEJyZr8TzaHI47FDwTCTKED91QTa+BPwPFBGWFfYYHs
         m71p4t71Sp5d4GRScJeMxziV+ZskerDKh1O1MY++ykIYlpNEdGKKPp0gZaXiZkmsKI+b
         J8F5moJXL8X2i6SntCn6sr5lLN27bLkUjW0LW1XPd2G4u4hu4X1N3oqlU70oeZWzoFF9
         Wdmg==
X-Gm-Message-State: AOAM530H/TIWRp95DYvxr6yWRGACKP+nDFL3UQ+n7ht6VY/O8qKdrcpi
        2aQL/D6rbTUHxoCDO9AbTsrNrA==
X-Google-Smtp-Source: ABdhPJz8xLGj6PyHHnWxNk1fB9l9swenCZNjFdqaoHR4cK01bpPaXCLBFCFf4j5xacHn27d9sC7Xrw==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6280720wrt.154.1594738261236;
        Tue, 14 Jul 2020 07:51:01 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: [PATCH 08/13] cpufreq: acpi-cpufreq: Take 'dummy' principle one stage further
Date:   Tue, 14 Jul 2020 15:50:44 +0100
Message-Id: <20200714145049.2496163-9-lee.jones@linaro.org>
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

If we fail to use a variable, even a 'dummy' one, then the compiler
complains that it is set but not used.  We know this is fine, so we
set it to its own value here.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_intel’:
 drivers/cpufreq/acpi-cpufreq.c:247:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
 drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_amd’:
 drivers/cpufreq/acpi-cpufreq.c:265:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Andy Grover <andrew.grover@intel.com>
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Denis Sadykov <denis.m.sadykov@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 429e5a36c08a9..d38a693b48e03 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -247,6 +247,7 @@ static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
 	u32 val, dummy;
 
 	rdmsr(MSR_IA32_PERF_CTL, val, dummy);
+	dummy &= dummy; /* Silence set but not used warning */
 	return val;
 }
 
@@ -264,6 +265,7 @@ static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
 	u32 val, dummy;
 
 	rdmsr(MSR_AMD_PERF_CTL, val, dummy);
+	dummy &= dummy; /* Silence set but not used warning */
 	return val;
 }
 
-- 
2.25.1

