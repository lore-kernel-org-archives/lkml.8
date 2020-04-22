Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C683AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E0C20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549854;
	bh=sPrl9R+yoAc0NrziY7jtHcAjfyMMgN98O+1GI2m295k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fkv9y9jdrNvORhavJCbCIP8h5L5bH1tbAW03kFtmADCBk+utVK/jN9ttIiAcPx8VY
	 vtbnKnZGH46QW86f8oZTsL+y4fzDgSaSd2uY2ym0oN+PNeaIyHJ9S7Nzr+nCI1PbCl
	 7LWgjNZWGMvtNFKThw9t9qI0P9psiLbl/Ss9RUEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgDVKEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgDVKEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5DD2076C;
        Wed, 22 Apr 2020 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549848;
        bh=sPrl9R+yoAc0NrziY7jtHcAjfyMMgN98O+1GI2m295k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXdF1eHCBM7VhvgY2KopZUjTZNsTeIl+2z854ekTIE96dMPlIMlRQusWB61a2yFu4
         6u+bBQ3KqLe9EasclK83tSLSRy139mg8nKHMgzVLm2Q5R74mTMy5iM1OKgj4DQ3Q6v
         xS0MXFunKPsveqtnomkl6wgcpHauCOB5RLgCBUMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 4.9 031/125] MIPS: OCTEON: irq: Fix potential NULL pointer dereference
Date:   Wed, 22 Apr 2020 11:55:48 +0200
Message-Id: <20200422095038.431066604@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
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
 


