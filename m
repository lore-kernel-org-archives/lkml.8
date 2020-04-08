Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40BC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED24206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eShkpyC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDHBUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:20:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDHBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:20:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so3841768oth.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w74IQpWH+YeWMBE49oRHFdAV4Qtub4fERsktwyE3yMU=;
        b=eShkpyC2j7BgC9dKflFtWT3BanRLRI4FR5r+l2HfDAnmrCnH5wdmKlUqR5xw0nn1vt
         zJeiNrFQtsSsD4YbvTaBJ9FHsXfdLuJ3Vgy5twrY+84lgek6k1UOSIwKi16yf2Fu5qon
         P4dELGkn4E2CENN87UdXHtkLnxTl5sEdAzKgaexWGfeXcggMGF1qeH1cF6en+AaK0XuK
         6nI5sPWSOE9Luyu+0SoK4HXVjxOfon5XfmdN/UFHUZsXS3m4T3B404Ocsp7gRykWeook
         DqOxk1d9SRrrhDf1BlitGdiPVVDqOtSQ3nkl0eU+6JU9JVjm83mE6nDhHI1khrXPRyyY
         vhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w74IQpWH+YeWMBE49oRHFdAV4Qtub4fERsktwyE3yMU=;
        b=duz6PIJDvBAooAzPAFhAELdxx8amkZxBTSsKS3wwME4qIelEp5R8ODZGiUmKPytmZr
         gIf5DiuJ/G6yoNsgFTrYuwkH90LrYow3I9btkabMo61VWjc4VC0MR/4nQS13yvOF6ssE
         SbtqPlSSynH7CA6ZqbF7vGOq9CJUe/rpvoVaJU03cnaynR8AvwAFQJBpRLoNWUDS2zUa
         R2SVYjIX/ubJvPoQIpTn4vQoXnxUpY2897SbMF/YOYIr0Pnt+5B0ux7RGPAndRFz+fe9
         A86dAFMBbziOZuTj9NvaKjPKGZCAr97VZ1YKi1ESAmb57hkTOiSyMvwZyg8VL2kVrxAR
         XGWw==
X-Gm-Message-State: AGi0PuZU6L3JrSRhCN4E6jXZoDwCOeufHflARAHsnokV/uw9LmxymNuI
        /rgrmHk3du4+DjqZ3WyXobKcHdEE
X-Google-Smtp-Source: APiQypLG2wKpFDLR8uMgZ5n9JRt0QDVqxhTip1KKep9inHP7v17jRMPb6Wb+tLc+sKxMOXkklAAGpw==
X-Received: by 2002:a4a:a226:: with SMTP id m38mr4189121ool.94.1586308830034;
        Tue, 07 Apr 2020 18:20:30 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id g72sm5927092otg.79.2020.04.07.18.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 18:20:29 -0700 (PDT)
Date:   Tue, 7 Apr 2020 18:20:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] ARC: [plat-hsdk]: fix USB regression
Message-ID: <20200408012028.GA40613@ubuntu-s3-xlarge-x86>
References: <20200407161933.10874-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407161933.10874-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:19:33PM +0300, Eugeniy Paltsev wrote:
> As of today the CONFIG_USB isn't explicitly present in HSDK defconfig
> as it is implicitly forcibly enabled by UDL driver which selects CONFIG_USB
> in its kconfig.
> The commit 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
> reverse the dependencies between UDL and USB so UDL now depends on
> CONFIG_USB and not selects it. This introduces regression for ARC HSDK
> board as HSDK defconfig wasn't adjusted and now it misses USB support
> due to lack of CONFIG_USB enabled.
> 
> Fix that.
> 
> Fixes: 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/configs/hsdk_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
> index 0974226fab55..f79c15892704 100644
> --- a/arch/arc/configs/hsdk_defconfig
> +++ b/arch/arc/configs/hsdk_defconfig
> @@ -65,6 +65,7 @@ CONFIG_DRM_UDL=y
>  CONFIG_DRM_ETNAVIV=y
>  CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_USB

Shouldn't this be CONFIG_USB=y?

As it stands, this patch does nothing.

Cheers,
Nathan
