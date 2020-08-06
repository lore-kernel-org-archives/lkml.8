Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1442177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596742967;
	bh=+KnJrFERQrp3dPKSUc1xIQnc5Saif+iDLZ4z9rYvTrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bE7BG3wcpd+5tK/kOH7qRiFZjD5E+QJgIcL7pcQa+iI9H2jyR72ZOvWmmjtqlFIqk
	 s48TUN2v8qHxhmHBnYmIZ3HIOhNRvGoDKLv1p75cl0rsI4Nnulo8fpeN0EQ0YKngLZ
	 pgv3CCxM4Q2smsZ7JHpAZWzW9RwmcLjJ9MQnJVp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHFTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:42:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F89C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:42:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so29596910ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wi2K2VmaVuEJKxsBXVACPYhOGfV5lKrS6VT4VRRVAIo=;
        b=exH7ebZZk4zntQVf6meSMlTasyfrVTkGylP6ZE4LetPGKZ30Ovl1QOrsJ4uecNkwtw
         Vcdhrjd1Qt6gKwzBhkRuC/t2IG9ggSueSH7AjIlXOh1neF32gp6DTZujMEIt/hyemf9Z
         vZnQgx3DKyBnRgFTNp3ZdzeNiTJFObhN22mlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wi2K2VmaVuEJKxsBXVACPYhOGfV5lKrS6VT4VRRVAIo=;
        b=FMNgJz6TZIEG+Av4/2ySrlk7H9VAVcK8tZzWE2VG9TwyOw4UAA42qifZBHe8VTGGjw
         5PWVVVDX8r6EGv/BlAfsKB2a5dB76zRPBlHCPrx0p+gx1mLRLQfUIbL+RXI9nGzbfRzE
         lxzyERjU91paEzMRxf7FvQU9JgLCj1z4UBWBEyvqDk0rPKtF/Ka1NbzkPe5sV+PK3i2n
         O2vUNaHL3PkE81Qe3PrLb+IsAnrdGdyPkf/t7doRfXOAMaaSbo0NsR2lznnl9l71NlgB
         nd3AdnNfeJYsgUoFwVMKBpSYZiCCvH1R90FAdImLF/9w3BGQp8sdaHYR5SaWOD6rJsqT
         PsPg==
X-Gm-Message-State: AOAM533rdKiZ7PXxoqwR08f9zRDuE73kHUctFksk8ACWn2C1OUyrZEFz
        lrIjlDurRmtkbUyd31xwq5DBe4mU3Sc=
X-Google-Smtp-Source: ABdhPJxVh33N+UUedqsQdcVTB47qn0UDzesAg3SFVyodzso9Xi24cdCr/E4fdfJv3d+AMkbbql1Wmg==
X-Received: by 2002:a2e:a49c:: with SMTP id h28mr4610233lji.234.1596742961626;
        Thu, 06 Aug 2020 12:42:41 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x4sm2820856ljd.34.2020.08.06.12.42.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:42:40 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i10so18348608ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:42:39 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr4003694ljk.421.1596742959144;
 Thu, 06 Aug 2020 12:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200803190354.GA1293087@gmail.com> <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com> <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com> <20200806192333.GB24304@suse.de>
In-Reply-To: <20200806192333.GB24304@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 12:42:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=win5DxMK-MH57NSrA+nVxF60MYR9RyArPX5NW_0yaBpoA@mail.gmail.com>
Message-ID: <CAHk-=win5DxMK-MH57NSrA+nVxF60MYR9RyArPX5NW_0yaBpoA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 12:23 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> Yes, that's the best for now. My gut feeling is that the fault Jason is
> seeing didn't happen on a vmalloc address, but I can't prove that yet.

No, it's definitely fairly high in the vmalloc space. Look at the
faulting address:

   BUG: unable to handle page fault for address: ffffe8ffffd00608

and the code sequence is this:

>   12: 48 8b 06              mov    (%rsi),%rax
>   15: 4c 8b 67 40          mov    0x40(%rdi),%r12
>   19: 49 89 c6              mov    %rax,%r14
>   1c: 45 30 f6              xor    %r14b,%r14b
>   1f: a8 04                test   $0x4,%al
>   21: b8 00 00 00 00        mov    $0x0,%eax
>   26: 4c 0f 44 f0          cmove  %rax,%r14

that admittedly odd sequence is get_work_pwq(work)

And then the faulting instruction is:

>   2a:* 49 8b 46 08          mov    0x8(%r14),%rax <-- trapping instruction

and this is the "->wq" dereference.

So it's the pwq->wq that traps, with 'pwq' being the trapping base
pointer, and clearly being in the vmalloc space.

I think pwq may a percpu allocation, so not _directly_ vmalloc().
Adding Tejun to the cc in case he can clarify ("No, silly Linus, it's
allocated here..").

                Linus
