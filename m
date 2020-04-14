Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8CC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5B215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lct5lXl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390452AbgDNA2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgDNA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:28:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A24C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:28:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so5297219pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Iab8a1FKfuOAzK+EtN5ksWX3Ch8SBZHLkolYH18vMow=;
        b=lct5lXl+IscuWLrw6XCAopB0jz61pOOckI0TmsidUgK4aX5mFUXIL+srhSrr7xsXiI
         R858On8eqIKqa3BXB4MJdWnfFhKywElGKTmO4z+5bqMcrhqViWsYCBSTHeu5VymTDvXy
         vzDM5SQexLRHSqiZTMW5uVEwHz6m0ToMk5ffxuaUr7dFrUjGIrbFJSlBk8RtMkG1HFta
         e9YzM1vFQZlEpZx+IwYLnAg7oi80UtsWCGSGE9hdWjS2nYrQr6DSDyUzhadbwcYpuzTu
         tfVONL2lwfWuYRw4uqk4mrPTFWRAPc4c1PM/LJ8V399ICf9ZbS1MhBB39wQOxCgx1dGp
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Iab8a1FKfuOAzK+EtN5ksWX3Ch8SBZHLkolYH18vMow=;
        b=RliE2PAF9cHp2EHfVpHY5NNmSJQvVqnUe9dAxUy+77a9dbdHYCai6Bh0G1W+RSayXa
         qK6IlpsLBpbKT9mEY+9+nUxGO00NMzX78K+ynd764lkNWwDVZdphdl41N3g2f8BnC1DX
         RWMTzP/7zKf0n6sxblaM0/CCyhPv4keP1d4ykjUT1+dnCDNmlO1lWEih9klBTbspo9Ax
         ivZ/+JHzrpn4sgwWkiRt1KpYztXjRyE8FH9yfT1gzzAgd2u3opguZc8evgLAtzTEFc+C
         1IrhNh/L4QCfuiRYbr9HvUzSGhQxMlAIdw+2FqqzgGbaEWGTzmbcqO4NemBt6mZimfWf
         BuqA==
X-Gm-Message-State: AGi0PuacaeJWCPvH9XkA5q6EMF9h1y36S94ENlvko2KmsyWYm+rSj9zN
        uZ8FcZUGbFruxM07LCKVG9/Fj0GLUt8=
X-Google-Smtp-Source: APiQypLZpjmT/ThpynRDdIZHTO4aZH7CnvngDUK8vlIGwZhBDCAfCPTuSg0ilh9qJ0MLoF72azaR+A==
X-Received: by 2002:a63:5724:: with SMTP id l36mr15697582pgb.366.1586824079677;
        Mon, 13 Apr 2020 17:27:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 132sm9849909pfc.183.2020.04.13.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 17:27:59 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:27:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/4] huge vmalloc mappings
In-Reply-To: <20200413125303.423864-1-npiggin@gmail.com>
Message-ID: <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Nicholas Piggin wrote:

> We can get a significant win with larger mappings for some of the big
> global hashes.
> 
> Since RFC, relevant architectures have added p?d_leaf accessors so no
> real arch changes required, and I changed it not to allocate huge
> mappings for modules and a bunch of other fixes.
> 

Hi Nicholas,

Any performance numbers to share besides the git diff in the last patch in 
the series?  I'm wondering if anything from mmtests or lkp-tests makes 
sense to try?

> Nicholas Piggin (4):
>   mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
>   mm: Move ioremap page table mapping function to mm/
>   mm: HUGE_VMAP arch query functions cleanup
>   mm/vmalloc: Hugepage vmalloc mappings
> 
>  arch/arm64/mm/mmu.c                      |   8 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c |   6 +-
>  arch/x86/mm/ioremap.c                    |   6 +-
>  include/linux/io.h                       |   3 -
>  include/linux/vmalloc.h                  |  15 +
>  lib/ioremap.c                            | 203 +----------
>  mm/vmalloc.c                             | 413 +++++++++++++++++++----
>  7 files changed, 380 insertions(+), 274 deletions(-)
> 
> -- 
> 2.23.0
> 
> 
> 
