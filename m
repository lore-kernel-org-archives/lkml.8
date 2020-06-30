Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15890C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7512073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2yPj9Hn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8eYH3Cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgF3KL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgF3KLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:11:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5832C03E97A;
        Tue, 30 Jun 2020 03:11:52 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593511910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33/vZZMyohUNfXRumqVj9hIrhFlkrsZU2CsaFjHDyok=;
        b=d2yPj9HnUB3ptB1ih3ZIEyxnVB+fuQUUvHIcRjM/wlF1wpiVWDYdG1L1bWRvN42FKcdxs2
        1Rd1xt1dSm2Zdlv8v2b1012xcPV40lFPNqEh64W5AD8VeBWud+LbcqIznUt668IDyeF8eF
        59SRFQ13QI8fH1xmXl9xhllguH5RsfxHe9H3UtLiPJz+OdEjSLZx9v6HPKWE/h9WnryjEN
        8tnQvI9T6vYaI/2k/MNx9ncMPJ4FcRfl0bJWjHJ/aLPDszApNVectKK7wJr8QaoFJPv1sS
        l0btXk4qIbJdkk9l17NtUGc7ugRoeRXvis0YKJNCe+8h0fudPIg5q5wrmT6tmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593511910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33/vZZMyohUNfXRumqVj9hIrhFlkrsZU2CsaFjHDyok=;
        b=n8eYH3CcWL5VxDoAO7ww54iqTQbs74lwovUdMSqdCuzcZvwxIPn0tG0c3NOwnJK2A9Xkc+
        26tWHfv3+x1S1NCw==
From:   "tip-bot2 for Palmer Dabbelt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-intc: Fix a typo in a pr_warn()
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200611175302.253540-1-palmer@dabbelt.com>
References: <20200611175302.253540-1-palmer@dabbelt.com>
MIME-Version: 1.0
Message-ID: <159351190983.4006.4419268552171045942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     559fe74ba6b0c8283e923a64f19fc0398fb64d04
Gitweb:        https://git.kernel.org/tip/559fe74ba6b0c8283e923a64f19fc0398fb64d04
Author:        Palmer Dabbelt <palmerdabbelt@google.com>
AuthorDate:    Thu, 11 Jun 2020 10:53:02 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 21 Jun 2020 15:15:41 +01:00

irqchip/riscv-intc: Fix a typo in a pr_warn()

Anup originally re-spun his patch set to include this fix, but it was a bit too
late for my PR so I've split it out.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200611175302.253540-1-palmer@dabbelt.com
---
 drivers/irqchip/irq-riscv-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index a6f97fa..8017f6d 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -99,7 +99,7 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	hartid = riscv_of_parent_hartid(node);
 	if (hartid < 0) {
-		pr_warn("unable to fine hart id for %pOF\n", node);
+		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
 	}
 
