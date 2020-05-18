Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F35207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgERW2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:28:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52638 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgERW2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:11 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoEv-00005F-Ff; Tue, 19 May 2020 00:28:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ARM: dts: rockchip: rename and label gpio-led subnodes
Date:   Tue, 19 May 2020 00:27:59 +0200
Message-Id: <158984064169.2259329.4243090830868839814.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428144933.10953-1-jbx6244@gmail.com>
References: <20200428144933.10953-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 16:49:32 +0200, Johan Jonker wrote:
> Current dts files with 'gpio-led' nodes were manually verified.
> In order to automate this process leds-gpio.txt
> has been converted to yaml. With this conversion a check
> for pattern properties was added. A test with the command
> below gives a screen full of warnings like:
> 
> arch/arm/boot/dts/rk3188-radxarock.dt.yaml: gpio-leds:
> 'blue', 'green', 'sleep'
> do not match any of the regexes:
> '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
