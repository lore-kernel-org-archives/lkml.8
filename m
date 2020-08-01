Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F12C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE34A2083E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596287606;
	bh=/4onQlDCzaUFK/Z+RS1ZIvjtCTjj71c6KU35qFJyO1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oky9exJpvPK1HC1jdQCIZmPsXXAPRYz+pwVdy2cEIQJWvUq6TIh4sMn/adH8S58Za
	 Xdvg2TijA0C+XGWbocl4iNolwkd/Jc/1IZjmKXEdLp5aDEpSw29eIqwrO/TiScl+pq
	 yQ5GYmfOzh1InHQe85CoWwlSWBNPZvjzSeTT0f3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHANNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 09:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHANND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 09:13:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341392076A;
        Sat,  1 Aug 2020 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596287582;
        bh=/4onQlDCzaUFK/Z+RS1ZIvjtCTjj71c6KU35qFJyO1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEamH0x4S8u6xupbf9tA9j8S8W6D3HmNkcfzwBbhCro8L1TAqGQqpBu/W6RqBt7Si
         TAwMIN94oSGPIZKnvKBaFQxlc2RFyPdHm9kDkQJtW5EK+UYd02ErPGBmrjFzL0d8qG
         qa+YTfjeEFIcKbGZxWQ4vnexLM0b6rCZ8TYoaOIg=
Date:   Sat, 1 Aug 2020 15:12:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     devel@driverdev.osuosl.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: r8188eu: replace rtw_netdev_priv define with
 inline function
Message-ID: <20200801131247.GA2131407@kroah.com>
References: <20200801094707.13449-1-insafonov@gmail.com>
 <20200801095108.GA2840539@kroah.com>
 <968d30fc-4e5f-b495-e986-b18b05e9a895@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968d30fc-4e5f-b495-e986-b18b05e9a895@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 04:11:38PM +0300, Ivan Safonov wrote:
> On 8/1/20 12:51 PM, Greg Kroah-Hartman wrote:
> > On Sat, Aug 01, 2020 at 12:47:07PM +0300, Ivan Safonov wrote:
> > > The function guarantees type checking of arguments and return value.
> > > 
> > > Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> > > ---
> > >   drivers/staging/rtl8188eu/include/osdep_service.h | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
> > > index 31d897f1d21f..e0ccafdea9cd 100644
> > > --- a/drivers/staging/rtl8188eu/include/osdep_service.h
> > > +++ b/drivers/staging/rtl8188eu/include/osdep_service.h
> > > @@ -71,8 +71,10 @@ struct rtw_netdev_priv_indicator {
> > >   };
> > >   struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
> > > -#define rtw_netdev_priv(netdev)					\
> > > -	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
> > > +static inline struct adapter *rtw_netdev_priv(struct net_device *dev)
> > > +{
> > > +	return (((struct rtw_netdev_priv_indicator *)netdev_priv(dev))->priv);
> > > +}
> > >   void rtw_free_netdev(struct net_device *netdev);
> > 
> > Is the cast really needed?
> 
> (struct rtw_netdev_priv_indicator *) cast needed for access to '->priv'.
> 
> The (struct adapter *) return type is a starting point for simplify
>     struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> constructions.

Ah, sorry, missed that I thought this was a cast of netdev_priv(dev)
itself, and not the additional structure.

> > 
> > And no blank line before the next function prototype?
> 
> In v2.
> 
> > 
> > And is this really needed?  Type checking is already happening as this
> > is a "simple" macro, right?
> 
> 1. The flexibility of macros is not needed here.
> 2. The macro silently assigns ->priv to any pointer, while the function
> indicates such a compile-time error.

Ok, put that somewhere in the changelog please, saying how the existing
macro does not provide any error checking.

thanks,

greg k-h
