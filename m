Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21627C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF421206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjbb7f4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgDKBJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:09:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46924 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDKBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:09:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id g7so2826437qtj.13;
        Fri, 10 Apr 2020 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iRPNCUopOeuAhFwHnCtHaZbbr9O5vbosVzEKtXgcT5s=;
        b=Zjbb7f4pCGHlYwtSmmuJRbum27NtKtJOtr9qyTRAOAyfJtocXRvrBDdfXF7cipgkrp
         ByxbiBOWSWEXZKcJ22eyqXv99f9mbRmdVrpIqRdeZzsHEQWiUhBi4VozVtLvT3EKTIUY
         TqmygYI25QL66dZpT4Z6PERIxhLBWlO3A/z0JTOHydr9luqpJ2zT+LjaBBeYBl+ZIsqU
         PFrVKKLFeCkGWcfbojZIdyN+vy/WmIvj9mL4//7SttVWMD+/XfI4g92ZFJVBA8lo93VH
         30s5tFXYwm+3aNgYBXVDg8CpNoW24j2r4qRMEBv0qNPQMkYAT2J0uwzYyj0ulF750br4
         S73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iRPNCUopOeuAhFwHnCtHaZbbr9O5vbosVzEKtXgcT5s=;
        b=FvnUWxM+QfJearnsCVp6nT3B2NgYtTFj3by3oDk2p/bjJc2okY5EZF1XduwtaLKGSi
         iYfExO5/lK1B2vR4z4IjKVNWHt7nSh/GWMdlfykYTU7wYNA9tWFooJgVe5aKlrJZsFek
         NABAOnOpGyZoiNp6jrR10oscz1XkgPvjJTvU75Rnkzz7X4yQPCc5BwFNpwlmM25AjWAG
         P9f/mm7BkrWstnt+5IhFhnzZKjX/uW6IhsFqkz7ej3eXz9EHr5yaNimujsIP/v0qbKHL
         i2Br9NOKwBG5IN1Btlwpe/cqyIi75BYOYFzSTipeaYHzalbOUtKsrxdSFJ7JvBFs2c6V
         hw4g==
X-Gm-Message-State: AGi0PuafsX7MLKlMPPAiRrYVZneh6/iPRdGt8x+UTUQpN8Ur2LIp6loP
        01yt55FPPjgP9DNkXL8/LMHoMyII
X-Google-Smtp-Source: APiQypLVH0alfptMYo1VDEwUAh8JK5u1evINJCaygvhmUFK2fW7gSMgFZwhRSryDA/2eP8cda89e9g==
X-Received: by 2002:ac8:2afc:: with SMTP id c57mr1782052qta.324.1586567343364;
        Fri, 10 Apr 2020 18:09:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 11sm1918074qkg.122.2020.04.10.18.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:09:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 21:09:01 -0400
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Like Xu <like.xu@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-x86_64@vger.kernel.org
Subject: Re: [Bug report] Kernel 5.7 become unbootable
Message-ID: <20200411010901.GB1612878@rani.riverdale.lan>
References: <CABXGCsPpD+ExaeA6v+gSPPgtxcVzpKLWJNwGPPDKGFkPCv5kDg@mail.gmail.com>
 <1d02e4f3-8d83-4c55-bce2-f5aa4af2e363@linux.intel.com>
 <20200410142920.GA936997@rani.riverdale.lan>
 <CABXGCsMA05e6491bQ2RdhFZAKeMkcxAUz4qL3026iApw8O06mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsMA05e6491bQ2RdhFZAKeMkcxAUz4qL3026iApw8O06mQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 12:23:52AM +0500, Mikhail Gavrilov wrote:
> On Fri, 10 Apr 2020 at 19:29, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Please try with the patches at
> > https://lore.kernel.org/linux-efi/20200409130434.6736-1-ardb@kernel.org/
> >
> > In particular, patches 3 and 4. The first one is a fix for upstream
> > commit 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> 
> Thanks, I can confirm that these patches solve the issue with unbootable kernel.
> But, now after successful booting, I see another issue.
> Kernel logs flooded with the error messages:
> [   18.253336] BUG: sleeping function called from invalid context at
> drivers/gpu/drm/drm_mm.c:371
> [   18.253339] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
> 1723, name: gnome-shell
> [   18.253340] INFO: lockdep is turned off.
> [   18.253342] CPU: 23 PID: 1723 Comm: gnome-shell Tainted: G      D W
>         5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
> [   18.253343] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
> [   18.253344] Call Trace:
> [   18.253350]  dump_stack+0x8b/0xc8
> [   18.253352]  ___might_sleep.cold+0xb6/0xc6
> [   18.253362]  drm_mm_insert_node_in_range+0x31b/0x490 [drm]
> [   18.253365]  ? trace_kmalloc_node+0xbb/0x110
> [   18.253408]  amdgpu_vram_mgr_new+0x1e8/0x3c0 [amdgpu]
> [   18.253413]  ttm_bo_mem_space+0xd5/0x300 [ttm]
> [   18.253417]  ttm_bo_validate+0x122/0x1c0 [ttm]
> [   18.253420]  ? mutex_trylock+0x116/0x130
> [   18.253423]  ttm_bo_init_reserved+0x30f/0x3e0 [ttm]
> [   18.253456]  amdgpu_bo_do_create+0x1a3/0x630 [amdgpu]
> [   18.253489]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
> [   18.253521]  amdgpu_bo_create+0x30/0x2e0 [amdgpu]
> [   18.253524]  ? lock_acquire+0xa4/0x2e0
> [   18.253557]  amdgpu_gem_object_create+0x7b/0xf0 [amdgpu]
> [   18.253590]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
> [   18.253622]  amdgpu_gem_create_ioctl+0x1ba/0x280 [amdgpu]
> [   18.253655]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
> [   18.253663]  drm_ioctl_kernel+0x86/0xd0 [drm]
> [   18.253671]  drm_ioctl+0x206/0x390 [drm]
> [   18.253703]  ? amdgpu_gem_object_close+0x180/0x180 [amdgpu]
> [   18.253736]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [   18.253739]  ksys_ioctl+0x82/0xc0
> [   18.253741]  __x64_sys_ioctl+0x16/0x20
> [   18.253744]  do_syscall_64+0x5c/0xa0
> [   18.253746]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [   18.253748] RIP: 0033:0x7f24b8c2142b
> [   18.253750] Code: 0f 1e fa 48 8b 05 5d ba 0c 00 64 c7 00 26 00 00
> 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d ba 0c 00 f7 d8 64 89
> 01 48
> [   18.253752] RSP: 002b:00007fff0960d0c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [   18.253753] RAX: ffffffffffffffda RBX: 00007fff0960d120 RCX: 00007f24b8c2142b
> [   18.253754] RDX: 00007fff0960d120 RSI: 00000000c0206440 RDI: 000000000000000f
> [   18.253755] RBP: 00000000c0206440 R08: 0000555e7752ca40 R09: 00007f24b8ceda40
> [   18.253756] R10: 0000000000000008 R11: 0000000000000246 R12: 0000555e7752ca40
> [   18.253757] R13: 000000000000000f R14: 0000000000200000 R15: 0000555e7720ffd0
> 
> I think be better if I fill another bugreport in drm mailing list or
> will be enough reply to this mailing list from here?
> 
> --
> Best Regards,
> Mike Gavrilov.

Glad that the booting problem got fixed.

Probably cc both the drm and amdgpu maintainers and change the subject
to be more specific.

Thanks.
