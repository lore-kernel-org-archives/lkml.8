Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06490C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45C2206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580321508;
	bh=NjBCFS6TpuMsbK40cyZdCeawNzv8Ge2iWq7ObLo21Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JOgiI1qUKKxVRi35jRZ+4NWF1IaqUQ5bLtU00i1Azm5yUOHR5Pn3VTe6Ddm9G/9yM
	 oI3I7TKl4FmiaB6A82vRkvKsVBbgxcdUBSq/hcwx+mvObvwTPGm8QRXWK0TGyaFQ+E
	 3lRua9JiTY5kKM0RsqI3sPjxZ5SkE/NObLyUuTbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgA2SLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:11:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2SLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:11:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so349465ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02ZRS+PX7FQYAeZ4yNizHXrsol3AHhSPPT78jnWNZSI=;
        b=QLAygB4qtDxvH7s7qkN9dHmEs4g1BPG63djXzdzgACGYT42ynfm9s9Lb6wl6JEcOYx
         VHqjFnJu+fdebeORwwd797eZtr0k+l99ShChTTRKnqrNDUTgLoQC5F0yuP+ecv2VagFU
         TSrC4G9MN5OF3GeHvZjnu2QPdx+V3So5512Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02ZRS+PX7FQYAeZ4yNizHXrsol3AHhSPPT78jnWNZSI=;
        b=QqeKPNZuPbmd+oRC9tKlkHHnKvYeOyg8ljHbW3e3nVQs+x7SQdrFU1VFw4xliwDuv6
         CGZKrtXDY2Xhfm5BZw4vm2SA59rcj/r/djraHE1zwdcBx5D0kleGUc7s4UGioBQnfgTa
         atLblRCB1C4bwzULhqPAkfPeZUy4vd0KzBD1hCoxbcAMh77dyll6WEbaGm+kIev29eNJ
         dPq53zxlfe11GXGazmPi0eCoEhoe3D9oncq4ObBwwfOmU9YCJ6CfUo/i6UVYqcroyts1
         vT4OyxdzElPu325Trfxch/s91HtIgAE0fdWHlq7gOOVXVe3qSjgd4jQdHJiHVHgozIJV
         Q7yA==
X-Gm-Message-State: APjAAAXNrlmCbCL+Hq7cBahyyIU/AjXGCHzY3RQcDHUCdFU4qSDR9tQc
        i2yfFws3zphB+h94TkioKF4gABx12p0=
X-Google-Smtp-Source: APXvYqz4bapoi+X/tZZ8GJrq/8Nm8hpRRST4zRsVDsLCPq1HoiieV5MiXppQbkftSLaTWH5lCaFmYA==
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr234304ljp.142.1580321504683;
        Wed, 29 Jan 2020 10:11:44 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u11sm1432768lfo.71.2020.01.29.10.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:11:43 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id y19so326830lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:11:43 -0800 (PST)
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr305234lff.142.1580321502988;
 Wed, 29 Jan 2020 10:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20200129101401.GA3858221@kroah.com>
In-Reply-To: <20200129101401.GA3858221@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 10:11:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
Message-ID: <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 2:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big USB and Thunderbolt and PHY driver updates for 5.6-rc1.

Hmm. This actually causes a new warning even before I start building it:

  WARNING: unmet direct dependencies detected for I2C_S3C2410
    Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && HAVE_S3C2410_I2C [=n]
    Selected by [m]:
    - PHY_EXYNOS5250_SATA [=m] && (SOC_EXYNOS5250 || COMPILE_TEST
[=y]) && HAS_IOMEM [=y] && OF [=y]

and the cause seems to be

  203b7ee14d3a ("phy: Enable compile testing for some of drivers")

where PHY_EXYNOS5250_SATA now has a

  depends on SOC_EXYNOS5250 || COMPILE_TEST
  depends on HAS_IOMEM
  depends on OF

and then blindly does a

  select I2C_S3C2410

without having the dependencies that I2C_S3C2410 has.

How did this ever pass any testing in linux-next without being
noticed, when I noticed within five seconds of pulling it? It
literally warns immediately on "make allmodconfig".

The warnings happen during the build too, as it does the silentconfig.
So I'm not sure how this was missed.

Stephen, does linux-next perhaps miss these config-time warnings?

I have partially reverted that commit in my merge (removing the "||
COMPILE_TEST" for that PHY_EXYNOS5250_SATA entry) because warnings are
not acceptable.

               Linus
