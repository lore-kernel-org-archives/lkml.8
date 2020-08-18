Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F1B2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597777329;
	bh=3JxHEf69MiYBgRnPoJemOu/qqSt5jjbd8a7ucWtXl5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=riW6N03ukedHMmOTf3m1M8P1SBDBvMMs1vf1qStPMdU7Wlm3HhuszkBIWFUXjgSMs
	 UMjVIItLdydo+yfsXxqJLw44KNX1KD51LxRg8Lx1JOaj09K9bz7Y8vof0LVQbbasOF
	 SWyO5o6eJroPWIewBI+Ke8MXaX+ZW/6HyeTF5n+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHRTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHRTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:02:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DEC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:02:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b30so10774127lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQVuZWCOnlFwQnX2Zqx0X5sy3pLItQeKoPELobHQVGQ=;
        b=OdFylsapCoULupAOYKw2uxh3CBvd6ctb0Q+oE4KHDc7exoz8gPT0JzpVzCs2UFYloZ
         pdfG98SZ4TKORf3pZEGIPjJidGca60aMQLOi2nen+7fHRK9fQJKdqmCu+AFXvUdhjWjx
         E0UpiJcscdcfZTXaD9DYNr+NvdEPSVQoYZIRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQVuZWCOnlFwQnX2Zqx0X5sy3pLItQeKoPELobHQVGQ=;
        b=XDq9LkdIJqK7VHLrLX+1BE52/jRNmnrf3qsSboJsjpupRFecT2hsAHwD6lVFINgOjF
         CFaJVT9xjcTmZ2lKePKBHknqGDcfXJ1Zl1GEkQrkx26Q8ydfNueH2SadpOzykOpnXxW7
         qn6TfbOU5aUKz8mjY19e/lG7PgWkesNIJ8PIg9ieHFbQ3W9FO3mUJukqLat4XZpTtli+
         pw1l1lsb9STov1Sdi1of8qRQGxwTRycnaZ6mN98Dp55F6UtYlImMLyiY6eBKLbDf6cU4
         9o4CHb7RKVIsI/SHSX0KvNFYer3Nr6FvvgvXuVeLtxLbF/CYb1VLyyvBKljY9V75tZPB
         E8IQ==
X-Gm-Message-State: AOAM530u6WW2+wr8PTomzNDpA4oFdWZIX9uyA6Hp4uP/hykaJ20RgEGG
        wHflp8mp+DDzcN1uekBmAZkBKma28P2dXA==
X-Google-Smtp-Source: ABdhPJw/V3r1lQUAQReVTFvOHAJaO+ZVna4FJ30ASNRtJN7uzHQzSMbcFNSYoBKmwW8GCL0yZkUt1g==
X-Received: by 2002:a19:5c2:: with SMTP id 185mr10301706lff.38.1597777321118;
        Tue, 18 Aug 2020 12:02:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j6sm6762278lfp.44.2020.08.18.12.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 12:01:59 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t23so22663266ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:01:59 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr9769511ljc.371.1597777319256;
 Tue, 18 Aug 2020 12:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200815043041.132195-1-shy828301@gmail.com>
In-Reply-To: <20200815043041.132195-1-shy828301@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 12:01:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbaptBBKYS+XdCgdjU_RbFPaAd8EkT6_Un6CtNmezt9A@mail.gmail.com>
Message-ID: <CAHk-=wjbaptBBKYS+XdCgdjU_RbFPaAd8EkT6_Un6CtNmezt9A@mail.gmail.com>
Subject: Re: [v3 PATCH] mm/memory.c: skip spurious TLB flush for retried page fault
To:     Yang Shi <shy828301@gmail.com>
Cc:     Yu Xu <xuyu@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:04 PM Yang Shi <shy828301@gmail.com> wrote:
>
> We could just skip the spurious TLB flush to mitigate the regression.

Ok, this patch I will apply.

I still hope that arm64 fixes (maybe already fixed) their spurious TLB
function, and I think we should rename it to make sure everybody
understands it's local, but in the meantime this patch hides the
regression and isn't wrong.

Thanks,

                Linus
