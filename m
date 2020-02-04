Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8D21741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580809662;
	bh=qqCO45tLyXv//k090GJiiuFH5iCsSgUZxI4IZouLnsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u73YTIcJMWX0oGwDW8QlLyH00+vhD/QJSF6Ds2McPEKFFVL4TvcJY6XF85uwPELFx
	 7hcw0SSEa2ufk9nQg2INkAy5EOAekWiPZ5SbbX+8Dhr+GTei6fvNLR2PY92MU2OSI5
	 N2Q19jvSIRvQx1I/IVcVfzRu7JDNxkOlKN02ZRXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBDJrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:47:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35717 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgBDJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:47:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id z18so11754491lfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6L54LVO9TvXxaJUND81Bx/qLlmxq42uCrN3lAcDoSms=;
        b=b/osIeYqbEgY+nKVlM9kE8bpWmiwBdLDJGLuhwYXSlkik23+QmJmDM5c3LtU5xl3gG
         q77ocJA+3cq5OZIXDA+mOQ+VVB3fjyYRs8exALjP5HTcPfQJXO4fE0k9clAK9jlSPhmG
         w4OB1ORfFsCaSV78oeYano4UKe655zT7hE3OERa713AgNGG4sRYhTCq9D9ymwQQUBmmM
         mtuxLGAqHRM37Y4xJjL7WhbmrAeiKnxit3e+1rqz7SKmZHiZDvI745NtdkICFx7p6AQw
         mes31F2epihms7rk2/fKDp4LbEIBe+QkZP8m1uWlhyEeb4FrrbFtiHCjLCRXTlZgqlwd
         Z4sA==
X-Gm-Message-State: APjAAAVvH/Co6vGfawFxIkmcr2Bn1FuPNiZZ0fWa5zRK9aEuGB4znpIA
        r/KpMKoZbpd1kXdI21yo9B8=
X-Google-Smtp-Source: APXvYqyIbJSw+Sx6yeQ9gVTr/+qxk9LEkrfSKMjVWWS4SZzGC9cNh2zqf5bZ8fXCY2jQlxbm8JVE0Q==
X-Received: by 2002:ac2:599c:: with SMTP id w28mr14738010lfn.78.1580809659847;
        Tue, 04 Feb 2020 01:47:39 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id w9sm11187437ljh.106.2020.02.04.01.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 01:47:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iyuo8-0003Is-IY; Tue, 04 Feb 2020 10:47:48 +0100
Date:   Tue, 4 Feb 2020 10:47:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_port: Restore tty port default ops on unregistering
Message-ID: <20200204094748.GG26725@localhost>
References: <1580285224-7712-1-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580285224-7712-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:07:04AM +0100, Loic Poulain wrote:
> When a port is unregistered from serdev, its serdev specific client_ops
> pointer is nullified, which can lead to future null pointer dereference.
> Fix that by restoring default client_ops when port is unregistered from
> serdev.

Hmm, yeah, this seems like something we should fix as 8250 appears to
allow reregistering ports, but...

> port registering/unregistering can happen several times, at least it
> happens when statically registered 8250 ISA port are replaced at boot
> time by e.g. device-tree defined 8250 ports.

How did the serdev controller get registered in the first place here if
you're talking about statically registered 8250 ISA ports (i.e. where is
the client defined)?

Did you actually ever hit this one?

> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/tty/tty_port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 044c3cb..bf893da 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -203,8 +203,10 @@ void tty_port_unregister_device(struct tty_port *port,
>  	int ret;
>  
>  	ret = serdev_tty_port_unregister(port);
> -	if (ret == 0)
> +	if (ret == 0) {
> +		port->client_ops = &default_client_ops;
>  		return;
> +	}
>  
>  	tty_unregister_device(driver, index);
>  }

Johan
