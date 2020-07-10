Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E783C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2E32073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594342426;
	bh=reFQJi1XKgmgNcqGOKHw+14/THKDf3slVwdFWIaTLWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v9J1+s0YopSPCi94M4gtPRQvsHfPIMmrPVQKrA4RX/v1Mtrf3M7gH3raYkcLLV7pC
	 VxpEPAKU+vkb5HFq6DGVIFbduD783TGdEeHpF/qKgfH0XbpN6gY7tTd6BRfjT1rZtb
	 K89pYSMfLO0GyflOyEFPQTJZX2HgElMR4ShFpo08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGJAxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgGJAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:53:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 17:53:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k17so2235731lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFh3SaPo/ZFXaZidxF67lCWnAMjqlEvCBJ64cvHaUrY=;
        b=NT4TzoavA8XuxEdHVVxEKPvDs3nmncFob4PBzrwmPVHTSJRRctMxc6oSaNN7BF0xsT
         i/UGzXG4LWriSd9Bu28syC4R7ie6so4SQ4Epa01FDTqcTOmm7z2nDQQmUMSTl4oC8vCG
         Khzd6HT2LkjjViT/d/cWTEiVFWO5HfzBpZ3aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFh3SaPo/ZFXaZidxF67lCWnAMjqlEvCBJ64cvHaUrY=;
        b=AUHRCgE5USthnPFfjJBW1alBlX3YinVjhD9UtZ5RgYOh0J+aKvSJ+63Yfk9NCw+DT5
         ltX5PuNVP7+G39Brmno1J3CUq6n/SBk5uhDPicJq06sleUybfHFSotgQD4j3tp1xRft+
         GZO+an4uPKPQs9GSLDgZSDy2GM2wXwAApVO0q4bXRPy/+QJ+phrEow2OnUi+lfL1FtrE
         8b8UbabQZGj/6J2EiJZd8KvBZkZqiAzGgEDJMS26jQ9F6/M4ZxE3myf20FtmJqTyt3IW
         +EnEze0ZwGjG/8MT3DKfngZYDR/BUBnsw7bUBYIbvdai5oMbhU8C0C3NSgutCflx+f7E
         g9Sw==
X-Gm-Message-State: AOAM532qSUfhElKkAuEw6gAgS7XkZVTIuZF838UAk7vOznCHl0MQFxbi
        b/Hp8/i4GBYMOKmDD8xP5njYS/1RqVg=
X-Google-Smtp-Source: ABdhPJwiQ76YuzgSdgr6zOpg8CKAukpZ8U4pVVCSzzPyXEQJDoe9gYTTPt3eB/swOKmB7OmCk0v9aw==
X-Received: by 2002:a19:4cd:: with SMTP id 196mr41570342lfe.136.1594342422129;
        Thu, 09 Jul 2020 17:53:42 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z84sm2160327lfa.54.2020.07.09.17.53.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 17:53:41 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id j11so4463673ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 17:53:41 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr37491111ljj.102.1594342420759;
 Thu, 09 Jul 2020 17:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200709221102.323356-1-cesarb@cesarb.eti.br>
In-Reply-To: <20200709221102.323356-1-cesarb@cesarb.eti.br>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 17:53:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
Message-ID: <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
Subject: Re: [PATCH] Restore gcc check in mips asm/unroll.h
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 3:11 PM Cesar Eduardo Barros
<cesarb@cesarb.eti.br> wrote:
>
> While raising the gcc version requirement to 4.9, the compile-time check
> in the unroll macro was accidentally changed from being used on gcc and
> clang to being used on clang only.
>
> Restore the gcc check, changing it from "gcc >= 4.7" to "all gcc".

This is clearly a thinko on my side: the old

    CONFIG_GCC_VERSION >= 40700

became pointless, so I removed, it, but it was mixed with an "||" so
we actually wanted to make it unconditional on gcc, and instead now it
checks for CLANG version even when it shouldn't.

My bad, and your patch is obviously correct.

At the same time, I do wonder if  we could just remove the check for
CLANG_VERSION >= 80000 too, and just remove all the compiler check
hackery entirely?

Older versions of clang weren't very good at compiling the Linux
kernel in the first place. Do people actually use old clang versions?
That sounds like a really bad idea.

People who used to build the kernel with clang tended to actually get
their clang version from the clang git sources afaik (I still do, but
that's because I test experimental new features that aren't released
yet), exactly because back in the bad old days there were so many
problems.

These days you can use release versions, but they'd presumably not be
older than clang-8.

Adding Nick - is it really reasonable to build any kernel with any
clang version before 8.0.0?

It turns out that the arm side also has a check for clang < 8 because
of -mcmodel=tiny, so raising the minimum required clang version to
that would solve that issue too.

Right now we don't mention minimum clang/llvm versions in our docs at
all, because we only mention gcc. Mayeb this would be good to clarify.

               Linus
