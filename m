Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B21C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC64208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgICSNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:13:38 -0400
Received: from hermes.qwer.tk ([93.82.198.100]:44074 "EHLO hermes.qwer.tk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgICSNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:13:36 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 14:13:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by hermes.qwer.tk (Postfix) with ESMTP id C040F11E962
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:06:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at qwer.tk
Received: from hermes.qwer.tk ([127.0.0.1])
        by localhost (hermes.qwer.tk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q4Dz7dWVB4fM for <linux-kernel@vger.kernel.org>;
        Thu,  3 Sep 2020 20:05:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by hermes.qwer.tk (Postfix) with ESMTP id C3BBA18742C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:05:55 +0200 (CEST)
Received: from [192.168.50.79] (daidalos.qwer.tk [192.168.50.79])
        by hermes.qwer.tk (Postfix) with ESMTP id B445911E962
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:05:55 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
From:   Hermann Himmelbauer <hermann@qwer.tk>
Subject: Random Freezes: Kernel 5.4.34 / "iommu ivhd0: AMD-Vi: Event logged
 [ILLEGAL_DEV_TABLE_ENTRY" on Ryzen System (ASRock X470D4U2-2T)
Autocrypt: addr=hermann@qwer.tk; prefer-encrypt=mutual; keydata=
 xsDhBDvBnt8RBACMws44bPKEa5IhH4xO3RRRuzB2OHSK6wbd14yggq5/e3kL5wT6wiBrvnnz
 bm4fB0wXYVi1didw/x31Jivw0xvFTJmQFtkIRmznG4xL6H6sFUOoJ0ve+3BGHLCN8y/Sq8XA
 CiEbQ/a/O4xGBmVErsUHbVy8w1Vip+ryhmGE1pb4uwCgxz58QAphR7kSuYecCY6NSDmN25UD
 /A2A9YKYnIsC1kX9xmXqfK9WG3nHhAfXXaRnAAtIJmYWvYrmAKZFq1aCV0WEqEnmCzGGLUcs
 Hfz9QiTKeeDo2r3Kkeq3hkObVRpbz09O2E1UP0JM4wSH5KP1CU95Dh7K9grPbjGTmJRnApPZ
 AoIiAHn3bft8N4YFSGC0GnH9b1yKA/dERK82n+3E9xk4s1PF5e+yKFy9oMhHbyeeC0U5XtRh
 1g+IttjHByHhDkzspM+0m/IksTm+tO0XCMcs03kgNHus1nvNVgZ3ju0VG+t0kgxOwbPFfL7n
 EUzWs8V2xxDCdj51GPpPgS5d5EZ0bic64nboGZSYWQJPmGHCWkP8vE8MzThIZXJtYW5uIEhp
 bW1lbGJhdWVyIChPZmZpY2UpIDxoZXJtYW5uQGhpbW1lbGJhdWVyLWl0LmF0PsJmBBMRAgAm
 AhsjBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AFAlQ+eyMCGQEACgkQZLTRaymYk8dH9wCg
 i5a2Ziy6jfORkHZaLGTMiXFU4EUAn3yvFpjotgqRKWua1b+KC+U3/8VpzsFNBDvBnusQCACo
 zV8ICMObecOnFRB9K2kQTXg2YpQJ6fFCpdHj9uYwBLtoDMn1f1Hg68MxS2+/eoQ8AftaBd8B
 H7WPBbLDXD4OedM5lLMId3xJ94jSHb8LPF/dFvAW4jScDoDP2SBFPzugivHwYZhHwoefCVPi
 QKZFaDOOfBlRRTHlLRct3kcHCZloNqmprBxg4r5MAAaRzIllzUXzTim+AEq+9nvg1ka1k44s
 GKpdDD5U+qPmQL+4jVf7ESH1oNI7cFQqvM2KmONjtNzul0+WF3gkTAf2jc7eRCoPbi72Vsv+
 oPfh3/wT54d3TcGdti5cZlEsBttj9CNi6XTtLqVznlpO8AQoL/IjAAMFCACFf3thVOTTRAbR
 NSnxBe3SM45YIUFN/ROCb8WWlMj7o1pYHGJl2XFGhhRoGHYBrnrRy1NQKIVr/0O2V1LRhMMH
 h9lX74FpKLfEmIffmjoiWTM6O6ailoVVtwXdooRnGOHXkCqWrGPYToiq4xTncSiRE48Woc82
 tqXXhwFII23go450X13PbeqDHHzi3lL0l6JaGK0CdrCzANmn6xCMRo1+lYkCvmvmay/pyHNm
 5Le9VFLXSKsVbdU93FIVn98uT9/Qz4/lFVPEXrxIQFk1gCO+GmFBC7If7DmjfMU+YSt++pmC
 hl91UOEWDmqzZ5NPVYZxa9Pnw2WZxNmahcs1gkkVwk4EGBECAAYFAjvBnusAEgkQZLTRaymY
 k8cHZUdQRwABAR7eAKDEMfcDthWDvrCoAiQtm/wfYMx/bQCgqFmCXEfXZkSpnsr8RIrIWuK8 2Dk=
Message-ID: <23a5a7c4-bd01-845f-dbc7-24c973ffb60d@qwer.tk>
Date:   Thu, 3 Sep 2020 20:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,
After searching the internet for countless hours and not finding any
solution, I hope you can point me in the right direction for my
following problem:

I'm trying to install a 3-node cluster (proxmox/ceph) and experience
random freezes. The node can either be completely frozen (no blinking
cursor on console, no ping) or can get somewhat blocked / slow etc.

This happens most often on node 2 (approx. 3-4 times / day), node 3
never got stuck within 14 days runtime, node 1 once.

Unfortunately I did not find any way to trigger this behaviour, hoever,
I *think* that this happens most often if I stress the machine in some
way (performance test within a virtual machine) and then idling the machine.

When the machine freezes completely, there is no logfile. However, if it
is partially frozen, the following can be found in the kernel log (dmesg
-T):

----------- snip --------------

[Sat Aug 22 21:18:59 2020] perf: interrupt took too long (3134 > 3127),
lowering kernel.perf_event_max_sample_rate to 63750
[Fri Aug 28 16:55:06 2020] iommu ivhd0: AMD-Vi: Event logged
[ILLEGAL_DEV_TABLE_ENTRY device=2b:00.0 pasid=0x00000 address=0xffff2420
flags=0x0080]
[Fri Aug 28 16:55:06 2020] AMD-Vi: DTE[0]: 60000007e10a8603
[Fri Aug 28 16:55:06 2020] AMD-Vi: DTE[1]: 0000000000000009
[Fri Aug 28 16:55:06 2020] AMD-Vi: DTE[2]: 20000007e0d6a011
[Fri Aug 28 16:55:06 2020] AMD-Vi: DTE[3]: 0000000000000000
[Fri Aug 28 17:04:34 2020] iommu ivhd0: AMD-Vi: Event logged
[ILLEGAL_DEV_TABLE_ENTRY device=2b:00.0 pasid=0x00000 address=0xffff5bf0
flags=0x0080]
[Fri Aug 28 17:04:34 2020] AMD-Vi: DTE[0]: 60000007e10a8603
[Fri Aug 28 17:04:34 2020] AMD-Vi: DTE[1]: 0000000000000009
[Fri Aug 28 17:04:34 2020] AMD-Vi: DTE[2]: 20000007e0d6a011
[Fri Aug 28 17:04:34 2020] AMD-Vi: DTE[3]: 0000000000000000

[...] same message above multiple times [...]

[Fri Aug 28 17:16:46 2020] BUG: unable to handle page fault for address:
ffffffffffffffb8
[Fri Aug 28 17:16:46 2020] #PF: supervisor write access in kernel mode
[Fri Aug 28 17:16:46 2020] #PF: error_code(0x0002) - not-present page
[Fri Aug 28 17:16:46 2020] PGD 2d080e067 P4D 2d080e067 PUD 2d0810067 PMD 0
[Fri Aug 28 17:16:46 2020] Oops: 0002 [#1] SMP NOPTI
[Fri Aug 28 17:16:46 2020] CPU: 0 PID: 1472 Comm: corosync Tainted: P
        OE     5.4.34-1-pve #1
[Fri Aug 28 17:16:46 2020] Hardware name: To Be Filled By O.E.M. To Be
Filled By O.E.M./X470D4U2-2T, BIOS P3.30 10/03/2019
[Fri Aug 28 17:16:46 2020] RIP: 0010:hrtimer_nanosleep+0x9c/0x190
[Fri Aug 28 17:16:46 2020] Code: 39 c8 0f 8f e1 00 00 00 48 69 c0 00 ca
9a 3b 48 01 d0 48 89 c2 48 89 45 b0 4c 01 e2 0f 88 8d 00 00 00 48 39 c2
0f 8c 84 00 00 <00> 48 b8 ff ff ff ff ff ff ff 7f 48 39 f2 48 0f 4c d0
89 de 4c 89
[Fri Aug 28 17:16:46 2020] RSP: 0018:ffffac97812a3e88 EFLAGS: 00010286
[Fri Aug 28 17:16:46 2020] RAX: 0000000000000000 RBX: 0000000000000001
RCX: 0000000000000000
[Fri Aug 28 17:16:46 2020] RDX: ffff97092e81dfc0 RSI: 0000000000000000
RDI: ffffac97812a3e88
[Fri Aug 28 17:16:46 2020] RBP: ffffac97812a3ef8 R08: 0000000000000338
R09: 0000000000000001
[Fri Aug 28 17:16:46 2020] R10: 0000000000000006 R11: ffff970905f54e00
R12: 0000000000000000
[Fri Aug 28 17:16:46 2020] R13: ffffac97812a3e88 R14: ffffac97812a3f08
R15: 0000000000000000
[Fri Aug 28 17:16:46 2020] FS:  00007fb728e5a700(0000)
GS:ffff97092e800000(0000) knlGS:0000000000000000
[Fri Aug 28 17:16:46 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Aug 28 17:16:46 2020] CR2: ffffffffffffffb8 CR3: 00000007c65e8000
CR4: 00000000003406f0
[Fri Aug 28 17:16:46 2020] Call Trace:
[Fri Aug 28 17:16:46 2020]  ? hrtimer_init_sleeper+0x90/0x90
[Fri Aug 28 17:16:46 2020]  __x64_sys_nanosleep+0x7b/0xa0
[Fri Aug 28 17:16:46 2020]  do_syscall_64+0x57/0x190
[Fri Aug 28 17:16:46 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Fri Aug 28 17:16:46 2020] RIP: 0033:0x7fb732eea720
[Fri Aug 28 17:16:46 2020] Code: 00 f0 ff ff 77 44 c3 0f 1f 00 55 48 89
f5 53 48 89 fb 48 83 ec 18 e8 3f 00 04 00 48 89 ee 48 89 df 89 c2 b8 23
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2a 89 d7 89 44 24 0c e8 7d 00 04
00 8b 44 24
[Fri Aug 28 17:16:46 2020] RSP: 002b:00007fb728e59df0 EFLAGS: 00000293
ORIG_RAX: 0000000000000023
[Fri Aug 28 17:16:46 2020] RAX: ffffffffffffffda RBX: 00007fb728e59e20
RCX: 00007fb732eea720
[Fri Aug 28 17:16:46 2020] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 00007fb728e59e20
[Fri Aug 28 17:16:46 2020] RBP: 0000000000000000 R08: 00007fb72bffe618
R09: 0000000000000000
[Fri Aug 28 17:16:46 2020] R10: 00000000000e7c62 R11: 0000000000000293
R12: 00000000cccccccd
[Fri Aug 28 17:16:46 2020] R13: 0000000000000002 R14: 00007fb728e5a700
R15: 0000000000000002
[Fri Aug 28 17:16:46 2020] Modules linked in: msr(E) ebtable_filter(E)
ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) ip6table_filter(E)
ip6_tables(E) sctp(E) iptable_filter(E) bpfilter(E) bonding(E)
softdog(E) nfnetlink_log(E) nfnetlink(E) edac_mce_amd(E) ipmi_ssif(E)
kvm_amd(E) ccp(E) kvm(E) zfs(POE) zunicode(POE) zlua(POE) zavl(POE)
icp(POE) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E)
snd_hda_intel(E) aesni_intel(E) snd_intel_dspcfg(E) crypto_simd(E)
snd_hda_codec(E) snd_hda_core(E) cryptd(E) glue_helper(E) snd_hwdep(E)
snd_pcm(E) pcspkr(E) wmi_bmof(E) k10temp(E) snd_timer(E) snd(E) ast(E)
soundcore(E) drm_vram_helper(E) ttm(E) drm_kms_helper(E) drm(E)
i2c_algo_bit(E) fb_sys_fops(E) syscopyarea(E) sysfillrect(E)
sysimgblt(E) joydev(E) input_leds(E) cdc_ether(E) usbnet(E) mii(E)
ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) mac_hid(E) zcommon(POE)
znvpair(POE) spl(OE) vhost_net(E) vhost(E) tap(E) ib_iser(E) rdma_cm(E)
iw_cm(E) ib_cm(E) ib_core(E) iscsi_tcp(E) libiscsi_tcp(E)
[Fri Aug 28 17:16:46 2020]  libiscsi(E) sunrpc(E)
scsi_transport_iscsi(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E)
xor(E) zstd_compress(E) raid6_pq(E) dm_thin_pool(E)
dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) uas(E)
usbmouse(E) usb_storage(E) hid_generic(E) usbkbd(E) usbhid(E) hid(E)
i2c_piix4(E) ixgbe(E) xfrm_algo(E) dca(E) mdio(E) r8169(E) realtek(E)
ahci(E) libahci(E) wmi(E) video(E) gpio_amdpt(E) gpio_generic(E)
[Fri Aug 28 17:16:46 2020] CR2: ffffffffffffffb8
[Fri Aug 28 17:16:46 2020] ---[ end trace e2af4be9abde7025 ]---
[Fri Aug 28 17:16:46 2020] RIP: 0010:hrtimer_nanosleep+0x9c/0x190
[Fri Aug 28 17:16:46 2020] Code: 39 c8 0f 8f e1 00 00 00 48 69 c0 00 ca
9a 3b 48 01 d0 48 89 c2 48 89 45 b0 4c 01 e2 0f 88 8d 00 00 00 48 39 c2
0f 8c 84 00 00 <00> 48 b8 ff ff ff ff ff ff ff 7f 48 39 f2 48 0f 4c d0
89 de 4c 89
[Fri Aug 28 17:16:46 2020] RSP: 0018:ffffac97812a3e88 EFLAGS: 00010286
[Fri Aug 28 17:16:46 2020] RAX: 0000000000000000 RBX: 0000000000000001
RCX: 0000000000000000
[Fri Aug 28 17:16:46 2020] RDX: ffff97092e81dfc0 RSI: 0000000000000000
RDI: ffffac97812a3e88
[Fri Aug 28 17:16:46 2020] RBP: ffffac97812a3ef8 R08: 0000000000000338
R09: 0000000000000001
[Fri Aug 28 17:16:46 2020] R10: 0000000000000006 R11: ffff970905f54e00
R12: 0000000000000000
[Fri Aug 28 17:16:46 2020] R13: ffffac97812a3e88 R14: ffffac97812a3f08
R15: 0000000000000000
[Fri Aug 28 17:16:46 2020] FS:  00007fb728e5a700(0000)
GS:ffff97092e800000(0000) knlGS:0000000000000000
[Fri Aug 28 17:16:46 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Aug 28 17:16:46 2020] CR2: ffffffffffffffb8 CR3: 00000007c65e8000
CR4: 00000000003406f0

