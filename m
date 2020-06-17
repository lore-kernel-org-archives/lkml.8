Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6B8212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFQIhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:37:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgFQIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:37:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlTZJ-0005rL-1X; Wed, 17 Jun 2020 10:37:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rename and label gpio-led subnodes part 2
Date:   Wed, 17 Jun 2020 10:37:09 +0200
Message-Id: <159238301927.1406601.9417520180577782611.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522154657.9472-1-jbx6244@gmail.com>
References: <20200522154657.9472-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 17:46:57 +0200, Johan Jonker wrote:
> Current dts files with 'gpio-led' nodes were manually verified.
> In order to automate this process leds-gpio.txt
> has been converted to yaml. With this conversion a check
> for pattern properties was added. In part 2 rename and label
> gpio-led subnodes that passed the regex, but still don't have
> the preferred form. Any pin subnode that ends with '-gpio'
> in the pinctrl node generates a warning.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rename and label gpio-led subnodes part 2
      commit: 6dd5e12c0b9bba40b3947ac1a9fd2f992585b5c6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
