Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3A2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046508;
	bh=QXDIIPH8GK3Ux1ynVTxNG6RvRhtHCDyClAcTXjsslm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oX0Am1Yx/dCPbRc48EX2j0E+FTTUQERyMrVsNm6pA1nhHa07+6PbKi8WVDcPZY26l
	 uw/1crkupYfnqIQVndGWHrIAwZ97xXikMU5MnPkffHN9YJdxEIcD0epIdakYe+ualB
	 6ksAt2K5b8ev17ZeJZUDjqxF1piRoqcKQtvLLEbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409496AbgDPOPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408690AbgDPNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:51:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37642078B;
        Thu, 16 Apr 2020 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045060;
        bh=QXDIIPH8GK3Ux1ynVTxNG6RvRhtHCDyClAcTXjsslm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFBwl/tdeKdlRPmvCynDzv6MyN+qcJmUqVCyVQL+5weoUIyRHejjoAXstBfIRckDr
         MAWlVTZzYw4KzPYWB4sHezVIreAnsqs2ns/jxGSXdemHFmd+k0UoE6Wslg4jx9hnDu
         sB0wVM8BAHhZulOpegYA73H6LMyyW3LkNf0qbaJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 212/232] powerpc/xive: Fix xmon support on the PowerNV platform
Date:   Thu, 16 Apr 2020 15:25:06 +0200
Message-Id: <20200416131341.950407994@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

commit 97ef275077932c65b1b8ec5022abd737a9fbf3e0 upstream.

The PowerNV platform has multiple IRQ chips and the xmon command
dumping the state of the XIVE interrupt should only operate on the
XIVE IRQ chip.

Fixes: 5896163f7f91 ("powerpc/xmon: Improve output of XIVE interrupts")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200306150143.5551-3-clg@kaod.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/common.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -258,11 +258,15 @@ notrace void xmon_xive_do_dump(int cpu)
 
 int xmon_xive_get_irq_config(u32 hw_irq, struct irq_data *d)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
 	int rc;
 	u32 target;
 	u8 prio;
 	u32 lirq;
 
+	if (!is_xive_irq(chip))
+		return -EINVAL;
+
 	rc = xive_ops->get_irq_config(hw_irq, &target, &prio, &lirq);
 	if (rc) {
 		xmon_printf("IRQ 0x%08x : no config rc=%d\n", hw_irq, rc);


