Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCDC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D9220684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216825;
	bh=JThum9/paeUNDpn8XDYmH/coeUeKDxO9fVyraDChfEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ISHs8mNnUAq0fxUFSl4OAVvgF/UKHni4g3+gevSVMLNSXA3h4vLAwZNWnTit6qmb
	 u2clFxqGVa8Ru7fyLczlhd15F6Q4v45zu1cwF+KCHH0gOwX9ZQvIEj1I6m4nV1moNO
	 tVX1j7jOhy4T+li3TcYzXxzqpJDIdfp2G+hn9y8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgAPXUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390600AbgAPXUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CBD2073A;
        Thu, 16 Jan 2020 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216816;
        bh=JThum9/paeUNDpn8XDYmH/coeUeKDxO9fVyraDChfEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C06AL2oXu28pydTuTFwFSB5eBINY9LkQY/b3TgS8Tg1ewkjaP9pI8aP/4XihI73DP
         tfEte8FKm4XSduQMwcORKBbMJdqhzVhRGP/1nKFQLRZUM15gzRKWFy4lVVOXcdMwQS
         0uH0IxeP3y09QFlq9tq3SlCKNNFndRDDkeIFegEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 014/203] pinctrl: lochnagar: select GPIOLIB
Date:   Fri, 17 Jan 2020 00:15:31 +0100
Message-Id: <20200116231746.054979255@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit f7e36e18946b4ec756b9c5cf4fb8891be8d1e4a3 upstream.

In a rare randconfig build I came across one configuration that does
not enable CONFIG_GPIOLIB, which is needed by lochnagar:

ERROR: "devm_gpiochip_add_data" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_generic_free" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_generic_request" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_get_data" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!

Add another 'select' like all other pinctrl drivers have.

Fixes: 0548448b719a ("pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20191218163701.171914-1-arnd@arndb.de
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/cirrus/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -2,6 +2,7 @@
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
 	depends on MFD_LOCHNAGAR
+	select GPIOLIB
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF


