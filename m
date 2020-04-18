Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A4C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFAA21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587238944;
	bh=zbHEw43Rv1SzsGijkjuXsW2hf1qnezDRghgS/RG4r9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PpDNSa5WG+hE0cjpmTcHEjxsL+Yt5SOS1zTKeAiGVPXAqyx+MZk7ilaxFlJuRcqBx
	 ju/A0yj5fVwMujqqBh/UhFG/qUxKGaAVn61/qmqalG8cKnn/lwVoRavmGALu/HsXlw
	 tJp+eacHr+SYx9FsnoXB2HPJ0T/HGqW91b9zPgP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgDRTmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727966AbgDRTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:42:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A239C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:42:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so4649542lff.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4rEAS/O53Re2CpfxSr2/Dv5edNKCIi/n2DeEZZR7KY=;
        b=Zqa5Mu9fEAhtFeza5prrV1yWpCwrYY/kIL7e1PzuB0VaPYchsmGNPq2A2yJx0KdktA
         yKw2D4sAGZ7F2FEHUIRbuZqtw/gJTtLzShlshLMHwsW0bSUtv5dD1XzzxNPOvxuoXbhB
         B55HwDWCbOhs5ZBK+tO/PcjS/+L1qRJJ57Rxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4rEAS/O53Re2CpfxSr2/Dv5edNKCIi/n2DeEZZR7KY=;
        b=DBc7ULNYBPoII7+CBpGA+CTKwHq9UbzoavzRoKkHfQg33sdrFsiHCCFgIa+/cYmM7/
         v6qJtz6MkOAfqJVMFxQvXrhZkiiZYcxaHw8WZOfvO7uSKlelVz7KLLA8leZbS9jGJiA+
         wkbUB1yDwKwM+Occ7mcmFl77JD034PB+7y2ahICyuHhc+TheiZmJxjO8T+sffk9d5osf
         aU5UMV0EicOVwis9wHM7hARe2O5Pu72KQNN4K/MZvcLTtV6yz+8i6d3C4xGnnzZIdbpY
         5J6LWepNr4oi4dECnP7BSsfmGQThyDzf5/+q7an7tI4z1xWsEJRNKcNcsO7xvnBugqQ9
         d+Eg==
X-Gm-Message-State: AGi0PuYnxvhyV18O+2VqPrtgadYKtORqnRR7XswW3qTdKmkR8vSZCUxe
        71KD05vQccCLAgq6VSVAYgqkyppQlYA=
X-Google-Smtp-Source: APiQypK/n4GPpqM+6R+IpV8BO5uCdXbVP43vTvhVEorBiJpLLkhwaRpUvkEmbXR8/gJALeE2LNmU0w==
X-Received: by 2002:a19:3848:: with SMTP id d8mr5565779lfj.44.1587238940026;
        Sat, 18 Apr 2020 12:42:20 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x21sm1601753ljm.74.2020.04.18.12.42.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 12:42:19 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so5666077ljd.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:42:18 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr5121816ljc.209.1587238938281;
 Sat, 18 Apr 2020 12:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <158654083112.1572482.8944305411228188871.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4gOVN5QVPWduJupVgzq8Sbc_-B0qdYYcw2OcFhk-y2zBw@mail.gmail.com>
In-Reply-To: <CAPcyv4gOVN5QVPWduJupVgzq8Sbc_-B0qdYYcw2OcFhk-y2zBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 12:42:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiV1Xk6ShTeafyius+76OvXN=rfSh_VAjk7ZXFvzuFU4Q@mail.gmail.com>
Message-ID: <CAHk-=wiV1Xk6ShTeafyius+76OvXN=rfSh_VAjk7ZXFvzuFU4Q@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> > @@ -106,12 +108,10 @@ static __always_inline __must_check unsigned long
> >  memcpy_mcsafe(void *dst, const void *src, size_t cnt)
> >  {
> >  #ifdef CONFIG_X86_MCE
> > -       if (static_branch_unlikely(&mcsafe_key))
> > -               return __memcpy_mcsafe(dst, src, cnt);
> > -       else
> > +       if (static_branch_unlikely(&mcsafe_slow_key))
> > +               return memcpy_mcsafe_slow(dst, src, cnt);
> >  #endif
> > -               memcpy(dst, src, cnt);
> > -       return 0;
> > +       return memcpy_mcsafe_fast(dst, src, cnt);
> >  }

It strikes me that I see no advantages to making this an inline function at all.

Even for the good case - where it turns into just a memcpy because MCE
is entirely disabled - it doesn't seem to matter.

The only case that really helps is when the memcpy can be turned into
a single access. Which - and I checked - does exist, with people doing

        r = memcpy_mcsafe(&sb_seq_count, &sb(wc)->seq_count, sizeof(uint64_t));

to read a single 64-bit field which looks aligned to me.

But that code is incredible garbage anyway, since even on a broken
machine, there's no actual reason to use the slow variant for that
whole access that I can tell. The macs-safe copy routines do not do
anything worthwhile for a single access.

So my reaction remains that a lot of this is just completely wrong and
incredibly mis-designed.

Yes, the hardware was buggy garbage. But why should we make things
worse with making the software be incomprehensibly bad too?

              Linus
