Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA91C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2762067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="EuWScGRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA3Fr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:47:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38435 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3Fr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:47:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2477336wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ns94a++FWjOsbTeeCg/7iNufe7NhHhvLooLuqKzPs4M=;
        b=EuWScGRZC4xXOSG6AyJhlskw/EgG4iun905h0ly1MAINDqvsShPwXODms+Df8kf6Lp
         UZJeTtQ57vm9zWoROByeOMYkm0r9F7iXzGe9e3ySM6+F/n4PWOuZb6IPkIppC8BHdRR0
         hsLwZeXjnYlrNgGgxHo3aWmZnrfaGvcLBLT1RWtWcWT7VGyJ6rNqFp/+dscYOxKU5WhB
         Vxuf/ZeN6ph8K1RdDSZZDY2eNq7WKCRc6+7hOtHeHiFju6fZbnHS4/PAb8mF9GSlksZ8
         GiWHFbkKc9ZguREv42pKUQm2TpSVW0kEg2W/UFWS60ECnWCSKCbDZTdyeW1Xei6JlgkR
         wr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ns94a++FWjOsbTeeCg/7iNufe7NhHhvLooLuqKzPs4M=;
        b=EnhmzlgHv/BU/63HgzH14sHJdqnp7xP9z6CfcNEdHq+YB+c1yewxgJ0k0nhCUgbzFc
         K/1SX7pVIykA5MTKrebygBuI+1IgARMNpemi9IwGBWDQg5cB2W+sTPGQjj3OA9eCgdLu
         GOdJAjxYNUOvSk1s5r+N4zDXffDMtY1MI4bDE0t9URuUAKbi+tmBJWO64yMCsGXhCdmp
         WUb0I5YqWIn3gcxdFGTUilfCgYYOlCbEzqTnGrW+903NH4JklNogkb68fUMihuBZTgQ5
         CyeDFQmkGW6geUuYPVD7OCo5q2+NcBafxCEwFKUsARHXaCTDuLTLv1I07rByoOR07H+/
         fa/w==
X-Gm-Message-State: APjAAAXyRNKa1hGwdKN2rYSe+VaXYxK3bIySkM3Q7bX3v2MnHPAQ3JZd
        ek0ky7s75R6W0C6f6Bqv4fRtUA==
X-Google-Smtp-Source: APXvYqw7lvhNWu8D8/n/xfZTRAjkxdArUDaKd9rvy68whUjb+q4IWilWYdhKnUb6VFLncYPn8jttLg==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr3053936wrm.402.1580363242251;
        Wed, 29 Jan 2020 21:47:22 -0800 (PST)
Received: from centos.familie-tometzki.de (p5B3B1A03.dip0.t-ipconnect.de. [91.59.26.3])
        by smtp.gmail.com with ESMTPSA id h2sm6046638wrt.45.2020.01.29.21.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 21:47:21 -0800 (PST)
