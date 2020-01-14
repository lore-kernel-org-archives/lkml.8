Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2BC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52AD2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578992030;
	bh=JCChi5iOgTBRcs5GhTEYg6YEX2HIuM2ZGqA5rtsGUrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqjSwIZB9jmg0lbVT87PNhpBvlH+M0U0IEFXtEJzCx2xhEZlr1ssYPg4tA25MUHCB
	 TAF/Wv31LuCPrPwqM9Y7BuEOOY3L3p+tvsArHk1AjoB+wif8xMMzJR4yhXQtzxd7gk
	 NSwQH+Lnv0UfzpTbRzFuXt2vmz14Ef3n+5zqsMQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANIxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:53:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39942 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:53:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so11184459edx.7;
        Tue, 14 Jan 2020 00:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jF2tdIecki+DQ7lqcMG62cCuHUle8BdpmOn9fa7Pb5c=;
        b=XgUxkIZf2/8IWtmEjm5X5/5HeW0rj3U1RIe3C+gr0bITBJrYjAwJA+s/V9I2xpe5zw
         VWWECr/0YuXWPgpxgSqC/74wZ1TiPP4mSHISFICZ1v1Q92aHkVLUfClpPDOafyujvTIw
         oaOJUcH7hhla2Y17E2vURRbQkvrB60Jt8FWdoffF9icIv/sLgHnKof0FKojYbfTk1Wba
         QIpB/HADpek+a5uB8apJFwROnTSbuRG6/LWTpXCBJtHQMqqA/pryES1kHiea/5bY74o6
         y8x4/UnIwSDdPtAEP9jV+djY+3Ytej7JwPr10sEK0LQ50ds7zDWbOcOC69vG2z/YN0rg
         bgxA==
X-Gm-Message-State: APjAAAWLNOEPJFgwmNDz+4l4572dijr2OAT+ZAS/sHzWMhiHlVNoaT45
        fpBIWAZcrwx2yykhCi6wal5DeZxh
X-Google-Smtp-Source: APXvYqygVkOwFasGwl9eMHv6ocMtP0ea95/KypoS9E6mF12yxzivVsRyX1xxQB3pZu4HC2c1cf3TkA==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr21472460eja.27.1578992027395;
        Tue, 14 Jan 2020 00:53:47 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id qw15sm577405ejb.92.2020.01.14.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 00:53:46 -0800 (PST)
Date:   Tue, 14 Jan 2020 09:53:44 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Use proper printk format for resource_size_t
Message-ID: <20200114085344.GA4976@pi3>
References: <20200103163925.3967-1-krzk@kernel.org>
 <82e79053-00bf-283e-458d-0b2711258585@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82e79053-00bf-283e-458d-0b2711258585@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 09:27:35AM +0100, Helge Deller wrote:
> On 03.01.20 17:39, Krzysztof Kozlowski wrote:
> > resource_size_t should be printed with its own size-independent format
> > to fix warnings when compiling on 64-bit platform (e.g. with
> > COMPILE_TEST):
> >
> >     arch/parisc/kernel/drivers.c: In function 'print_parisc_device':
> >     arch/parisc/kernel/drivers.c:892:9: warning:
> >         format '%p' expects argument of type 'void *',
> >         but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/parisc/kernel/drivers.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
> > index a6c9f49c6612..a154de424421 100644
> > --- a/arch/parisc/kernel/drivers.c
> > +++ b/arch/parisc/kernel/drivers.c
> > @@ -889,8 +889,8 @@ static void print_parisc_device(struct parisc_device *dev)
> >  	static int count;
> >
> >  	print_pa_hwpath(dev, hw_path);
> > -	pr_info("%d. %s at 0x%px [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",
> > -		++count, dev->name, (void*) dev->hpa.start, hw_path, dev->id.hw_type,
> > +	pr_info("%d. %s at %pa[p] [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",
> 
> It needs to be    %pap   instead of   %pa[p].
> The documentation in Documentation/core-api/printk-formats.rst is correct, but misleading.
> I corrected & applied it.
> Thanks!

Damn it, you're right. Thanks for noticing!

Best regards,
Krzysztof

