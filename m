Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B00C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FA9208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="XkoEqgLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBWKUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:20:47 -0500
Received: from vps.xff.cz ([195.181.215.36]:41666 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582453245; bh=2tN9XTMyK3Umo3ghVIJmzvxq0UXC2Jq+XBIALehkoD0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=XkoEqgLqCnr+tkqDHpkd4XMU7/XEpc92wTJDACbB7353407pP6PMR1qytzkz8FZu9
         50U87c+urvZy12Gr8YgpdEk3XegL8DQZRxBdek5sj07FSSwcPyS+ePNawjzN/TcXEx
         1AP8JFD35wgNTZAY7pyYtQYQcHvAp7Uu2ccSeofs=
Date:   Sun, 23 Feb 2020 11:20:44 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Lars Melin <larsm17@gmail.com>
Cc:     linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support Castles Vega5000 PoS terminal USB
Message-ID: <20200223102044.odcmcxdk45egxu5i@core.my.home>
Mail-Followup-To: Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222233202.237967-1-megous@megous.com>
 <9d9263a0-cddb-0efb-46a5-1d223a8232e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9263a0-cddb-0efb-46a5-1d223a8232e3@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 23, 2020 at 10:08:04AM +0700, Lars Melin wrote:
> On 2/23/2020 06:32, Ondrej Jirman wrote:
> > This terminal's USB port needs NO_UNION_NORMAL quirk to work with
> > cdc-acm driver.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >   drivers/usb/class/cdc-acm.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> > index 62f4fb9b362f1..8577441c81a4d 100644
> > --- a/drivers/usb/class/cdc-acm.c
> > +++ b/drivers/usb/class/cdc-acm.c
> > @@ -1739,6 +1739,9 @@ static const struct usb_device_id acm_ids[] = {
> >   	{ USB_DEVICE(0x22b8, 0x2d9a),   /* modem + AT port + diagnostics + NMEA */
> >   	.driver_info = NO_UNION_NORMAL, /* handle only modem interface          */
> >   	},
> > +	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles Technology VEGA 5000 */
> > +	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
> > +	},
> >   	{ USB_DEVICE(0x0572, 0x1329), /* Hummingbird huc56s (Conexant) */
> >   	.driver_info = NO_UNION_NORMAL, /* union de
> 
> This quirk is in the driver since almost a year ago.

You're right. Thank you.

I held to the patch for way too long, and didn't notice someone else patched
it in the meantime.

regards,
	o.

> br
> /Lars
> 
