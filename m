Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8EDC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ECA2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580894921;
	bh=+3IRa4bmKNZ7uasdvFl0JKG0KAwk9cNuWiw/XoUD+gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pRFXY5RdZHaMsjro7M6PuKI9egT21RiOXfAxSbj3Dg52nodT6cRmA2VYTsi1iqZiT
	 dhpzzT8yHn89DweN936o/2xUHO2ctpLoN6m8va6fggZRfm/m83yLGaz2mOrIlWSNn0
	 6kQGORS6pRy5TvSMXF55tBCwu/Ak2Rr+oGgWV5xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBEJ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBEJ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:28:40 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59BC20659;
        Wed,  5 Feb 2020 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580894920;
        bh=+3IRa4bmKNZ7uasdvFl0JKG0KAwk9cNuWiw/XoUD+gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnD3wItV8pPshlAkZ5wa4Z5UnEbyjMzuYxBp69Z7KkpO9q44ykd1gmzo9/ZXXI4tS
         bmYOay2fZLJZlDOkawdEtEvCZDSgxrP3tlmxXdlRZXu630ZnrGbo30ysY7c58Kb7+R
         Txtw1dWeCNCNWpLJdh20k6z3SjsY4KqVirbbBVg0=
Date:   Wed, 5 Feb 2020 09:28:37 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 65/90] Input: aiptek - use descriptors of current
 altsetting
Message-ID: <20200205092837.GA1164405@kroah.com>
References: <20200203161917.612554987@linuxfoundation.org>
 <20200203161925.451117468@linuxfoundation.org>
 <20200204081155.GC26725@localhost>
 <20200204100332.GC1088789@kroah.com>
 <20200204101855.GI26725@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204101855.GI26725@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:18:55AM +0100, Johan Hovold wrote:
> On Tue, Feb 04, 2020 at 10:03:32AM +0000, Greg Kroah-Hartman wrote:
> > On Tue, Feb 04, 2020 at 09:11:55AM +0100, Johan Hovold wrote:
> > > On Mon, Feb 03, 2020 at 04:20:08PM +0000, Greg Kroah-Hartman wrote:
> > > > From: Johan Hovold <johan@kernel.org>
> > > > 
> > > > [ Upstream commit cfa4f6a99fb183742cace65ec551b444852b8ef6 ]
> > > > 
> > > > Make sure to always use the descriptors of the current alternate setting
> > > > to avoid future issues when accessing fields that may differ between
> > > > settings.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > Acked-by: Vladis Dronov <vdronov@redhat.com>
> > > > Link: https://lore.kernel.org/r/20191210113737.4016-4-johan@kernel.org
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  drivers/input/tablet/aiptek.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> > > > index 06d0ffef4a171..e08b0ef078e81 100644
> > > > --- a/drivers/input/tablet/aiptek.c
> > > > +++ b/drivers/input/tablet/aiptek.c
> > > > @@ -1713,7 +1713,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
> > > >  
> > > >  	aiptek->inputdev = inputdev;
> > > >  	aiptek->intf = intf;
> > > > -	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
> > > > +	aiptek->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
> > > >  	aiptek->inDelay = 0;
> > > >  	aiptek->endDelay = 0;
> > > >  	aiptek->previousJitterable = 0;
> > > 
> > > I asked Sasha to drop this one directly when he added it, so it's
> > > probable gone from all the stable queues by now.
> > 
> > Oops, no, let me go drop it.
> > 
> > > But I'm still curious how this ended up being selected for stable in the
> > > first place? There's no fixes or stable tag in the commit, and I never
> > > received a mail from the AUTOSEL scripts.
> > 
> > I don't know, there was a bunch of last-minute patches picked up for
> > this round based on some "fixes needed due to other fixes".
> 
> Ah, yeah, could be dependencies otherwise, but then you usually send a
> notice about that. And in this case this is the last commit to this
> particular driver in Linus's tree too.

Yes, things went a bit sideways for this round for various reasons :(
