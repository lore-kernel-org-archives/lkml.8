Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09867C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B521520658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693625;
	bh=BSX9EcTnUekZaIJkQio+Eo14SvKz1ux0nZh1+7uibnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3RKMu+Hz6kPnkjv1SdHB/jnkvoazfE356tOUtV//WxFN7PdKVywUWnRWvDSDDbVG
	 ssTYf4G4E28WqkMbtsH5ZaiSARz8ul834qKmm4V6WIQzpEYnYGZw64X7OFdsfQo3zS
	 r7wDO/HuQ0sTr4NZ4Ywtm9hd6FZDC8AyBi50iHyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbgHQTrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgHQPVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:21:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E6A20709;
        Mon, 17 Aug 2020 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677661;
        bh=BSX9EcTnUekZaIJkQio+Eo14SvKz1ux0nZh1+7uibnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2I+PZ5xznCoUzDl7dk2wQTXaH8T/sn0xTinV9QFBZCMG/wlIW0tLi2W6a3PpvV7US
         /nGl3Az1QJ8edZbTB32PgDQixI+4T0m90zE2aWk5pCIRU4waKA1XgQ+koETfFqpo8i
         mADijbgikiWd3OAbxM2MIaPdgym5K/SSBIku9QfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 063/464] irqchip/loongson-htvec: Fix potential resource leak
Date:   Mon, 17 Aug 2020 17:10:16 +0200
Message-Id: <20200817143836.783964413@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 652d54e77a438cf38a5731d8f9983c81e72dc429 ]

In the function htvec_of_init(), system resource "parent_irq"
was not released in an error case. Thus add a jump target for
the completion of the desired exception handling.

Fixes: 818e915fbac5 ("irqchip: Add Loongson HyperTransport Vector support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1594087972-21715-4-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-htvec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 1ece9337c78dc..b36d403383230 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -192,7 +192,7 @@ static int htvec_of_init(struct device_node *node,
 	if (!priv->htvec_domain) {
 		pr_err("Failed to create IRQ domain\n");
 		err = -ENOMEM;
-		goto iounmap_base;
+		goto irq_dispose;
 	}
 
 	htvec_reset(priv);
@@ -203,6 +203,9 @@ static int htvec_of_init(struct device_node *node,
 
 	return 0;
 
+irq_dispose:
+	for (; i > 0; i--)
+		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
 free_priv:
-- 
2.25.1



