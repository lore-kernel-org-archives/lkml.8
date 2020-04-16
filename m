Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E110AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4505214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051707;
	bh=sPrl9R+yoAc0NrziY7jtHcAjfyMMgN98O+1GI2m295k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFrqFOET/UTjI+Jc8qZuWdUtZI9Px4xJHFd5g739V2L5XlZNUeowQWGRfpCYxT1LR
	 11yxnffXLBtBhGdz8rpjbyWfQYFJY2bJuHsYqktiC3cxBl8siPpN7wPZ2Q4bitWss6
	 BzZAtsDhV2E+e5E7UYF7PH1GVIaNIrr5X+HWeRLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgDPPlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897412AbgDPNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CFF21BE5;
        Thu, 16 Apr 2020 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044224;
        bh=sPrl9R+yoAc0NrziY7jtHcAjfyMMgN98O+1GI2m295k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEK1K8LEkk3wsvxo7xZT1gDIgmmcFoc3e2LDXPeRtlKgbKtn+oldmIak3d6s3cKNy
         ilorSkYLRYeegoZd6Vj/DUMVnUGN4QII3Ad3Q7TrsXqs2ZJx13it7Z5KQ0zub+5YyE
         ttodI4fiR8GkmDKBt5JHChdRunAI/PzOIK09Kypc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.5 132/257] MIPS: OCTEON: irq: Fix potential NULL pointer dereference
Date:   Thu, 16 Apr 2020 15:23:03 +0200
Message-Id: <20200416131342.934826468@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 792a402c2840054533ef56279c212ef6da87d811 upstream.

There is a potential NULL pointer dereference in case kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on *cd*

This bug was detected with the help of Coccinelle.

Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/octeon-irq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2199,6 +2199,9 @@ static int octeon_irq_cib_map(struct irq
 	}
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
 	cd->host_data = host_data;
 	cd->bit = hw;
 


