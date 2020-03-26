Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B2BC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661E4207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585214023;
	bh=3Cts5hRVZZTFKZiX/k6ex55sn7Fiz0P34g8CwAIbVRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hfhIJDsU24a0VxIQnzFWKKG/+w0zoz2HDURFSnT2s80ipP4ZORHsT4eOMK3+ThKK9
	 3I2MVepx1aJ0eVL3xkCzdS7twRKTzcy3AFV+CjmL+LnMuAo91FmlRfYcGUqt0CU5N+
	 4w4A3x8tShNsBDV2c9Zf2pMfhDn1KFjwVFxEe4vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCZJNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:13:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37615 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgCZJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:13:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so5605391ljd.4;
        Thu, 26 Mar 2020 02:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyyUQXlsRxfomovzXi3a4kjq7QvbeI6bqADRdDoCJDI=;
        b=HVKfRzPKtNDSQgCAR0UEGnT2sOseBT6bcZ5+yHkrlfNjglJKRx7UfnRIbLrAhcZWHh
         0aagsu8xKRbTXM/TV5AQupc8DkhVw8toHDUTk3tAIHWmlTOEjt4eOqDKavFeJQpDKQPx
         /m9OSiqtWGNXxo7TWMNICqRZynNvf6eYG3Egm464IlQmemUVUuCui9ezTCvYoRvfwmNx
         gIKi78cnGCDJGLRRUPCghUqqOCerqMm//u3aSb07pjvIICL2yCb/zSPvpFCu7MFnQ5rs
         XdYyazUmREdP6sFZeyy/1P5bEO5yPWVerVGG1i7IMw7sJvLrbNi3BT7aq3CFRlvsuyh8
         A+FA==
X-Gm-Message-State: AGi0Pub7hJvNQU8GGFs9myMetFU5xInxChM3LsKHQ5L9V+QcbsgwZWBH
        gpu8QwNjI2ICOfxiNn/xx14=
X-Google-Smtp-Source: APiQypIFtvQUm+uMPq1l2Hbw7svcZDHM7fc7bFFNVoc0kXHdImSyYm+iyNeTmANGUpYJ6ahggl+jiw==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr2062884ljh.70.1585214019931;
        Thu, 26 Mar 2020 02:13:39 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id f2sm1036510ljn.101.2020.03.26.02.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 02:13:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jHOZq-0003Cl-Gx; Thu, 26 Mar 2020 10:13:26 +0100
Date:   Thu, 26 Mar 2020 10:13:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Qiujun Huang <hqjagain@gmail.com>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com
Subject: Re: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in
 edge_interrupt_callback
Message-ID: <20200326091326.GD4899@localhost>
References: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
 <20200326081433.GA979574@kroah.com>
 <20200326082117.GC4899@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326082117.GC4899@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:21:17AM +0100, Johan Hovold wrote:
> On Thu, Mar 26, 2020 at 09:14:33AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 25, 2020 at 03:52:37PM +0800, Qiujun Huang wrote:
> > > The boundary condition should be (length - 1) as we access data[position+1].
> > > 
> > > Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
> > > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > > ---
> > >  drivers/usb/serial/io_edgeport.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > > index 5737add..4cca0b8 100644
> > > --- a/drivers/usb/serial/io_edgeport.c
> > > +++ b/drivers/usb/serial/io_edgeport.c
> > > @@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
> > >  		/* grab the txcredits for the ports if available */
> > >  		position = 2;
> > >  		portNumber = 0;
> > > -		while ((position < length) &&
> > > +		while ((position < length - 1) &&
> > >  				(portNumber < edge_serial->serial->num_ports)) {
> > >  			txCredits = data[position] | (data[position+1] << 8);
> > >  			if (txCredits) {
> > > -- 
> > > 1.8.3.1
> > > 
> > 
> > Johan, any objection from me taking this in my tree now?
> 
> Just let me take a look at it first.
>
> Are sending another PR to Linus for 5.6? Otherwise I can include this
> in my 5.7 PR to you. Will try to get it to you today.

This issue predates git so I'd add

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>

if you want to take it yourself. Just let me know, otherwise I'll
include in my PR.

Johan
