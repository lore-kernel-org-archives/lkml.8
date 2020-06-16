Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5841207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgFPXjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:39:42 -0400
Received: from mta-out1.inet.fi ([62.71.2.202]:40956 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPXjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:39:42 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 19:39:40 EDT
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthekredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhephfeigfehueefteduuefguefgveffhffgueeiieffffejvdeijedtuefhieduvedtnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddthegnpdhinhgvthepkeegrddvhedurdduleegrdduieegpdhmrghilhhfrhhomhepoehprhhushhilhdqudesmhgsohigrdhinhgvthdrfhhiqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
Received: from [192.168.1.105] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5EE535C50013C974 for linux-kernel@vger.kernel.org; Wed, 17 Jun 2020 02:32:39 +0300
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: WARNING at switch_mm_irqs_off, followed by frozen machine
Message-ID: <c060d969-beb1-f99b-ab56-d2e9fd85c5dc@pp.inet.fi>
Date:   Wed, 17 Jun 2020 02:32:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yesterday my computer with kernel version 5.7.2 was frozen badly enough 
that hard reset was necessary (did not react to SysRq keys). Upon 
checking logs I found following warning and information from the time 
just before resetting it.

Computer has AMD Ryzen 7 2700, Asus B450 motherboard.

5.8-rc1 encountered BUG() and did not boot (iommu and smp_processor_id() 
called from wrong context, I'll see if I can catch log somehow).

kernel: [ 1166.739530] ------------[ cut here ]------------
kernel: [ 1166.739539] WARNING: CPU: 4 PID: 0 at 
switch_mm_irqs_off+0x3ef/0x4a0
kernel: [ 1166.739540] Modules linked in: nf_tables(E) nfnetlink(E) 
binfmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) snd_hda_cod
ec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) 
snd_hda_codec_hdmi(E) snd_usb_audio(E) snd_hda_intel(E) 
snd_intel_dspcfg(E) snd_usbmidi_lib(E) snd_hda_cod
ec(E) snd_rawmidi(E) snd_hda_core(E) snd_hwdep(E) snd_seq_device(E) 
mc(E) snd_pcm_oss(E) amdgpu(E) snd_mixer_oss(E) gpu_sched(E) snd_pcm(E) 
ttm(E) snd_timer(E) jo
ydev(E) drm_kms_helper(E) snd(E) cec(E) soundcore(E) eeepc_wmi(E) 
asus_wmi(E) fb_sys_fops(E) syscopyarea(E) battery(E) edac_mce_amd(E) 
sparse_keymap(E) sysfillrec
t(E) sysimgblt(E) i2c_algo_bit(E) kvm_amd(E) video(E) kvm(E) 
irqbypass(E) 8250(E) ccp(E) wmi_bmof(E) sg(E) 8250_base(E) r8169(E) 
serial_mctrl_gpio(E) rng_core(E)
crct10dif_pclmul(E) realtek(E) serial_core(E) crc32_pclmul(E) libphy(E) 
ghash_clmulni_intel(E) aesni_intel(E) wmi(E) i2c_piix4(E) k10temp(E) 
crypto_simd(E) cryptd
(E) efi_pstore(E) glue_helper(E) efivars(E) acpi_cpufreq(E) button(E)
kernel: [ 1166.739583]  nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) 
grace(E) parport_pc(E) drm(E) sunrpc(E) ppdev(E) lp(E) agpgart(E) pa
rport(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) raid10(E) 
raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) 
async_xor(E) xor(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) 
multipath(E) linear(E) md_mod(E) evdev(E) input_leds(E) hid_generic(E) 
usbhid(E) hid(E) crc32c_intel(E) xhci_pci(E) xhci_hcd(E) sd_mod(E) 
usbcore(E) t10_pi(E) gpio_amdpt(E) gpio_generic(E)
kernel: [ 1166.739613] CPU: 4 PID: 0 Comm: swapper/4 Tainted: 
G            E     5.7.2 #2
kernel: [ 1166.739614] Hardware name: System manufacturer System Product 
Name/TUF B450-PLUS GAMING, BIOS 2008 12/06/2019
kernel: [ 1166.739618] RIP: 0010:switch_mm_irqs_off+0x3ef/0x4a0
kernel: [ 1166.739621] Code: 00 00 0f 84 be fc ff ff b9 49 00 00 00 b8 
01 00 00 00 31 d2 0f 30 48 8b 86 68 03 00 00 65 48 89 05 fe 9e fb 7e e9 
9c fc ff ff <0f> 0b f0 4c 0f ab ad 00 04 00 00 e9 3b fe ff ff b9 49 00 
00 00 b8
kernel: [ 1166.739623] RSP: 0018:ffffc90000147e48 EFLAGS: 00210086
kernel: [ 1166.739624] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
kernel: [ 1166.739626] RDX: ffff88871e43c001 RSI: ffff88871e43c0c0 RDI: 
ffff8886fdede440
kernel: [ 1166.739627] RBP: ffff8886fdede440 R08: 0000000000000001 R09: 
ffff8887f3b5d140
kernel: [ 1166.739628] R10: 000000000000025f R11: 0000000000000018 R12: 
ffff8886fdede440
kernel: [ 1166.739629] R13: 0000000000000004 R14: ffff88871e43c0c0 R15: 
0000000000000000
kernel: [ 1166.739631] FS:  0000000000000000(0000) 
GS:ffff8887fe900000(0000) knlGS:0000000000000000
kernel: [ 1166.739632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [ 1166.739633] CR2: 00003d9b09447000 CR3: 000000071e4e0000 CR4: 
00000000001406e0
kernel: [ 1166.739635] Call Trace:
kernel: [ 1166.739643]  __schedule+0x1cd/0x5e0
kernel: [ 1166.739647]  schedule_idle+0x28/0x40
kernel: [ 1166.739651]  do_idle+0x149/0x1f0
kernel: [ 1166.739655]  cpu_startup_entry+0x19/0x20
kernel: [ 1166.739659]  start_secondary+0x170/0x1c0
kernel: [ 1166.739663]  secondary_startup_64+0xa4/0xb0
kernel: [ 1166.739667] ---[ end trace 8c88a1b8567786da ]---

--

  - Ilkka Prusi


