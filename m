Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1820675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847076;
	bh=F4Lhoeop5jyc/HLHpAGZSESF9WLzwH4clZlIidY28eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nT9ugiD9MwpYgwJJqJ4tehtDRpr1gezg+qBbXTeVpJa187yZUnoyqvUdsf6l1HUED
	 z3zATs2KZ52W52nsglunshktdXN6DN606ZSlIe4y4tKJFi212og609/qwFGmhAy0FB
	 I6vlZ1cbZ0haP7PCgUr0HtJX5CS2s/R+gO7TEMMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgCJNbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgCJMuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F114720674;
        Tue, 10 Mar 2020 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844605;
        bh=F4Lhoeop5jyc/HLHpAGZSESF9WLzwH4clZlIidY28eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mq/FmkkxqH62emZvc02uU+JWKH0BfqQBOgbubpaz+qmSpuGDIa2EwCaFZhFsPINka
         lTpWGAAX/0UwWm6Xul3O1fUvYdTn2+JtCgMv/3NQp6nXwTUTB4lcnIvd4gwX2uWN6I
         OvBAGVHjgR2KJi/3mLL4VnuRaAS+Fjd/DZCuYHpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/168] csky/smp: Fixup boot failed when CONFIG_SMP
Date:   Tue, 10 Mar 2020 13:38:18 +0100
Message-Id: <20200310123640.610127709@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit c9492737b25ca32679ba3163609d938c9abfd508 ]

If we use a non-ipi-support interrupt controller, it will cause panic here.
We should let cpu up and work with CONFIG_SMP, when we use a non-ipi intc.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b753d382e4cef..0bb0954d55709 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -120,7 +120,7 @@ void __init setup_smp_ipi(void)
 	int rc;
 
 	if (ipi_irq == 0)
-		panic("%s IRQ mapping failed\n", __func__);
+		return;
 
 	rc = request_percpu_irq(ipi_irq, handle_ipi, "IPI Interrupt",
 				&ipi_dummy_dev);
-- 
2.20.1



