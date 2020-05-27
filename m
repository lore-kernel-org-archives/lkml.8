Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD992078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590569599;
	bh=21T7sPdQCrYT7yx27IXVTIKRDL60nkltAXenV63O92M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cw5XV3Jtrg+vzWI32St+svwAuCOJm7ZRdj1bilV+FD6WJKZuXNazgxPf/vGVufAqU
	 xmO1zBkX/1NzTCOIiphMBD5st5kZWRJ1YXwMQo2geLpmE4zuFqS4yhoLah1dqOM2Bl
	 t1HtQiufV0BM2NZmulqxIpW/kNqwWkE1HEuz4Ytw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgE0IxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388112AbgE0IxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:53:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA9F20723;
        Wed, 27 May 2020 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590569597;
        bh=21T7sPdQCrYT7yx27IXVTIKRDL60nkltAXenV63O92M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jap5XRLqUYxuDAD+TFlFFCsHfOP1n3cKaPyUG1wx2aWwZQaFUekRMDW5RX+f7/9nm
         whX6Bap6JcEsdXGAX8+ZaqqRHA3ogx/2NUaGIZYYi9y0L9B8LuYr7f7tH48GfX3we0
         QoWeiz77MD8CnHHgOj5Uo7bFhFlrdURuXiqNDiGA=
Date:   Wed, 27 May 2020 10:53:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        hanjie.lin@amlogic.com, yue.wang@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH for-5.8 2/2] usb: dwc3: meson-g12a: fix USB2 PHY
 initialization on G12A and A1 SoCs
Message-ID: <20200527085315.GA168054@kroah.com>
References: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
 <20200526202943.715220-3-martin.blumenstingl@googlemail.com>
 <40a874eb-1a2b-533e-ee3e-bd90510abaf9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a874eb-1a2b-533e-ee3e-bd90510abaf9@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:17:31AM +0200, Neil Armstrong wrote:
> Hi Martin,
> 
> On 26/05/2020 22:29, Martin Blumenstingl wrote:
> > dwc3_meson_g12a_usb2_init_phy() crashes with NULL pointer on an SM1
> > board (which uses the same USB setup as G12A) dereference as reported
> > by the Kernel CI bot. This is because of the following call flow:
> >   dwc3_meson_g12a_probe
> >     priv->drvdata->setup_regmaps
> >       dwc3_meson_g12a_setup_regmaps
> >         priv->usb2_ports is still 0 so priv->u2p_regmap[i] will be NULL
> >     dwc3_meson_g12a_get_phys
> >       initializes priv->usb2_ports
> >     priv->drvdata->usb_init
> >       dwc3_meson_g12a_usb_init
> >         dwc3_meson_g12a_usb_init_glue
> >           dwc3_meson_g12a_usb2_init
> >             priv->drvdata->usb2_init_phy
> >               dwc3_meson_g12a_usb2_init_phy
> >                 dereferences priv->u2p_regmap[i]
> > 
> > Call priv->drvdata->setup_regmaps only after dwc3_meson_g12a_get_phys so
> > priv->usb2_ports is initialized and the regmaps will be set up
> > correctly. This fixes the NULL dereference later on.
> > 
> > Fixes: 013af227f58a97 ("usb: dwc3: meson-g12a: handle the phy and glue registers separately")
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/usb/dwc3/dwc3-meson-g12a.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> > index ce5388338389..1f7f4d88ed9d 100644
> > --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> > +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> 
> [...]
> 
> Fixes regression reported at [1] on SEI510 board based on Amlogic G12A.
> 
> Felipe, Greg, can this be queued on uxb-next for 5.8 ?
> 
> Acked-by: Neil Armstrong <narmstron@baylibre.com>

I can take this and patch 1/2 here if Felipe acks them.

thanks,

greg k-h