From:   Damian Tometzki <damian.tometzki@familie-tometzki.de>
X-Google-Original-From: Damian Tometzki <dti+kernel@familie-tometzki.de>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
Message-ID: <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
Date:   Thu, 30 Jan 2020 06:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200129183404.GB30979@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 29.01.20 um 19:34 schrieb Borislav Petkov:
> On Wed, Jan 29, 2020 at 09:40:58AM -0800, Linus Torvalds wrote:
>> On Wed, Jan 29, 2020 at 9:07 AM Luck, Tony <tony.luck@intel.com> wrote:
>>>
>>> This returns "3" ... not what we want. But swapping the ERMS/FSRM order
>>> gets the correct version.
>>
>> That actually makes sense, and is what I suspected (after I wrote the
>> patch) what would happen. It would just be good to have it explicitly
>> documented at the macro.
> 
> Like this?
> 
> ---
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 13adca37c99a..d94bad03bcb4 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -164,6 +164,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
>   	".popsection\n"
>   
> +/*
> + * The patching happens in the natural order of first newinstr1 and then
> + * newinstr2, iff the respective feature bits are set. See apply_alternatives()
> + * for details.
> + */
>   #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
>   	OLDINSTR_2(oldinstr, 1, 2)					\
>   	".pushsection .altinstructions,\"a\"\n"				\
> 
>> That would be bad indeed, but I don't think it should matter
>> particularly for this case - it would have been bad before too.
>>
>> I suspect there is some other issue going on, like the NOP padding
>> logic being confused.
> 
> Or the cmp $0x20 test missing in the default case, see below.
> 
>> In particular, look here, this is the alt_instruction entries:
>>
>>     altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
>>     altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
>>
>> where the arguments are "orig alt feature orig_len alt_len pad_len" in
>> that order.
>>
>> Notice how "pad_len" in both cases is the padding from the _original_
>> instruction (142b-141b).
> 
> <snip this which I'll take a look later so that we can sort out the
> issue at hand first>
> 
>> So I'm just hand-waving. Maybe there was some simpler explanation
>> (like me just picking the wrong instructions when I did the rough
>> conversion and simply breaking things with some stupid bug).
> 
> Looks like it. So I did this:
> 
> ---
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 7ff00ea64e4f..a670d01570df 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -39,23 +39,19 @@ SYM_FUNC_START(__memmove)
>   	cmp %rdi, %r8
>   	jg 2f
>   
> -	/* FSRM implies ERMS => no length checks, do the copy directly */
> -.Lmemmove_begin_forward:
> -	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> -	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
> -
>   	/*
> -	 * movsq instruction have many startup latency
> -	 * so we handle small size by general register.
> -	 */
> -	cmp  $680, %rdx
> -	jb	3f
> -	/*
> -	 * movsq instruction is only good for aligned case.
> +	 * Three rep-string alternatives:
> +	 *  - go to "movsq" for large regions where source and dest are
> +	 *    mutually aligned (same in low 8 bits). "label 4"
> +	 *  - plain rep-movsb for FSRM
> +	 *  - rep-movs for > 32 byte for ERMS.
>   	 */
> +.Lmemmove_begin_forward:
> +	ALTERNATIVE_2 \
> +		"cmp $0x20, %rdx; jb 1f; cmp $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
> +		"cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS, \
> +		"movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM
>   
> -	cmpb %dil, %sil
> -	je 4f
>   3:
>   	sub $0x20, %rdx
>   	/*
> 
> ---
> 
> Notice how the *first* option of the alternative, which is the default
> one, has that gotten that additional "cmp $0x20, %rdx; jb 1f" test which
> sends us down to the less than 32 bytes copy length.
> 
> Your original version didn't have it and here's what I saw:
> 
> So I stopped the guest just before that code and the call trace looked
> like this:
> 
> #0  memmove () at arch/x86/lib/memmove_64.S:43
> #1  0xffffffff824448c2 in memblock_insert_region (type=0xffffffff824a8298 <memblock+56>, idx=<optimized out>, base=0,
>      size=4096, nid=2, flags=MEMBLOCK_NONE) at mm/memblock.c:553
> #2  0xffffffff824454f0 in memblock_add_range (type=0xffffffff824a8298 <memblock+56>, base=0, size=<optimized out>,
>      nid=73400320, flags=<optimized out>) at mm/memblock.c:641
> #3  0xffffffff82445627 in memblock_reserve (base=0, size=4096) at mm/memblock.c:830
> #4  0xffffffff823ff399 in setup_arch (cmdline_p=0xffffffff82003f28) at arch/x86/kernel/setup.c:798
> #5  0xffffffff823f9ae1 in start_kernel () at init/main.c:598
> #6  0xffffffff810000d4 in secondary_startup_64 () at arch/x86/kernel/head_64.S:242
> #7  0x0000000000000000 in ?? ()
> 
> and count in rdx was:
> 
> rdx            0x18     24
> 
> Without that "cmp $0x20" test above, we do the "cmp $680, %rdx; jb 3f;" test
> and we run into the following asm at label 3:
> 
> 3:
>          sub $0x20, %rdx
>          /*
>           * We gobble 32 bytes forward in each loop.
>           */
> 
> <--- right here %rdx is:
> 
> rdx            0xfffffffffffffff8       -8
> 
> and yeeehaaw, we're in the weeds and then end up triplefaulting at some
> unmapped source address in %rsi or so.
> 
> So now I'm going to play all three variants with pen and paper to make
> sure we're still sane.
> 
> Thx.
> 
Hello together,

