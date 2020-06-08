Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2562075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkSeJ0OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFHA5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgFHA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:57:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551BBC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 17:57:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so5046345pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3OG+06AXNGyPUKWS0CfV/HeZ0RO1YmM6taoaSNJTNb0=;
        b=gkSeJ0OIv2Q9f9FRVfE/AY8wMB38EFl+MYiI5yaKaPhEUiyngpAIcMhkxlnCORyMyE
         Uveq79eksjSRCjISzVOLOoEbNZaz3AmzBK3S3qBUH12jXGcO/vlpP6OZdCybjL0a8W9b
         BcXM6vFwCivhVdeJ4XAIZ3Vfmdig1cGbRDlWCeALmVxJbsvIEm0X5czHcAWUiCYXCqvK
         65ZoOHtbiiAqZwk0Pxe5PDeJq1Yfry5V7Cv5QdSMLueKqjWcMqH0nBA17Tsdk34Ag96R
         MnBQE34BM6D6oXMTNn6ppMGHJbVNgWNxSUEfJHVi9ipciMqbFU5f/Nlt8V9ZJUWnXmew
         ixAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3OG+06AXNGyPUKWS0CfV/HeZ0RO1YmM6taoaSNJTNb0=;
        b=tg/WmK21Em5Bfa+1NLeP6d4jlUvlIvKbIaiM7jGRIheiYC2aaC5MWVti4emP/7LXFx
         VUZzPED7VArET8xyrfDYtQVnHx5JDbLbYhbTpb/lJ/x7rQ96X7VU2YVeZ26NpcHrGFeX
         EQPLKuqcsn9wMkXt27xecar6AIO09psJiGQz13/yl3mlsXh3tr8GghH56fmUQHqrRwN0
         hoJQC7z5XGp3qsxb/0GdufA9bFUofqjhA8g0CpggHChh+3a+FQXI1+aKlqsK13ROY0Tb
         HgbVf0GJ4Q3hBAlfoGFHUnmfR+uvN0tlSynEm8Z+c8Fj2Wh9/9V/uOiY6RXJ1xYt8QUj
         RPew==
X-Gm-Message-State: AOAM531JRtEwvfn89tA1Yho9eMBCdvxYpG1il5X1XrsxdDuCe3l62FyP
        7OstlmEXER0tOjS+mtB4B0r1Zw==
X-Google-Smtp-Source: ABdhPJyXDIv4C8INThRvIT6Bf/nmSYOBdcjapxN3vhwx5zwiBCZ+TSCVAAbMEZwmiMDg7g1WKK/YNQ==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr15266617pjo.35.1591577841542;
        Sun, 07 Jun 2020 17:57:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 19sm4382556pgh.21.2020.06.07.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 17:57:20 -0700 (PDT)
Date:   Sun, 7 Jun 2020 17:57:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hch@lst.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, perex@perex.cz, tglx@linutronix.de,
        tiwai@suse.com, x86@kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 82fef0ad811f "x86/mm: unencrypted non-blocking DMA allocations
 use coherent pools" was Re: next-0519 on thinkpad x60: sound related? window
 manager crash
In-Reply-To: <1591570155.2tn9o40h95.none@localhost>
Message-ID: <alpine.DEB.2.22.394.2006071756040.138746@chino.kir.corp.google.com>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200607163803.GA10303@duo.ucw.cz> <alpine.DEB.2.22.394.2006071209470.84952@chino.kir.corp.google.com> <1591570155.2tn9o40h95.none@localhost>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jun 2020, Alex Xu (Hello71) wrote:

