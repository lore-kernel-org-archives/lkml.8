Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CFC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F322080D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598151392;
	bh=iyFPi017R6uQQFW1MDqjSaSTXPbfRJ3RbkpUEyl+BK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nyXEU27Xq8N77Ls6WMZJdsF0/FcijQkRhrd6aZIqHVzkBXNduhanyCMhOdxI87rDB
	 DzaXNzd5fJFzD1/XMTyhMkMCskEqTwmKZHnqKiQsewXhe05gUZ3vFPUUvcz0aETJJo
	 dynrUnFaKU27tOfSqrm2dmEfvOr+4zyAQke+7mnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHWC4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHWC4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:56:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E15E42072D;
        Sun, 23 Aug 2020 02:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598151390;
        bh=iyFPi017R6uQQFW1MDqjSaSTXPbfRJ3RbkpUEyl+BK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVRCUi2I6h4HGir9GpwFKUd1qF0xLASBjpacqS4VGOqf2e7NcqrtmgRkvWo1Ug00z
         FP22ACX8Ytucig8ed1gyCto/W8vqpBupyNurRmqFgn8x85bK/0h091LYsClYKMmr3f
         syxKX+2l7lAujvAq7QfA9YXhSuy5ck3JJcM3+f7w=
Date:   Sun, 23 Aug 2020 10:56:22 +0800
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
Subject: Re: [PATCH v2 3/4] arm64: defconfig: re-sync DRM related defconfig
 bits
Message-ID: <20200823025622.GR30094@dragon>
References: <cover.1597913263.git.agx@sigxcpu.org>
 <e13be6f742ecdf06f7000af6e8e5ec5bcb65f7f0.1597913263.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e13be6f742ecdf06f7000af6e8e5ec5bcb65f7f0.1597913263.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:50:58AM +0200, Guido Günther wrote:
> This moves the CONFIG_DRM_SIMPLE_BRIDGE entry around making further
> updates simpler.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Patch #3 and #4 do not apply to my branch.

Shawn
