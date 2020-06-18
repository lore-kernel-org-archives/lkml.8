Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E520899
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFQ5EDbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgFRKWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFRKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:21:59 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F411C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Fla4chMFJzO0aNCJJyP8BOuDWDtn7eZ6rMLdrpKfo7c=; b=YFQ5EDbeOJNlVNwa2WAl9UuH1f
        9bLyakI+hfNcdg68eAIY6m+w3Jao3Jrn1foVtS28ByV2YxW4NCE4FVp/h9JkTgMdHtnfOndfaM034
        xibn0IHoQ88PjPyEPqXO7ZohaUuw52DVB6946btokJZAruoRJHK3v3ASCrRfOfWr3NXH+k1pVXeu8
        zmNClOx05koDzzKuPZ4jAVdrrLB+kO5MyQt0SJ8KTMdqy9q9TEYa+1XPZQu2dHgrpVl38rk36Q56T
        WDSxxiHejhMyKhW5VdjiEk4bYZmiZzNONDrY40OHHqXUWTEd5yMIdsXMDe+O25hZMIIpFitKTkOws
        H086WVlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlrfu-0008R6-HR; Thu, 18 Jun 2020 10:21:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4DA93017B7;
        Thu, 18 Jun 2020 12:21:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FF842122F650; Thu, 18 Jun 2020 12:21:35 +0200 (CEST)
Date:   Thu, 18 Jun 2020 12:21:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Cc:     linux-kernel@vger.kernel.org, riel@surriel.com, luto@kernel.org,
        x86@kernel.org
Subject: Re: WARNING at switch_mm_irqs_off, followed by frozen machine
Message-ID: <20200618102135.GA616959@hirez.programming.kicks-ass.net>
References: <c060d969-beb1-f99b-ab56-d2e9fd85c5dc@pp.inet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c060d969-beb1-f99b-ab56-d2e9fd85c5dc@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:32:39AM +0300, Ilkka Prusi wrote:
> Hi,
> 
> Yesterday my computer with kernel version 5.7.2 was frozen badly enough that
> hard reset was necessary (did not react to SysRq keys). Upon checking logs I
> found following warning and information from the time just before resetting
> it.
> 
> Computer has AMD Ryzen 7 2700, Asus B450 motherboard.
> 
> 5.8-rc1 encountered BUG() and did not boot (iommu and smp_processor_id()
> called from wrong context, I'll see if I can catch log somehow).

Since you're building your own kernels, can you make sure to always
have:

 - CONFIG_DEBUG_BUGVERBOSE=y
 - CONFIG_DEBUG_INFO=y

and then when reporting, run the thing through:

  ./scripts/decode_stacktrace.sh

Because the below splat is _VERY_ hard to decipher because of all the
missing information.

> kernel: [ 1166.739530] ------------[ cut here ]------------
> kernel: [ 1166.739539] WARNING: CPU: 4 PID: 0 at
> switch_mm_irqs_off+0x3ef/0x4a0

With BUGVERBOSE the above would've included a __LINE__ number which
would've easily identified which WARN went *splat*, but now..

> kernel: [ 1166.739540] Modules linked in: nf_tables(E) nfnetlink(E)
> binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) snd_hda_cod
> ec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E)
> snd_hda_codec_hdmi(E) snd_usb_audio(E) snd_hda_intel(E) snd_intel_dspcfg(E)
> snd_usbmidi_lib(E) snd_hda_cod
> ec(E) snd_rawmidi(E) snd_hda_core(E) snd_hwdep(E) snd_seq_device(E) mc(E)
> snd_pcm_oss(E) amdgpu(E) snd_mixer_oss(E) gpu_sched(E) snd_pcm(E) ttm(E)
> snd_timer(E) jo
> ydev(E) drm_kms_helper(E) snd(E) cec(E) soundcore(E) eeepc_wmi(E)
> asus_wmi(E) fb_sys_fops(E) syscopyarea(E) battery(E) edac_mce_amd(E)
> sparse_keymap(E) sysfillrec
> t(E) sysimgblt(E) i2c_algo_bit(E) kvm_amd(E) video(E) kvm(E) irqbypass(E)
> 8250(E) ccp(E) wmi_bmof(E) sg(E) 8250_base(E) r8169(E) serial_mctrl_gpio(E)
> rng_core(E)
> crct10dif_pclmul(E) realtek(E) serial_core(E) crc32_pclmul(E) libphy(E)
> ghash_clmulni_intel(E) aesni_intel(E) wmi(E) i2c_piix4(E) k10temp(E)
> crypto_simd(E) cryptd
> (E) efi_pstore(E) glue_helper(E) efivars(E) acpi_cpufreq(E) button(E)
> kernel: [ 1166.739583]  nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
> parport_pc(E) drm(E) sunrpc(E) ppdev(E) lp(E) agpgart(E) pa
> rport(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) raid10(E)
> raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E)
> async_xor(E) xor(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) multipath(E)
> linear(E) md_mod(E) evdev(E) input_leds(E) hid_generic(E) usbhid(E) hid(E)
> crc32c_intel(E) xhci_pci(E) xhci_hcd(E) sd_mod(E) usbcore(E) t10_pi(E)
> gpio_amdpt(E) gpio_generic(E)
> kernel: [ 1166.739613] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G           
> E     5.7.2 #2
> kernel: [ 1166.739614] Hardware name: System manufacturer System Product
> Name/TUF B450-PLUS GAMING, BIOS 2008 12/06/2019
> kernel: [ 1166.739618] RIP: 0010:switch_mm_irqs_off+0x3ef/0x4a0
> kernel: [ 1166.739621] Code: 00 00 0f 84 be fc ff ff b9 49 00 00 00 b8 01 00
> 00 00 31 d2 0f 30 48 8b 86 68 03 00 00 65 48 89 05 fe 9e fb 7e e9 9c fc ff
> ff <0f> 0b f0 4c 0f ab ad 00 04 00 00 e9 3b fe ff ff b9 49 00 00 00 b8

