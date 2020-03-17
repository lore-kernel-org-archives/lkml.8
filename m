Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001FCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D428B2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbgCQA04 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:26:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51502 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733009AbgCQA0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:26:55 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE04K-0004Ns-3D; Tue, 17 Mar 2020 01:26:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix vref-supply for &saradc node rk3288 firefly reload
Date:   Tue, 17 Mar 2020 01:26:51 +0100
Message-ID: <2367208.yvSAVzBJkc@phil>
In-Reply-To: <20200314140755.4877-1-jbx6244@gmail.com>
References: <20200314140755.4877-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 14. März 2020, 15:07:55 CET schrieb Johan Jonker:
> A test with the command below gives this error:
> 
> arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml: saradc@ff100000:
> 'vref-supply' is a required property
> 
> PMIC Channel OUT11 with powername 'vcc_18'
> (connected through R155 bridge with 'vccio_wl')
> is used for the recovery key and ADC_AVDD_1V8.
> 
> Fix error by adding 'vcc_18' as vref for the saradc.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/
> rockchip-saradc.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


