Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90734C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233920732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFyxFMY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDJTYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:24:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44738 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:24:03 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so2745479iok.11;
        Fri, 10 Apr 2020 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66mZM4coy6pH0Dml/lq3A5SGkrPeNs0wnL4UCKRBw6c=;
        b=oFyxFMY97Cxldc7vH6/GOD4Mv/bwYVeU94o0STeh2ObQvgU695RNAHBg46ZjeX+L3L
         2tQh9DmUw3XRosLfm69mwsv5O41Km6wMmFL1/dK1KsVRdSpOFsJheytGnFAP/4wOmE8m
         +j3v3YUM6+6GG3miiqW4dhUVcSC0emIT5CVv1JNHOau5Jf0qrvLNkaVYmpBBFizDNmiU
         vG/uyEuX184qNWlsvDSUXeO0kaqtQ3Kcy8H0iN9BiPDbrhzx15IGkCT7uH0Jl5xboNAc
         RCB906alozIWT7sq7rM4z2bwjG77rJVtXDumBUid93yluUiw+54QXXv1GKAN1OkpQzPf
         t7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66mZM4coy6pH0Dml/lq3A5SGkrPeNs0wnL4UCKRBw6c=;
        b=SlmMiAMVp0bf+xBUT38IjejjjSuPMU/LE3/b259uoev7VVjYkt/Q5i8RbmpAjMFwjd
         AjWMwEvvgdbnxUZvsURrgQ16ZXw/S4RF+rs+qD38zS4uLAktGGaXMUCOyWQfZm7bg8Hv
         tt1xD4UtEjTaNH714lkw9zRHfSNTi1WULZU24M4/1RJQSwNrGaO+j3vWRd3B+Cl/QG2K
         Txdkurm1h627WNZty+OD4UxbBdW6PX+X526vXlRLdbELcXDYAsbmnruqCwK7CFo5F/lf
         O4SfSuxKxJlt/QbYsWzvUFJh+Ke/8hfnvBPyjXf2Bch5d4cg2tZZjX/hPJufbCpcqp1I
         obqg==
X-Gm-Message-State: AGi0PuavCCUMPDITFp078p/Acy5zQoC0mFiu1qUfqhTrKibIa2rKJ2Ba
        otT6i+bQOPMxjh3oWqv8iRLZAq8MPi6qkU4LLni+O2qmkFU=
X-Google-Smtp-Source: APiQypK4RQqhRXnfMD7s4373ZpJXXJD4nW2FVqAeJjm6uBEo09Cgcf71gJqYAPUh2BhE/8uDCHT5KEiAiZB9uBFO4sw=
X-Received: by 2002:a05:6602:1da:: with SMTP id w26mr5707882iot.191.1586546642978;
 Fri, 10 Apr 2020 12:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPpD+ExaeA6v+gSPPgtxcVzpKLWJNwGPPDKGFkPCv5kDg@mail.gmail.com>
 <1d02e4f3-8d83-4c55-bce2-f5aa4af2e363@linux.intel.com> <20200410142920.GA936997@rani.riverdale.lan>
In-Reply-To: <20200410142920.GA936997@rani.riverdale.lan>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 11 Apr 2020 00:23:52 +0500
Message-ID: <CABXGCsMA05e6491bQ2RdhFZAKeMkcxAUz4qL3026iApw8O06mQ@mail.gmail.com>
Subject: Re: [Bug report] Kernel 5.7 become unbootable
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Like Xu <like.xu@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-x86_64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 19:29, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Please try with the patches at
> https://lore.kernel.org/linux-efi/20200409130434.6736-1-ardb@kernel.org/
>
> In particular, patches 3 and 4. The first one is a fix for upstream
> commit 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")

Thanks, I can confirm that these patches solve the issue with unbootable kernel.
But, now after successful booting, I see another issue.
Kernel logs flooded with the error messages:
[   18.253336] BUG: sleeping function called from invalid context at
drivers/gpu/drm/drm_mm.c:371
[   18.253339] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
1723, name: gnome-shell
[   18.253340] INFO: lockdep is turned off.
[   18.253342] CPU: 23 PID: 1723 Comm: gnome-shell Tainted: G      D W
        5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
[   18.253343] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
[   18.253344] Call Trace:
[   18.253350]  dump_stack+0x8b/0xc8
[   18.253352]  ___might_sleep.cold+0xb6/0xc6
[   18.253362]  drm_mm_insert_node_in_range+0x31b/0x490 [drm]
[   18.253365]  ? trace_kmalloc_node+0xbb/0x110
[   18.253408]  amdgpu_vram_mgr_new+0x1e8/0x3c0 [amdgpu]
[   18.253413]  ttm_bo_mem_space+0xd5/0x300 [ttm]
[   18.253417]  ttm_bo_validate+0x122/0x1c0 [ttm]
[   18.253420]  ? mutex_trylock+0x116/0x130
[   18.253423]  ttm_bo_init_reserved+0x30f/0x3e0 [ttm]
[   18.253456]  amdgpu_bo_do_create+0x1a3/0x630 [amdgpu]
[   18.253489]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
[   18.253521]  amdgpu_bo_create+0x30/0x2e0 [amdgpu]
[   18.253524]  ? lock_acquire+0xa4/0x2e0
[   18.253557]  amdgpu_gem_object_create+0x7b/0xf0 [amdgpu]
[   18.253590]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
[   18.253622]  amdgpu_gem_create_ioctl+0x1ba/0x280 [amdgpu]
[   18.253655]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
[   18.253663]  drm_ioctl_kernel+0x86/0xd0 [drm]
[   18.253671]  drm_ioctl+0x206/0x390 [drm]
[   18.253703]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
[   18.253736]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[   18.253739]  ksys_ioctl+0x82/0xc0
[   18.253741]  __x64_sys_ioctl+0x16/0x20
[   18.253744]  do_syscall_64+0x5c/0xa0
[   18.253746]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   18.253748] RIP: 0033:0x7f24b8c2142b
[   18.253750] Code: 0f 1e fa 48 8b 05 5d ba 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d ba 0c 00 f7 d8 64 89
01 48
[   18.253752] RSP: 002b:00007fff0960d0c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   18.253753] RAX: ffffffffffffffda RBX: 00007fff0960d120 RCX: 00007f24b8c2142b
[   18.253754] RDX: 00007fff0960d120 RSI: 00000000c0206440 RDI: 000000000000000f
[   18.253755] RBP: 00000000c0206440 R08: 0000555e7752ca40 R09: 00007f24b8ceda40
[   18.253756] R10: 0000000000000008 R11: 0000000000000246 R12: 0000555e7752ca40
[   18.253757] R13: 000000000000000f R14: 0000000000200000 R15: 0000555e7720ffd0

I think be better if I fill another bugreport in drm mailing list or
will be enough reply to this mailing list from here?

--
Best Regards,
Mike Gavrilov.
