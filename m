Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819FC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587416214;
	bh=KCYA5zqgMzJkd7n2MPXzIyvvaZIa/qObgQPo4z0EmKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=djnFx+1m5cP3wvNgrM7j/8GXNwFm99pxruOceWqKOfKbQ2/Wd5fIss62MD+mEWhPf
	 9sb2Q1g2fjVIkiefEwIw1Cdx3lp3cz3I2akjtpN2zXI3m1frpgdypO3GpnwEauW+Fs
	 YXAtKgK70K8jZJDVDKUiQlkrvuNuTgwBonK4+D/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgDTU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgDTU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:56:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:56:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 131so9204296lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YMKp9wPvX7FbDR3+6WEIzSglLbYUecdGkyUsv5KulQ=;
        b=FcXT9x/jUah+X0xgwFiqlUqBQvX1G3RiMhY/gwPoHmmY/XQlinet+aCVntYoTSXix0
         nYnC67xrDgLTWaT5S4DrH+GUnhJL1ZtDCuTvhpZ7ZxXg/ozncV3EsUCU+SCShBpzLktB
         /uVd+li/PDjb4APhJ2J6DiaYwIXndtCUke1hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YMKp9wPvX7FbDR3+6WEIzSglLbYUecdGkyUsv5KulQ=;
        b=KkdVF9jv8sozE2+zcuVJNpEM4FoHjuwiwr9YRTtRqPkb3PNmhk6IBmkj5IBOVgSNOp
         JLKLigZB9wmlfZ/ZF9cD8U+nzn9HG1rzFm4B8aq3onthhu4vVbkKXXGiWKfYnRKgTWLl
         zZXr9Rz6aYUZdM9HxdlFFTVVqEdli4l9YvNMtelEozrXVt4KsqEGrMHcDuXvHiNYwDiF
         CdvEtNOC6F1kvD/rWWLbP9fpgfHRqjIH5PyevAx+aKI3lkWg9MedoQ/Czf4OXaG0149n
         bwCidxAF56ln696uQkjDYKQsnylrC+ofvD4/8MHJbVBPUHBCb7ezWS11ZlgTHqDmQTbt
         Wa6w==
X-Gm-Message-State: AGi0PuYGF3Exy0pUjSFDKYGL56OvpOjod4alViLrO9owJeTs6N0uLWBq
        +0obMpp0Iqt1/8CCXnzoqPOUfR2M7rM=
X-Google-Smtp-Source: APiQypL/59+1EqH72UTLKWk/pLNkLOXnFRalXsovPzf+2BQu3FbwHeJEYWcFmHBLIE2iRMz26DC45Q==
X-Received: by 2002:ac2:4105:: with SMTP id b5mr11799155lfi.94.1587416210679;
        Mon, 20 Apr 2020 13:56:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d23sm406416ljg.90.2020.04.20.13.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:56:49 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l11so9265422lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:56:48 -0700 (PDT)
X-Received: by 2002:a19:946:: with SMTP id 67mr9797282lfj.142.1587416208523;
 Mon, 20 Apr 2020 13:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com> <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5FB1C0@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5FB1C0@ORSMSX115.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 13:56:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9Qk=b5h0y=s9vUoLxAD0Nz5BrsU7g0=-ZiUFO9q3EmQ@mail.gmail.com>
Message-ID: <CAHk-=wg9Qk=b5h0y=s9vUoLxAD0Nz5BrsU7g0=-ZiUFO9q3EmQ@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tsaur, Erwin" <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:45 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Another X86 vendor seems to be adding something like that. See MCOMMIT
> in https://www.amd.com/system/files/TechDocs/24594.pdf

That sounds potentially very expensive.

Particularly, as you say, something like the kernel (or
virtualization) may want to at least test for it cheaply on entry or
switch or whatever.

I do think you want the mcommit kind of thing for writing, but I think
the intel model of (no longer pcommit) using a writeback instruction
with a range, and then just sfence is better than a "commit
everything" thing.

But that's just for writing things, and that's fundamentally very
different from the read side errors.

So for the read-side you'd want some kind of "lfence and report"
instruction for the "did I see load errors". Very cheap like lfence,
so that there wouldn't really be a cost for the people if somebody
_really_ want to get notified immediately.

And again, it might just be part of any serializing instruction. I
don't care that much, although overloading "serializing instruction"
even more sounds like a bad idea.

               Linus
