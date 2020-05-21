Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B8F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgEUARd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:17:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45466 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgEUARd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:17:33 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jbYtq-0005Re-SD; Thu, 21 May 2020 02:17:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix pinctrl-names for gpio-leds node on rk3326-odroid-go2
Date:   Thu, 21 May 2020 02:17:25 +0200
Message-Id: <159002021954.2754417.8270198597807714801.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519111444.2208-1-jbx6244@gmail.com>
References: <20200519111444.2208-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 13:14:44 +0200, Johan Jonker wrote:
> The 'pinctrl-names' property should contain a list of names
> to the assigned states. The value 'led_pins' in the gpio-leds
> node on rk3326-odroid-go2 is not a state that is normally used,
> so change it the common name 'default'.

Applied, thanks!

[1/1] arm64: dts: rockchip: fix pinctrl-names for gpio-leds node on rk3326-odroid-go2
      commit: b2cb68e864222eb3cc1d7c3c06edc40469699983

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
