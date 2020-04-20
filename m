Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79128C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561B72082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lo/nsXDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDTKja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:39:30 -0400
Received: from vps.xff.cz ([195.181.215.36]:53552 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1587379168; bh=3JRQF0O3I0HdGeUd7K/NKhUR4du8lhknE+/rA7T8Zt8=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=lo/nsXDihOXxSgFONiiZSxKacqThKmQwRJzPH0c9i82cpOUg6AA8DobDnPl907DXK
         yag95t79gqoJpHulcgLzU5mBN6LR7Acrlg3e5O7p9y+bYhah0hO+0DEIxnHVRIgI/F
         83UqnrTkPe1NSo+6/f22xh4cx95o+JhPzwC2S29E=
Date:   Mon, 20 Apr 2020 12:39:27 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200420103927.uvzotrolz2inz6q2@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
 <20200420084547.q5xqlbnmug7l45p2@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420084547.q5xqlbnmug7l45p2@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Apr 20, 2020 at 10:45:47AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Apr 19, 2020 at 03:50:04PM +0200, Clément Péron wrote:
> > Now that required drivers are merged we can contibute on DVFS
> > support for Allwinner H6.
> > 
> > This serie is based on Yangtao Li serie[0] and Ondřej Jirman work[1].
> > 
> > Most of the OPP tables are taken from original vendor kernel[2].
> > Plus there are new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > 
> > I wrote a simple script to randomly set a frequency during
> > a random time[3]. This script is quite stressfull and set some high
> > frequency without checking temperature. This can result on behavior
> > that whould not occurs with the real cpufreq framework.
> > As Maxime point out I also tested with cpufreq-ljt-stress-test
> > (found here https://github.com/ssvb/cpuburn-arm).
> > This script doesn't trigger any issue.
> > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > works. As CPU regulator is only set for CPU0.
> > 
> > The GPU devfreq was drop as the regulator is still not properly
> > drive by panfrost driver[4].
> > I will re-introduce it later.
> > 
> > Ondřej Jirman has an Orange Pi 3, Jernej has a PineH64 and a Tanix
> > TX6 boards and I have a Beelink GS1 board so I have enable these
> > boards. But CPU Devfreq is really touchy has it depends on:
> > board design, SoC speed_grade and environement which can affect
> > thermal cooling and have different behavior for different user.
> > 
> > If people can test this serie and give feedback, I will try to
> > introduce this in LibreElec tree, so LE community can test it.
> 
> Applied all of them, thanks!

Please also apply "[PATCH v2 1/7] arm64: dts: allwinner: h6: Add
clock to CPU cores" from the v2 series, otherwise cpufreq will
not work.

I can also send a missing patch adding the trip points, and cpu
as a cooling device, that I linked in my other reply to this patch
series afterwards, if Clément wants.

regards,
	o.

> Maxime


