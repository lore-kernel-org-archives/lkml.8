Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FEC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BC42072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578650890;
	bh=WrH36AHMdMHvdW2ynfc0mnXcxX5VgvyDqqCnPFOwIEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P498pm/13+PCCRDLjFknZgPMHO2gbv+u8S1IlZNlooCYi7TD2pAfSqyTh6+OhJG4P
	 6HswbDngpVzhuc8gveESqYo8mRecHEjDcAzMJF5ljh2QtmTCfkrxWIjI/KGAxQTiQ5
	 i24ahiR+tJkCceS8hPZp7WIsYpa/Tudrz7oWt2W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgAJKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:08:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32919 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgAJKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:08:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so1564041lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMR/A6pyW5FEM1U8xEMbCP0uXb0dwX5dOOik560rwKg=;
        b=hIDNU0U5lNHwU1VDijBYChUpgM+utV22QeKOhOGZlZeQninmHqQbOBm+QOCs7y85yg
         fm0Z4CycybadAXd9JKahHumJg40haf2AiRGggtMXujeT01ZmJzelg+FyALuIPEQDwe7y
         k4dLTBjCInVvXtl3cWxqGFb9IvtbfLT1PRIlSbRUUC+dDKLCjVpvFqzRPqUimhkZqSnZ
         AYmp9Na7BWbDfv7o2FxyA8t1trfbj2D0i7jkpPzq3NxV3jIyztuesc7jOpr8l9lECa6k
         5uVJqGZFqLdcrhEtb3DJJDVKQOc5SKBUGNT8AK+u3maDSPymGj0RZi8A/LqiKrmkrybF
         Yj/Q==
X-Gm-Message-State: APjAAAWnRAtuQ6/7ezymZeEUIqnnzDhWgicXpjbS5+aJqVSuSrVq/Lea
        4Fx4uJQXcxmX8rtmzommK20=
X-Google-Smtp-Source: APXvYqy000juSVZcoTyphGtn73Qy4cYgLf6XMRyhINGK1akoIC3h68aujIzLffVRiBxEdJeNikHUpA==
X-Received: by 2002:a2e:86c8:: with SMTP id n8mr2005170ljj.205.1578650886991;
        Fri, 10 Jan 2020 02:08:06 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id l21sm741503lfh.74.2020.01.10.02.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:08:06 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iprDF-0001Ao-AP; Fri, 10 Jan 2020 11:08:17 +0100
Date:   Fri, 10 Jan 2020 11:08:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: always relink the port
Message-ID: <20200110100817.GA4273@localhost>
References: <20191227174434.12057-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227174434.12057-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 05:44:34PM +0000, Sudip Mukherjee wrote:
> If the serial device is disconnected and reconnected, it re-enumerates
> properly but does not link it. fwiw, linking means just saving the port
> index, so allow it always as there is no harm in saving the same value
> again even if it tries to relink with the same port.

This is a pretty vague description. Commit fb2b90014d78 ("tty: link tty
and port before configuring it as console") completely broke usb-serial
(and anything else hotpluggable) which obviously depends on being able
to reuse a minor number when a new device is later plugged in after a
disconnect.

Things are crashing left and right due to that stale port-pointer, and I
just had to debug this only to find that this one is sitting in the
tty-linus branch. I know, I know, Christmas and all, but would be nice
to get it into -rc6. :)

> Fixes: fb2b90014d78 ("tty: link tty and port before configuring it as console")

Also note that the offending commit had a stable tag unlike this one.

> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/tty/tty_port.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 5023c85ebc6e..044c3cbdcfa4 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -89,8 +89,7 @@ void tty_port_link_device(struct tty_port *port,
>  {
>  	if (WARN_ON(index >= driver->num))
>  		return;
> -	if (!driver->ports[index])
> -		driver->ports[index] = port;
> +	driver->ports[index] = port;
>  }
>  EXPORT_SYMBOL_GPL(tty_port_link_device);

Johan