> > On Sun, 7 Jun 2020, Pavel Machek wrote:
> > 
> >> > I have a similar issue, caused between aaa2faab4ed8 and b170290c2836.
> >> > 
> >> > [   20.263098] BUG: unable to handle page fault for address: ffffb2b582cc2000
> >> > [   20.263104] #PF: supervisor write access in kernel mode
> >> > [   20.263105] #PF: error_code(0x000b) - reserved bit violation
> >> > [   20.263107] PGD 3fd03b067 P4D 3fd03b067 PUD 3fd03c067 PMD 3f8822067 PTE 8000273942ab2163
> >> > [   20.263113] Oops: 000b [#1] PREEMPT SMP
> >> > [   20.263117] CPU: 3 PID: 691 Comm: mpv Not tainted 5.7.0-11262-gb170290c2836 #1
> >> > [   20.263119] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4, BIOS P4.10 03/05/2020
> >> > [   20.263125] RIP: 0010:__memset+0x24/0x30
> >> > [   20.263128] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> >> > [   20.263131] RSP: 0018:ffffb2b583d07e10 EFLAGS: 00010216
> >> > [   20.263133] RAX: 0000000000000000 RBX: ffff8b8000102c00 RCX: 0000000000004000
> >> > [   20.263134] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb2b582cc2000
> >> > [   20.263136] RBP: ffff8b8000101000 R08: 0000000000000000 R09: ffffb2b582cc2000
> >> > [   20.263137] R10: 0000000000005356 R11: ffff8b8000102c18 R12: 0000000000000000
> >> > [   20.263139] R13: 0000000000000000 R14: ffff8b8039944200 R15: ffffffff9794daa0
> >> > [   20.263141] FS:  00007f41aa4b4200(0000) GS:ffff8b803ecc0000(0000) knlGS:0000000000000000
> >> > [   20.263143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > [   20.263144] CR2: ffffb2b582cc2000 CR3: 00000003b6731000 CR4: 00000000003406e0
> >> > [   20.263146] Call Trace:
> >> > [   20.263151]  ? snd_pcm_hw_params+0x3f3/0x47a
> >> > [   20.263154]  ? snd_pcm_common_ioctl+0xf2/0xf73
> >> > [   20.263158]  ? snd_pcm_ioctl+0x1e/0x29
> >> > [   20.263161]  ? ksys_ioctl+0x77/0x91
> >> > [   20.263163]  ? __x64_sys_ioctl+0x11/0x14
> >> > [   20.263166]  ? do_syscall_64+0x3d/0xf5
> >> > [   20.263170]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> > [   20.263173] Modules linked in: uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev snd_usb_audio videobuf2_common snd_hwdep snd_usbmidi_lib input_leds snd_rawmidi led_class
> >> > [   20.263182] CR2: ffffb2b582cc2000
> >> > [   20.263184] ---[ end trace c6b47a774b91f0a0 ]---
> >> > [   20.263187] RIP: 0010:__memset+0x24/0x30
> >> > [   20.263190] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> >> > [   20.263192] RSP: 0018:ffffb2b583d07e10 EFLAGS: 00010216
> >> > [   20.263193] RAX: 0000000000000000 RBX: ffff8b8000102c00 RCX: 0000000000004000
> >> > [   20.263195] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb2b582cc2000
> >> > [   20.263196] RBP: ffff8b8000101000 R08: 0000000000000000 R09: ffffb2b582cc2000
> >> > [   20.263197] R10: 0000000000005356 R11: ffff8b8000102c18 R12: 0000000000000000
> >> > [   20.263199] R13: 0000000000000000 R14: ffff8b8039944200 R15: ffffffff9794daa0
> >> > [   20.263201] FS:  00007f41aa4b4200(0000) GS:ffff8b803ecc0000(0000) knlGS:0000000000000000
> >> > [   20.263202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > [   20.263204] CR2: ffffb2b582cc2000 CR3: 00000003b6731000 CR4: 00000000003406e0
> >> > 
> >> > I bisected this to 82fef0ad811f "x86/mm: unencrypted non-blocking DMA 
> >> > allocations use coherent pools". Reverting 1ee18de92927 resolves the 
> >> > issue.
> >> > 
> >> > Looks like Thinkpad X60 doesn't have VT-d, but could still be DMA 
> >> > related.
> >> 
> >> Note that newer -next releases seem to behave okay for me. The commit
> >> pointed out by siection is really simple:
> >> 
> >> AFAIK you could verify it is responsible by turning off
> >> CONFIG_AMD_MEM_ENCRYPT on latest kernel...
> >> 
> >> Best regards,
> >> 								Pavel
> >> 
> >> index 1d6104ea8af0..2bf2222819d3 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -1520,6 +1520,7 @@ config X86_CPA_STATISTICS
> >>  config AMD_MEM_ENCRYPT
> >>         bool "AMD Secure Memory Encryption (SME) support"
> >>         depends on X86_64 && CPU_SUP_AMD
> >> +       select DMA_COHERENT_POOL
> >>         select DYNAMIC_PHYSICAL_MASK
> >>         select ARCH_USE_MEMREMAP_PROT
> >>         select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> > 
> > Thanks for the report!
> > 
> > Besides CONFIG_AMD_MEM_ENCRYPT, do you have CONFIG_DMA_DIRECT_REMAP 
> > enabled?  If so, it may be caused by the virtual address passed to the 
> > set_memory_{decrypted,encrypted}() functions.
> > 
> > And I assume you are enabling SME by using mem_encrypt=on on the kernel 
> > command line or CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is enabled.
> > 
> > We likely need an atomic pool for devices that support DMA to addresses in 
> > sme_me_mask as well.  I can test this tomorrow, but wanted to get it out 
> > early to see if it helps?
> 
> This patch doesn't seem to help. I have the same problem (kernel page 
> fault, __memset, snd_pcm_hw_params...).
> 
> I don't have CONFIG_DMA_DIRECT_REMAP enabled, and AFAICT it doesn't seem 
> to be selectable currently on x86, unless there are some patches 
> floating around for that.
> 

Thanks for trying it out, Alex.  Would you mind sending your .config and 
command line?  I assume either mem_encrypt=on or 
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is enabled.

Could you also give this a try?

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -99,10 +99,11 @@ static inline bool dma_should_alloc_from_pool(struct device *dev, gfp_t gfp,
 static inline bool dma_should_free_from_pool(struct device *dev,
 					     unsigned long attrs)
 {
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
+	if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
+		return false;
+	if (force_dma_unencrypted(dev))
 		return true;
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev))
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return false;
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
 		return true;
