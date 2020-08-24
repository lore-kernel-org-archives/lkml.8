Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E34420639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USYQV3t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHXSaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:30:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9BC061573;
        Mon, 24 Aug 2020 11:30:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so4967491pgh.6;
        Mon, 24 Aug 2020 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvahKbRIpaFw4iDFms58BHKJX5qJVF7TGaQHbBglo1Q=;
        b=USYQV3t+wV42/UGZaeIIOH0qk8f3VEaRroVBT74bC6gIah8i5jwxPLwwMA2ElVq6wG
         w0nU3uXq+y8QnaBpZRtQwX/U7jY/2OXZX7ALpJjv9upxAkVMLamh5rUHwvE1JM2vyN3L
         s8x2HoCtkKU/l6MwQepHdfmgEvgd8o7PzgqaZbjyxCeHohEp43LcxI6xPxJWvZh/wutO
         i3W+ufTYc61BXBcbRpO6tjF2abCwFjrUZcg/WtzhwP8pudifB7GFGjJbRdxAU+3SKwRj
         cM5NRcSpKgBiKUe0+f7tp5/gx5mvMq8wrqLs8cH7mQC+f73PCIRo+TincUihwrqkYU9U
         Q6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvahKbRIpaFw4iDFms58BHKJX5qJVF7TGaQHbBglo1Q=;
        b=Tzmp9crGnkH/sNM01oLN7DhCk6IRHMab7Sq/awM2p+Dds04IX1anU/U83Hhf9NZobo
         0UxGYUKCZjln6bUkQc8LJsAvjQHiAEq+nFXU0x4UVkZbZShUZA5rKiM+TlEPpYvelkD+
         6Dx5xjoiJhP3R3VdAqCtM6AMsGLf+xCzIc56JfgwnfflrnzWzZs6Kgi24U6OBKSAiRrT
         gk/qk+HL0t4YRW35WD6O30MKeOw4YCn5QQzzwx5F+xx9zdx9cWfbTwAUeeBwOyeim5Mo
         YLkobVkwx09NSB36jcZviZgxio+Jv+nVux2Kmxre9ZRNnntvTlJeGeVdx+845QGA5cK+
         zY+Q==
X-Gm-Message-State: AOAM532WPIWpTWwwh+bQJw8hZ5jFQ1QepHljwHFiYFvhDikBxHd4AylN
        ffOLeyupYaEiuSuqCZCklbo=
X-Google-Smtp-Source: ABdhPJwOcYBnWFbgKF+6O2k9o9I+Z1j8AlUiizd4ou69B2Cwjcf4cGLwm9hW0621dJdwD7JdcGWN8w==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr4315839pll.299.1598293813850;
        Mon, 24 Aug 2020 11:30:13 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a66sm3920460pfa.176.2020.08.24.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:30:13 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: wedge40: Update UART4 pin settings
Date:   Mon, 24 Aug 2020 11:29:55 -0700
Message-Id: <20200824182955.7988-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824182955.7988-1-rentao.bupt@gmail.com>
References: <20200824182955.7988-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable UART4's NRTS4 (A19) pin because the pin is used for RS485
software emulation.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 3f2a48fa77b3..8c426ba2f8ab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -71,7 +71,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
+		     &pinctrl_rxd4_default
+		     &pinctrl_ndts4_default>;
 };
 
 &uart5 {
-- 
2.17.1

