Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0481C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A9620707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580477405;
	bh=lyIY/MCqxwXTLaQPrczbKavK+sCmU8VVDmFaUG+1hAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qgmfd2W0559Ok/lVq5SEirb/zwrihElTzPyjMIDQH841uVVASjDjB2BTDT5RGG7Q4
	 9c2+ljyV+jlsV452SxldRbT1TlgJTU9UNG1NCnr4BawuISeyJNjvLaPvMt9s6uQQcg
	 FK178EJITnXGlPzjZScGXrstrRkrmnUbaoR0gAZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgAaNaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:30:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43089 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgAaNaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:30:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so7073122ljm.10;
        Fri, 31 Jan 2020 05:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3ofS0LU2j4KZSTG1ARNb3S7n9ZGoR5Ws7eg6uLZtiw=;
        b=bfc2OE+C4Aef4P4Ai3j0AHQOtkyAOd4/UjenmzzrPtVKPdN2JmgHZW6m3PNHB4fszS
         CNsBCpnFkeJX+1akXdZxx6TsdrOEmTQBSmviG/Ea/kkGhUFsY7R0n0NRzQjhAokNBuUI
         Hz+BAAaZpCgjv8GoEBVI28fHHbFIMx7TI8kLsyijRd9K3/OsYi2jcNwHEK0IBXBtXdpc
         tD1rYdGuMEk7ZaH32Ygt2MzHybi62vPdKR1JTWnj5CvTP6ZCuFK+UHYR/siTRjHPtxzO
         RWt9NC242JojaNQVSIUqKW0BJUeGT3L7TF71qY0mm1H4FNciK36yLOaM2dauDFx/3p1T
         sr5Q==
X-Gm-Message-State: APjAAAWEfwwIY36p763+56vK44pRSzNrxHTbLhJWTexrz7TP5RNqyrC0
        BS4VyIqkGScTsVvajEOGm5Y=
X-Google-Smtp-Source: APXvYqwSHLUzboH/GEd0OnUNJ0P78aZbrS4iXiwn3JjobMobPwafTTxVY+k3PAOWpJi9QmVflcQM6w==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr5868233ljj.31.1580477400572;
        Fri, 31 Jan 2020 05:30:00 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id q14sm4604833lfc.60.2020.01.31.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:29:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ixWN2-0005aX-Dn; Fri, 31 Jan 2020 14:30:04 +0100
Date:   Fri, 31 Jan 2020 14:30:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200131133004.GD10381@localhost>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131050651.hlq27kehtir3agf2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131050651.hlq27kehtir3agf2@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:06:52AM +0300, Dan Carpenter wrote:
> We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> ("USB: debugging code shouldn't alter control flow").
>
> The difference between dev_WARN() and dev_err() is that dev_WARN()
> prints a stack trace and if you have panic on OOPS enabled then it leads
> to a panic.  The dev_err() function just prints the error message.
> 
> Back in the day we didn't have usb emulators fuzz testing the kernel
> so dev_WARN() didn't cause a problem for anyone, but these days the
> dev_WARN() interferes with syzbot so let's change this to a dev_err().

The commit you refer to did more than just change dev_err() to
dev_WARN(); it also stopped returning an error in case a driver
submitted an URB for an endpoint of the wrong type. At that point in
time all this was dependent on CONFIG_USB_DEBUG however.

> Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> 
>  drivers/usb/core/urb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index da923ec17612..0980c1d2253d 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>  
>  	/* Check that the pipe's type matches the endpoint's type */
>  	if (usb_urb_ep_type_check(urb))
> -		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> +		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
>  			usb_pipetype(urb->pipe), pipetypes[xfertype]);
>  
>  	/* Check against a simple/standard policy */

It seems this change would just be papering over these driver bugs. The
dev_WARN() is there in the first place to allow us to catch them.

Even if it takes some work, it should be doable to track down and add
the missing sanity checks to the drivers that lack them. Some have
already been fixed, and I have some more pending patches to fix or add
helpers to simplify fixing the remaining ones.

Johan
