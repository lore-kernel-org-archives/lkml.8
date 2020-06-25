Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68211C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5720709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="L859KQKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407300AbgFYVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406260AbgFYVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:40:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:40:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so6912914wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ+Pk/YGo7vT5UD1x1N/jzBmkMBTGO2Pa6LVhFRJyFw=;
        b=L859KQKy8laWnQsH+a6oq9uf01IlkpVCnVGi6rtBf1Zs885cPlBY97FVfLcHe1fP0K
         69wPXtM36CpX9vKUbxSRRoioox22rD8Etg7RaXEQHngpdZYoX7RdUf/6shdsvsZkELLT
         jZj8FsrPCunm59/gM5y5dPLuWHljHSo5BVXMyriG8s1uHCai8Qw2pUp8UTtvj3R+4AyR
         A5piS2E+xN6dW6k1nbjKyPfS+JsIvjgn/t9eRtUtzYhylViFFZ1kv9/VhHdbwo6FXAcA
         MlIwik49dHYlFnAdo5eyQWZ/50Tq8t6acMw2hnDpPi+ELz9hrRVxB1F59e6ICZWS0GR9
         6pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ+Pk/YGo7vT5UD1x1N/jzBmkMBTGO2Pa6LVhFRJyFw=;
        b=P4w3lY8hoZ4W4+MIaGNsSf/K9H3vXasDnVYyVDGdA/6+nJAN3iMng8IC7u/6zlhpE5
         mB8ORPG4MbS9xvff5x9YQ9DYGdJC2YK/032UOfJuZN46AgaZ2QC7DFi/LjrWebYvtHS0
         66dnyoq9BVgJYlUVE+rudvTPdM9dyjtf0PLF9JNLI60NlsJI0XP8CrIDuq7AfZi0lsE+
         mCyet13kZohsP3kXMKfn9Xto2c8GzD8lqnbFhp5p8sWnEqF3Nwf8vSW+5J9GBdcViOtN
         uDGL24u/G3aTqmJsIIlaML8b7HJzXCBxON4sTL9rQUi1leZ9abNV8/PTKV3iaLzs3UYw
         naUg==
X-Gm-Message-State: AOAM5333zvTFv39L1JTNSXqjV4TGaSqCNNC9gq8KM+LCFUqsybp6gQsG
        0Rl8YjOkwiN7TxoGqBqTzv9ck9EUITvZnXPR/6451A==
X-Google-Smtp-Source: ABdhPJw5wFghjwcJHH/Vl3khsl/Blx/J1JNPX+KSPBuEhp/1yTGT5oNwfMlrXqJECitwtlgVBTGSW6tmEG2fsepa0wc=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr68482wmk.138.1593121203747;
 Thu, 25 Jun 2020 14:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
 <20200625211453.GS20319@zn.tnic> <CAFmMkTGy5vOiPUpWw6HfQv-JM90JqLBcsKwMpbWdsjaLBw730Q@mail.gmail.com>
 <20200625212736.GT20319@zn.tnic> <5b1699b5-6766-b5c8-fe1f-faf5a9b7c97e@intel.com>
In-Reply-To: <5b1699b5-6766-b5c8-fe1f-faf5a9b7c97e@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 25 Jun 2020 14:39:52 -0700
Message-ID: <CALCETrWLqdmFpGn8r7phKnZOondNRLhKHfe0bmEO=uX1S+xVcQ@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace (patch v2)
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 2:38 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/25/20 2:27 PM, Borislav Petkov wrote:
> > On Thu, Jun 25, 2020 at 06:16:12PM -0300, Daniel Gutson wrote:
> >> What didn't become clear from the thread last time is the direction to
> >> proceed. Concrete suggestion?
> > Here are two:
> >
> > https://lkml.kernel.org/r/20200619161752.GG32683@zn.tnic
> > https://lkml.kernel.org/r/20200619161026.GF32683@zn.tnic
> >
> > but before that happens, I'd like to hear Dave confirm that when we
> > expose all that information to userspace, it will actually be true and
> > show the necessary bits which *actually* tell you that encryption is
> > enabled.
> >
> > If you're still unclear, go over the thread again pls.
>
> It boils down to this: we shouldn't expose low-level, vendor-specific
> implementation details if we can avoid it.  Let's expose something that
> app can actually use.
>
> Something that will work for all of the TME, MKTME and SEV platforms
> that I know of and continue to work for a while would be to have a
> per-numa-node (/sys/devices/system/node[X]/file) that says: "user data
> on this node is protected by memory encryption".
>
> SEV guests would always have a 1 in all nodes.
>
> TME systems with no platform screwiness like PMEM would always have a 1.
>
> Old systems would have a 0 in there.
>
> TME systems which also have PMEM-only nodes would set 0 in PMEM nodes
> and 1 on DRAM nodes.
>
> Systems with screwy EFI_MEMORY_CPU_CRYPTO mixing within NUMA nodes would
> turn it off for the screwy nodes.
>
> Is that concrete enough?

What about MKTME platforms that (using hypothetical future kernel
support) have encryption enabled for a node but have disabled it for
specific pages using madvise()?  Or that have any other nontrivial
policy like that?
