Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D3E20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587414478;
	bh=dyBm7I04/BcG1QP4G1MC3heldhpx4b6YSPyL7WyQfjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XtTdFnWUdJ7AVhicAeW1mnI8q37iNFq6CS6h58Tn1WpobwgVGTxbgCqTs/mbxHQr+
	 g6kbIlvGoicOu5a0Fr5G86i1L9TL2dr/DfulRYJQMUZ1lW/OJMIZP14bbN8zEZWOUn
	 aimfUgYei4ufikF9sXEAlUHx+o1rczCNnusXKQ6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgDTU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:27:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:27:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so11512689ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lXVFlCuhZRlNIKPWno7jyPJtjBUewfnSNmf8ZBkjkU=;
        b=cn88vqLJ3iqpfoPaMzWrtCIV4M8jcHhWWu71rGqbgTe5Q/UQn2kwB72nwO+wt0ZsxV
         Fe0cMAvboICZetRhUSad49xM+2KRg2LEkiMxaySpZdfmgaSTauF8lNCz7NT6nkAP+jvT
         GCDKi7YV6yK0o0sTidFCFjCHDaGmRz+vbXKJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lXVFlCuhZRlNIKPWno7jyPJtjBUewfnSNmf8ZBkjkU=;
        b=B1JUrmwJaZNgZm7hxzqRVlOGuNr5mDaSR7x0JS47twt0FtuMCnQyWN3Fmyxhgmls0L
         xbAsrqMjTgtwYYnAKTOGRe6YNTk8x/x/VCRVl4VC+UFiPEvvcDLnjUEGm+utPEpDykq9
         plz4m5xuj2aaeuEBRknHUFG0EpGIPtZgsKxqKeIMgxdLz/RDd95GGZoeNeDsNTHxMK4k
         eF47xQW4ltbXwZf5SfGwSC+C0d/ceID10lwEuxHwTU8+Ueqy1IPGawtQC+qRx2dC6VNp
         SVCv7Y55CaVp903UaHdbsMFuaYK+ZPPUQxNDAm/TjV8FvhdpXu7glU8wFD+hH5PMViEd
         /6+g==
X-Gm-Message-State: AGi0PuZBskYQIOThi6Bop1Y4pOvO84eJUgPQUS1omZ1uH7zjhLiQOCmY
        Uvoz3XwHvtglRjHJsWdjWH5HkH+5kaY=
X-Google-Smtp-Source: APiQypI1eBzbZHgMYGSKXRItjiBHH1WDoKfd8rSGYUx450dBurYhILTojmROYC6aDC50db3olpq5QQ==
X-Received: by 2002:a05:651c:449:: with SMTP id g9mr11514232ljg.278.1587414474248;
        Mon, 20 Apr 2020 13:27:54 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h21sm358838lfp.1.2020.04.20.13.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:27:53 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 198so9178946lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:27:52 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr11369327lfk.192.1587414472376;
 Mon, 20 Apr 2020 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com> <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 13:27:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
Message-ID: <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> I think they do. If the result of the wrong data has already
> been sent out the network before you process the signal, then you
> will need far smarter application software than has ever been written
> to hunt it down and stop the spread of the bogus result.

Bah. That's a completely red herring argument.

By "asynchronous" I don't mean "hours later".

Make it be "interrupts are enabled, before serializing instruction".

Yes, we want bounded error handling latency. But that doesn't mean "synchronous"

           Linus
