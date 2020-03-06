Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005612072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCFAWs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:22:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCFAWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:22:47 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jA0l3-0006jB-1X; Fri, 06 Mar 2020 01:22:29 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add doc for Pine64 Pinebook Pro
Date:   Fri, 06 Mar 2020 01:22:27 +0100
Message-ID: <2185162.N5mF8xYTKh@phil>
In-Reply-To: <20200304213023.689983-2-t.schramm@manjaro.org>
References: <20200304213023.689983-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. März 2020, 22:30:22 CET schrieb Tobias Schramm:
> From: Emmanuel Vadot <manu@freebsd.org>
> 
> Add a compatible for Pine64 Pinebook Pro
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

applied for 5.7, but moved above Rock64 ;-)

Thanks
Heiko


