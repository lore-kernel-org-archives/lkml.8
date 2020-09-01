Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB1C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641A72071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7o8/lr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIAKUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:20:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B79C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:20:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so303079plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mzeTFMKOo8l9sbsoHTHy+DYgTJIcAYGM2OFDh+7YnV4=;
        b=E7o8/lr3uAunH7766jfVTNlEN0CaV5kQIR+1FxqhDZDFBUwie7v0cdNC3ZbsBbTwDW
         +q4lKTh3I50jyruF0Kf3GRS8uJTb792Xm4Jhs2JT7Q2DnQ9BJ/xlCazanECpcRi870+o
         5abkQRfsQP/YV+g7FrifUOvzIYMibmvNZXSeHxQDlkWaCl/NXQfZ7mFLxEeaX+Pqilmi
         FqN1HbwLtcqnQ6Q3PvbJsdsNFIO0hQJVVQRMIFIA8hQazuz5wgoFXFAXszuUq3ER+nNs
         hZ2l+cWIInGBLtg8bGm5yxfNnX50WFaPlhD0IxIWcuzi63OxYbAB/jHesJXFf8vLDVZU
         WWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzeTFMKOo8l9sbsoHTHy+DYgTJIcAYGM2OFDh+7YnV4=;
        b=A34vunFGCgQ0Wk/yw9qeqEEeZCHeSHeKrBZmK3la1iF4blhEnrcv1AKPJN8XEvF7nu
         cnz0m69jW1X56uJomsrXDTx49cphwvrGDvHEs5dtVLmeAuzZppjGytLmEsxN9VFhrNwJ
         3mdb607B/EB7CKXvIWtz/PmX+dQGEog66jDckyciiTZlr8Ai4R5u7gVnq5h5CBLDC/5s
         iVtNN8phtiC6cUDjp7q+XYEqzyHx9O33zonM419FUzE//tI6ZLaaZPrLSZr39N9kwJvE
         enkqI5R7eIKqjb/yh0JKOQGooi8N3LsXKN8MIvS+/hS+hD3fM+nNrBW3d7HIXrpbwvJO
         KX0w==
X-Gm-Message-State: AOAM531gCh+l+n0nF2MKKerSVe+p+mDpSC5imstJHQoSbJ+pmSSaU0lX
        CLr/9AOwVfrVR4I2gPqrl906Tzwlfwc=
X-Google-Smtp-Source: ABdhPJyB/+mWYRD8yu0KCLSyy03GpQkyJPECT2gRsoK7qAVNUQZcl2UkP7yMDYVkplXnzcBddcvJcg==
X-Received: by 2002:a17:90a:4401:: with SMTP id s1mr863684pjg.79.1598955647085;
        Tue, 01 Sep 2020 03:20:47 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id s67sm1352506pfs.117.2020.09.01.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:20:46 -0700 (PDT)
Date:   Tue, 1 Sep 2020 19:20:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Reserve memblock for initrd
Message-ID: <20200901102044.GB3562056@lianli.shorne-pla.net>
References: <20200831212102.4014642-1-shorne@gmail.com>
 <20200901055924.GC432455@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901055924.GC432455@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:59:24AM +0300, Mike Rapoport wrote:
> On Tue, Sep 01, 2020 at 06:21:01AM +0900, Stafford Horne wrote:
> > Recently OpenRISC added support for external initrd images, but I found
> > some instability when using larger buildroot initrd images. It turned
> > out that I forgot to reserve the memblock space for the initrd image.
> > 
> > This patch fixes the instability issue by reserving memblock space.
> > 
> > Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/kernel/setup.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > index b18e775f8be3..2c8aa53cc7ba 100644
> > --- a/arch/openrisc/kernel/setup.c
> > +++ b/arch/openrisc/kernel/setup.c
> > @@ -80,6 +80,15 @@ static void __init setup_memory(void)
> >  	 */
> >  	memblock_reserve(__pa(_stext), _end - _stext);
> >  
> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +	/* Then reserve the initrd, if any */
> > +	if (initrd_start && (initrd_end > initrd_start)) {
> > +		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> > +			ALIGN(initrd_end, PAGE_SIZE) -
> > +			ALIGN_DOWN(initrd_start, PAGE_SIZE));
> > +	}
> 
> The core mm takes care of reserving the entrire pages for the memory
> reserved with memblock, so it is not necessary to do it here.

Thanks for the pointer

I guess what you mean is it is not required to do the page alignment.  I used
other architectures as an example and most do the alignment, I think for most
architectures this can be pulled out to generic code.

-Stafford

> > +#endif /* CONFIG_BLK_DEV_INITRD */
> > +
> >  	early_init_fdt_reserve_self();
> >  	early_init_fdt_scan_reserved_mem();
> >  
> > -- 
> > 2.26.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
