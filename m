Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE8320656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ShddrI1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgFJSdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFJSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:32:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CEC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:32:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so3401858wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuF+cADa9Q3nUhREBOrFxHULJ1t6/1ibL+MaQiIT2O4=;
        b=ShddrI1KueMSqR6Wmvilt3rbyr+sz5HwFSfAUsjfnmYpijcnBNTyMgSkGknkRMlEvD
         T7ONcUqIiN6ZuI/+73WkfNKjPnjpCxAY0Tq+chqDh8IyImYw44Sg7NfS0nCQK0g2iQfF
         hJUycqfOB9F5s9VszPETBUbzqglDtFaWamE4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuF+cADa9Q3nUhREBOrFxHULJ1t6/1ibL+MaQiIT2O4=;
        b=OSdeBr0wKEEfOAO956zGg4MgtreWcUd4xuQVUDdBYnOMkEk57Cot0ZxccAxIfs6DQI
         zO4J777EQElTnrbILEg8WxQ1x9GYNwR+i+oqKO0+mnY0fClzQ3/SyTY67OW6nnGKYhoJ
         vODmUXzHfyiTHdECISSIIQDIdy+O7IYnwJCUJ0iTlsDiQd9buNHkWnPVYviI4DtuxrMz
         +rgKRNWtDi771rVZGtnhxVjcWc2GZ3JkXLW1Wh+Zjn7qyhtja3ZaoqgbuNicFgpPEjMO
         E/UA3PhEaxyK6Tl5KbWRunhPaqC2c7UHyWWrx+nCLJRiOJXI9dYPA2NPDr5H6UFemIqg
         cDxw==
X-Gm-Message-State: AOAM533Z3CGDG4Z9CEjFgjwg6syoW2tMu79jGtfibBC1sKmRvzGVbSF5
        naxo1A6Et5Aye89YUQWvBn9+MfG66zVSIGdlUwbu
X-Google-Smtp-Source: ABdhPJxCnMMuL58nYu6fTmdEAISV5qEamhPuW63lyo5ERyRoWIudqU0rQgeZrHhfm+NaPcTZ3CjeV2CAQGJ51/I8SH4=
X-Received: by 2002:adf:e68a:: with SMTP id r10mr5092633wrm.384.1591813978084;
 Wed, 10 Jun 2020 11:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr>
In-Reply-To: <20200603153608.30056-1-alex@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 10 Jun 2020 11:32:47 -0700
Message-ID: <CAOnJCUJSKvLDsXC8+wyO1xsZDzLJmjY2kwMKhjz0t+uS8h0pDw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PUD/PGDIR entries for linear mapping
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 8:36 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This small patchset intends to use PUD/PGDIR entries for linear mapping
> in order to better utilize TLB.
>
> At the moment, only PMD entries can be used since on common platforms
> (qemu/unleashed), the kernel is loaded at DRAM + 2MB which dealigns virtual
> and physical addresses and then prevents the use of PUD/PGDIR entries.
> So the kernel must be able to get those 2MB for PAGE_OFFSET to map the
> beginning of the DRAM: this is achieved in patch 1.
>

I don't have in depth knowledge of how mm code works so this question
may be a completely
stupid one :). Just for my understanding,
As per my understanding, kernel will map those 2MB of memory but never use it.
How does the kernel ensure that it doesn't allocate any memory from those 2MB
memory if it is not marked as reserved?

> But furthermore, at the moment, the firmware (opensbi) explicitly asks the
> kernel not to map the region it occupies, which is on those common
> platforms at the very beginning of the DRAM and then it also dealigns
> virtual and physical addresses. I proposed a patch here:
>
> https://github.com/riscv/opensbi/pull/167
>
> that removes this 'constraint' but *not* all the time as it offers some
> kind of protection in case PMP is not available. So sometimes, we may
> have a part of the memory below the kernel that is removed creating a
> misalignment between virtual and physical addresses. So for performance
> reasons, we must at least make sure that PMD entries can be used: that
> is guaranteed by patch 1 too.
>
> Finally the second patch simply improves best_map_size so that whenever
> possible, PUD/PGDIR entries are used.
>
> Below is the kernel page table without this patch on a 6G platform:
>
> ---[ Linear mapping ]---
> 0xffffc00000000000-0xffffc00176e00000    0x0000000080200000 5998M PMD     D A . . . W R V
>
> And with this patchset + opensbi patch:
>
> ---[ Linear mapping ]---
> 0xffffc00000000000-0xffffc00140000000 0x0000000080000000         5G PUD     D A . . . W R V
> 0xffffc00140000000-0xffffc00177000000    0x00000001c0000000 880M PMD     D A . . . W R V
>
> Alexandre Ghiti (2):
>   riscv: Get memory below load_pa while ensuring linear mapping is PMD
>     aligned
>   riscv: Use PUD/PGDIR entries for linear mapping when possible
>
>  arch/riscv/include/asm/page.h |  8 ++++
>  arch/riscv/mm/init.c          | 69 +++++++++++++++++++++++++++++------
>  2 files changed, 65 insertions(+), 12 deletions(-)
>
> --
> 2.20.1
>
>


-- 
Regards,
Atish