I had to run this through ./scripts/decodecode, to obtain:

All code
========
   0:	00 00                	add    %al,(%rax)
   2:	0f 84 be fc ff ff    	je     0xfffffffffffffcc6
   8:	b9 49 00 00 00       	mov    $0x49,%ecx
   d:	b8 01 00 00 00       	mov    $0x1,%eax
  12:	31 d2                	xor    %edx,%edx
  14:	0f 30                	wrmsr  
  16:	48 8b 86 68 03 00 00 	mov    0x368(%rsi),%rax
  1d:	65 48 89 05 fe 9e fb 	mov    %rax,%gs:0x7efb9efe(%rip)        # 0x7efb9f23
  24:	7e 
  25:	e9 9c fc ff ff       	jmpq   0xfffffffffffffcc6
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	f0 4c 0f ab ad 00 04 	lock bts %r13,0x400(%rbp)
  33:	00 00 
  35:	e9 3b fe ff ff       	jmpq   0xfffffffffffffe75
  3a:	b9 49 00 00 00       	mov    $0x49,%ecx
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	f0 4c 0f ab ad 00 04 	lock bts %r13,0x400(%rbp)
   9:	00 00 
   b:	e9 3b fe ff ff       	jmpq   0xfffffffffffffe4b
  10:	b9 49 00 00 00       	mov    $0x49,%ecx
  15:	b8                   	.byte 0xb8

And then pattern match that against my local defconfig build of
arch/x86/mm/tlb.o and pray my compiler did anyting like your
(unspecified) compiler.

Going by that, I ended up with:

		/*
		 * Even in lazy TLB mode, the CPU should stay set in the
		 * mm_cpumask. The TLB shootdown code can figure out from
		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
		 */
		if (WARN_ON_ONCE(real_prev != &init_mm &&
				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
			cpumask_set_cpu(cpu, mm_cpumask(next));

being the WARN that went splat. I've Cc'ed both Rik and Andy who are
responsible for those lines. But this is all very little to go on.

> kernel: [ 1166.739623] RSP: 0018:ffffc90000147e48 EFLAGS: 00210086
> kernel: [ 1166.739624] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> kernel: [ 1166.739626] RDX: ffff88871e43c001 RSI: ffff88871e43c0c0 RDI:
> ffff8886fdede440
> kernel: [ 1166.739627] RBP: ffff8886fdede440 R08: 0000000000000001 R09:
> ffff8887f3b5d140
> kernel: [ 1166.739628] R10: 000000000000025f R11: 0000000000000018 R12:
> ffff8886fdede440
> kernel: [ 1166.739629] R13: 0000000000000004 R14: ffff88871e43c0c0 R15:
> 0000000000000000
> kernel: [ 1166.739631] FS:  0000000000000000(0000) GS:ffff8887fe900000(0000)
> knlGS:0000000000000000
> kernel: [ 1166.739632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: [ 1166.739633] CR2: 00003d9b09447000 CR3: 000000071e4e0000 CR4:
> 00000000001406e0
> kernel: [ 1166.739635] Call Trace:
> kernel: [ 1166.739643]  __schedule+0x1cd/0x5e0
> kernel: [ 1166.739647]  schedule_idle+0x28/0x40
> kernel: [ 1166.739651]  do_idle+0x149/0x1f0
> kernel: [ 1166.739655]  cpu_startup_entry+0x19/0x20
> kernel: [ 1166.739659]  start_secondary+0x170/0x1c0
> kernel: [ 1166.739663]  secondary_startup_64+0xa4/0xb0
> kernel: [ 1166.739667] ---[ end trace 8c88a1b8567786da ]---
> 
> --
> 
>  - Ilkka Prusi
> 
> 
