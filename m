Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F80C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D20206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580322033;
	bh=LvoXdvznlP7G0tgiMLKIf8Qlwe1SWx6uPYbpHMmrbyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5ZAlZ5jGGHDZkePsbvZ5Pqc73XL9RVNNRfhMfGH8wr2P8fGabLy8AaXY1XlTGo2j
	 iD4+JuspxmJXZtvp34a/e/QFAXd5pMRWGVKw7IokHUPe5YjdEJY6JhOJdncxPeHMIe
	 7WSCg22LBbRlmoMpOtiWX9Zz84EMWZiHzdu5vc2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgA2SUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:20:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39086 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgA2SUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:20:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so774466edb.6;
        Wed, 29 Jan 2020 10:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAlt9sUhm5zn3CkiuoYhtDJJhOfJezTwh/rQdwcy2qo=;
        b=eJRQTd+UmPmkPeVCidfgtok3ECCsOhxDAtf2V1lu1Jm1LFsOLwaQkP+TNA3tAy6Bcf
         SDn+HWH8CjKEurIHA1eJxmZpUeXTX+qXseSGh20j8FncSonzqK8pprKkKZkzt0DqGGPt
         UeU+ZeHCK8qfopA9V8wlLgvupSiapbI9caE5HA5OgKqun6qCrxbrjw3VyoF1k3DciLQR
         WsaZDNHnaBrtVqwsfN9kHr3B9tj0jD/Mxu9epEbKl1wsvI7M3bHUJ/Mn0uQGkITlgFBX
         R5ixb6lteoMasgLcaUWYZdT6UXstz8VGSazUDeC/Lick12exoeCiPk355CBYdBujDRBt
         djBQ==
X-Gm-Message-State: APjAAAXBbnV8jEm2tacxEukq+Tk8Zq9LDLBqf0KAuz16YCsI34mbZG1R
        N+e9FZ+WSqLv0E3VqbcmGOk=
X-Google-Smtp-Source: APXvYqyM76d1tXBOIO/kDgSXHenjgUCHVzUXMOBkFUyHNley4ZSGxzdiDbG0DVWYM1y6KBWr7W0ByQ==
X-Received: by 2002:a05:6402:1764:: with SMTP id da4mr264387edb.24.1580322030093;
        Wed, 29 Jan 2020 10:20:30 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id e22sm315486edq.75.2020.01.29.10.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 10:20:29 -0800 (PST)
Date:   Wed, 29 Jan 2020 19:20:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
Message-ID: <20200129182027.GA13142@kozik-lap>
References: <20200129101401.GA3858221@kroah.com>
 <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:11:26AM -0800, Linus Torvalds wrote:
> On Wed, Jan 29, 2020 at 2:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Here is the big USB and Thunderbolt and PHY driver updates for 5.6-rc1.
> 
> Hmm. This actually causes a new warning even before I start building it:
> 
>   WARNING: unmet direct dependencies detected for I2C_S3C2410
>     Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && HAVE_S3C2410_I2C [=n]
>     Selected by [m]:
>     - PHY_EXYNOS5250_SATA [=m] && (SOC_EXYNOS5250 || COMPILE_TEST
> [=y]) && HAS_IOMEM [=y] && OF [=y]
> 
> and the cause seems to be
> 
>   203b7ee14d3a ("phy: Enable compile testing for some of drivers")
> 
> where PHY_EXYNOS5250_SATA now has a
> 
>   depends on SOC_EXYNOS5250 || COMPILE_TEST
>   depends on HAS_IOMEM
>   depends on OF
> 
> and then blindly does a
> 
>   select I2C_S3C2410
> 
> without having the dependencies that I2C_S3C2410 has.
> 
> How did this ever pass any testing in linux-next without being
> noticed, when I noticed within five seconds of pulling it? It
> literally warns immediately on "make allmodconfig".
> 
> The warnings happen during the build too, as it does the silentconfig.
> So I'm not sure how this was missed.
> 
> Stephen, does linux-next perhaps miss these config-time warnings?
> 
> I have partially reverted that commit in my merge (removing the "||
> COMPILE_TEST" for that PHY_EXYNOS5250_SATA entry) because warnings are
> not acceptable.

Hi Linus,

The I2C fix for this is in Wolfram's tree already:
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

Best regards,
Krzysztof

