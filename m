Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519C320665
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKcs7Qp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgICOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgICObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:31:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D5C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:31:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so2458415pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oFkfi9X0bSyXN4Ol4NwfhYQ7K4ImI2pu3/xQMs0Xbv0=;
        b=MKcs7Qp8KGb5+t9fJnG083u4Kx6jssLPOPuGjGnViTuBwYXUYj8SkxVu8TxvG+761V
         5jrmqvo5emK3h8WHpzZmo8kS5n6YpWxfdwzpUWLSnNpCl7HwfAbXFjVyuiEvxu52rM+j
         +CFROzDjJI50NcZoCXs8L4qBWmoLZs+5/AkbOCFND0nfn3KRlAeoNd8AW3w8q68Zs2P9
         zsNWJG8wLxAu7hZH/mIVYkmj02yfDn7D6TYV8WCac1RKjWV5gb1GF9qXq7r0U01Vu6wN
         qMLWn8c7JX6P5kzXgnpEbs+WyooB9h+Cov7neLg4lwjLL31c6ZRjiH6LeiiU6X561wbU
         UtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFkfi9X0bSyXN4Ol4NwfhYQ7K4ImI2pu3/xQMs0Xbv0=;
        b=MYWL6u/uLe/eBA8dpuYsNlPoNrdI5OYVGutupymku4MwWin+4R3w1Fjg5gDzkuhRaU
         c5Pl5NtCM8Dht7tONJkG8Ag9BG4yiygNpj7FFlJm6SZqLJ4RtCowMR/sLObnpeh+mHcm
         n0tdczLOPDlU+WFaAlicTVaNqlMkNQuU02/e457LRPt7mOQxwMtV/urDtqGOYbvuysLq
         MThiNV0hbe5jo33FAUAVjqNMnCiBgpfkoP9DZKppxn4mgSNP4Wby9KXtvg+PyA7BdUWA
         8xF5ZhYAAR9tJCnIoCFzarMfRL98dCAjY8fPlFR+Sv8kjfl0BiRgG0uD5SnVxNFUu0aV
         BoeA==
X-Gm-Message-State: AOAM5328jlqhAsaNyM+x5l7N4fRl/y1Ya3h9uVn4iwu1YkybMwPxI52f
        3h6XT6slHOe14CJZxsQHF5c=
X-Google-Smtp-Source: ABdhPJwlYk90RS7DiBtFzKRDGKn9wXHh7hXxCQNlalKw2n+V/V5fU5hw8dP94ZQaoDksnGg07uKbtA==
X-Received: by 2002:a05:6a00:811:: with SMTP id m17mr4053548pfk.20.1599143498199;
        Thu, 03 Sep 2020 07:31:38 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id n1sm3489776pfu.154.2020.09.03.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 07:31:37 -0700 (PDT)
Date:   Thu, 3 Sep 2020 23:31:35 +0900
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
Message-ID: <20200903143135.GD3562056@lianli.shorne-pla.net>
References: <20200831212102.4014642-1-shorne@gmail.com>
 <20200901055924.GC432455@kernel.org>
 <20200901102044.GB3562056@lianli.shorne-pla.net>
 <20200901121130.GA698558@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901121130.GA698558@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:11:30PM +0300, Mike Rapoport wrote:
> On Tue, Sep 01, 2020 at 07:20:44PM +0900, Stafford Horne wrote:
> > On Tue, Sep 01, 2020 at 08:59:24AM +0300, Mike Rapoport wrote:
> > > On Tue, Sep 01, 2020 at 06:21:01AM +0900, Stafford Horne wrote:
> > > > Recently OpenRISC added support for external initrd images, but I found
> > > > some instability when using larger buildroot initrd images. It turned
> > > > out that I forgot to reserve the memblock space for the initrd image.
> > > > 
> > > > This patch fixes the instability issue by reserving memblock space.
> > > > 
> > > > Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > > ---
> > > >  arch/openrisc/kernel/setup.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > > > index b18e775f8be3..2c8aa53cc7ba 100644
> > > > --- a/arch/openrisc/kernel/setup.c
> > > > +++ b/arch/openrisc/kernel/setup.c
> > > > @@ -80,6 +80,15 @@ static void __init setup_memory(void)
> > > >  	 */
> > > >  	memblock_reserve(__pa(_stext), _end - _stext);
> > > >  
> > > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > > +	/* Then reserve the initrd, if any */
> > > > +	if (initrd_start && (initrd_end > initrd_start)) {
> > > > + 	memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> > > > +		ALIGN(initrd_end, PAGE_SIZE) -
> > > > +		ALIGN_DOWN(initrd_start, PAGE_SIZE));
> > > > +	}
> > > 
> > > The core mm takes care of reserving the entrire pages for the memory
> > > reserved with memblock, so it is not necessary to do it here.
> > 
> > Thanks for the pointer
> > 
> > I guess what you mean is it is not required to do the page alignment.
> 
> Right. 
> 
> > I used other architectures as an example and most do the alignment, I
> > think for most architectures this can be pulled out to generic code.
> 
> You are more than welcome :)
> We already have a generic free_initrd_mem(), maybe it's time to have a
> generic reserve_initrd_mem().
> 
> I'm ok with openrisc doing the alignment, but I think using local
> variables would make the core more readable, e.g
> 
> 	if (initd_start && (initrd_end)) {
> 		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
> 		unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
> 
> 		memblock_reserve(aligned_start, aligned_end);
> 	}
> 
> What do you say?

Well, if the alignment is not needed I rather not do it.  That would make the
code as simple as:

        if (initrd_start && (initrd_end > initrd_start)) {
                memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
        }

Let me look what is involved in making a reserve_initrd_mem().

-Stafford

> > -Stafford
> > 
> > > > +#endif /* CONFIG_BLK_DEV_INITRD */
> > > > +
> > > >  	early_init_fdt_reserve_self();
> > > >  	early_init_fdt_scan_reserved_mem();
> > > >  
> > > > -- 
> > > > 2.26.2
> > > > 
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> 
> -- 
> Sincerely yours,
> Mike.
