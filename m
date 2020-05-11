Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80AFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BE6206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fTLHNSai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgEKNt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729957AbgEKNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:49:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67557C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:49:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so9728455qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4rPpMLzUp9bspNeARk829RL9zhdg6LdCbnWGM4mXn5M=;
        b=fTLHNSaidCTBTVafRZ88/JPpZndAW4JKAiqp+xUjmlcGq11JBx+zkoc/gLYyuRZMpU
         8huyG7Lesc6lj13AkjhSbtSdyaW0HhfFpl0iYlVpDT1IiP7SHlaVI+MZSY7RwrTYhtBq
         RQNBgrM8IvriB2Mvvs4e8HQwdfhdtIbJbykV3RNu3vDxx3lnpyWu6MdARnOn+R62z8Jc
         KN8rcWegPekMEUZip8kruV0JwYQbPzQPKIlrCHz/KHExck9xbphKWhwcVarhbGi64Uoa
         alGo+ohiWuSyQC8pRj3oZO/AC0G930Xueg4XAOk+AAPwsMsi4evR7ZHEiIxrpqeKQKyH
         7Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4rPpMLzUp9bspNeARk829RL9zhdg6LdCbnWGM4mXn5M=;
        b=HKGVZuU2CAP/IwQBEaag49nsioIweaLFuCmhRjqZ6slToWpJG/u9mxuB/TiUsIqRym
         wg/uriz3ZoWVRzyIBm70JpRHd3E3CDYt7oKpw9IX6fY/fLEvPAFmzgYlwyAvUd7Gk62Z
         ZayUBgLBfpjwSI/Vx9m6jFM/VoL6ZJdgh7l5PT3anXVdLM3LJuQgpjJO+FKYlfDUQG9N
         2IQ4nMdXs9Wrbm9+L4hy8KmnIU5znROioJRbkHoSvpe3f5C2MTmTPE+O774AY0pss5VJ
         d/mALqqj6Js/r7Ln6ySfYhfb4/Ml3lsEZIUFy4S0Yf92idzHZzrdXr1Afpe4r8AXqSYg
         LbMA==
X-Gm-Message-State: AGi0PuY/JfhqEWWsbzxJUrb98DB6LfTviWwyqqOYlwgqgPglrN8R+bgt
        Vv2q00W6Rw3qCgckZ8bQwuKgIdMjiis=
X-Google-Smtp-Source: APiQypJNAQ0/U/AQ7HD5Ea1GoiCuDrCNke0sGrNZi0ZXjdmU+vdOsV+r7iIZyEfm/aW74L1CSMAM/Q==
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr15376455qka.320.1589204995576;
        Mon, 11 May 2020 06:49:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i10sm1542178qkk.128.2020.05.11.06.49.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 06:49:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jY8oc-0005UB-FF; Mon, 11 May 2020 10:49:54 -0300
Date:   Mon, 11 May 2020 10:49:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a
 select
Message-ID: <20200511134954.GS26002@ziepe.ca>
References: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
 <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 05:16:12PM -0700, Andrew Morton wrote:
> On Fri,  1 May 2020 15:20:44 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > There is no reason for a user to select this or not directly - it should
> > be selected by drivers that are going to use the feature, similar to how
> > CONFIG_HMM_MIRROR works.
> > 
> > Currently all drivers provide a feature kconfig that will disable use of
> > DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
> > they don't want the overhead.
> > 
> 
> I'm not too sure what's going on here, but i386 allmodconfig broke.
> 
> kernel/resource.c: In function '__request_free_mem_region':
> kernel/resource.c:1653:28: error: 'PA_SECTION_SHIFT' undeclared (first use in this function); did you mean 'SECTIONS_PGSHIFT'?
>   size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> 
> because in current mainline, allmodconfig produces
> CONFIG_DEVICE_PRIVATE=n but in current linux-next, allmodconfig
> produces CONFIG_DEVICE_PRIVATE=y.  But CONFIG_SPARSEMEM=n so the build
> breaks.

I think Arnd identified this, let us just revet the patch that caused
it.

> Bisection fingers this commit, but reverting it doesn't seem to fix
> things.  Could you take a look please?

There is a latter patch adding a 'select DEVICE_PRIVATE' so reverting
this needs to swap that to 'depends on'.

I've done both and updated git

Regards,
Jason
