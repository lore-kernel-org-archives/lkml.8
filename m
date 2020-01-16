Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F911214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uM1d8VSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405277AbgAPSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45036 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404121AbgAPSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so20176148wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9F6cbFc8MWLMRVXLq32wbzz9Kc9aRwk3yX4Xas8bss=;
        b=uM1d8VSmZZEDzRFh4G+Dl1YcFQ3A4IkT4iX5O2Q5yIdRYJ4u11XY+kKfiARvf1Dxbm
         AxWD5RspyGhLSTapb0Bk0W9/hPr3ay3FQwLPZi2P3pX3DSdldd0SZQt46Fqe3Q6fcz8Y
         vpxloEvz2j5siGPCupbKWMRVfEx1nPoJlS9iUsbOs7waxMYjdJGglZzahSb3M77AFPEH
         cWgX5YUYkOkUFzKGMrm3eWmAen/c8dGL6siCHMi0g6g4zKbCLYWqASlFDaKJzp6hO3bm
         R2mdkbSPjg/V9huALrb+01zXL8B3X9JbvoAtpp5uZQ65P2jVWbOK/AVSyRluofc+Opkc
         uFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9F6cbFc8MWLMRVXLq32wbzz9Kc9aRwk3yX4Xas8bss=;
        b=bqVrwMDFGRyBwpHwU7AEOHj4gnaLRg9kygU8cp+ZTPyTGUlMKn3KVjlRlja+1kFmbf
         u6x0VyvxLJ8V9HXBq6y/R5eJx67VjXhld7MbxetgoW0Ui3PQB0p3ttsykz4cNe6pkUmA
         aseNjeONmeF7Q3ssmjg1XjHopokaEnTmhgzTsNmVXMSv/6pXWxhyjP163Ra65ULBlPw4
         wVqrFEiCXcmfFIpv6HXHFr5oCsIewHgg4fNY27jxGv3kq9gsPISd+3GmBI2II/QlPxDL
         HZYtkJTG0A8nRmnrQz9f3fF2z/PCGjIfyjs8ASUhMDekNAK4NM8mc6ZqclSBO2MB0Ln2
         VY5A==
X-Gm-Message-State: APjAAAVJBtV2st+lQPzd/KPda7ep7Iq/iYn7nRMBrhyB8upqZefxI2lx
        h8bis2trcRDHeFRvl/mdQ/NzZQ==
X-Google-Smtp-Source: APXvYqwoCn4hBCC+0/xS3tPJId3zBSKv5xWcoMMTaUBuT+gcV1DRDV3+D3pCf+Td4gXXKuNNsYYz3A==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr4809753wrp.182.1579198996620;
        Thu, 16 Jan 2020 10:23:16 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS)
Subject: [PATCH 01/17] clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation
Date:   Thu, 16 Jan 2020 19:22:48 +0100
Message-Id: <20200116182304.4926-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1574233946-48377-1-git-send-email-decui@microsoft.com
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 287d8d58c21a..1aec08e82b7a 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
 	.read	= read_hv_clock_tsc,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend= suspend_hv_clock_tsc,
+	.resume	= resume_hv_clock_tsc,
 };
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
-- 
2.17.1

