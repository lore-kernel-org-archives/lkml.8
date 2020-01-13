Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A2FC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338DA20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAMHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:41:07 -0500
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:59570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728687AbgAMHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:41:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8B517182CED2A;
        Mon, 13 Jan 2020 07:41:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wood37_2679249ff1e4c
X-Filterd-Recvd-Size: 3273
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Jan 2020 07:41:04 +0000 (UTC)
Message-ID: <f35928f4e8f78be59617c0d49308001d92b314c7.camel@perches.com>
Subject: Re: [PATCH] rtc: i2c/spi: Avoid inclusion of REGMAP support when
 not needed
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 12 Jan 2020 23:40:10 -0800
In-Reply-To: <CAMuHMdXRpKJNm6tFjccO67dQr=_Hc4rD1NmJzzrHPDEyja0R5w@mail.gmail.com>
References: <20200112171349.22268-1-geert@linux-m68k.org>
         <9286d81a883f4795176182fdb9e69bc19a8232c7.camel@perches.com>
         <CAMuHMdXRpKJNm6tFjccO67dQr=_Hc4rD1NmJzzrHPDEyja0R5w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-13 at 08:25 +0100, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Mon, Jan 13, 2020 at 7:36 AM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2020-01-12 at 18:13 +0100, Geert Uytterhoeven wrote:
> > > Merely enabling I2C and RTC selects REGMAP_I2C and REGMAP_SPI, even when
> > > no driver needs it.  While the former can be moduler, the latter cannot,
> > > and thus becomes built-in.
> > > 
> > > Fix this by moving the select statements for REGMAP_I2C and REGMAP_SPI
> > > from the RTC_I2C_AND_SPI helper to the individual drivers that depend on
> > > it.
> > > 
> > > Note that the comment for RTC_I2C_AND_SPI refers to SND_SOC_I2C_AND_SPI
> > > for more information, but the latter does not select REGMAP_{I2C,SPI}
> > > itself, and defers that to the individual drivers, too.
> > > 
> > > Fixes: 080481f54ef62121 ("rtc: merge ds3232 and ds3234")
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > Joe: When merging addresses, scripts/get_maintainer.pl replaces
> > >      Alexandre's authoritative email address from MAINTAINERS by the
> > >      obsolete address in the SoB-line of the commit referred to by the
> > >      Fixes-line.
> > 
> > Hi Geert
> > 
> > What are you doing to get this changed output?
> 
> scripts/get_maintainer.pl
> 0001-rtc-i2c-spi-Avoid-inclusion-of-REGMAP-support-when-n.patch
> 
> > I get the same get_maintainer address output either way
> > with only with the 'blamed_fixes:' content added.
> 
> Thanks, I can confirm it's fixed in next-20200110.
> With v5.5-rc6, it still gives the old addresss.

Well, OK, get_maintainer is the same but there is a
different .mailmap in -next

$ git log --stat -p -1 94a250713
commit 94a25071301a898d8c603db2f05a0016eb7b7d28
Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Tue Dec 10 14:46:53 2019 +0100

    mailmap: Update email address for Alexandre Belloni
    
    Free Electrons is now Bootlin.
    
    Link: https://lore.kernel.org/r/20191210134653.2995661-1-alexandre.belloni@bootlin.com
    Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


