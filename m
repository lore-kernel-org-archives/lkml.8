Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D98208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3DuAi5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFQQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgFQQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592411173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1M9WvivRzg/UUgjnxURfzGnX8qHpGKU/oDf/OOqkscI=;
        b=C3DuAi5xowUFEZZmlGJkuA7ds+Hbd6Q2N5GW6kVi8ulIL5wB3ESS9F1RQv9OGimU3Ax0cU
        bKcyyrVuqQWTZr/9llXywC/NWLMsJamm2h0uED2ZHzTV01K75/h1BZwAl/lHxjIqosLjJ7
        tjg6P1Oo9rXDO8KtlBV3KlHZSaTa690=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-MD4jdINdOpqw1fg6BVfzbQ-1; Wed, 17 Jun 2020 12:26:12 -0400
X-MC-Unique: MD4jdINdOpqw1fg6BVfzbQ-1
Received: by mail-qk1-f199.google.com with SMTP id l6so2228801qkk.14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1M9WvivRzg/UUgjnxURfzGnX8qHpGKU/oDf/OOqkscI=;
        b=R/5fBAa5tQq8tK0G54tjB2imGWdKVFg9Q3Ze6mdt+9qJssb1axBoMex3frq3JMWu10
         ojxVidy+dz5PPNDyM9VvYlZxdIJX/YzIOSl9H/4IriZxo7VNc5WD/gSpJ5B91nYux0il
         lN1riXosxlGdGJOMhs5S+SXBeuYp8u0tgKXtqYXHZiZXNB7QcHNbzhJy64OPkatAbzOW
         /EmGZx0wm49E+eibtM2Z1zIlwZaiR7OghHFEqJybTW9ro7wz9bxyVbLt/Td7Xpa9DMDM
         1Vd5byV3vut77VFr6FVx126a9xZH0bH5Zskqa8DP4hWjBigEbVeZzOkCaSzQmNLrZxOs
         ZrqA==
X-Gm-Message-State: AOAM533IwyWCxET7smR07i1tMzFVlVQOecirvsCZ32dK6Jkq882YkYki
        iVkeRMQn89Awtglf4BeEn8e4euUjlwtJilfFFCyYhWt0UhPnctttSPID5NFC+p04PPvzuIfEa7/
        T+1eh30fp8qzBsRPV8k2Y8/ER
X-Received: by 2002:a0c:8145:: with SMTP id 63mr7951246qvc.60.1592411170977;
        Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5WMjBE13VUb/JibHYqb8P3sJF0YbvsjnO7AsWjJWN8INO9NeIPMzvOcqYNy8ozdjAcpcqxA==
X-Received: by 2002:a0c:8145:: with SMTP id 63mr7951232qvc.60.1592411170743;
        Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t188sm393624qka.27.2020.06.17.09.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:26:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 02/25] mm: Introduce mm_fault_accounting()
Message-ID: <20200617162608.GF76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-3-peterx@redhat.com>
 <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
 <20200615231917.GA6307@xz-x1>
 <20200616120037.e96d8d9b42e615f3b8da222f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616120037.e96d8d9b42e615f3b8da222f@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:00:37PM -0700, Andrew Morton wrote:
> On Mon, 15 Jun 2020 19:19:17 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Jun 15, 2020 at 03:32:40PM -0700, Linus Torvalds wrote:
> > > On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Provide this helper for doing memory page fault accounting across archs.  It
> > > > can be defined unconditionally because perf_sw_event() is always defined, and
> > > > perf_sw_event() will be a no-op if !CONFIG_PERF_EVENTS.
> > > 
> > > Well, the downside is that now it forces a separate I$ miss and all
> > > those extra arguments because it's a out-of-line function and the
> > > compiler won't see that they all go away.
> > > 
> > > Yeah, maybe some day maybe we'll have LTO and these kinds of things
> > > will not matter. And maybe they already don't. But it seems kind of
> > > sad to basically force non-optimal code generation from this series.
> > 
> > I tried to make it static inline firstly in linux/mm.h, however it'll need to
> > have linux/mm.h include linux/perf_event.h which seems to have created a loop
> > dependency of headers.  I verified current code will at least generate inlined
> > functions too for x86 (no mm_fault_accounting() in "objdump -t vmlinux") with
> > gcc10.
> > 
> > Another alternative is to make it a macro, it's just that I feel the function
> > definition is a bit cleaner.  Any further suggestions welcomed too.
> 
> Could create a new header file mm_fault.h which includes mm.h and
> perf_event.h.  A later cleanup could move other fault-related things
> into that header and add the appropriate inclusions into files which
> use these things.
> 
> btw, I think mm_account_fault() might be a better name for this function.
> 
> And some (kerneldoc) documentation would be nice.  Although this
> function is pretty self-evident.
> 
> > > 
> > > Why would you export the symbol, btw? Page fault handling is never a module.
> > 
> > I followed handle_mm_fault() which is exported too, since potentially
> > mm_fault_accounting() should always be called in the same context of
> > handle_mm_fault().  Or do you prefer me to drop it?
> 
> Let's not add an unneeded export.  If someone for some reason needs it
> later, it can be added then.

I plan to take the approach that Linus suggested, probably with
mm_account_fault() declared as static inline in memory.c.  I'll remember to add
some kerneldoc too.

Thanks!

-- 
Peter Xu

