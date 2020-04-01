Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11549C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F35420705
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759651;
	bh=TnaegqLutaCcUAWij8JhdcO3zXmQdHFlD4ZdAEXwmjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JDV1kjLPZtsK2F6kJu3crz2O8uD2XnxZsTyAD2JaNmBFA5nYIZa9CCKycDQGAwO7p
	 ys65CF+Nn9wecBraHtA0O7B3iPnGqd5A977vMjplgmABec0sJ5eTJqYZ0ncv6fQAeU
	 n051n8fXnrveywDbTS8SfWwsbgNpu26mNpV8He9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbgDAQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390058AbgDAQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:47:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C947E20705;
        Wed,  1 Apr 2020 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759647;
        bh=TnaegqLutaCcUAWij8JhdcO3zXmQdHFlD4ZdAEXwmjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBs+mqxqSNS3FeHRRhyzLeZJKA6YRbqXqMZxhtMqYYx10H+Dx0OMeyF+0dCxd6+I0
         gjbOJkdbuU5Jya5vAt9O1z+zuJ92Iy8K6Kr55axsg1RqBSElCQosaPn22ADSjowQzj
         8b8Kq9PzpCiTQ+7+uyTcv5ZuuOai8fMBz6N4WIJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Hudson <skrll@netbsd.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.14 146/148] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
Date:   Wed,  1 Apr 2020 18:18:58 +0200
Message-Id: <20200401161606.062822760@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hudson <skrll@netbsd.org>

commit 6687c201fdc3139315c2ea7ef96c157672805cdc upstream.

Define the sdhci pinctrl state as "default" so it gets applied
correctly and to match all other RPis.

Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
Signed-off-by: Nick Hudson <skrll@netbsd.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -118,6 +118,7 @@
 &sdhci {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	non-removable;


