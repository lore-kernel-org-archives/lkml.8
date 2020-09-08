Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1017AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E724206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wETpD6sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgIHQIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgIHQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D0C06179B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:56:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so19638766wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYC9v1Z1TC/eRVDb6B6iUcOvbi2c078flAMPYhklKtQ=;
        b=wETpD6saEAEz/nnn8zVtwhh+gaFPha+TeS89jJ1i0WXRSxkwSLmbkgYLe8LJONzyMS
         DoB7HEnSel284io7HecToViYhGiJ/osVBiEYD5yf36sYhXeLWHEvuky/VfFW+7XxkgGB
         VNk4oD+jr9cpDC8j7R2bk16HED+JGEVY/OcjOdN2e+kZrHY2LHNqjx+alq560KySCd1/
         RwuqL+2rbOxyAm0vQxuu+ygoqRDiR/sxu6RsaVECGbE7ZTmzbo3vAPc3y+pfvc+FtQcc
         g1bQM/CkUw5uoAWK6aYaUslAe00EShXz22vICKweKwyYvAPpqK2uKAcCW+a4z8jnwfTk
         tehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYC9v1Z1TC/eRVDb6B6iUcOvbi2c078flAMPYhklKtQ=;
        b=aPPGpkPbgaj118C1mWjkjZM082+NknRP4OWJnU/eyYvKQaMV4GJ481xS8bJ2KfXHZY
         KPXQw6iXtSK/WOQs2/+KaOyPE7ybEsKh0Sm7Yddg2QXzp7gsox8TbVgcAS7oA65gpLs5
         I3s4kuQlKFF3aFoL+CG/3bywIaRyIlH9wpv3WVFtceSz5ofJAytuxIE7gjkegtR9pQrE
         7cc3wopxWCUOhwH3aLEM2yKC0X7MIJoRA0gtZQUQ0sZsbZvIOEjzNMw2C+5JLvh/NquS
         +Em6KQmxWOrHQn1H/+uFiutk7q1t08lLC1RoEHscznhsbLKr3VH6MwexwG27HLygfjVA
         e5rw==
X-Gm-Message-State: AOAM532sXaXA05KZEeL3PabCKGvZ93hG9xw3527V12HuqUUnZyfI4Mi9
        Xg2JajqcCObhwVMuGXwleMz9UA==
X-Google-Smtp-Source: ABdhPJzbyBGQJjklA0DbEeiaRcvxaMdt7wtqKlePMw2vv0wGDtTenivAuH+P4XF9OnbAiMxdsAAPtw==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr335425wrs.36.1599580598237;
        Tue, 08 Sep 2020 08:56:38 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id h184sm34756040wmh.41.2020.09.08.08.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:56:37 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:56:31 +0200
From:   Marco Elver <elver@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dave Hansen <dave.hansen@intel.com>, glider@google.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mark.rutland@arm.com,
        penberg@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        andreyknvl@google.com, aryabinin@virtuozzo.com, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
Message-ID: <20200908155631.GC61807@elver.google.com>
References: <20200907134055.2878499-1-elver@google.com>
 <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
 <20200908153102.GB61807@elver.google.com>
 <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:36PM +0200, Vlastimil Babka wrote:
> On 9/8/20 5:31 PM, Marco Elver wrote:
> >> 
> >> How much memory overhead does this end up having?  I know it depends on
> >> the object size and so forth.  But, could you give some real-world
> >> examples of memory consumption?  Also, what's the worst case?  Say I
> >> have a ton of worst-case-sized (32b) slab objects.  Will I notice?
> > 
> > KFENCE objects are limited (default 255). If we exhaust KFENCE's memory
> > pool, no more KFENCE allocations will occur.
> > Documentation/dev-tools/kfence.rst gives a formula to calculate the
> > KFENCE pool size:
> > 
> > 	The total memory dedicated to the KFENCE memory pool can be computed as::
> > 
> > 	    ( #objects + 1 ) * 2 * PAGE_SIZE
> > 
> > 	Using the default config, and assuming a page size of 4 KiB, results in
> > 	dedicating 2 MiB to the KFENCE memory pool.
> > 
> > Does that clarify this point? Or anything else that could help clarify
> > this?
> 
> Hmm did you observe that with this limit, a long-running system would eventually
> converge to KFENCE memory pool being filled with long-aged objects, so there
> would be no space to sample new ones?

Sure, that's a possibility. But remember that we're not trying to
deterministically detect bugs on 1 system (if you wanted that, you
should use KASAN), but a fleet of machines! The non-determinism of which
allocations will end up in KFENCE, will ensure we won't end up with a
fleet of machines of identical allocations. That's exactly what we're
after. Even if we eventually exhaust the pool, you'll still detect bugs
if there are any.

If you are overly worried, either the sample interval or number of
available objects needs to be tweaked to be larger. The default of 255
is quite conservative, and even using something larger on a modern
system is hardly noticeable. Choosing a sample interval & number of
objects should also factor in how many machines you plan to deploy this
on. Monitoring /sys/kernel/debug/kfence/stats can help you here.

Thanks,
-- Marco
