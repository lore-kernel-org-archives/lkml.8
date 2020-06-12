Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4AAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8A20836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZBz7bXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFLQfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:35:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C46C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:35:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t21so6855278edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yVNHTAW1XJdHmtR0a1FJNXlEuEIG0Mtgdk/0DC6Vuc=;
        b=aZBz7bXB0OSgiOS5qyjbOW7Vx612Zl0oSmCA4hK1BT3lmeJ7LLBJWNU+POU/09YNh1
         j/lK2JfDJqhRHhc1A1KkKGonuB+BRc2o1ujrU7/h43XG1GUnNsSLxZT5PoSY1PC4tn07
         CcI+VSPVjGfz5gigqiDyQI7uDcinagrKGi6ckxl/cQaqPEmo6QPmbzWFOVg82z7STdKa
         LRo4PssmtQNwXVLUAwhuZdd399UCA2Qw1ZcATFxQLuC9+IjbMq8VzdeM9WifkYF9efNQ
         xXDKs4UqPz/mAQVis0fXV+tkDAVu0Ix4MQLrp7Gy65drUfZchR3qqrBIymlr6heDhQRd
         cnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yVNHTAW1XJdHmtR0a1FJNXlEuEIG0Mtgdk/0DC6Vuc=;
        b=REPR+Dg0I9RncWGAEFTbB0CELn4BnFjmaQeUMGd+c0eWYKRpNHkS2N0d3S0LHXUTDr
         xzzadVhmWE1XTZh14ymfqIDH5Ysa1gc41MLdy0KT1GyONTwax7rVpcRB5B/zBAS66DZI
         /nTjl9kGNGZ+JNP1hhEuweDkvi+VcS9oO3EhBsfTWf232riMwKlyJYu2hf2NMrcuPZUr
         6bIgHaS4HyB+7vDxgHbVM4lc3m8IkOmGa05swKKCYFMvWCI/HFjFxz34mPBMPquU/ssj
         wfG9pz18KZhoUFkcG7l2IExGnhVS/0VuchuRwKHbs+5qwOi11wZ2BaTZ7K195MFmDo12
         zRtw==
X-Gm-Message-State: AOAM533FnpYW4Etm9B+QJZ83+E0IDMg9hKdcUcu5Srs7vU1mQhKplL6Q
        KQfRL/26nc5xEKI+8neAW5LMx3WK
X-Google-Smtp-Source: ABdhPJxbL1NKw5rS6qml0HyAppqAQIFg9QJZOnmwuoyhuH8EzlqHpEmKFC8zs5m9mOJklk+2G0Vx5w==
X-Received: by 2002:a05:6402:22e4:: with SMTP id dn4mr12647031edb.288.1591979711743;
        Fri, 12 Jun 2020 09:35:11 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:1143:792f:f1d8:ffcf])
        by smtp.gmail.com with ESMTPSA id kt10sm3816790ejb.54.2020.06.12.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:35:10 -0700 (PDT)
Date:   Fri, 12 Jun 2020 18:35:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Henning Colliander <henning.colliander@evidente.se>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
Subject: Re: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast
 removes address space '<asn:2>' of expression
Message-ID: <20200612163509.6ieqxm4peqcfgd7o@ltop.local>
References: <202006121356.lKucoVPo%lkp@intel.com>
 <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
 <9b599221-3c15-909c-168a-766c554827d9@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b599221-3c15-909c-168a-766c554827d9@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 01:33:16AM +1000, Greg Ungerer wrote:
> Hi Marc,
> 
> On 12/6/20 5:48 pm, Marc Kleine-Budde wrote:
> > the k-build robot found this sparse problem, triggered by building a CAN driver
> > for m68k. Is this a problem in our CAN driver or in the m68k headers?
> 
> I suspect a problem with the m68k (specifically non-mmu) headers.

Indeed.

> I think this one is due to not forcing the volatile cast in __raw_write().
> So this change will fix that:
> 
> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> index 0498192e1d98..1bc739f1f1ad 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h
> @@ -14,15 +14,15 @@
>   * that behavior here first before we include asm-generic/io.h.
>   */
>  #define __raw_readb(addr) \
> -    ({ unsigned char __v = (*(volatile unsigned char *) (addr)); __v; })
> +    ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
>  #define __raw_readw(addr) \
> -    ({ unsigned short __v = (*(volatile unsigned short *) (addr)); __v; })
> +    ({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
>  #define __raw_readl(addr) \
> -    ({ unsigned int __v = (*(volatile unsigned int *) (addr)); __v; })
> +    ({ u32 __v = (*(__force volatile u32 *) (addr)); __v; })
> -#define __raw_writeb(b, addr) (void)((*(volatile unsigned char *) (addr)) = (b))
> -#define __raw_writew(b, addr) (void)((*(volatile unsigned short *) (addr)) = (b))
> -#define __raw_writel(b, addr) (void)((*(volatile unsigned int *) (addr)) = (b))
> +#define __raw_writeb(b, addr) (void)((*(__force volatile u8 *) (addr)) = (b))
> +#define __raw_writew(b, addr) (void)((*(__force volatile u16 *) (addr)) = (b))
> +#define __raw_writel(b, addr) (void)((*(__force volatile u32 *) (addr)) = (b))

Look good to me but isn't easier to leave them undefined and include
asm-generic/io.h?

> > >     arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
> 
> This one I am not sure about yet.
> Still investigating.

	swab32(__raw_readl(addr)) ?

Keeping __le32_to_cpu() will only force you to use ugly casts for no benefits
and the comment above explain clearly the situation about the endianness.

Best regards,
-- Luc
