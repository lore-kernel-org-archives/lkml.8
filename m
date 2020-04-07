Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B36C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A3206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hyx/r2qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgDGOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:16:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42430 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgDGOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:16:35 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B59B859E;
        Tue,  7 Apr 2020 16:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586268993;
        bh=CcU2iAia1wY4OY0Wlixli88UQl/oDVQJd3BN2oHVZs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hyx/r2qvOlhW/upsn1igaKv3oxlLGcSnhX+2DoQ0FH+lQrwx8zYoWNsqDWEBT4CKj
         oPNY9yZdASHuEJaHeFRyZAnMLIC3Fo9mHavnwXkFOAwGBriB9/5rKXn/AP7AqGoVFv
         r5MsZwh13hLhgZBGK7HbMd3B5QlAYYCZcPkHptlA=
Date:   Tue, 7 Apr 2020 17:16:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/4] defconfig: fix changed configs and refresh
Message-ID: <20200407141624.GG4751@pendragon.ideasonboard.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
 <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Apr 07, 2020 at 03:16:14PM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> > Three configs have been renamed and/or changed behaviour.
> > Clean that by using the new config name.
> > Then refresh the defconfig with make defconfig savedefconfig.
> >
> > The refreshed defconfig does result in a not changed .config.
> >
> > Applies on linux-next/master tag: next-20200407
> >
> > Max Krummenacher (4):
> >   arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
> >   arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
> >   arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
> >   arm64: defconfig: refresh
> 
> Probably CONFIG_DRM_DISPLAY_CONNECTOR should also be enabled for HDMI,
> VGA, and composite display connectors on various boards since commit
> 0c275c30176b2e78 ("drm/bridge: Add bridge driver for display
> connectors"), but it's not clear to me when exactly this became a
> requirement, as before there was no code that looked for e.g.
> vga-connector.
> Laurent?

It's not required yet for R-Car DU, but I'm working on changing that :-)
If we can enable CONFIG_DRM_DISPLAY_CONNECTOR in defconfig as part of
this series, it would be useful for me.

-- 
Regards,

Laurent Pinchart
