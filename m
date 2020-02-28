Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C795C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40998246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvOgREED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgB1AjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:39:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1AjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:39:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so516636plb.0;
        Thu, 27 Feb 2020 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/yxTrdmlGAmNZb612vOa6OICzFDLjBrtfyjwcjGr0I=;
        b=qvOgREEDhea8eVEYFz9FqSehJre6irn23Wigft+6rL2Zg1SfkE4xnms/IjVxqde/EW
         kQpfCOuBvFF4m62qUQcy/PNlUQZHAacD2g4PEvcx2ML6wSxgcnuBxAeBm+S9Sa3sHXC1
         9pYbeqa7yaav0NlPou5YXeHLUMNMyIG+QPPwqfJ1OOC/65n9acuprnxXV20OeezE857v
         oypneDDwUgsy21O756k82Q/VRddxcSMcXzaIqsSsRILTqqPANxcuSTK/AZVWQKSzJmQ6
         z0G2ojoTb3a+Z2rrCvLD97gr4ZAXnR8JzioAwuMYMpMAGZTSBJqkEzPJpX4G7v+PqOWd
         pCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/yxTrdmlGAmNZb612vOa6OICzFDLjBrtfyjwcjGr0I=;
        b=JlKDgAHPzJRP3A9qm7p5tqQeQxsGmzPjZnkLgN/64pTke1GdJ6nkKPtmnItQZ5mstB
         ai8DeYx+lye8ye1vCsrL0tGGRhGl7M/YGUIENBkNJbyytt8J8sSMBXrHfRE8bBF2COKq
         yT+W/pDueYCMJuxjvV7Tyf52AvLNfEGE8zYBCnTINl1V1FhKarqK/Zz7GhcbLLe2AJZe
         RM2h9hI1RTJLe+qq3jI6ozocSAXr9PJp0VriQMhQQCZKzdV62UIym64bAEZreRaTDfkq
         Pb2hHMOFEmAIW0kSvxO0zFPuLRXuAZSXiaU93J0QG/V73Wt5OXNViC2bHdA0Elw9H98F
         V33A==
X-Gm-Message-State: APjAAAU0Y3SvOyOzHgpEEHUPyV0SiWFopzhMRpdtn3yQVGvwm3UbU4+V
        9YT9sRLK9uIc9NeaZ2KruEI=
X-Google-Smtp-Source: APXvYqyhdz4YW3ZnR+9gXnGHrvh1yrfSz86rFuRvtglPoDEGuSTSyqF9J15P0kW1RUNoryevyEYhVQ==
X-Received: by 2002:a17:902:8542:: with SMTP id d2mr1490574plo.200.1582850340892;
        Thu, 27 Feb 2020 16:39:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g12sm8176155pfh.170.2020.02.27.16.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 16:39:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:38:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antti =?iso-8859-1?Q?Sepp=E4l=E4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFT PATCH 4/4] usb: dwc2: Make "trimming xfer length" a debug
 message
Message-ID: <20200228003859.GC11811@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-5-linux@roeck-us.net>
 <CAD=FV=VZYOV-uNwPB3zBpfdWV6U0qFeC1HTqwEWR1+x962J3mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VZYOV-uNwPB3zBpfdWV6U0qFeC1HTqwEWR1+x962J3mA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:07:14PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With some USB network adapters, such as DM96xx, the following message
> > is seen for each maximum size receive packet.
> >
> > dwc2 ff540000.usb: dwc2_update_urb_state(): trimming xfer length
> >
> > This happens because the packet size requested by the driver is 1522
> > bytes, wMaxPacketSize is 64, the dwc2 driver configures the chip to
> > receive 24*64 = 1536 bytes, and the chip does indeed send more than
> > 1522 bytes of data. Since the event does not indicate an error condition,
> > the message is just noise. Demote it to debug level.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/dwc2/hcd_intr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Suggest a "Fixes" or "Cc: stable" tag.  This one isn't as important as
> the others, but presumably you'll start hitting it a lot more now
> (whereas previously we'd just crash).
> 
Good point. Added

Fixes: 7359d482eb4d3 ("staging: HCD files for the DWC2 driver")

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks again!

Guenter