in my qemu env the system isnt coming up. I tried both with and without 
the changes from Borislav.

Best regards
Damian


0.605193] ------------[ cut here ]------------
[    0.605933] General protection fault in user access. Non-canonical 
address?
[    0.605948] WARNING: CPU: 0 PID: 1 at arch/x86/mm/extable.c:77 
ex_handler_uaccess+0x48/0x50
[    0.606931] Modules linked in:
[    0.606931] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0 #15
[    0.606931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[    0.606931] RIP: 0010:ex_handler_uaccess+0x48/0x50
[    0.606931] Code: 83 c4 08 b8 01 00 00 00 5b c3 80 3d 78 75 50 01 00 
75 dc 48 c7 c7 00 ea 1e 82 48 89 34 24 c6 05 64 75 50 01 01 e8 9e fd 00 
00 <0f> 0b 48 8b 34 24 eb bd 80 3d 4f 75 50 01 00 55 48 89 fd 53 49
[    0.606931] RSP: 0000:ffffc900000dbc30 EFLAGS: 00010286
[    0.606931] RAX: 000000000000003f RBX: ffffffff82339d6c RCX: 
0000000000000000
[    0.606931] RDX: 0000000000000007 RSI: ffffffff8316dc5f RDI: 
ffffffff8316e05f
[    0.606931] RBP: 000000000000000d R08: ffffffff8316dc20 R09: 
0000000000029840
[    0.606931] R10: 000000010196fab4 R11: 0000000000000001 R12: 
0000000000000000
[    0.606931] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    0.606931] FS:  0000000000000000(0000) GS:ffff88800f800000(0000) 
knlGS:0000000000000000
[    0.606931] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.606931] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 
00000000000006f0
[    0.606931] Call Trace:
[    0.606931]  fixup_exception+0x3e/0x51
[    0.606931]  do_general_protection+0x9c/0x260
[    0.606931]  general_protection+0x28/0x30
[    0.606931] RIP: 0010:copy_user_generic_string+0x2c/0x40
[    0.606931] Code: 00 83 fa 08 72 27 89 f9 83 e1 07 74 15 83 e9 08 f7 
d9 29 ca 8a 06 88 07 48 ff c6 48 ff c7 ff c9 75 f2 89 d1 c1 e9 03 83 e2 
07 <f3> 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f 80 00 00 00 00 0f
[    0.606931] RSP: 0000:ffffc900000dbda0 EFLAGS: 00010246
[    0.606931] RAX: 0000000000000000 RBX: ffff88801e488000 RCX: 
0000000000000001
[    0.606931] RDX: 0000000000000000 RSI: 009896808086a201 RDI: 
ffffc900000dbdc0
[    0.606931] RBP: ffffffffffffffff R08: ffff88800f82d280 R09: 
0000000000000073
[    0.606931] R10: 0000000000000000 R11: ffffc900000dbd68 R12: 
0000000000000dc0
[    0.606931] R13: 00000000000000fe R14: ffffffff81252d01 R15: 
009896808086a201
[    0.606931]  ? __register_sysctl_table+0x361/0x500
[    0.606931]  __probe_kernel_read+0x2e/0x60
[    0.606931]  __kmalloc+0x10b/0x230
[    0.606931]  __register_sysctl_table+0x361/0x500
[    0.606931]  ? kmem_cache_alloc_trace+0xee/0x1e0
[    0.606931]  __register_sysctl_paths+0x186/0x1b0
[    0.606931]  ? iomap_init+0x1b/0x1b
[    0.606931]  ? do_early_param+0x89/0x89
[    0.606931]  dquot_init+0x23/0x117
[    0.606931]  ? iomap_init+0x1b/0x1b
[    0.606931]  do_one_initcall+0x31/0x1b0
[    0.606931]  ? do_early_param+0x89/0x89
[    0.606931]  ? do_early_param+0x89/0x89
[    0.606931]  kernel_init_freeable+0x15b/0x1b3
[    0.606931]  ? rest_init+0x9a/0x9a
[    0.606931]  kernel_init+0x5/0xf6
[    0.606931]  ret_from_fork+0x35/0x40
[    0.606931] ---[ end trace 8ee2a58282a5eb54 ]---
[    0.650539] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
