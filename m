Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF662076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598037544;
	bh=wSTKeZ8RYsodv17qoVbfr6E+L2ticHuZsb/2G+eOf2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MT6rHHVrMI43yn0yN3q/XAT02WS4SxYeAfBSi8Hv1oKHj8HYj6O2DcVX2kymOJDhO
	 dTtAFwfTXZ0fXfa4ROBmFcnLeBnGk0OOoEmt2vymjN6Z0kgW0rulmBM0CaFg2u+QEg
	 wqhHKcP0Kkc0RLoNop4qmlGQgl8Ft4XrHrdlT0lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHUTTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:19:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0CC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:19:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so3043046ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLc84kj5PHVUSiFGEP5mfzNqVCypKwLtWPaDrgaberY=;
        b=SofWc/w6t4rEsc85RaLfw4+1oCNKhS2jGDmsKj708JnMxQaUL81Q5yOWX5EhAMzU+x
         Cb3KyXSNMzLbsgJPGamhAP2iMjt3UL8rroxFzqL7p6C5UBNeY6HNa3Jd1zJI2GavW46Q
         WhVw+1qcn3yzbaRWJ0lfgO2uTu43gklL+LpRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLc84kj5PHVUSiFGEP5mfzNqVCypKwLtWPaDrgaberY=;
        b=dnL9y5an4AebaHwClIguIf9fsQB19XYJunpi9sS9D9yLUJjFETf9gui5PWJ1d+0V8l
         oGAj3tTfDVQ4eg42LkZQPizPdR9hW0B7KLbh7mZMEhZdt0PenhzFn1ssg1fGboyQdDw/
         GBgKDibf7UYhRfPFnJ1JO35ZhNBqIaD1oERxHM312HeoZ7mEJrZFTpx09fnG7WJWJIss
         UqM0INs+e0dr0Vt+8J7wu1T6Me1L9Ud0eACVfN1GEJwS9KZQoasDf1SEMFFgImr66PYN
         6s7d7yMzCCB+5A9OekByzpEc0zGifekretnfwAc6w3XF6DI6aR881VAqz1Nh2OrFvfit
         Jq2A==
X-Gm-Message-State: AOAM5336+FHAi7N+c4The5xfpAwlFcXp+pV1IgrbUUKf91wS1NqX2bIx
        wWO7Yz9b7xYrQHJ6NehbqNQ5DN45YwaOWw==
X-Google-Smtp-Source: ABdhPJxWOTRdaLbFofCTg/MowVjA5TrEYL/PfHoPnIeaFcbyM9xLIF9iB+eKEJfozK0yzpFqX/0GPQ==
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr2081057ljp.6.1598037539655;
        Fri, 21 Aug 2020 12:18:59 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e17sm550965ljg.85.2020.08.21.12.18.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:18:57 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d2so1446551lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:18:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr2073008lfp.10.1598037536954;
 Fri, 21 Aug 2020 12:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200821123746.16904-1-joro@8bytes.org>
In-Reply-To: <20200821123746.16904-1-joro@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:18:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNEsVwVMwQdHL4O1tDWQa-HcmOv-EmqLTQH+SoC2CkWA@mail.gmail.com>
Message-ID: <CAHk-=wgNEsVwVMwQdHL4O1tDWQa-HcmOv-EmqLTQH+SoC2CkWA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Track page table modifications in __apply_to_page_range()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Joerg Roedel <jroedel@suse.de>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 5:38 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The __apply_to_page_range() function is also used to change and/or
> allocate page-table pages in the vmalloc area of the address space.
> Make sure these changes get synchronized to other page-tables in the
> system by calling arch_sync_kernel_mappings() when necessary.

I get the strong feeling that these functions should be using a
"struct apply_details *" or something like that (the way the
zap_page_range() code has that "zap_details" thing).

Because adding more and more arguments gets pretty painful after a
while. But maybe the compiler inlining it all makes it a non-issue.

It also strikes me that I think the only architecture that uses the
whole arch_sync_kernel_mappings() thing is now just x86-32.

[ Well, x86-64 still has it, but that's because we undid the 64-bit
removal, but it's on the verge of going away and x86-64 shouldn't
actually _need_ it any more ]

So all of this seems to be purely for 32-bit x86. Which kind of makes
this all fail the smell test.

But the patch does seem to be the minimal fix for a real issue - I'm
just pointing out ugly details, not actual problems with the patch.

IOW, a somewhat reluctant Ack, hoping that this will be cleaned up
some day. Possibly/hopefully because arch_sync_kernel_mappings() just
goes away entirely.

                 Linus
