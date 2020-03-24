Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B6C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B220658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585041761;
	bh=0TPf3secQJjkFx+zKThyzOMnFi35QiP1l+SWJl3EaR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e5CHO9CsdUQ8bKq9/RviXWazOHA8mVw0nrKPRYxS/SJ7UrS9xIP9vyyKJIow3337W
	 bqROQ3WdapKmCm8eV5lTuUtjBcwFkmxqoOEjWkmNN4+eRnSbD90rxOMNYb4MUE7eWw
	 FKJWWzujIFwVNeVlwDokV7sOZ6rjjMYHDqNnAOLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCXJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:22:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34610 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgCXJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:22:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id e7so3591744lfq.1;
        Tue, 24 Mar 2020 02:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qDHSQH6EF59vFu2CoB02DlvePw9hZXaswBE3r0QTlyE=;
        b=j8yk4Cjn7dxGSjlIEaYXPFZy+8ayMawPfDNh7/sOLp2Wgebj5Wwqwqjo29amxrDboG
         1YJ9Isjs/TOKn7oAiVlmKvP2RIpTUtOqFtOzfvBLWgGcibta/9s0xtqRuYFx3r+0+8Of
         2oHj3D3CQ8fCd5iIqNtASiRFU6NPe0pDNaQa4eP4ES1phO6oDwUbGqsFbQzKceVCycFx
         B/KijK2FzHSGLim0oT8ViY9we133xs1u+/nBLKdGTdWJQ5Lg8J/H8lJ1+I2HXuuHliDQ
         TvMDZRj8IC8wjrWnOvO64dW1cmDnYkOVICV5lGnOnfaIZmfyBQJkv3JctLgIUN/1xX3q
         Oy7w==
X-Gm-Message-State: ANhLgQ3eE3nwL1za7mV7uh7XFOelD6AMAvIR7NCVuK78rqP50TqA8oFP
        hYZHnoG65ghYhYkYl0R6IMU6fNez
X-Google-Smtp-Source: ADFU+vsNF/6bV1pC9Nn0GEfnxkuJCuYsLmoNUrH1MIQeRQd2Y3p/f9x1qsjH/s3laHqnLe109A6IMg==
X-Received: by 2002:a19:8c3:: with SMTP id 186mr12451840lfi.27.1585041757288;
        Tue, 24 Mar 2020 02:22:37 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id w28sm4474515lfl.3.2020.03.24.02.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:22:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jGflR-0003lF-L5; Tue, 24 Mar 2020 10:22:25 +0100
Date:   Tue, 24 Mar 2020 10:22:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Cezary Jackiewicz <cezary@eko.one.pl>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] USB: serial: option: add support for ASKEY WWHC050
Message-ID: <20200324092225.GB5810@localhost>
References: <20200320220155.5609-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320220155.5609-1-paweldembicki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:01:52PM +0100, Pawel Dembicki wrote:
> ASKEY WWHC050 is a mcie LTE modem.
> The oem configuration states:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1690 ProdID=7588 Rev=ff.ff
> S:  Manufacturer=Android
> S:  Product=Android
> S:  SerialNumber=813f0eef6e6e
> C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us
> 
> Tested on openwrt distribution.
> 
> Signed-off-by: Cezary Jackiewicz <cezary@eko.one.pl>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Thanks for the patches, looks good.

But who is really the author of patches 1 and 2? You or Cezary? In the
first case, you can use the Co-Developed-By tag to give Cezary credit,
and otherwise you need to add a From line so that authorship is recorded
correctly.

Take a look at Documentation/process/submitting-patches.rst.

> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 0b5dcf973d94..2f17019d3810 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2018,6 +2018,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(4) | RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
>  	  .driver_info = RSVD(6) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1690, 0x7588, 0xff),			/* ASKEY WWHC050 */
> +	  .driver_info = RSVD(1) | RSVD(4) },

I know the entries here appear to be in mostly random order, but if
you're adding numerical ids towards the end, perhaps you can try to
insert them in order.

>  	{ } /* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, option_ids);

Johan
