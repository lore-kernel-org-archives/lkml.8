Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5009C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B3920723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjV8+Zvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgGFSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:14:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7EC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:14:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a6so16991374ilq.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UHICUm1ASAOU14aQtTlqoeqvqVo45hMYZnvaiF40E5Y=;
        b=CjV8+Zvl4pETFI7EuOND0luxa2djfvNOy8tGGK4EhkoGTpsjBJcR9nOgEluBPz0bM9
         uooQwvUahizMcjsxKIOeydfm2fHsk0um137nCtHiu+uzGgcS3wRevl/uJ1/ahPT8dwAa
         AscWbdXmnQZ49dWOpaczWaJaQxs4kJUbUbl7qBpnc8fn0TgjAuEweauQMlelIH7uIy1R
         utB8iXV6jIycJB0yk14F5DFtaE/CIK0lFtdxNUD/hQtZf/7dg4bSQ2mV1PkSEqpMdJJo
         yJFD8SqamXEvcJpxg18IhJJ9eZj77R+nO1GxqHj7mID8JRuoVy3Zvm/p+u4l/Oy5nTk4
         9Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UHICUm1ASAOU14aQtTlqoeqvqVo45hMYZnvaiF40E5Y=;
        b=hyg12MZIUVxMjMPvYWAvaApwmVEgJYDvNRRfgxHLced66/T4JXjoXIeNzA0LOEMJoo
         /JXju07OYtaM6BqSJ6+NFKD2dQsMJOU7+UcAM+KL+2Du2mHDC286bR0jEtApPfQsq6WD
         GE/ZC3NHAFEM2aR4Zi7Zb27xKTYQTgiM9aoT+wFfeBkZm+kSkfrRBGJxqeInyAcO2NEl
         Za2pU7rCdoNmOeVW6I1BA0UIQCQHDnzcApRlZJIXqllqEblfhN6QLSVRwMmOxIVUHQEf
         3oZNjjKYp7dqo+maAwS/9Efu+cwv6Vc7/80MP8xMO/OenEDuN8N/QXs8szw6VP8+hI24
         CAzA==
X-Gm-Message-State: AOAM531eAn0HBar3MunD6W3eqjMNXW2QMoG2HvNS+NA8sytqa7Vi/aqC
        ep0n4FuWOC1VvNylB8Q0PZAIwssvc9F8FH1Urts=
X-Google-Smtp-Source: ABdhPJxcB7vidTBBGzLtWdiIB4C23C/5CtuZhMhvw+iXD2/Ibm6NZ7Dya9EPsou0hM51oBxNBeiVIVodmNN3xX9pv4o=
X-Received: by 2002:a92:1589:: with SMTP id 9mr12930352ilv.212.1594059253025;
 Mon, 06 Jul 2020 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
 <20200706083900.GC4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200706083900.GC4800@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Jul 2020 20:14:01 +0200
Message-ID: <CA+icZUV1yB97zME5zFxD9w3-_55Ov8y=HtKk60+X0LsvtLMdow@mail.gmail.com>
Subject: Re: [Linux v5.8-rc4] objtool warnings with gcc-10
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 06, 2020 at 09:09:55AM +0200, Sedat Dilek wrote:
> > [ Please CC me I am not subscribed to this mailing-list ]
> >
> > Hi Josh and Peter,
> >
> > today I switched over from Linux v5.7.y to Linux v5.8-rc4 and built
> > the first time with GCC version 10 on Debian/testing AMD64.
> >
> > $ cat /proc/version
> > Linux version 5.8.0-rc4-1-amd64-gcc10 (sedat.dilek@gmail.com@iniza)
> > (gcc-10 (Debian 10.1.0-4) 10.1.0, GNU ld (GNU Binutils for Debian)
> > 2.34) #1~bullseye+dileks1 SMP 2020-07-06
> >
> > I see these objtool warnings (which are new to me):
> >
> > $ grep warning: build-log_5.8.0-rc4-1-amd64-gcc10.txt | sort
> > arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118: unreachable instruction
> > drivers/atm/horizon.o: warning: objtool: interrupt_handler()+0x19f: unreachable instruction
> > drivers/message/fusion/mptbase.o: warning: objtool: mpt_Soft_Hard_ResetHandler()+0x33a: unreachable instruction
> > drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool: ahd_intr.part.0()+0x10f: unreachable instruction
> > drivers/scsi/pcmcia/aha152x_core.o: warning: objtool: run()+0x4c0: unreachable instruction
> > fs/btrfs/backref.o: warning: objtool: btrfs_backref_finish_upper_links()+0x309: unreachable instruction
> > fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xc: unreachable instruction
> > fs/btrfs/relocation.o: warning: objtool: update_backref_cache.part.0()+0x1de: unreachable instruction
> > kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
> > net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction
>
> That's more CONFIG_LIVEPATCH=y wreckage I expect. The problem is that
> GCC -flive-patching= thing wreck the propagation of the noreturn.
>
> This really is a compiler issue and we've not managed a sensible
> work-around in objtool.

With llvm-toolchain-11 version
11.0.0-++20200701093119+ffee8040534-1~exp1 from Debian/experimental I
do not see these warnings.

This is due to "-flive-patching=inline-clone" is *NOT* used when
CONFIG_LIVEPATCH=y with clang-11.

- Sedat -
