Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E086D205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591218025;
	bh=FetGcMhGfY2h9O1jW73kESWp2lhuksVAtiyXes639Wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kAafHZ6eWPxQXV98psIaIw2RA7//7IgCbqLxD04qc6s66iClmcZqpbhp5Sj46z1P2
	 wu5wJfAH3FvSxy+LZcmUd5nSDbQgI0NyigcQKilEVHkuiASN2exhUhq6U+Cuse+EtL
	 btdbqH5cVn+k6FNvCfZRhGhf2YHrSnUoD7MJ4nB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFCVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:00:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32742C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 14:00:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so2190563lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0b+qr176vnemvoQgcf1HFSuRPIqMyeMZrgGdeChVyfo=;
        b=bpoZOeXkOq2jdLMF9vg9SSQ/4oMaJZ3yhJEERc3GP8VTAFh8GVOMQroy6GKYhMGGJu
         AMxgClLtjnSkIrR4yo8GVGPq9+EnIVNedKMFY7CnQp14jERaDVMEvJqIFKdzkrYvsQaQ
         0wQvXi1lx10JMJxvBSafvGuuRvyaxpRFlk3mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0b+qr176vnemvoQgcf1HFSuRPIqMyeMZrgGdeChVyfo=;
        b=Jl1GV7JzPmiP+B9zJZO4BWhNjXe2x76nCBHdvRSqNXAiIl4ummTRmu3DBG5GNkRqCB
         q0RoowloDfIunR3TPGfRZD/sXUYF1ojtP5wKrxZNnPbgLx1yXXdO3UOtIcTCL4Bjywfb
         u8FKEJKcytfCOaiRXuwZL6SWcGf3UKUIWw7L0DuT6HDFHkta+xgZvm6pP4oiqxTGZnuN
         Yq3bWusLKt08G5AuTx7Tkg77ACMR8kdgKB/03z3EZgNplJz2GfkayalgsQoP1Hxhjw2N
         5T5CSw48cm06Gf085onI2p3eqKwNqL1vurvsaR4g9wI15/8EvUQaaXKxoWlq+1J7XyRp
         E0ow==
X-Gm-Message-State: AOAM5313pt3BJ3r4c7BD8mnyuR8+9LhqufwCuR0o+VBb0H2UlIQ8+elj
        nt+a0Te51kOJU7UHNmWd+cfrKrJdHUU=
X-Google-Smtp-Source: ABdhPJzhePRlQteT4K6dW3quJRKnZUr/UV/bh1j99P6XL+stb3+AemuF5nhK41YAwIiGmWbhC+eL9g==
X-Received: by 2002:a19:8447:: with SMTP id g68mr721056lfd.132.1591218020798;
        Wed, 03 Jun 2020 14:00:20 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y18sm967969lfk.16.2020.06.03.14.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 14:00:19 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a9so997224ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 14:00:19 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr539040ljn.285.1591218019098;
 Wed, 03 Jun 2020 14:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200602125445.GA12527@alpha.franken.de>
In-Reply-To: <20200602125445.GA12527@alpha.franken.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 14:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtew82tj8_QLPU-xqT702vmB0pGgQSuQkK_Javnz6PPw@mail.gmail.com>
Message-ID: <CAHk-=whtew82tj8_QLPU-xqT702vmB0pGgQSuQkK_Javnz6PPw@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes for v5.8-rc1
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bibo Mao <maobibo@loongson.cn>
Cc:     linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:55 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> Bibo Mao (4):
>       mm/memory.c: Add memory read privilege on page fault handling

Hmm. That's a horribly named commit, but can you clarify why this
didn't just use the existing pte_mkyoung?

These are all paths that set the dirty bit early if it's a write, I
don't see why they wouldn't set the accessed bit too.

Even on architectures that manage the accessed bit in hardware, this
might be a (tiny) performance advantage because it avoids a page table
walker microfault to set the bit when it's accessed.

We already do the pte_mkyoung() in paths like cow_user_page(), so the
others may have been just oversights?

Or was there possibly some reason we didn't want to do it here?

                Linus
