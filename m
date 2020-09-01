Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB7DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFBD2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975319;
	bh=RJLp00XD7TP+whWdfvsvIJ+pYOGSXaR2waw3YKDqRMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V+4EmmWHZ0sUgQq3Z5ptfJ6d/4rbo3H+asarwvuDmWQumoAce1/IWy4n3bRQ++TdD
	 aO4VJgfnA4SYFGTj5b3Lz8Lxtwk0H1f4MBgZABcBRSOM9gBVhDK9zEtlnyHubIFHS1
	 0uzLumJYTuznkBZIbOG2ndnHIJHzxPNFEHatgN88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgIAPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbgIAPox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87BA206FA;
        Tue,  1 Sep 2020 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975092;
        bh=RJLp00XD7TP+whWdfvsvIJ+pYOGSXaR2waw3YKDqRMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMwvNnMbV9fNcBUhamDgNjSr/oTytWQES+qy/1ekPM0wuvAbs7GRz4QLbTwTENhOQ
         C1hvnKy3YO5MK7BFt1DLBqb0Diex+ZAdyC2RNuUHItOqdl7l/OEicMjEO90xixPYQ0
         kV1GVB0gcag2I4oWlfbIAjcMMroo1dxRDVmg5h+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.8 206/255] genirq/matrix: Deal with the sillyness of for_each_cpu() on UP
Date:   Tue,  1 Sep 2020 17:11:02 +0200
Message-Id: <20200901151010.573485838@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 784a0830377d0761834e385975bc46861fea9fa0 upstream.

Most of the CPU mask operations behave the same way, but for_each_cpu() and
it's variants ignore the cpumask argument and claim that CPU0 is always in
the mask. This is historical, inconsistent and annoying behaviour.

The matrix allocator uses for_each_cpu() and can be called on UP with an
empty cpumask. The calling code does not expect that this succeeds but
until commit e027fffff799 ("x86/irq: Unbreak interrupt affinity setting")
this went unnoticed. That commit added a WARN_ON() to catch cases which
move an interrupt from one vector to another on the same CPU. The warning
triggers on UP.

Add a check for the cpumask being empty to prevent this.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/matrix.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -380,6 +380,13 @@ int irq_matrix_alloc(struct irq_matrix *
 	unsigned int cpu, bit;
 	struct cpumap *cm;
 
+	/*
+	 * Not required in theory, but matrix_find_best_cpu() uses
+	 * for_each_cpu() which ignores the cpumask on UP .
+	 */
+	if (cpumask_empty(msk))
+		return -EINVAL;
+
 	cpu = matrix_find_best_cpu(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;


