Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76847C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCAE2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747984;
	bh=BA46yIdWlpDA7i2X07YkpysZ6Pq9BB41WDFHVxN+xLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Wc+DcSW5GHGjH8aUH7tclNE/krcinFpJiS7CQlztLka+CYMYCo4ZdqRgF9KUK1hR
	 a+Mvc0PINyiQma2LIo9gyc8XD6327nVxVVsINv85Hm6OLRvV5sQnOg4QwLukooskpr
	 v1XGKKiTtOGVQfzTTdHa5FOkiTIFjyFeFFm7GL0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgBCQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbgBCQjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:39:39 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864A82192A;
        Mon,  3 Feb 2020 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747979;
        bh=BA46yIdWlpDA7i2X07YkpysZ6Pq9BB41WDFHVxN+xLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+8OYsuZg7G7rtBYk9bUFsdufxG/lHKcFESYsZMdk9MWTu5q4wdoL4qY0sgGgIzH5
         JwXUqc9gAp5xY8Q6LAoEeGVjX2jHN9xUhiyCmTmTNh7zl4MRyCZt+G5pjnVNBj9MjP
         rk8zpwW1qOnNrxFlY6pnCPCShcw0AbK5HT4S4iAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rosales-fernandez, Carlos" <carlos.rosales-fernandez@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 55/90] perf/x86/intel/uncore: Add PCI ID of IMC for Xeon E3 V5 Family
Date:   Mon,  3 Feb 2020 16:19:58 +0000
Message-Id: <20200203161924.464976443@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit e74383045119fb8055cf31cb39e0fe951d67163a ]

The IMC uncore support is missed for E3-1585 v5 CPU.

Intel Xeon E3 V5 Family has Sky Lake CPU.
Add the PCI ID of IMC for Intel Xeon E3 V5 Family.

Reported-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Rosales-fernandez, Carlos <carlos.rosales-fernandez@intel.com>
Link: https://lkml.kernel.org/r/1578687311-158748-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index dbaa1b088a30e..c37cb12d0ef68 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,7 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC		0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC		0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC		0x191f
+#define PCI_DEVICE_ID_INTEL_SKL_E3_IMC		0x1918
 #define PCI_DEVICE_ID_INTEL_KBL_Y_IMC		0x590c
 #define PCI_DEVICE_ID_INTEL_KBL_U_IMC		0x5904
 #define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
@@ -657,6 +658,10 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_E3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* IMC */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
@@ -826,6 +831,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(SKL_E3_IMC, &skl_uncore_pci_driver),  /* Xeon E3 V5 Gen Core processor */
 	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
 	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
 	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
-- 
2.20.1



