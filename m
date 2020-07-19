Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D7120684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXaBS10F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGSSMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:12:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:12:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls15so9022868pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kxZp5oQLXLp2mcGfAQe0wlBX6+dD2V4bhp1ZWl8hiqM=;
        b=hXaBS10Fqhq432zqPQ3rSbg/lJhhUXwu0Bts4s5ZuJR0FNddji/eu8ggs2cyRJRZww
         54ox3nSLBWhafPF8aV1WWsBow5JA3iz5MxwH/GOQJNbtfLRI7xhKxwA+QRAvODVkzjHl
         stcAp18Ha7VQEiJvVXF2LiceVCcHbVb+Br+5UZlvibpv2p1no3hWPjkOgnXllbVeOgRI
         gQwZ47Ubp5XicTFVvKlK2FMjNTyVA5Vo2aI8bIpf70yXkUL6RPL3iWbi29Ai1YUbKttG
         0ud0k+TdAdwpzXt9lT5LB7csP5YRa/LTD1XlQ9N/5tDfszeKnR4r+gEVEmyKMi33lxIV
         LDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kxZp5oQLXLp2mcGfAQe0wlBX6+dD2V4bhp1ZWl8hiqM=;
        b=iRXTz8Z+FBrSMDeNHgpIZYnqS2M5ZPoP6sjxPR1TuDohHQMe6bhBkwlqJgiiLWMpk2
         v4CLBl3QGSBNsnmUH15SdcpwH/2n/dodR+t2C+fQGv0ahfXOKBAr1cMpgPf1HoJncK1f
         GblTHxffWPf1DOoDmMnQsfsb77ho/MX1sJPDiCC7DPbe8bgIiwRICJ9oF14OG+imu+0B
         nP8B1i3gNChb6OdiMepqVuU+2OsQdYkSiGuVsG6gwNhIIbd7BZOmfe1i3Wd/IlxYn5Oh
         z768cvYM0M6+bUahnl26J5Xhp4qLx3wdhn1uphkxkncsfnAKmVm8NRUxJQAgepEc7s0P
         BL/g==
X-Gm-Message-State: AOAM532uMtC+Q3aREYMt7Z40BhGpxF60PJCl/UTcNYkDS+NmAV3fpMIu
        FgTRPb1a8+MgThJV0y/y9LOwRJL19rA=
X-Google-Smtp-Source: ABdhPJxa+u1x4+zWtMj1qS+kTxLzw51OdKtEp/n1No2Fqb0RJgRlPcvHscfCaCdnCoIKozfLl2Rzig==
X-Received: by 2002:a17:90a:110:: with SMTP id b16mr19295803pjb.235.1595182323905;
        Sun, 19 Jul 2020 11:12:03 -0700 (PDT)
Received: from thinkpad ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id g5sm9027863pjl.31.2020.07.19.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 11:12:03 -0700 (PDT)
Date:   Sun, 19 Jul 2020 11:12:23 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: properly check endpoint types
Message-ID: <20200719181223.GA210062@thinkpad>
References: <20200718155836.86384-1-rkovhaev@gmail.com>
 <20200719092338.GC171181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719092338.GC171181@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:23:38AM +0200, Greg KH wrote:
> On Sat, Jul 18, 2020 at 08:58:36AM -0700, Rustam Kovhaev wrote:
> > As syzkaller detected, wlan-ng driver submits bulk urb without checking
> > that the endpoint type is actually bulk, add usb_urb_ep_type_check()
> > 
> > Reported-and-tested-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
> > Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> > ---
> >  drivers/staging/wlan-ng/hfa384x_usb.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
> > index fa1bf8b069fd..7cde60ea68a2 100644
> > --- a/drivers/staging/wlan-ng/hfa384x_usb.c
> > +++ b/drivers/staging/wlan-ng/hfa384x_usb.c
> > @@ -339,6 +339,12 @@ static int submit_rx_urb(struct hfa384x *hw, gfp_t memflags)
> >  
> >  	hw->rx_urb_skb = skb;
> >  
> > +	result = usb_urb_ep_type_check(&hw->rx_urb);
> > +	if (result) {
> > +	       netdev_warn(hw->wlandev->netdev, "invalid rx endpoint");
> > +	       goto cleanup;
> > +	}
> 
> In looking at this again, can you just make these checks in the probe
> function, and abort binding the driver to the device at that point in
> time?  This feels really late in the init sequence.
> 
> The real problem here is in the hfa384x_create() function, where it
> blindly takes the 1 and 2 endpoints and assumes that those are the
> "correct type".  How about checking the types there, and if they are
> incorrect, returning an error from that function and have the caller
> return the error as well.
> 
> That should keep anything else in the driver from being initialized and
> set up, and stop bad devices from being bound to the driver at a much
> earlier point in time.
> 
> Note, just checking for the valid type/direction of those endpoints
> should be sufficient.
> 
tyvm for the feedback! makes perfect sense, i'll send a new patch

