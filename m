Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF1C433EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C771E2065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je2dR1bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGRJU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC828C0619D2;
        Sat, 18 Jul 2020 02:20:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so7856635pgq.1;
        Sat, 18 Jul 2020 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPz9PqO9Fqan7fgK9F0BFc881ZLwxwDTW7XHlYlGQII=;
        b=Je2dR1bAFL2DpRZeffZ72m+vvYqZGOkck7LsbrjSfzvVXDJRqBt4uPs1r5zzhI2Ehv
         0bHZDbS9+/c4ZA4fVkm3VJnRpQRuJK4gpo5GzY2Qi9HEq1f0eQMvDADvH3a244sQfLbc
         AtxS+NBQ27Shwf5FrJVWqenviRZCy91jCI96lGvqFofpZSqzlghNJrIwWPra85Oss4gM
         XlYstoNOk88A/fNeyDfhjC1RVYzfef+b1eTUScYHRYk+qANfqK2xd8SRSJ6uJn8iRyM4
         pWofsrOsFc31e1orAv95bfi8NQkO8wYN5EB17yihlRxzeCy7Rwfhj9ny+hWg0vhOm+42
         1UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VPz9PqO9Fqan7fgK9F0BFc881ZLwxwDTW7XHlYlGQII=;
        b=fwdgp/GFirYdDIE4wbvfMS5Da9Iuxu7bNmyK7+tmrw2cliQ5lZ3fZhZUAq0b1EIA0F
         KAr5P9gLlc3/GDaBG0vSYgXJVQABNhzqOLaCr4eEHuIU2RkXCf9okUH7qfdkaTyv+Ovs
         Fs0BOGGn41FT8KDAx25tXsd+L+AC4bIy7+akO9oBjbbFaborm8rGqLJ9KFSTnmPik/Xg
         7jlE8UKK1S0RLXEjZSGcLbttnYFe+3P+n+lbjr5uqfA3zETuAf7iHwtfCohjJSJbyCXI
         rUfb8jQzqHRWj0kLS2wkb2WbXqVKjNUhuR3UCoZqexNpMnf92/o3ci4BZ0qUucQzcZ/y
         bRlA==
X-Gm-Message-State: AOAM531gewpOAusC44uZPqhLbuaOs7CkemhFPrW9K/fO6k/0Uk7oRZPy
        J/CeHPa6VSomR9UBnt+UOWs=
X-Google-Smtp-Source: ABdhPJxeAlYCHfG6arM5pN4J/6BocT8Uxjj31ay2Co5u+K7ginHHumgJ+ahENZRQ1pUz+Y3suEN8ig==
X-Received: by 2002:a63:df56:: with SMTP id h22mr11642652pgj.140.1595064028398;
        Sat, 18 Jul 2020 02:20:28 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:27 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 05/10] arm64: dts: actions: limit address range for pinctrl node
Date:   Sat, 18 Jul 2020 14:49:29 +0530
Message-Id: <1595063974-24228-6-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for
Actions Semi S700") following error has been observed while booting
Linux on Cubieboard7-lite(based on S700 SoC).

[    0.257415] pinctrl-s700 e01b0000.pinctrl: can't request region for
resource [mem 0xe01b0000-0xe01b0fff]
[    0.266902] pinctrl-s700: probe of e01b0000.pinctrl failed with error -16

This is due to the fact that memory range for "sps" power domain controller
clashes with pinctrl.

One way to fix it, is to limit pinctrl address range which is safe
to do as current pinctrl driver uses address range only up to 0x100.

This commit limits the pinctrl address range to 0x100 so that it doesn't
conflict with sps range.

Fixes: 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for Actions
Semi S700")

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v5:
	* Added Mani's Reviewed-by: tag.
Changes since v4:
        * Reordered it from 04/10 to 05/10.
Changes since v3:
        * No change.
Changes since v2:
        * this is no more don't merge and fixed
          the broken S700 boot by limiting pinctrl
          address range.
        * Modified the subject to reflect the changes.
Changes since v1:
        * No change.
Changes since RFC:
        * kept as do not merge.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2006ad5424fa..f8eb72bb4125 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -231,7 +231,7 @@
 
 		pinctrl: pinctrl@e01b0000 {
 			compatible = "actions,s700-pinctrl";
-			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			reg = <0x0 0xe01b0000 0x0 0x100>;
 			clocks = <&cmu CLK_GPIO>;
 			gpio-controller;
 			gpio-ranges = <&pinctrl 0 0 136>;
-- 
2.7.4

