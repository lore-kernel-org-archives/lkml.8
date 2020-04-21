Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCEBC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29AE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587438051;
	bh=C66zT+0eni1hQi75iXGL2m0XhwqvpODjKWdzrm+Wf24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DQdS5wbIb202Vc3SibknO2WVmIOJMvKO7eCTYi/yxcp0mQop9ehOWuDxoN0YsaIGJ
	 MUSm2RG69qWbY4SH6/s3PvJZ52pd56/PUdjpN41veJo61XgJhPdxMAhMhY9i0Fxhu7
	 6WMas1T6lAOtrbNenwMwCfRRdSnb+1H1c1IXblQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgDUDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgDUDAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:00:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A982082E;
        Tue, 21 Apr 2020 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587438048;
        bh=C66zT+0eni1hQi75iXGL2m0XhwqvpODjKWdzrm+Wf24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0xe2ozp9oV1ZLX5y+0fOMLcAjScVQncZUs+qCBH5NYLA1NqK3fmFqTPSlbv1BkNm
         Fx+uVD9wykiqEp+a8QAetlIM66lAGyw0FkjaQH7YzOqEeKtdcIsdNO6Wi62aCDA3jl
         VKi40FWaBDbsjn4QuVi8IGd1qZJHU8/kcpiZMpc4=
Date:   Tue, 21 Apr 2020 11:00:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Subject: Re: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for
 the mikroBUS
Message-ID: <20200421030034.GA8571@dragon>
References: <20200318001603.9650-1-olteanv@gmail.com>
 <20200318001603.9650-13-olteanv@gmail.com>
 <20200420143831.GB32419@dragon>
 <CA+h21hrfwJ7LMjj=sy7LG3D-FFhVSRuM5TwqfX9LvW4XKarUWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hrfwJ7LMjj=sy7LG3D-FFhVSRuM5TwqfX9LvW4XKarUWA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:10:35PM +0300, Vladimir Oltean wrote:
> On Mon, 20 Apr 2020 at 17:38, Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 02:16:03AM +0200, Vladimir Oltean wrote:
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > >
> > > For debugging, it is useful to have access to the DSPI controller
> > > signals. On the reference design board, these are exported to either the
> > > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> > > BRDCFG3[SPI3]).
> > >
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > ---
> > > Changes in v5:
> > > None.
> > >
> > > Changes in v4:
> > > None.
> > >
> > > Changes in v3:
> > > None.
> > >
> > > Changes in v2:
> > > Change compatible string for spidev node.
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > > index 6d05b76c2c7a..0d27b5667b8c 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > > @@ -83,6 +83,20 @@
> > >       };
> > >  };
> > >
> > > +&dspi2 {
> > > +     bus-num = <2>;
> > > +     status = "okay";
> > > +
> > > +     /* mikroBUS1 */
> > > +     spidev@0 {
> > > +             compatible = "rohm,dh2228fv";
> >
> > Is the compatible documented?
> >
> > Shawn
> >
> > > +             spi-max-frequency = <20000000>;
> > > +             fsl,spi-cs-sck-delay = <100>;
> > > +             fsl,spi-sck-cs-delay = <100>;
> > > +             reg = <0>;
> > > +     };
> > > +};
> > > +
> > >  &esdhc {
> > >       sd-uhs-sdr104;
> > >       sd-uhs-sdr50;
> > > --
> > > 2.17.1
> > >
> 
> I don't really know what's the status with spidev compatibles. I do
> see other device trees are using this one, I thought it should be
> fine.

My understanding is that every compatible needs to be documented.

Shawn
