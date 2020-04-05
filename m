Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4CC2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40935206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="QJ79tLBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgDEOyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:54:45 -0400
Received: from vps.xff.cz ([195.181.215.36]:38982 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgDEOyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1586098483; bh=YvInvH/mqpjWA9tS3gUA31bXJDMR40kHIKld7q04mmg=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=QJ79tLBwI18mxgsos5s6y/yEYEzpyGors8eAHWB3JvCsqxbtpH0uyxMCT3YGmbbfF
         A8Rnk9/WZSr2nDyyx0DlHucdax5BmYhZ1E8B6Cyh9JiRX7+nRDVRF0eLgVfAyMxejI
         c5y2X6oLpB3ckC9eG1gXqQSHdVvyBJUOiptaBqX0=
Date:   Sun, 5 Apr 2020 16:54:43 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200405145443.uycsh73kxmurdmil@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
 <20200405115138.vrrvv7spnv6ifm6x@core.my.home>
 <CAJiuCcfAKCs5ZLi_O21eyx-ZraC2Sb_ugQSmOEYm5+eVkQ7ZSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcfAKCs5ZLi_O21eyx-ZraC2Sb_ugQSmOEYm5+eVkQ7ZSw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 05, 2020 at 04:33:37PM +0200, Clément Péron wrote:
> Hi Ondřej,

[ ... ]

> Good point, this information should be added for both CPU and GPU regulator.
> This could be nice to confirm this point with a scope.
> 
> Also I remark that Allwinner user higher temperature than what we set :
> alarm_low_temp = <105000>;
> alarm_high_temp = <110000>;
> alarm_temp_hysteresis = <15000>;
> shut_temp= <115000>;
> https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L1924
> 
> Don't you think that we can push a bit higher the temperature it's
> actually at 80°C ?

We probably can. But just 5°C between high temp and criticla temp is probably
not enough. I'd probably set our value to something like 90-100°C so that quick
temperature spike before regulation kicks in would not shutdown the CPU.

regards,
	o.

> Thanks for the review,
> Clement
> 
