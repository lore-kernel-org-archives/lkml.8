Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517DC20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGCP5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:57:00 -0400
Received: from foss.arm.com ([217.140.110.172]:46924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgGCP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:56:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B8831B;
        Fri,  3 Jul 2020 08:56:56 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 512E73F73C;
        Fri,  3 Jul 2020 08:56:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/2] sparc64: Deselect IRQ_PREFLOW_FASTEOI
Date:   Fri,  3 Jul 2020 16:56:44 +0100
Message-Id: <20200703155645.29703-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703155645.29703-1-valentin.schneider@arm.com>
References: <20200703155645.29703-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 hasn't needed to select this since commit:

  ee6a9333fa58 ("sparc64: sparse irq")

which got rid of the calls to __irq_set_preflow_handler() first installed
by commit:

  fcd8d4f49869 ("sparc: Use the new genirq functionality")

Deselect this option.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/sparc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index da515fdad83d..ed35760043e8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -81,7 +81,6 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-	select IRQ_PREFLOW_FASTEOI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_ARCH_AUDITSYSCALL
-- 
2.27.0

