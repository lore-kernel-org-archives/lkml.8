Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE147C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C59206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592595691;
	bh=gK72NF5MHXF5jO3xH9PohYMEcoHR6l8OPAq/Dgr9H/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ONXTUQDNKBCu8LLkCnZBG8NasqXMvmKnc5bcJmrZeiom+aZnpWZEIiKUB3HwTZfir
	 2ykPyTQVwIvkC16YAEghR6xbRvD9SGUmvcUrJkJ1vJ4bz1u7ztAt4IikI5yEWMLfPA
	 Dqi7XAyoUyc7WObwYvwDtjD/9Vusrpu/3qrCjHDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbgFSTla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbgFSTl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:41:29 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F95D21835
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595688;
        bh=gK72NF5MHXF5jO3xH9PohYMEcoHR6l8OPAq/Dgr9H/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KlKmUSPCB/t6LRW7dmplw7gciumA15UeCzGnmQcMRFbfwX2r8IaNyry2X+F/b0WrP
         IP5SL2P8cjOu24M+5JnXd2+ZNIVKDNmYnCwyIsJ5hiI1hZPOef31FTUAF1P1Dcc5fA
         tNw0UhwLpPfimJiW5IYaOSqMIbHe9T33KQIwwM18=
Received: by mail-wr1-f49.google.com with SMTP id l10so10785805wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:41:28 -0700 (PDT)
X-Gm-Message-State: AOAM531Qrd2zwlWMg+767G7mrmjub2Pz6NyKaxHoZOMwXvMm0Bw8Ixq1
        0ygPlrJ81IK7wJZCwR/GUV7DurqmXdVFLlOWKzU6Vg==
X-Google-Smtp-Source: ABdhPJzYHrqb944OB8ANUvzrpl8D9pgFo/WnVLpZaIxkI/UXGNTief8ct7ehCvrtOhrdSXCTzGxkEJoHcW00CEgP+C8=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr4694508wrw.18.1592595686545;
 Fri, 19 Jun 2020 12:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic> <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
 <20200619164056.GB2235992@kroah.com> <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com>
In-Reply-To: <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 12:41:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com>
Message-ID: <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 9:47 AM Richard Hughes <hughsient@gmail.com> wrote:
>
> On Fri, 19 Jun 2020 at 17:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > > Yes. I want to show the user *why* TME is not available.
> > So even if it is "available" that's fine, even if it is not being used?
>
> No, it's just one more thing we can check and report. For instance,
> "Full memory encryption: NO [firmware-disabled, unencrypted-swap, EFI
> memory map incomplete]

The list is bigger than this, and it will probably get even bigger in
the future.  For example, if the specific thing you care about is "is
my memory encrypted on the DIMM", choices include:

 - Yes, mostly, TME
 - Yes, mostly, SME
 - Yes, mostly, SEV (which comes in several variants)
 - Yes, because this is actually a Graphene SGX enclave or similar.
 - No, your memory controller can't do this.
 - No.  Although your memory controller can do this, it isn't right
now, because [reason].
 - (in the future, maybe) Partially, because *MK* TME is enabled and
encryption depends on the specific policy.
 - (in the future, maybe) No, but you think yes, because MKTME is
enabled and you used a fixed key that is stored somewhere.
 - (in the future, maybe) Maybe, because some memory is encrypted and
some isn't.

But if what you *actually* care about is whether someone who resets
the system and takes over gets to learn the contents of the DIMMs
(i.e. a "cold-boot attack"), then there are more answers:

 - Protected because of TXT: the memory controller will not allow
reads until the DIMMs are cleared.
 - Protected because of whatever AMD's equivalent is.
 - Protected to some extent because the installed firmware will wipe
memory on reset.

If you care about whether the contents of anonymous memory will be
encrypted at rest on swap, then you care about what the swap backing
store is *and* where the key came from.

If you care about whether and to what degree the contents of anonymous
memory are protected from a malicious hypervisor, the answer is
complicated.

I don't object in principle to Linux giving userspace more visibility
into what's going on, but I'm not convinced that adding a new
must-support-for-a-long-time interface that only solves 5% of your
problem is worth it.  Especially if, some day, the shiny new interface
says "TME is on", but this really means "MKTME is on and the
administrator configured it to only encrypt specific things for
performance reasons".
