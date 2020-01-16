Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862FD20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198764;
	bh=wU/9PA9pxNxoDXJ6lPoMf6WRbdEvS/5kHPeCbNbXJpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oe7TeGkH5zKsdmbxXRtz9Hy7ZVhM7AhjtF/Z9Jgc1WiTprO029VvPTCV3LyR6E9B4
	 2vWr4s6RawsbWzlW2hxOyjtsiAY7P0JDJq1k7f0ovKUcedu9VBOYUKeB2i8RJP1URU
	 dhXKUS1/4jKUGuy+P/+gNIweciv5VuZbXrV1FTns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbgAPSTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392582AbgAPR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:28:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F303246F5;
        Thu, 16 Jan 2020 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195709;
        bh=wU/9PA9pxNxoDXJ6lPoMf6WRbdEvS/5kHPeCbNbXJpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Dzflyv4R0/TqyWbFz6J9fPWeUjIrCGylBM7bjL/AqvE1efgGgi4Pw1EMJlwSZmxw
         /XSPIkMvG0Ajeb2bdmnbPrw9Pv/YdSkQEqCfDm8HvY4Blddk7JgrbyiO5sTfbFn9Q2
         Y1JkP+EZFmq2Nb2JhbMds38Y2TdbPNpf55g1eStk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 255/371] x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
Date:   Thu, 16 Jan 2020 12:22:07 -0500
Message-Id: <20200116172403.18149-198-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2591bc4e8d70b4e1330d327fb7e3921f4e070a51 ]

apic->send_IPI_allbutself() takes a vector number as argument.

APIC_DM_NMI is clearly not a vector number. It's defined to 0x400 which is
outside the vector space.

Use NMI_VECTOR instead as that's what it is intended to be.

Fixes: 82da3ff89dc2 ("x86: kgdb support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105218.855189979@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8e36f249646e..904e18bb38c5 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -438,7 +438,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  */
 void kgdb_roundup_cpus(unsigned long flags)
 {
-	apic->send_IPI_allbutself(APIC_DM_NMI);
+	apic->send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 
-- 
2.20.1

