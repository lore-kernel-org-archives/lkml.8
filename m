Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45604C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEC420720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWtwK76S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2CZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:25:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgA2CZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 21:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HILDSvPRsZHmEArR0PMVzasAJNRt38VzhSWvR3P31I8=; b=ZWtwK76SjN81h5GhxumXa8bsQ
        XgdeUzY/KSYDm/q34/e4zgf2vnyBKI/RqSnCiuwWJXwxwZ9zGRXs2pbZJLsCpVjxhOA8um5Wah1e5
        A0iFEokIQrfAYUccC17FH+fz8Yo004XrAJbI2jis8/cpJoTZo7Tgr7inPXs1erEOi5OOW9hkNHjEq
        zSS3OSJiqXeRKnEsBZ0Xuz9nbzNhYsDKCNg5G47oB0PRu6Pz3GyVfFod3FVVEy/a1ZrTSErORl2rJ
        iESp08qFEDIwz/eaJ3eOPeYclmwqM78jfLm+CS/0qLTBzg7O4n2i4AazbbnOARFTwtGPUhdIAeCD7
        z8nSqS27Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwd2a-0000Ro-63; Wed, 29 Jan 2020 02:25:16 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RESEND] irqchip: some Kconfig cleanup for C-SKY
Message-ID: <d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org>
Date:   Tue, 28 Jan 2020 18:25:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fixes to Kconfig help text:

- spell out "hardware"
- fix verb usage

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
---
 drivers/irqchip/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200128.orig/drivers/irqchip/Kconfig
+++ linux-next-20200128/drivers/irqchip/Kconfig
@@ -438,7 +438,7 @@ config CSKY_MPINTC
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
 	  for C-SKY SMP system.
-	  In fact it's not mmio map in hw and it use ld/st to visit the
+	  In fact it's not mmio map in hardware and it uses ld/st to visit the
 	  controller's register inside CPU.
 
 config CSKY_APB_INTC
@@ -446,7 +446,7 @@ config CSKY_APB_INTC
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY APB interrupt controller driver used
-	  by C-SKY single core SOC system. It use mmio map apb-bus to visit
+	  by C-SKY single core SOC system. It uses mmio map apb-bus to visit
 	  the controller's register.
 
 config IMX_IRQSTEER

