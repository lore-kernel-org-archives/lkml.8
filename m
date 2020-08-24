Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C5520706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598273217;
	bh=a+1o0PTMneX8uphjhwaL9LZrDMgRjnzdhnnVEaiH5/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7JhOakj1IeMJCmb6XQzntk5CjaTF4rJGyqia9NXwMC0YcCE0bBKy9h8VIEr2U1uI
	 3M5q2mx6wG/27mKgBHfC/PkL1q5j0Wy07H//ONa39zhdyWTFQqg+nns8rcwZ6kpUA4
	 vZR8S+AlaDsx60V6oiP/3YlY93qrBVo/qdPjUTC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHXMqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHXMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:46:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575FB20706;
        Mon, 24 Aug 2020 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598273210;
        bh=a+1o0PTMneX8uphjhwaL9LZrDMgRjnzdhnnVEaiH5/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYSR3P8WkqrqAyGOI6FNDvoDQmJ0PwtaDkr2sm5i9XWeN39lU1FsccYwrjaALiB//
         ijhLsFTHnbp2QlvcZI2VgUwr2k/SXPnTHWEwZ2HycV+wBWkP4ERIlnEEkeyKGOzwlA
         TXXieX61hkQ6siuGc6uMvtGAjTpE/ByuvfKKeDHo=
Date:   Mon, 24 Aug 2020 20:46:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
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
Message-ID: <20200824124635.GE12776@dragon>
References: <cover.1598166983.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1598166983.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 09:18:06AM +0200, Guido Günther wrote:
> These patches add the NWL host controller to the imx8mq and make use of it on
> the Librem 5 Devkit enabling the built in MIPI DSI LCD panel.
> 
> I opted to add imx8mq internal ports and endpoints between nwl and lcdif to the
> generic dtsi since those are SOC rather than board specific properties.
> 
> Changes from v3
> - Rebase patch 3 and 4 against Shawn's imx/defconfig
>   Patches 1 an 2 got already applies, thanks!
> 
> Changes from v2
> - Add Tested-by from Martin Kepplinger, thanks!
>   https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m067f2d659fcd1c0cb7792b22d0c4db06ed235815
>   https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m9aff315ee38fd9bbcd3a896876726c14b2fb7048
> 
> Changes from v1
> - Add Reviewed-by from Fabio Estevam, thanks!
>   https://lore.kernel.org/linux-arm-kernel/CAOMZO5DUA5eS8apZPbte0EcSQ4Vwpg6YLK7D0YdjSUy+kdBu8Q@mail.gmail.com/
>   https://lore.kernel.org/linux-arm-kernel/CAOMZO5ANrd2JCmHyxZ0Sv0WNcU9T-q3MbaeADxbOwf+31MQ4LQ@mail.gmail.com/#t
>   https://lore.kernel.org/linux-arm-kernel/CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com/
> - As per review comment by Fabio Estevam
>   Re-sync DRM related defconfig bits. I didn't resyc the whole defconfig since
>   this is pretty much kernel version dependent.
> 
> Guido Günther (2):
>   arm64: defconfig: re-sync DRM related defconfig bits
>   arm64: defconfig: Enable imx8mq-librem5-devkit display stack

Applied both, thanks.
