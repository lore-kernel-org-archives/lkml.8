Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6713EC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F162173E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MLIeXrP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbgDCIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:12:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35882 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:12:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so5414657oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ymTJVtUxBUPQPt/DjBQudCk2SDBLtq2q0vAVeHEhjU=;
        b=MLIeXrP5vfs5pP0srG+5v4SHJhfyQO53bs//r28tSH5Z9+XMQzqZKd5isNZPnGtaVA
         3cZRtIeOcaLBJRSQYypEbgbwY7mwZoRbBLKquFYBAGV9toZtODL6tslmFISYdlp5rKTK
         DOJ5dJQ6DrOlklAY8LMbdgHc8DfcHyurH1bqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ymTJVtUxBUPQPt/DjBQudCk2SDBLtq2q0vAVeHEhjU=;
        b=btmzA30uaouQmto6vQDGjy53Lg/XrIgLYs7F3w/cluWh6ot6xw/ZOu7QJhuLVLCaUA
         ozBdTjN+2GGkUibFIgK7pXMxIg0WwCgwZNPBmLUZsIsPCZATWRaGD7IC1fRrkUNjF13q
         RSXGm9hk8e62SlVzGuccYld+/CTofB7rgq0Sks4AL96yWK+Aoj68DIpa5LTV3sS5oK/A
         odeHsIL1BReLZm1hVIesiRRy0v+KqRQAzt3WCOy5hlBbmZ/XsNknOwVR1OSPf103q+az
         dIcrYCU2ewI/ecS3sGcOhDBhBMOaTuhmKI3Vk22cKjaHg4MFRu/ohgs04w/iyjcR8hKw
         N2rg==
X-Gm-Message-State: AGi0PuZYrE1yHrfhJIWxex2M8KzcnN1d5e9WmrticSYk0LfIqbhu3mQE
        WEgfb5GC1A5ZUk9+voZJF3Cpd+OTGv/0e0nrbn4mnA==
X-Google-Smtp-Source: APiQypLRxxLFI6qTSkiV0Pf6uGsAY0VtZxtzNnd9fFv8py//ecV5Oqx7DayfYPDR5/wP+uzeQY0CO8aRmlpOvO9fB58=
X-Received: by 2002:aca:aac1:: with SMTP id t184mr2170657oie.14.1585901546393;
 Fri, 03 Apr 2020 01:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
 <20200402203317.GA34560@ubuntu-m2-xlarge-x86> <CAHk-=wjHEOHCf7kAOJOY9bOr9O0CRzxds+8YcXVVGbMZ+7kyXg@mail.gmail.com>
In-Reply-To: <CAHk-=wjHEOHCf7kAOJOY9bOr9O0CRzxds+8YcXVVGbMZ+7kyXg@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 3 Apr 2020 10:12:15 +0200
Message-ID: <CAKMK7uH+vX=eh17-m9mL17QQ1uxjfDEcdj-tno-fAYA4Z1+Jag@mail.gmail.com>
Subject: Re: [git pull] drm for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 2, 2020 at 1:33 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > This fixes it but I am not sure if it is proper or not (could be
> > problematic if CONFIG_PHYS_ADDR_T_64BIT is set but
> > CONFIG_ARCH_DMA_ADDR_T_64BIT is not, not sure if that is possible) so I
> > figured I'd report it and let you guys deal with it.
>
> Yeah, no, that patch can't be right.
>
> From your build failure, your configuration has dma_addr_t being a
> 'long long unsigned int', and map->offset being a resource_size_t is
> for just a 'unsigned int'. Casting 'unsigned int *' to 'unsigned long
> long *' is not valid.
>
> You'd have to do something like
>
>         dma_addr_t temp;
>
> and pass the address of *that* in, and then assign that to map->offset
> (and verify that it fits), I think.
>
> That's kind of what the old code did.
>
> Or alternatively, the 'offset' field should just be of type
> 'dma_addr_t' instead (see include/drm/drm_legacy.h). But I didn't
> check if something else wants it to be a resource_size_t.

This is all exclusive in legacy code back from the days when drm
drivers where shared with *bsd. None of that code ever learned that
there's maybe a difference between dma/phys/virtual address sizes, and
that's about the least of the problems it has.

Revert seems to be clean, I'd vote for that. And maybe we instead try
to push these horrors more under the CONFIG_DRM_LEGACY. I'll try to
remember to do that, afaics the only thing outside are the
drm_pci_alloc/free multi-layered wrappers in drm_pci.c.

Linus, can you pls push the revert yourself, to avoid build bot
breakage for longer than necessary?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
