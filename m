Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25DFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9132620760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594030725;
	bh=LQCdrf8K4fiKpthxDAGdPxbZ/BncNjdAdIWvbt2wwxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oH51ky8edYvxvoOZpwdBlU6oqgXFnBjibMhysrIwoChvs5BJwOtUh1nXLSlXVzsFy
	 d+4+h+xWj8uZujgFXDhaU3pJldZBVyKPL85D58nVv2ks5cv4XvcAv4GLp192akv3QI
	 0kqH5GBCzOYyL1DZeT6QSjICe+lOGPMaS0wcR2rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGFKSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:18:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40501 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:18:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id n23so44649530ljh.7;
        Mon, 06 Jul 2020 03:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOp2uyVBG5gwkjiva5Sfw6FnlHzL7jIzLJ/NT02k/uo=;
        b=a6dCe4S/yJMZtUcFkJObVRlPEpKVilX4e3K8sMmncjgHxP+czLnnGgd2rTDgWRQGtZ
         EqYfAGEaJR8i/AfJGiD5g1ZLp8Ei9bIC9mmRSNY5MgEBbeccQQmgpIeiC9dMEiDOedUt
         OdAbJJLd0fyYXp8Rt72xFh6yyPlLqJgrza1l30s0RVIwAcGIcVO1qhhY62PwzdlBPrXy
         Sltm5VllMucAbAZknCFQloKmYbd2cG4F1ajHNfM5u37PU5+SgEFeghKY3P92y+93mIZ2
         FB0IsYmPdIGiUkaU/vqcCHVMrMrbNAEvByXLsmWkyCqYAE8s0/mL8wuS+8+xdNxAKFcF
         HZtg==
X-Gm-Message-State: AOAM53064T0qVzTSwoTAf0YCLhzG4jUB6362eWEfyjMTtIwBPKdU0Q0R
        UWq8SFDvOXX3tLaE2q606r4=
X-Google-Smtp-Source: ABdhPJynA0arFW9wLop6raoNt7g4KPdBmiU32EFC/I++X/OQyfmEqR8nPSQ5XEdGhYRjaSMBrQLI6A==
X-Received: by 2002:a2e:8199:: with SMTP id e25mr11409062ljg.307.1594030717821;
        Mon, 06 Jul 2020 03:18:37 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n7sm7768397lji.97.2020.07.06.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:18:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jsOCo-0006MM-Ju; Mon, 06 Jul 2020 12:18:34 +0200
Date:   Mon, 6 Jul 2020 12:18:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        =?utf-8?B?UGjDuiBMxrB1?= An <luuanphu@gmail.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when
 buffers fill
Message-ID: <20200706101834.GI3453@localhost>
References: <ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com>
 <20200626074206.GP3334@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626074206.GP3334@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:42:06AM +0200, Johan Hovold wrote:
> On Fri, Jun 26, 2020 at 04:24:20AM +0000, Phu Luu wrote:
> > From: Brant Merryman <brant.merryman@silabs.com>
> > 
> > CP210x hardware disables auto-RTS but leaves auto-CTS when
> > in hardware flow control mode and UART on cp210x hardware
> > is disabled. This allows data to flow out, but new data
> > will not come into the port. When re-opening the port, if
> > auto-CTS is enabled on the cp210x, then auto-RTS must be
> > re-enabled in the driver.
> > 
> > Signed-off-by: Phu Luu <phu.luu@silabs.com>
> > Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
> 
> Please revisit these tags as well.
> 
> > ---
> > 06/09/2020: Patch v3 2/2 Modified based on feedback from Johan Hovold <johan@kernel.org>
> > 12/18/2019: Patch v2 Broken into two patches and modified based on feedback from Johan Hovold <johan@kernel.org>
> > 12/09/2019: Initial submission of patch "Proper RTS control when buffers fill"
> > 
> >  drivers/usb/serial/cp210x.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> > index bcceb4ad8be0..091441b1c5b9 100644
> > --- a/drivers/usb/serial/cp210x.c
> > +++ b/drivers/usb/serial/cp210x.c
> > @@ -917,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
> >  	u32 baud;
> >  	u16 bits;
> >  	u32 ctl_hs;
> > +	u32 flow_repl;
> >  
> >  	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
> >  
> > @@ -1017,6 +1018,23 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
> >  	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> >  	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
> >  		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
> > +		/*
> > +		 * When the port is closed, the CP210x hardware disables
> > +		 * auto-RTS and RTS is deasserted but it leaves auto-CTS when
> > +		 * in hardware flow control mode. This prevents new data from
> > +		 * being received by the port. When re-opening the port, if
> > +		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
> > +		 * re-enabled in the driver.
> > +		 */
> 
> I already asked this of Brant, but could you please be more specific
> about which state the RTS-line end up in when disabling the UART (e.g.
> 0x00: statically inactive)?
> 
> The reason I ask is that after open() returns, the tty layer would raise
> RTS, which should again allow data to flow in in contrast to what the
> comment and changelog text claims.

I had another reason to look at this driver so I could determine that
the patch description and comment were indeed incorrect; the tty layer
asserts RTS when reopening the port just fine and data flows in.

> We still want to enable auto-RTS of course so the patch is otherwise
> correct.

I've fixed up the commit message and comment, reordered the SOB tags
and added your Co-developed-by tag before applying both of these now:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-next

Johan