[... continues with iommu ivhd0: AMD-Vi: Event some minutes later,
various other kernel traces etc. and I/O-errors like the following]

[Tue Sep  1 17:28:41 2020] ata7.00: exception Emask 0x0 SAct 0x8180000
SErr 0x0 action 0x6 frozen
[Tue Sep  1 17:28:41 2020] ata7.00: failed command: READ FPDMA QUEUED
[Tue Sep  1 17:28:41 2020] ata7.00: cmd
60/00:98:00:08:00/01:00:00:00:00/40 tag 19 ncq dma 131072 in
                                    res
40/00:00:00:01:80/00:00:00:00:00/00 Emask 0x4 (timeout)
[Tue Sep  1 17:28:41 2020] ata7.00: status: { DRDY }

----------- snip --------------

"device=2b:00.0" is an intel 10GBit ethernet adapter (X550T). So perhaps
there is some driver issue regarding this ethernet adapter?

The system consists of the following components:

- AMD Ryzen 3 3200G, 4x 3.60GHz, boxed (YD3200C5FHBOX)
- ASRock Rack X470D4U2-2T (Mainboard)
- Samsung SSD 970 EVO Plus 250GB, M.2 (MZ-V7S250BW) (builtin SSD for OS)
- 2 * Kingston Server Premier DIMM 16GB, DDR4-2666, CL19-19-19, ECC (BOM
Number: 9965745-002.A00G, Part Number: KSM26ED8/16ME)
- be quiet! Pure Power 11 CM 400W ATX 2.4 (BN296) (Netzteil)
- 2 * Micron 5300 PRO - Read Intensive 960GB, SATA
(MTFDDAK960TDS-1AW1Z6) (SSD for Ceph)
- LogiLink PC0075, 2x RJ-45, PCIe 2.0 x1 (second NIC with two ports)

The system is Linux Debian 10.4 (Proxmox 6.2-4) with kernel 5.4.34-1-pve
#1 SMP PVE 5.4.34-2 (Thu, 07 May 2020 10:02:02 +0200) x86_64 GNU/Linux.

What I did so far:

- Disabled C6 as I read that this CPU-state can lead to unstable systems
(via "python zenstates.py --c6-disable").
- Updated my Bios to the latest version (3.20)
- Checked that the CPU + RAM are compatible to the mainboard (they are
listed as compatible on the ASRock website)
- Checked logs in IPMI (undervoltage, temperature etc., nothing is logged)
- Memory test (memtest86, no errors)

Do you have any clue what could be the reason for these freezes? Should
I think of some hardware error? Or is this some known Linux bug that can
be fixed?

Best Regards,
Hermann

-- 
hermann@qwer.tk
PGP/GPG: 299893C7 (on keyservers)
