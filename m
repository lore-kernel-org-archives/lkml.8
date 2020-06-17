Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04581C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEC421532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAu0Qdvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:49:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3CC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:49:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k1so1281687pls.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V8lfggKruB1yxFCmUN4ar1a8ljPH48vbHQvDBnle06w=;
        b=BAu0QdvrHfiQZ08QWi34W+w11gyEywFYCO6sOb3qBaVIoncA8HDODvGWklons9V1Bt
         9lyak1FCWvUwiO4WdJ4oM+LCoWrMcSKhhzVa1IfTr4IpRgUKuExeRgmEwAsXm+ae8C90
         uYBs4m556VRNtgXQtGduEa4erGq/5rIbRdayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8lfggKruB1yxFCmUN4ar1a8ljPH48vbHQvDBnle06w=;
        b=egMMwtpLKGmfKP6zldaRgk+OTKtSOrzIKRHRJwdQ+oKnJ0W85SLs4iO5qhX4NJUXiJ
         baStDJu/tDgmcHhLQ6Grwh2mnpTLB+Gv/z+kAv+v+Un3M3TJzSLJkuJME/F+0/FJ3f0/
         JHcWJVpFDP30LshS/cdCpLHJgqSLliC9OhPTdTbkDg8za/pvxhm6NMOiHipWZqP5b1dz
         ZmEX5a+WXXKkPE30QjApuhf4mim9wJ6OxoPQcy4Q4UaLfwmfpa0/Z506B7RaPFKcHu93
         QIMVHhX1wG6yQ/EgUe0fCckcclMtH6hrqyhWqs/I+4YPtZUDbAlMjaCoW/DNttH1k31C
         fRqg==
X-Gm-Message-State: AOAM533mRZGcx/MjFvznqmSISaeJh4IZFxyPuUThX/RdHn2akVYLKgu0
        N6zeEm1kNaCbq5oKZZ0T66zmXQ==
X-Google-Smtp-Source: ABdhPJw9S4YN836QBe6/J0KFILnonDrNZ5QstUwSC3O98xpTSz+s1IeX7ybnbluBUeCNZ5SSyIApIQ==
X-Received: by 2002:a17:90b:3c6:: with SMTP id go6mr219283pjb.224.1592416171161;
        Wed, 17 Jun 2020 10:49:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mu17sm213065pjb.53.2020.06.17.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:49:30 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:49:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <202006171039.FBDF2D7F4A@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-10-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> always get the cache from its page in kmem_cache_free()") to support kmemcg,
> where per-memcg cache can be different from the root one, so we can't use
> the kmem_cache pointer given to kmem_cache_free().
> 
> Prior to that commit, SLUB already had debugging check+warning that could be
> enabled to compare the given kmem_cache pointer to one referenced by the slab
> page where the object-to-be-freed resides. This check was moved to
> cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
> configs by commit 598a0717a816 ("mm/slab: validate cache membership under
> freelist hardening").
> 
> These checks and warnings can be useful especially for the debugging, which can
> be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
> WARN_ONCE() so only the first hit is now reported, others are silent. This
> patch changes it to WARN() so that all errors are reported.
> 
> It's also useful to print SLUB allocation/free tracking info for the offending
> object, if tracking is enabled. We could export the SLUB print_tracking()
> function and provide an empty one for SLAB, or realize that both the debugging
> and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
> this patch moves cache_from_obj() from slab.h to separate instances in slab.c
> and slub.c, where the SLAB version only does the kmemcg lookup and even could

Oops. I made a mistake when I applied CONFIG_SLAB_FREELIST_HARDENED
here, I was thinking of SLAB_FREELIST_RANDOM's coverage (SLUB and SLAB),
and I see now that I never updated CONFIG_SLAB_FREELIST_HARDENED to
cover SLAB and SLOB.

The point being: I still want the sanity check for the SLAB case under
hardening. This needs to stay a common function. The whole point is
to catch corruption from the wrong kmem_cache * being associated with
an object, and that's agnostic of slab/slub/slob.

So, I'll send a follow-up to this patch to actually do what I had
originally intended for 598a0717a816 ("mm/slab: validate cache membership
under freelist hardening"), which wasn't intended to be SLUB-specific.

-- 
Kees Cook
