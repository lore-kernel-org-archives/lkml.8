Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85294C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E812465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTxNEenG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBSSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:53:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSSxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:53:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so1770010wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHetkJh3JFpiVt0PkP/E1Oke7WhO+z+xsxym+bAfrek=;
        b=lTxNEenGz1OUGedaxamjo330XgTZtq3/ugQcBWOKCaUSz8PUvSXavKhSekJMET26ui
         /pQjA3j5JEX66oBotNXPyC+N8spqlGrmwmrCOmihv0nD6Vo3GZcV9JpG3/290IF6/EQW
         kAPbe8pphk4lsCBefFCF/+8wV89zh8dDbslWce+yCiTzlaHoN4Ibivtw+jEqUproqPWs
         5HZtkR6h9c8SSG8O4ypxLuRb84XtGW1hFzfy76B29tV6Hyk8X+bSpNlGGKeN2SnZMfnO
         bV0BLpD4/OP//J2c1xKQmybGwv9a49locydNHmlXpNTyUqQYTZdAzS7gknZoDdeIPWqU
         cQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHetkJh3JFpiVt0PkP/E1Oke7WhO+z+xsxym+bAfrek=;
        b=ZvyIPGfzSMzv3X0OGFOO92pWs4IikNWtGcTcDbEO85SjMejlgSel4LrxTBL90IGTlf
         O4p3iSJl84ONqW6vVUFNIurleDCyRuT2ZkQ80Xvo+nUyXu8237pIjXc4RDEWatLqVOH7
         yYELhB/6a1wRQEhk8Be+JmZhlupRz8B9qzqyi4fQpJCqC4p99gRtSSTU1VUy5YVmHrfP
         nOP7DcSwOCH1+8+mRhF6O+GUDsC16MLkKtV8CNXRkKW+IsYopQr/u3kS5eOo58lLD3DB
         W17um1OQcJ17nC/Wf+mD3L4jjoSwTcw28jR12E6G/8SwUSi41IwazfByLv046NB03mU9
         XqCg==
X-Gm-Message-State: APjAAAXN5NCyoXUOhGuWyI1OO1Vjxo4mU6ksHWb4Dv5yP1CgbIk3lhOB
        kcn9EwuaHY6NjLXI/VlqSnzPiB29YBscULZP2nYAJg==
X-Google-Smtp-Source: APXvYqxSEzUSXoHrR9umdCftiz8DlqN9C2r2gE3HRSV535aAzXzWAdF7gGIVmVaaH9yHxTRzIQlAyMKjrbP/ABWFdA0=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr37778174wrr.208.1582138417419;
 Wed, 19 Feb 2020 10:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com> <0386ecad-f3d6-f1dc-90da-7f05b2793839@arm.com>
