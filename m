Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C894B204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHXNmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:42:02 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53898 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgHXNfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:35:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 673CAFB03;
        Mon, 24 Aug 2020 15:35:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aJ1hfcJNSXF6; Mon, 24 Aug 2020 15:35:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4E43A45869; Mon, 24 Aug 2020 15:35:20 +0200 (CEST)
Date:   Mon, 24 Aug 2020 15:35:20 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm64: dts: imx8mq: Add NWL DSI host controller
 to Librem 5 Devkit
Message-ID: <20200824133520.GA20386@bogon.m.sigxcpu.org>
References: <cover.1598166983.git.agx@sigxcpu.org>
 <20200824124635.GE12776@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824124635.GE12776@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Aug 24, 2020 at 08:46:36PM +0800, Shawn Guo wrote:
> On Sun, Aug 23, 2020 at 09:18:06AM +0200, Guido Günther wrote:
> > These patches add the NWL host controller to the imx8mq and make use of it on
> > the Librem 5 Devkit enabling the built in MIPI DSI LCD panel.
> > 
> > I opted to add imx8mq internal ports and endpoints between nwl and lcdif to the
> > generic dtsi since those are SOC rather than board specific properties.
> > 
> > Changes from v3
> > - Rebase patch 3 and 4 against Shawn's imx/defconfig
> >   Patches 1 an 2 got already applies, thanks!
> > 
> > Changes from v2
> > - Add Tested-by from Martin Kepplinger, thanks!
> >   https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m067f2d659fcd1c0cb7792b22d0c4db06ed235815
> >   https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m9aff315ee38fd9bbcd3a896876726c14b2fb7048
> > 
> > Changes from v1
> > - Add Reviewed-by from Fabio Estevam, thanks!
> >   https://lore.kernel.org/linux-arm-kernel/CAOMZO5DUA5eS8apZPbte0EcSQ4Vwpg6YLK7D0YdjSUy+kdBu8Q@mail.gmail.com/
> >   https://lore.kernel.org/linux-arm-kernel/CAOMZO5ANrd2JCmHyxZ0Sv0WNcU9T-q3MbaeADxbOwf+31MQ4LQ@mail.gmail.com/#t
> >   https://lore.kernel.org/linux-arm-kernel/CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com/
> > - As per review comment by Fabio Estevam
> >   Re-sync DRM related defconfig bits. I didn't resyc the whole defconfig since
> >   this is pretty much kernel version dependent.
> > 
> > Guido Günther (2):
> >   arm64: defconfig: re-sync DRM related defconfig bits
> >   arm64: defconfig: Enable imx8mq-librem5-devkit display stack
> 
> Applied both, thanks.

Thanks!
 -- Guido
