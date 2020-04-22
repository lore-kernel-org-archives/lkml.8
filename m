Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3800C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999D420656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551966;
	bh=ZaYqdeRvQZPigS+ANvJSCa11Eqd6O2GHEYnBCZcLTBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aNipmQ24OQXmObq7SmjViKRcT/rXok166PjGhAr8zD9TVXGE9I2s7VyNsYXd3DcC1
	 yW2BOLahqA5nlNhaxz+6VPEPpKQj3DrMdJk+irWWMqPheYe+Fe9X4unLAMifv/j6O1
	 HZd0PoQhIn9jMyjMtA+M39bhfVLqioZeamfVjI84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgDVKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgDVKV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:21:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C0520780;
        Wed, 22 Apr 2020 10:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550886;
        bh=ZaYqdeRvQZPigS+ANvJSCa11Eqd6O2GHEYnBCZcLTBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdzrHt/PRwr+dB/O1GnGvO4lN9yFD5N6ZvMvi5D5EPiBOuHQqt7rVh0BL59dOVLce
         6ZL+RQ/CgKK3j+hvqzsRGdnWDjStMX+fSOGo+4Bmt+mWHyeNYQPPyWfHT6UO3PJ6xJ
         lCsC+ny5hBA3XCZMTy6cM0+KHavGiadTztIqNUJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.6 015/166] irqchip/mbigen: Free msi_desc on device teardown
Date:   Wed, 22 Apr 2020 11:55:42 +0200
Message-Id: <20200422095049.987353070@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

commit edfc23f6f9fdbd7825d50ac1f380243cde19b679 upstream.

Using irq_domain_free_irqs_common() on the irqdomain free path will
leave the MSI descriptor unfreed when platform devices get removed.
Properly free it by MSI domain free function.

Fixes: 9650c60ebfec0 ("irqchip/mbigen: Create irq domain for each mbigen device")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200408114352.1604-1-yuzenghui@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mbigen.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -220,10 +220,16 @@ static int mbigen_irq_domain_alloc(struc
 	return 0;
 }
 
+static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	platform_msi_domain_free(domain, virq, nr_irqs);
+}
+
 static const struct irq_domain_ops mbigen_domain_ops = {
 	.translate	= mbigen_domain_translate,
 	.alloc		= mbigen_irq_domain_alloc,
-	.free		= irq_domain_free_irqs_common,
+	.free		= mbigen_irq_domain_free,
 };
 
 static int mbigen_of_create_domain(struct platform_device *pdev,


