Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270BE22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260473;
	bh=3nBhr8KvHL41nT9MeEU1tSZse/nQrdOPicJryuGPjBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PtPDQB5ypExfz6cBy60T7P8ltaiJx2O0Cm0nwOo4oll+p3Tmm7IE8ppwdysbydQY9
	 wAPQKkeBzmdn89z1Nvol+HXdLVEm9OxWN7bZ/ZOtAAoVlHRVKDyvD3rn6EgxASSRYa
	 rYBMU8HJzRSWwMY9bhiugG7AI3k9YzaEdNeSJqmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGTPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbgGTPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0FBC206E9;
        Mon, 20 Jul 2020 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260466;
        bh=3nBhr8KvHL41nT9MeEU1tSZse/nQrdOPicJryuGPjBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geDDRCIcAcyu++h0aMyarV1xcCDFvKDRZqN6586HMPEXBwuS+snkmLTWZZ01tdM3S
         r6chJMnn19P92b/02EYBEVa9yNZMyuPiOu1+J9jDdem3GSlI6KXxJv8yY8sIiC2YTT
         x8G0m/H/bdYOH/0U5w/0ju2yxvFwnSJqlveTl1H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 4.19 113/133] MIPS: Fix build for LTS kernel caused by backporting lpj adjustment
Date:   Mon, 20 Jul 2020 17:37:40 +0200
Message-Id: <20200720152809.201439787@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

Commit ed26aacfb5f71eecb20a ("mips: Add udelay lpj numbers adjustment")
has backported to 4.4~5.4, but the "struct cpufreq_freqs" (and also the
cpufreq notifier machanism) of 4.4~4.19 are different from the upstream
kernel. These differences cause build errors, and this patch can fix the
build.

Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Stable <stable@vger.kernel.org> # 4.4/4.9/4.14/4.19
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/time.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -40,10 +40,8 @@ static unsigned long glb_lpj_ref_freq;
 static int cpufreq_callback(struct notifier_block *nb,
 			    unsigned long val, void *data)
 {
-	struct cpufreq_freqs *freq = data;
-	struct cpumask *cpus = freq->policy->cpus;
-	unsigned long lpj;
 	int cpu;
+	struct cpufreq_freqs *freq = data;
 
 	/*
 	 * Skip lpj numbers adjustment if the CPU-freq transition is safe for
@@ -64,6 +62,7 @@ static int cpufreq_callback(struct notif
 		}
 	}
 
+	cpu = freq->cpu;
 	/*
 	 * Adjust global lpj variable and per-CPU udelay_val number in
 	 * accordance with the new CPU frequency.
@@ -74,12 +73,8 @@ static int cpufreq_callback(struct notif
 						glb_lpj_ref_freq,
 						freq->new);
 
-		for_each_cpu(cpu, cpus) {
-			lpj = cpufreq_scale(per_cpu(pcp_lpj_ref, cpu),
-					    per_cpu(pcp_lpj_ref_freq, cpu),
-					    freq->new);
-			cpu_data[cpu].udelay_val = (unsigned int)lpj;
-		}
+		cpu_data[cpu].udelay_val = cpufreq_scale(per_cpu(pcp_lpj_ref, cpu),
+					   per_cpu(pcp_lpj_ref_freq, cpu), freq->new);
 	}
 
 	return NOTIFY_OK;


