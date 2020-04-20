Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE0120A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Ql7xHYAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTK1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:27:14 -0400
Received: from vps.xff.cz ([195.181.215.36]:53266 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTK1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1587378431; bh=o62eKdBWITau5Cn4J0cykM+HQVejW+cPPQs4pz5s9gE=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=Ql7xHYAz0EL8wAdFvHCBeD7yJ1M+OZ3T1Qj8MgauhSeO4oCK/8hHaY7K8xg3d6IvP
         /7lrGbdhKlZW0z4cYThrhr/FAg8MusoUx23eP3pCMTHdE/pO3btP1XOBKzTZh2CLlI
         IBWwdCwX5nru7DaINj9TdP/+gt7pT60xLu1Uvdt8=
Date:   Mon, 20 Apr 2020 12:27:11 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v3 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200420102711.4ozfiiakvgisukpk@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
 <20200420094801.ltsittj3gdrbbr3u@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420094801.ltsittj3gdrbbr3u@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:48:01AM +0200, megous hlavni wrote:
> Hello Clément,
> 
> On Sun, Apr 19, 2020 at 03:50:04PM +0200, Clément Péron wrote:
> > Hi Sunxi maintainers and members,
> > 
> > Now that required drivers are merged we can contibute on DVFS
> > support for Allwinner H6.
> > 
> 
> [ snip ]
> 
> > 
> > Changes since v2 (thanks to Maxime Ripard):
> >   - Change Orange Pi boards to Orange Pi 3
> >   - Change soc speed nvmem node name
> >   - Fix device tree warnings
> >   - Drop GPU opp tables
> 
> Looks like you may have also inadverently dropped the second patch from v2
> series that implemented CPU thermal trip points.

Also it looks like the patch 1 from v2 implementing the clock properties
is missing from v3, and I don't see it being already applied anywhere.
Without that cpufreq doesn't work.

Also, thermal trip points need to be in the opp.dtsi to avoid dtc warnings
during build.

https://megous.com/git/linux/commit/?h=ths-5.7&id=cacefd7decf5ae0ce42ab4d48a13a58552929ebd

regards,
	o.

> > Changes since v1 (thanks to Ondřej Jirman):
> >   - Remove Polling thermal
> >   - Add Orange Pi boards
> >   - Remove minimal voltage change for Beelink GS1
> >   - Add ramp-deplay for GPU and CPU regulators
> >   - Push to thermal point to 85°C (Allwinner set them to 100°C and 115°C)
> >   - Added 1.6GHz and 1.7GHz to OPP table.
> > 
> > Clément Péron (6):
> >   arm64: configs: Enable sun50i cpufreq nvmem
> >   arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
> >   arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
> >   arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
> >   arm64: dts: allwinner: Sort Pine H64 device-tree nodes
> >   arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Pine H64
> 
> You may also want to fix title of this patch to drop the GPU reference.
> 
> thank you and regards,
> 	o.
> 
> > Ondrej Jirman (1):
> >   arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
