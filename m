Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6494DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63764205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589415104;
	bh=RUjSpMND5aMOfaKqLcHoLIHBP8YKcPlobA2rAbNdzyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tvGq3Wbos6dNSBsxRu2tXBI98CtZHtbfnYc3s7BgnPwdNkEw1i1CEEBBX2vSNGn7y
	 GYs6/Q+3TWNW9xICB2b+q5iGUD2+1iN+dz3+lKwg+BAd4Aq013e4UCnxRwiNCGHvK1
	 soVFm+64r3rFiVkV6/UnvgVm//Lv19TcbstWKiJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbgENALn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732871AbgENALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:11:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF44C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:11:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so1514991lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utoJ2tKHLEz+lZ3hja/CgFMrWscoXl/r2VYjQKIyAGQ=;
        b=dgAGAPUhoFn+CuYLX3qhe1jMrseuW5lWoLa9YJnJqxEirnWvTEs0V9fdT4wR2Pbuav
         ksHfg5B1xR6nbSC/FbwhfAwAEkiYvr/0yCXzPdNE2tC1kmuWjl2FDCJU8eshKLGL7qug
         7hQYoTeBsfOX8bFMOOk/iDCziz5PVRMkoOVPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utoJ2tKHLEz+lZ3hja/CgFMrWscoXl/r2VYjQKIyAGQ=;
        b=AAV9ggVAKw1FA/XEkEyU2Mb9Ofv3IhmNTa+eUhrKSl87qVBf5z0Q+2R6WuWBVkwyma
         EhQVwy2M0FQTiibUM4D5NNvdY8BWXOaE9qZlPA+v5rlSSgz8UINnvhOY55yE5bh1qjp4
         Ln5pmXWbqFvllSm+P+7L0yrniJRpU00IsIsA4PFX2wgb0bVAYYj2RFs/lQTIktaISqG/
         oJqX9HOTV8cUNAlCzN9hO9oaaU2FSxphI+utUsLsOMbLrB93EAF0hDocPF+/OTaUfI8K
         jgxL3vuvVnRan9lVsGssEM/BmoZGtyErakAnTqVz9PjjBt6k0eT8XvPLJupFHrkVMV7T
         tpzA==
X-Gm-Message-State: AOAM532aDqBpQJnZjHlWQbkOK17MseFMryavK/dbhj47qivyawQ2S2YG
        qq7MkM8COco0Xn081Vd0lRZSFoUCBaw=
X-Google-Smtp-Source: ABdhPJywFgccVYTcROgf5j0u5LqQd47crbBSwhw9QnDZNR9yJIHoZRjQvqNpjeW2eRi5xUNJjair4Q==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr879429ljm.165.1589415099959;
        Wed, 13 May 2020 17:11:39 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f2sm486498ljg.98.2020.05.13.17.11.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:11:38 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id f18so1495733lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:11:37 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr879037ljp.209.1589415097255;
 Wed, 13 May 2020 17:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
In-Reply-To: <20200513233616.GD6733@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 17:11:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
Message-ID: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:36 PM Borislav Petkov <bp@suse.de> wrote:
>
>
> Looking at them, they do have an mb() too so how about this then
> instead?
>
> #define prevent_tail_call_optimization()        mb()

Yeah, I think a full mb() is likely safe, because that's pretty much
always going to be a real instruction with real semantics, and no
amount of link-time optimizations can move it around a call
instruction.

I could imagine some completely UP in-order CPU that doesn't need to
serialize with anything at all, and even "mb()" might be empty.  I
think you can compile old ARM kernels for that. But realistically I
think we can ignore them at least for now - I'm not sure the link-time
optimization will even do things like that tailcall conversion, and
I'm not convinced that old pre-ARMv7 systems will be relevant by the
time (if) it ever does.

                   Linus
