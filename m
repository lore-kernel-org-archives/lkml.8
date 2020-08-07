Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABCBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C8B2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7mC8E68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgHGRU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHGRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:20:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C06C061A27
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:20:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so2372633wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s8Gg7Zt8gvjVcJNqZJEesrPztRK/2q4jyigfD0LuxL0=;
        b=J7mC8E68aYnj2RergZPJmlURoMDBxPuYGSSgoOGWnrU0RV2jKkTOL9u1LfD8O3oQ+j
         rPjBORNpj3pTQP7vR2TvQc4QSeDFHnJFntoZdwSA9vbeEd5MlK5rqzJGyCP7sGO9uQIZ
         /8QmCW4CZdfG7Bz3LiTM2Qw/DS3YKrjc6NFSaNyHGaXU54Zb86aoIrR0pksNFu01abEr
         QolRT8rPOndmAV/+u7J382KsweZWvO4nzctjvPu3Ms5MK0HWpBtqzSsDLRrCrjUsFCAj
         d3H6hIYK7gInEQXtQjP3P/CkGzq1jFM/sIGudxRCu3/t6R+7DSLSFCTLeRlmAPTmrb4Q
         imqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s8Gg7Zt8gvjVcJNqZJEesrPztRK/2q4jyigfD0LuxL0=;
        b=r+YShnbUVpPWvVfrkazX9nGMfNF3BUqDkzqAPvEoIb8hn7dyjbCK9SkPTnBelaL8Lz
         yCQQBVbwxhzu7ZSS76yM4+Kth0WCO0IJbwCpK3ilUe/QC66C0CTK6OeGEoZWKJBdR1Gl
         Vy38ErKEYk/F3Dm+rgrAtlWKIXVIwKul/BNcsH7o61VFBbyfHivMzYHS+WnrIlvYxEVa
         E9ngRsFHrenjnUDQo39iJY0W39O5uzg+dsc+EK1YKmuRleIzEc4snHTj5ukdFX4hrT64
         RIH2z+X+ld/o2RjQ7f9yIlK8J/7lq5qfeYP5gqa9b5GQHjOblco2jwWxEErV0WQXNCVD
         +Fhg==
X-Gm-Message-State: AOAM533W42nb21kpcZ7r/B5RpsQSRyn6aNSdPPoPAnKW1dRq+o7DGEax
        f2o4Vl8n9xL6cLGQ9pI1JHGJow==
X-Google-Smtp-Source: ABdhPJwtX/HDP1muKWF83XqDo5WH0PxfeVFbIX1cunmSOV+Dj9s8LZXg8o/Nuba/vDmB5+6zExwUPg==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr14385469wmc.9.1596820855087;
        Fri, 07 Aug 2020 10:20:55 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id j5sm11530953wmb.15.2020.08.07.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:20:54 -0700 (PDT)
Date:   Fri, 7 Aug 2020 19:20:48 +0200
From:   Marco Elver <elver@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
Message-ID: <20200807172048.GB1467156@elver.google.com>
References: <20200807160627.GA1420741@elver.google.com>
 <202008071010.69B612E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008071010.69B612E@keescook>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:16AM -0700, Kees Cook wrote:
> On Fri, Aug 07, 2020 at 06:06:27PM +0200, Marco Elver wrote:
> > I found that the below debug-code using kmem_cache_alloc(), when using
> > slub_debug=Z, results in the following crash:
> > 
> > 	general protection fault, probably for non-canonical address 0xcccccca41caea170: 0000 [#1] PREEMPT SMP PTI
> > 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #1
> > 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > 	RIP: 0010:freelist_dereference mm/slub.c:272 [inline]
> > 	RIP: 0010:get_freepointer mm/slub.c:278 [inline]
> 
> That really looks like more fun from my moving the freelist pointer... 
> 
> > 	R13: cccccca41caea160 R14: ffffe7c6a072ba80 R15: ffffa3a41c96d540
> 
> Except that it's all cccc at the start, which doesn't look like "data"
> nor the hardened freelist obfuscation.
> 
> > 	FS:  0000000000000000(0000) GS:ffffa3a41fc00000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: ffffa3a051c01000 CR3: 000000045140a001 CR4: 0000000000770ef0
> > 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > 	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 	PKRU: 00000000
> > 	Call Trace:
> > 	 ___slab_alloc+0x336/0x340 mm/slub.c:2690
> > 	 __slab_alloc mm/slub.c:2714 [inline]
> > 	 slab_alloc_node mm/slub.c:2788 [inline]
> > 	 slab_alloc mm/slub.c:2832 [inline]
> > 	 kmem_cache_alloc+0x135/0x200 mm/slub.c:2837
> > 	 start_kernel+0x3d6/0x44e init/main.c:1049
> > 	 secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:243
> > 
> > Any ideas what might be wrong?
> > 
> > This does not crash when redzones are not enabled.
> > 
> > Thanks,
> > -- Marco
> > 
> > ------ >8 ------
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 15bd0efff3df..f4aa5bb3f2ec 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1041,6 +1041,16 @@ asmlinkage __visible void __init start_kernel(void)
> >  	sfi_init_late();
> >  	kcsan_init();
> >  
> > +	/* DEBUG CODE */
> > +	{
> > +		struct kmem_cache *c = kmem_cache_create("test", 21, 1, 0, NULL);
> > +		char *buf;
> > +		BUG_ON(!c);
> > +		buf = kmem_cache_alloc(c, GFP_KERNEL);
> > +		kmem_cache_free(c, buf);
> > +		kmem_cache_destroy(c);
> > +	}
> > +
> >  	/* Do the rest non-__init'ed, we're now alive */
> >  	arch_call_rest_init();
> >  
> 
> Which kernel version? Can you send your CONFIG too?

Sorry, didn't see this before I replied to the other -- it's here:
https://lkml.kernel.org/r/20200807171849.GA1467156@elver.google.com

Thanks,
-- Marco
