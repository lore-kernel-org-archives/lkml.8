Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E16C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC08B221F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="LDHslhvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDTJsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:48:04 -0400
Received: from vps.xff.cz ([195.181.215.36]:52748 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTJsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1587376081; bh=kvg/KPchN1Bd4x4Qv/4aiZ1j8gCVrRDg80fgEeNCT3w=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=LDHslhvFYkNvK5LvMAotJMKWV1Oyixl1P0cwrXBL45Fr3c1qZIqNW0bxcZLXITig4
         f/DpPOBGtsRKQJfjFTcdxD7J6Ss/ZC7HiH5Cf3bNqWtpztoJwT4noCkJ88+KCmCrnV
         GG+vlLU/1hj6lL0MSyXrB3F3b7EhsCh6OF++1eXI=
Date:   Mon, 20 Apr 2020 11:48:01 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v3 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200420094801.ltsittj3gdrbbr3u@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clément,

On Sun, Apr 19, 2020 at 03:50:04PM +0200, Clément Péron wrote:
> Hi Sunxi maintainers and members,
> 
> Now that required drivers are merged we can contibute on DVFS
> support for Allwinner H6.
> 

[ snip ]

> 
> Changes since v2 (thanks to Maxime Ripard):
>   - Change Orange Pi boards to Orange Pi 3
>   - Change soc speed nvmem node name
>   - Fix device tree warnings
>   - Drop GPU opp tables

Looks like you may have also inadverently dropped the second patch from v2
series that implemented CPU thermal trip points.

> Changes since v1 (thanks to Ondřej Jirman):
>   - Remove Polling thermal
>   - Add Orange Pi boards
>   - Remove minimal voltage change for Beelink GS1
>   - Add ramp-deplay for GPU and CPU regulators
>   - Push to thermal point to 85°C (Allwinner set them to 100°C and 115°C)
>   - Added 1.6GHz and 1.7GHz to OPP table.
> 
> Clément Péron (6):
>   arm64: configs: Enable sun50i cpufreq nvmem
>   arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
>   arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
>   arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
>   arm64: dts: allwinner: Sort Pine H64 device-tree nodes
>   arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Pine H64

You may also want to fix title of this patch to drop the GPU reference.

thank you and regards,
	o.

> Ondrej Jirman (1):
>   arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