In-Reply-To: <0386ecad-f3d6-f1dc-90da-7f05b2793839@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Feb 2020 19:53:26 +0100
Message-ID: <CAKv+Gu8gHcYW_5G5pfS=yVA7J5JPq0tWqYRcVBAxS0ZYjw9jPw@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] add support for Clang's Shadow Call Stack
To:     James Morse <james.morse@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 19:38, James Morse <james.morse@arm.com> wrote:
>
> Hi Sami,
>
> (CC: +Marc)
>
> On 19/02/2020 00:08, Sami Tolvanen wrote:
> > This patch series adds support for Clang's Shadow Call Stack
> > (SCS) mitigation, which uses a separately allocated shadow stack
> > to protect against return address overwrites.
>
> I took this for a spin on some real hardware. cpu-idle, kexec hibernate etc all work
> great... but starting a KVM guest causes the CPU to get stuck in EL2.
>
> With CONFIG_SHADOW_CALL_STACK disabled, this doesn't happen ... so its something about the
> feature being enabled.
>
>
> I'm using clang-9 from debian bullseye/sid. (I tried to build tip of tree ... that doesn't
> go so well on arm64)
>
> KVM takes an instruction abort from EL2 to EL2, because some of the code it runs is not
> mapped at EL2:
>
> | ffffa00011588308 <__kvm_tlb_flush_local_vmid>:
> | ffffa00011588308:       d10103ff        sub     sp, sp, #0x40
> | ffffa0001158830c:       f90013f3        str     x19, [sp, #32]
> | ffffa00011588310:       a9037bfd        stp     x29, x30, [sp, #48]
> | ffffa00011588314:       9100c3fd        add     x29, sp, #0x30
> | ffffa00011588318:       97ae18bf        bl      ffffa0001010e614 <__kern_hyp_va>
>
> INSTRUCTION ABORT!
>
> | ffffa0001158831c:       f9400000        ldr     x0, [x0]
> | ffffa00011588320:       97ae18bd        bl      ffffa0001010e614 <__kern_hyp_va>
> | ffffa00011588324:       aa0003f3        mov     x19, x0
> | ffffa00011588328:       97ae18c1        bl      ffffa0001010e62c <has_vhe>
>
>
> __kern_hyp_va() is static-inline which is patched wherever it appears at boot with the EL2
> ASLR values, it converts a kernel linear-map address to its EL2 KVM alias:
>
> | ffffa0001010dc5c <__kern_hyp_va>:
> | ffffa0001010dc5c:       92400000        and     x0, x0, #0x1
> | ffffa0001010dc60:       93c00400        ror     x0, x0, #1
> | ffffa0001010dc64:       91000000        add     x0, x0, #0x0
> | ffffa0001010dc68:       91400000        add     x0, x0, #0x0, lsl #12
> | ffffa0001010dc6c:       93c0fc00        ror     x0, x0, #63
> | ffffa0001010dc70:       d65f03c0        ret
>
>
> The problem here is where __kern_hyp_va() is. Its outside the __hyp_text section:
> | morse@eglon:~/kernel/linux-pigs$ nm -s vmlinux | grep hyp_text
> | ffffa0001158b800 T __hyp_text_end
> | ffffa000115838a0 T __hyp_text_start
>
>
> If I disable CONFIG_SHADOW_CALL_STACK in Kconfig, I get:
> | ffffa00011527fe0 <__kvm_tlb_flush_local_vmid>:
> | ffffa00011527fe0:       d100c3ff        sub     sp, sp, #0x30
> | ffffa00011527fe4:       a9027bfd        stp     x29, x30, [sp, #32]
> | ffffa00011527fe8:       910083fd        add     x29, sp, #0x20
> | ffffa00011527fec:       92400000        and     x0, x0, #0x1
> | ffffa00011527ff0:       93c00400        ror     x0, x0, #1
> | ffffa00011527ff4:       91000000        add     x0, x0, #0x0
> | ffffa00011527ff8:       91400000        add     x0, x0, #0x0, lsl #12
> | ffffa00011527ffc:       93c0fc00        ror     x0, x0, #63
> | ffffa00011528000:       f9400000        ldr     x0, [x0]
> | ffffa00011528004:       910023e1        add     x1, sp, #0x8
> | ffffa00011528008:       92400000        and     x0, x0, #0x1
> | ffffa0001152800c:       93c00400        ror     x0, x0, #1
> | ffffa00011528010:       91000000        add     x0, x0, #0x0
> | ffffa00011528014:       91400000        add     x0, x0, #0x0, lsl #12
> | ffffa00011528018:       93c0fc00        ror     x0, x0, #63
> | ffffa0001152801c:       97ffff78        bl      ffffa00011527dfc <__tlb_switch_>
> | ffffa00011528020:       d508871f        tlbi    vmalle1
> | ffffa00011528024:       d503201f        nop
>
>
> This looks like reserving x18 is causing Clang to not-inline the __kern_hyp_va() calls,
> losing the vitally important section information. (I can see why the compiler thinks this
> is fair)
>
> Is this a known, er, thing, with clang-9?
>
> From eyeballing the disassembly __always_inline on __kern_hyp_va() is enough of a hint to
> stop this, ... with this configuration of clang-9. But KVM still doesn't work, so it isn't
> the only inlining decision KVM relies on that is changed by SCS.
>
> I suspect repainting all KVM's 'inline' with __always_inline will fix it. (yuck!) I'll try
> tomorrow.
>

If we are relying on the inlining for correctness, these should have
been __always_inline to begin with, and yuckness aside, I don't think
there's anything wrong with that.


> I don't think keeping the compiler-flags as they are today for KVM is the right thing to
> do, it could lead to x18 getting corrupted with the shared vhe/non-vhe code. Splitting
> that code up would lead to duplication.
>
> (hopefully objtool will be able to catch these at build time)
>

I don't see why we should selectively en/disable the reservation of
x18 (as I argued in the context of the EFI libstub patch as well).
Just reserving it everywhere shouldn't hurt performance, and removes
the need to prove that we reserved it in all the right places.
