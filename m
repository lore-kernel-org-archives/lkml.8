Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC0FC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963D12065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595601948;
	bh=e8NxHBw15bPFDKNS3PtLCv2UFLG9ocdw579DTCyUFHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TcpBot1u/tpr54T6gylltowwNaCGFKEbSsHMb09DwwOZSDJ2KpD8NzkG9ZefMgMTU
	 F+1b9mARSP0E+8UT4YnQfgT4ELMZ4ToYlQKVp+UN6KGHhS6VVM62FLLYr8Sz3eqOaP
	 z5anStQMGvUwWLK19yOHsNE9B6xogVA+2O4jvrnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXOpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:45:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42951 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:45:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id h8so5318149lfp.9;
        Fri, 24 Jul 2020 07:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dzkx8gigl6y/De7kKuc0wZrJ0/8/lN60gfKkzmdYUI0=;
        b=dyhHWZM6Xgw4Ajl8H1CUqnUIkRVUc4RPb+xaHqfH5zcXUFE5RYdNu5Xw8cAoNAiTnu
         x5LEs8VOgk6h8ksaxEnWNeO5mkrw2qT0qZu3di1scTi5m5pyQnmpfzczPlr/eoocOyPF
         GPpoOYpPC/+Dcd+tEoZEohn4NqQyGp2afH+m1E30BNtBoXaqrK8N5fU3MggBGvsoiTX6
         Uhu43Fe+lydXOlaLE2lTxUrCEQzSabnniV12VfSbbl/qIAODmu9qevVj9K3JPfShstgd
         HbftaXgS2BynbbP0mSr5Lr4JcBT0awjUIaAw4ev8yXh+B11ZWoMEwVMClS9m4be9SjQW
         AtXg==
X-Gm-Message-State: AOAM53232PaXdJHGzBg1D6lybcSHOFg0gaReYA3Ui7c7Bv68FgkAFXPP
        0x7B2N+z11YouhK6AD1Btfo=
X-Google-Smtp-Source: ABdhPJxuDUKtDBKeqpYEsnpicDu6cv82dbR4O6uIC8LLHmnCf4mma1fQefnoPsAv972lWmW/J6c3kg==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr5218572lfc.100.1595601944019;
        Fri, 24 Jul 2020 07:45:44 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id m5sm287761ljb.98.2020.07.24.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:45:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jyyx6-00031S-Np; Fri, 24 Jul 2020 16:45:37 +0200
Date:   Fri, 24 Jul 2020 16:45:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] USB: serial: Replace HTTP links with HTTPS ones
Message-ID: <20200724144536.GP3634@localhost>
References: <20200719161920.60087-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719161920.60087-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 06:19:20PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/usb/usb-serial.rst  |  2 +-
>  drivers/usb/serial/cyberjack.c    |  2 +-
>  drivers/usb/serial/ftdi_sio.h     |  4 ++--
>  drivers/usb/serial/ftdi_sio_ids.h | 34 +++++++++++++++----------------
>  drivers/usb/serial/kobil_sct.c    |  2 +-
>  drivers/usb/serial/metro-usb.c    |  2 +-
>  6 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
> index 8fa7dbd3da9a..0a2071953691 100644
> --- a/Documentation/usb/usb-serial.rst
> +++ b/Documentation/usb/usb-serial.rst
> @@ -202,7 +202,7 @@ Keyspan USA-series Serial Adapters
>  
>    More information is available at:
>  
> -        http://www.carnationsoftware.com/carnation/Keyspan.html
> +        https://www.carnationsoftware.com/carnation/Keyspan.html
>  
>    For any questions or problems with this driver, please contact Hugh
>    Blemings at hugh@misc.nu

Looks like your script is buggy; there are many more URLs than this one
is this document.

> diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
> index e8373528264c..a5bf2b974813 100644
> --- a/drivers/usb/serial/ftdi_sio_ids.h
> +++ b/drivers/usb/serial/ftdi_sio_ids.h
> @@ -60,14 +60,14 @@
>  /*
>   * Texas Instruments XDS100v2 JTAG / BeagleBone A3
>   * http://processors.wiki.ti.com/index.php/XDS100
> - * http://beagleboard.org/bone
> + * https://beagleboard.org/bone
>   */

And here's another indication of that.

Johan
