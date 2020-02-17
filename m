Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F867C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9660207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581949363;
	bh=8DTBdEIPZHL+pnTNBLijhXTQYXxTMAMa6+mt+KfaJxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ww5fsN/o1Ywx51/wFLMrEezjNHpxtbq/I2jc5D4cM1Vnaawa5ULs6UTFd6hX+NNRb
	 /hCazNQIe7l/3kD+G/7sfoy4ixZUwlC+hYlnTkt0udQL1u//qLXUnDN69QJFAQIJ1G
	 fOSvV9RBWjnY4PIFavBnxu9vN6wWeXeATcwVZsSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgBQOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgBQOWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:22:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAE32072C;
        Mon, 17 Feb 2020 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581949360;
        bh=8DTBdEIPZHL+pnTNBLijhXTQYXxTMAMa6+mt+KfaJxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIoYI2jNtpluO89Bo+oIxKnwb861QMKWvv9jbloLr7yjtwXSIkR/ugSZedB3dJAsY
         n9xDDt7MdwpSEDjI5yOV3qZxwkuE5oVOTbXFum43Jpqimv/gVVThMB6DB3XdB3BqFL
         WYZQ6paTHo48EYtY0N8YweFCo5ERGUNw3SO1QO8Q=
Date:   Mon, 17 Feb 2020 15:22:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: audio-v2: Add uac2_effect_unit_descriptor
 definition
Message-ID: <20200217142238.GA1144881@kroah.com>
References: <20200213112059.18745-1-tiwai@suse.de>
 <20200213112059.18745-2-tiwai@suse.de>
 <s5hd0adguv9.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd0adguv9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 03:18:34PM +0100, Takashi Iwai wrote:
> On Thu, 13 Feb 2020 12:20:58 +0100,
> Takashi Iwai wrote:
> > 
> > The UAC2 Effect Unit Descriptor has a slightly different definition
> > from other similar ones like Processing Unit or Extension Unit.
> > Define it here so that it can be used in USB-audio driver in a later
> > patch.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  include/linux/usb/audio-v2.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
> > index ba4b3e3327ff..cb9900b34b67 100644
> > --- a/include/linux/usb/audio-v2.h
> > +++ b/include/linux/usb/audio-v2.h
> > @@ -156,6 +156,18 @@ struct uac2_feature_unit_descriptor {
> >  	__u8 bmaControls[0]; /* variable length */
> >  } __attribute__((packed));
> >  
> > +/* 4.7.2.10 Effect Unit Descriptor */
> > +
> > +struct uac2_effect_unit_descriptor {
> > +	__u8 bLength;
> > +	__u8 bDescriptorType;
> > +	__u8 bDescriptorSubtype;
> > +	__u8 bUnitID;
> > +	__le16 wEffectType;
> > +	__u8 bSourceID;
> > +	__u8 bmaControls[]; /* variable length */
> > +} __attribute__((packed));
> > +
> >  /* 4.9.2 Class-Specific AS Interface Descriptor */
> >  
> >  struct uac2_as_header_descriptor {
> 
> Greg, I suppose you are OK with this addition?
> 
> 

Yes, that's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
