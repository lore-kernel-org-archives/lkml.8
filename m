Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A00C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C82075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMINK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:13:10 -0500
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:54500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728680AbgAMINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:13:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4536F1801323F;
        Mon, 13 Jan 2020 08:13:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: egg05_1b3c562f00915
X-Filterd-Recvd-Size: 4075
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Jan 2020 08:13:07 +0000 (UTC)
Message-ID: <b72846874d5ee367bf86e787ca2152f90d814a34.camel@perches.com>
Subject: Re: [PATCH] rtc: i2c/spi: Avoid inclusion of REGMAP support when
 not needed
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Jan 2020 00:12:12 -0800
In-Reply-To: <CAMuHMdVPFCiPtwuEhG9rd8c=aw=HnMBf+nCjftwux3m81W7igg@mail.gmail.com>
References: <20200112171349.22268-1-geert@linux-m68k.org>
         <9286d81a883f4795176182fdb9e69bc19a8232c7.camel@perches.com>
         <CAMuHMdXRpKJNm6tFjccO67dQr=_Hc4rD1NmJzzrHPDEyja0R5w@mail.gmail.com>
         <f35928f4e8f78be59617c0d49308001d92b314c7.camel@perches.com>
         <CAMuHMdVPFCiPtwuEhG9rd8c=aw=HnMBf+nCjftwux3m81W7igg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-13 at 08:57 +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 13, 2020 at 8:41 AM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-01-13 at 08:25 +0100, Geert Uytterhoeven wrote:
> > > On Mon, Jan 13, 2020 at 7:36 AM Joe Perches <joe@perches.com> wrote:
> > > > On Sun, 2020-01-12 at 18:13 +0100, Geert Uytterhoeven wrote:
> > > > > Merely enabling I2C and RTC selects REGMAP_I2C and REGMAP_SPI, even when
> > > > > no driver needs it.  While the former can be moduler, the latter cannot,
> > > > > and thus becomes built-in.
> > > > > 
> > > > > Fix this by moving the select statements for REGMAP_I2C and REGMAP_SPI
> > > > > from the RTC_I2C_AND_SPI helper to the individual drivers that depend on
> > > > > it.
> > > > > 
> > > > > Note that the comment for RTC_I2C_AND_SPI refers to SND_SOC_I2C_AND_SPI
> > > > > for more information, but the latter does not select REGMAP_{I2C,SPI}
> > > > > itself, and defers that to the individual drivers, too.
> > > > > 
> > > > > Fixes: 080481f54ef62121 ("rtc: merge ds3232 and ds3234")
> > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > ---
> > > > > Joe: When merging addresses, scripts/get_maintainer.pl replaces
> > > > >      Alexandre's authoritative email address from MAINTAINERS by the
> > > > >      obsolete address in the SoB-line of the commit referred to by the
> > > > >      Fixes-line.
> > > > What are you doing to get this changed output?
> > > 
> > > scripts/get_maintainer.pl
> > > 0001-rtc-i2c-spi-Avoid-inclusion-of-REGMAP-support-when-n.patch
> > > 
> > > > I get the same get_maintainer address output either way
> > > > with only with the 'blamed_fixes:' content added.
> > > 
> > > Thanks, I can confirm it's fixed in next-20200110.
> > > With v5.5-rc6, it still gives the old addresss.
> > 
> > Well, OK, get_maintainer is the same but there is a
> > different .mailmap in -next
> 
> Indeed.
> 
> However, I think the precedence should be
> 
>     MAINTAINERS > .mailmap > SoB in referenced commit
> 
> instead of
> 
>     .mailmap > SoB in referenced commit > MAINTAINERS
> 
> Do you agree?

Well, not really.  Priority is:

	1 .mailmap address
	2 SoB address in commit message
	2 SoB
address in referenced Fixes: commits
	3 MAINTAINERS address

MAINTAINER entries are sometimes stale and .mailmap
is generally more current so perhaps it should be

	1 .mailmap address
	2 SoB address in commit message
	3 MAINTAINERS address
	4 SoB address in referenced Fixes: commits

But it seems a restructuring of get_maintainer
would be required to do that as the Fixes: line is
parsed before any filenames in a patch and I'm not
too bothered by the precedence and output right
now to muck around in get_maintainer's internals.

cheers, Joe

