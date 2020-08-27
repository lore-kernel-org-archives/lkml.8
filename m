Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88EE22B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598512075;
	bh=N/nhk9ZU4iq0+cgOvmAy8U6IL85LhG10MTNPMpmXw0M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TjA8sG8TZWRKvlHXXRixqWK2JZWEpZ2EVHJlEeNYPelEjaY2EvGjFHY+KiA5w6kIA
	 LDqATEBlohR/N1glX6n+FKB0fUJ0t4J6J6ch4SVT895/AYFGpxiDOQHs7W0Gy2l+ez
	 JBRdCGUhZ9aFie957HammvxnJKNDdbXegVnUUVsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgH0HHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0HHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:07:51 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F9F20786;
        Thu, 27 Aug 2020 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598512071;
        bh=N/nhk9ZU4iq0+cgOvmAy8U6IL85LhG10MTNPMpmXw0M=;
        h=From:To:Cc:Subject:Date:From;
        b=UtVeiKwEjA811MRUai0bNAO/xw87FSHGWyrpQrDg32A/0z24mHKXEQ3gH2p6R+6P6
         9s1CpkfYQxiILIMcpsPAk0Hs01ZBhyQbzMoXlFUqxk3wcocXXiVWJA3at0kDS2OLra
         5hotaSRyL5GfHdrORiUMVhV2Z0AhqKmi0o8U9glg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Tero Kristo <t-kristo@ti.com>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] EDAC/aspeed: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:07:42 +0200
Message-Id: <20200827070743.26628-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/edac/aspeed_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index b194658b8b5c..fbec28dc661d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -209,8 +209,8 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 	/* register interrupt handler */
 	irq = platform_get_irq(pdev, 0);
 	dev_dbg(&pdev->dev, "got irq %d\n", irq);
-	if (!irq)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
 			      DRV_NAME, ctx);
-- 
2.17.1

