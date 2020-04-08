Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B720730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGUK0v3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHB7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:59:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40058 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:59:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id q2so2524134otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/UEX/qu552SCPFaaat1hu6i9S00M212yRB97ZlFyqw=;
        b=dGUK0v3QQ28XF/v/4rttw4NK/ilYlCaYkXrMBehOnMI3WsTobhpVFN2tErUSmvtD6J
         MNpwr0w8TltTkwPqLmOxkQTU9IkmlhEXWM0Sn1ILNxdD1JyifDauV4pZhVNvA189Tltd
         IJvU0fmMImx+hgrgtBqWcnad8EC5/zmWB6PTauFyXUUBfYZIwHqcQ+cGJ6rr4qfOvobO
         YoLU7oTh+GsyIzRoseGo01fJ65VodPSGb4PQFQfvE8fcAXmkYk7i46pVO90c5tIbzSbO
         u7KdV45BleSxjj6NShhMGJdTsubQ5c+NUx5HHalLU3sU9flTKyR2l9ruCEE2EQzcL/M/
         f+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/UEX/qu552SCPFaaat1hu6i9S00M212yRB97ZlFyqw=;
        b=pZ6CdQlmljo3lr9fH5PFHwDPvtR2e7jBNDByg/2yROxqBv23/k66fOn5cwmEezrM/W
         sY77yqjtFmHUjAjg84oAK3yHwOrX1kJ1AN5HIzm9SsdUA3Uea5Lrwtnk+/vszTQiXSRy
         QCNU1T1q3dwEtPQl/46fVSgrkA8sqvRk1vZ6PZuVBmaK3O2+S9HX1ozUOa0q7ZYxvENj
         DF8b/kU72groFlMhDbzf+nwy7oDHQ64XhgDdNeAtus/ZKLGx3YvipiXeGFacC6ZVYkm3
         qznhgEkZN6djEbZBTm0NwuQ9pv9w9iPoOE8I2PwLfB9feBMGVWRZiW8Tq7DqTjF//yf8
         XZXg==
X-Gm-Message-State: AGi0PuZBdyrSYH8ojv39ya0xfdulyBKN++80GfahbrnNg0ckRu4IFXw0
        ftTbHuEvHEGrhI5S1pKEKZE=
X-Google-Smtp-Source: APiQypJGBjWcy1K64T6QMq8WocCCTCUCqLf6FUlZTIYYZdEbAk6ISTQSX178vh57adpTgRUPbM6P+g==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr4225254otq.35.1586311191582;
        Tue, 07 Apr 2020 18:59:51 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id f184sm3221012oib.26.2020.04.07.18.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 18:59:51 -0700 (PDT)
Date:   Tue, 7 Apr 2020 18:59:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] ARC: [plat-hsdk]: fix USB regression
Message-ID: <20200408015949.GA40360@ubuntu-s3-xlarge-x86>
References: <20200407161933.10874-1-Eugeniy.Paltsev@synopsys.com>
 <20200408012028.GA40613@ubuntu-s3-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408012028.GA40613@ubuntu-s3-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:20:28PM -0700, Nathan Chancellor wrote:
> On Tue, Apr 07, 2020 at 07:19:33PM +0300, Eugeniy Paltsev wrote:
> > As of today the CONFIG_USB isn't explicitly present in HSDK defconfig
> > as it is implicitly forcibly enabled by UDL driver which selects CONFIG_USB
> > in its kconfig.
> > The commit 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
> > reverse the dependencies between UDL and USB so UDL now depends on
> > CONFIG_USB and not selects it. This introduces regression for ARC HSDK
> > board as HSDK defconfig wasn't adjusted and now it misses USB support
> > due to lack of CONFIG_USB enabled.
> > 
> > Fix that.
> > 
> > Fixes: 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > ---
> >  arch/arc/configs/hsdk_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
> > index 0974226fab55..f79c15892704 100644
> > --- a/arch/arc/configs/hsdk_defconfig
> > +++ b/arch/arc/configs/hsdk_defconfig
> > @@ -65,6 +65,7 @@ CONFIG_DRM_UDL=y
> >  CONFIG_DRM_ETNAVIV=y
> >  CONFIG_FB=y
> >  CONFIG_FRAMEBUFFER_CONSOLE=y
> > +CONFIG_USB
> 
> Shouldn't this be CONFIG_USB=y?
> 
> As it stands, this patch does nothing.
> 
> Cheers,
> Nathan

Nevermind, I came across v2 on the mailing list, sorry for the noise.

Cheers,
Nathan
