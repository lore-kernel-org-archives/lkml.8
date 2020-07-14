Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A5C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E4222A84
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqYEE3IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgGNSnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:43:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:43:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so7981425pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PSoCqSYVR+5FyIES+wNpKGXpQ6OMW93exMYtdsHXH4k=;
        b=VqYEE3IP8swNW+rXe3FApsMadhgHxhZy8ibBebKms2S7nKFFyNPBLEd6Rrue/Wv99e
         flXsbemj7CpKBYHX3MxvA67IKPUmppbSNT+gPgkFpNZ5qC3dQea/PXmw9FmNT3rqFJW6
         XidYvF/4kac1AeKE3xioGoL/1BwhhlJ+LcO0mpipTiSF5mDHNeGJDQNzmXGtTHlycY5I
         VbdMC9iNffDuRpABymuWbSjOGnv4B25/4AjOiBJ55fSam9EjCRStVnuI8UoJwY05u4UW
         ga3dV4mwHIGEglqHHwHXw80x4tF1T7GujKOADhgbtQYQItc+O+jB67qY4X8KCAxNW+r+
         8IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PSoCqSYVR+5FyIES+wNpKGXpQ6OMW93exMYtdsHXH4k=;
        b=GNJRxOwVOoCoJbSD5RfnzaAhlIPQgIX73OVh0zMz0hzHHyXUAZFXOJUGf8sVkEQ1/u
         0pPHSfnAPPpg3eA9BAZq9wFShxsmdyJLevFmog7jtB7pb8HLsJw1TRJ6bTzfDyPYwYjC
         lDPGjFdNIeTAucwbiLloBeHkShW7wgGC6OoHJHDj86hkF0cfjWgm4gF58sAXL9JDM/3+
         bsglUC9ObWT5rfS0n2+1PwX5AfTWbpxy8V0Q5+2PaDFI8BepylxEeWkpl97fO3mmsubM
         LRbdp37yAomvSLXCWjMky/VKuSAwIcKDd5zTO3kGxl77MPejUtSWVW06AyQag+4+vds1
         asqw==
X-Gm-Message-State: AOAM531+0PNSciahjaWWzcUBwxxBhaNLFcOZM35x8r7H9dVeyqYiUftX
        69DzLS6O9/6Jq1DgKZYe9fyZWA==
X-Google-Smtp-Source: ABdhPJwxHr5He73PpmJ7dhNXk0QtMbRcg41+cb1Z/AGCqiehbQOnK2uT3gPUge2Z3NVy2oAzpA9FOw==
X-Received: by 2002:a62:192:: with SMTP id 140mr5226967pfb.53.1594752195348;
        Tue, 14 Jul 2020 11:43:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d4sm17285706pgf.9.2020.07.14.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:43:14 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:43:14 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Jul 2020 11:43:12 PDT (-0700)
Subject:     Re: [PATCH V1 0/5] riscv: Add k/uprobe supported
In-Reply-To: <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
CC:     penberg@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, Bjorn Topel <bjorn.topel@gmail.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-3921ee3a-6033-4f1c-9c93-ecdb5751b3b1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jul 2020 07:55:28 PDT (-0700), guoren@kernel.org wrote:
> Hi Pekka,
>
> On Sat, Jul 4, 2020 at 2:40 PM Pekka Enberg <penberg@gmail.com> wrote:
>>
>> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
>> > The patchset includes kprobe/uprobe support and some related fixups.
>>
>> Nice!
>>
>> On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
>> > There is no single step exception in riscv ISA, so utilize ebreak to
>> > simulate. Some pc related instructions couldn't be executed out of line
>> > and some system/fence instructions couldn't be a trace site at all.
>> > So we give out a reject list and simulate list in decode-insn.c.
>>
>> Can you elaborate on what you mean by this? Why would you need a
>> single-step facility for kprobes? Is it for executing the instruction
>> that was replaced with a probe breakpoint?
>
> It's the single-step exception, not single-step facility!
>
> Other arches use hardware single-step exception for k/uprobe,  eg:
>  - powerpc: regs->msr |= MSR_SINGLESTEP
>  - arm/arm64: PSTATE.D for enabling software step exceptions
>  - s390: Set PER control regs, turns on single step for the given address
>  - x86: regs->flags |= X86_EFLAGS_TF
>  - csky: of course use hw single step :)
>
> Yes, All the above arches use a hardware single-step exception
> mechanism to execute the instruction that was replaced with a probe
> breakpoint.

I guess we could handle fences by just IPIing over there and executing the
fence?  Probably not worth the effort, though, as if you have an issue that's
showing up close enough to a fence that you can't just probe somewhere nearby
then you're probably going to disrupt things too much to learn anything.  I'd
assume that AMOs are also too much of a headache to emulate, as moving them to
a different hart would allow for different orderings that may break things.

I suppose the tricker issue is that inserting a probe in the middle of a LR/SC
sequence will result in a loss of forward progress (or maybe even incorrect
behavior, if you mess up a pairing), as there are fairly heavyweight
restrictions on what you're allowed to do inside there.  I don't see any
mechanism for handling this, maybe we need to build up tables of restricted
regions?  All the LR/SC sequences should be hidden behind macros already, so it
shouldn't be that hard to figure it out.

I only gave the code a quick look, but I don't see any references to LR/SC or
AMO so if you are handling these I guess we at least need a comment :)

>
>>
>> Also, the "Debug Specification" [1] specifies a single-step facility
>> for RISC-V -- why is that not useful for implementing kprobes?
>>
>> 1. https://riscv.org/specifications/debug-specification/
> We need single-step exception not single-step by jtag, so above spec
> is not related to the patchset.
>
> See riscv-Privileged spec:
>
> Interrupt Exception Code-Description
> 1 0 Reserved
> 1 1 Supervisor software interrupt
> 1 2–4 Reserved
> 1 5 Supervisor timer interrupt
> 1 6–8 Reserved
> 1 9 Supervisor external interrupt
> 1 10–15 Reserved
> 1 ≥16 Available for platform use
> 0 0 Instruction address misaligned
> 0 1 Instruction access fault
> 0 2 Illegal instruction
> 0 3 Breakpoint
> 0 4 Load address misaligned
> 0 5 Load access fault
> 0 6 Store/AMO address misaligned
> 0 7 Store/AMO access fault
> 0 8 Environment call from U-mode
> 0 9 Environment call from S-mode
> 0 10–11 Reserved
> 0 12 Instruction page fault
> 0 13 Load page fault
> 0 14 Reserved
> 0 15 Store/AMO page fault
> 0 16–23 Reserved
> 0 24–31 Available for custom use
> 0 32–47 Reserved
> 0 48–63 Available for custom use
> 0 ≥64 Reserved
>
> No single step!
>
> So I insert a "ebreak" instruction behind the target single-step
> instruction to simulate the same mechanism.

Single step is part of the debug spec.  That mostly discusses JTAG debugging,
but there's also some stuff in there related to in-band debugging (at least
watch points and single step, though there may be more).  IIRC you get a
breakpoint exception and then chase around some CSRs to differentiate between
the various reasons, but it's been a while since I've looked at this stuff.

It's all kind of irrelevant, though, as there's no way to get at all this stuff
from supervisor mode.  I don't see any reason we couldn't put together an SBI
extension to access this stuff, but I also don't know anyone who's looked into
doing so.  There are some complexities involved because this state is all
shared between machine mode and debug mode that we'd need to deal with, but I
think we could put something together -- at least for single step those are
fairly straight-forward issues to handle.

> -- 
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
