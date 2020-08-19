Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C456C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554B82078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHSTWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:22:32 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:42204 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgHSTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:22:29 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 19 Aug 2020 12:22:23 -0700
Received: from [0.0.0.0] (oddjob.vmware.com [10.253.4.32])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 29D0040475;
        Wed, 19 Aug 2020 12:22:24 -0700 (PDT)
Subject: Re: [vmwgfx] Xwayland crash on latest linus git
To:     <jongman.heo@samsung.com>,
        "linux-graphics-maintainer@vmware.com" 
        <linux-graphics-maintainer@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20200819074713epcms1p1b60d663694e96a0945327b1fba1e3483@epcms1p1>
 <20200819074713epcms1p1b60d663694e96a0945327b1fba1e3483@epcms1p1>
From:   Roland Scheidegger <sroland@vmware.com>
Message-ID: <c223a0d7-0a6e-e6ed-6471-2b77c7af952f@vmware.com>
Date:   Wed, 19 Aug 2020 21:22:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819074713epcms1p1b60d663694e96a0945327b1fba1e3483@epcms1p1>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: sroland@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm now able to reproduce this, looking into it. (The crash looks
actually similar to what was also happening with the next commit,
drm/ttm: make TT creation purely optional v3, but that got reverted
already.)

Roland


Am 19.08.20 um 09:47 schrieb 허종만:
> 
> Hi,
> 
> 
> I'm running Linux guest OS (Fedora 33 + custom build kernel) on Windows 10 host, with VMWare workstation.
> 
> Kernel 5.8 was fine, but latest linus git kernel has a problem, Xwayland crashes. 
> 
> Gnome login screen is Ok, but when I try login, crash occurs.
> 
> I just see black screen, cannot see graphic screen after the login screen.
> 
> 
>  * If I disable 3D accelaration from VMWare setting, then this issue doesn't occur
> 
> 
> git bisect log follows;
> 
> =================================================================================
> # git bisect log
> git bisect start '--' 'drivers/gpu/drm'
> # bad: [18445bf405cb331117bc98427b1ba6f12418ad17] Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> git bisect bad 18445bf405cb331117bc98427b1ba6f12418ad17
> # good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
> git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
> # good: [026c396b41a4c9412f6f2b6496077949ea99e3ad] drm/amdgpu: add ih ip block for navy_flounder
> git bisect good 026c396b41a4c9412f6f2b6496077949ea99e3ad
> # bad: [395be0f47a001a975d25a3e2a0bfe4f08ee193fa] Merge tag 'drm/tegra/for-5.9-rc1' of ssh://git.freedesktop.org/git/tegra/linux into drm-next
> git bisect bad 395be0f47a001a975d25a3e2a0bfe4f08ee193fa
> # good: [d524b87f77364db096855d7eb714ffacec974ddf] drm/i915: Update DRIVER_DATE to 20200702
> git bisect good d524b87f77364db096855d7eb714ffacec974ddf
> # bad: [3ffff3c6855bda1b39eae88f3730d2baddce3bfd] Merge tag 'drm-misc-next-2020-07-16' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect bad 3ffff3c6855bda1b39eae88f3730d2baddce3bfd
> # bad: [247c12fcba30ecb9473fe6b6c0375d46916417c9] drm/vc4: Reorder the bind order of the devices
> git bisect bad 247c12fcba30ecb9473fe6b6c0375d46916417c9
> # bad: [04f08f8831779e91fc59570dbbd3b7815c229d92] drm/ingenic-drm: drop use of legacy drm_bus_flags
> git bisect bad 04f08f8831779e91fc59570dbbd3b7815c229d92
> # good: [60e9eabf41fa916d2ef68c5bf929197975917578] Backmerge remote-tracking branch 'drm/drm-next' into drm-misc-next
> git bisect good 60e9eabf41fa916d2ef68c5bf929197975917578
> # bad: [35205ee9ba46dcb2a82dbb981ec5fb242c4d847d] drm/i915: Send hotplug event if edid had changed
> git bisect bad 35205ee9ba46dcb2a82dbb981ec5fb242c4d847d
> # bad: [3f1f6981afed9fa21efa12ce396b35ca684b8a29] drm: pl111: Credit where credit is due
> git bisect bad 3f1f6981afed9fa21efa12ce396b35ca684b8a29
> # bad: [2ddef17678bc2ea1d20517dd2b4ed4aa967ffa8b] drm/ttm: make TT creation purely optional v3
> git bisect bad 2ddef17678bc2ea1d20517dd2b4ed4aa967ffa8b
> # bad: [58e4d686d456c3e356439ae160ff4a0728940b8e] drm/ttm: cleanup ttm_mem_type_manager_func.get_node interface v3
> git bisect bad 58e4d686d456c3e356439ae160ff4a0728940b8e
> # first bad commit: [58e4d686d456c3e356439ae160ff4a0728940b8e] drm/ttm: cleanup ttm_mem_type_manager_func.get_node interface v3
> =================================================================================
> 
> But I can't revert first bad commit, 58e4d686d456, due to conflict. So I couldn't test it with the commit reverted.
> Also, there was another issue, boot crash [1], which is now fixed. 
> But I'm afraid it affects git bisect result.
> 
> [1] https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg828262.html&amp;data=02%7C01%7Csroland%40vmware.com%7C47c14d644bc2401449bf08d8441419ba%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637334200428210022&amp;sdata=uky0qUPe9dYnChyx9aHzOyHg1a12xaLQIUmMqOkigfk%3D&amp;reserved=0
> 
> Among above bad commits, followings are marked bad due to the boot crash, not the Xwayland crash.
> 
>     395be0f47a001a975d25a3e2a0bfe4f08ee193fa
>     3ffff3c6855bda1b39eae88f3730d2baddce3bfd
>     247c12fcba30ecb9473fe6b6c0375d46916417c9
>     04f08f8831779e91fc59570dbbd3b7815c229d92
>     35205ee9ba46dcb2a82dbb981ec5fb242c4d847d
>     3f1f6981afed9fa21efa12ce396b35ca684b8a29
>     2ddef17678bc2ea1d20517dd2b4ed4aa967ffa8b
> 
> 
> And following is journalctl log.
> 
> ===================================================================================
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: VMware: vmw_ioctl_command error Cannot allocate memory.
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE)
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) Backtrace:
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 0: /usr/bin/Xwayland (XNFreallocarray+0xb9) [0x562e51c93bb>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 1: /lib64/libpthread.so.0 (funlockfile+0x60) [0x7fb5661702>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 2: /lib64/libc.so.6 (gsignal+0x145) [0x7fb565fcbbc5]
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 3: /lib64/libc.so.6 (abort+0x116) [0x7fb565fb48a4]
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 4: /usr/lib64/dri/vmwgfx_dri.so (nouveau_drm_screen_create>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 5: /usr/lib64/dri/vmwgfx_dri.so (nouveau_drm_screen_create>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 6: /usr/lib64/dri/vmwgfx_dri.so (nouveau_drm_screen_create>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 7: /usr/lib64/dri/vmwgfx_dri.so (nouveau_drm_screen_create>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 8: /usr/lib64/dri/vmwgfx_dri.so (__driDriverGetExtensions_>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 9: /usr/lib64/dri/vmwgfx_dri.so (__driDriverGetExtensions_>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 10: /usr/lib64/dri/vmwgfx_dri.so (__driDriverGetExtensions>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 11: /usr/lib64/dri/vmwgfx_dri.so (__driDriverGetExtensions>
> Aug 14 15:26:39 localhost.localdomain kernel: ioremap: invalid physical address f91ab40ed1340000
> Aug 14 15:26:39 localhost.localdomain kernel: ------------[ cut here ]------------
> Aug 14 15:26:39 localhost.localdomain kernel: WARNING: CPU: 6 PID: 1093 at arch/x86/mm/ioremap.c:198 __ioremap_caller.cold+0x47/0x65
> Aug 14 15:26:39 localhost.localdomain kernel: Modules linked in:
> Aug 14 15:26:39 localhost.localdomain kernel: CPU: 6 PID: 1093 Comm: Xwayland Not tainted 5.8.0+ #108
> Aug 14 15:26:39 localhost.localdomain kernel: Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, >
> Aug 14 15:26:39 localhost.localdomain kernel: RIP: 0010:__ioremap_caller.cold+0x47/0x65
> Aug 14 15:26:39 localhost.localdomain kernel: Code: e9 d7 fa ff ff 89 c6 48 c7 c7 a8 27 85 b5 45 31 e4 e8 49 0b 0d 00 e9 5d fa ff ff>
> Aug 14 15:26:39 localhost.localdomain kernel: RSP: 0018:ffffa973414e7938 EFLAGS: 00010282
> Aug 14 15:26:39 localhost.localdomain kernel: RAX: 0000000000000032 RBX: 0000000000000002 RCX: 0000000000000000
> Aug 14 15:26:39 localhost.localdomain kernel: RDX: ffff91ab7cba6ae0 RSI: ffff91ab7cb98900 RDI: ffff91ab7cb98900
> Aug 14 15:26:39 localhost.localdomain kernel: RBP: f91ab40ed1340000 R08: 0000000000000001 R09: 0000000000000694
> Aug 14 15:26:39 localhost.localdomain kernel: R10: 0000000000026680 R11: 0000000000000003 R12: ffff91aaf5c13000
> Aug 14 15:26:39 localhost.localdomain kernel: R13: 0000000001000000 R14: ffffa973414e7a38 R15: ffffffffb49ababa
> Aug 14 15:26:39 localhost.localdomain kernel: FS:  00007fb56585d5c0(0000) GS:ffff91ab7cb80000(0000) knlGS:0000000000000000
> Aug 14 15:26:39 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 14 15:26:39 localhost.localdomain kernel: CR2: 0000562e529a90f8 CR3: 0000000095374001 CR4: 00000000003706e0
> Aug 14 15:26:39 localhost.localdomain kernel: Call Trace:
> Aug 14 15:26:39 localhost.localdomain kernel:  ? vmw_ttm_unbind+0x60/0x60
> Aug 14 15:26:39 localhost.localdomain kernel:  ttm_mem_reg_ioremap+0xea/0xf0
> Aug 14 15:26:39 localhost.localdomain kernel:  ttm_bo_move_memcpy+0x147/0x600
> Aug 14 15:26:39 localhost.localdomain kernel:  ttm_bo_handle_move_mem+0x5ce/0x5e0
> Aug 14 15:26:39 localhost.localdomain kernel:  ttm_bo_validate+0x144/0x160
> Aug 14 15:26:39 localhost.localdomain kernel:  vmw_validation_bo_validate_single+0x5b/0xa0
> Aug 14 15:26:39 localhost.localdomain kernel:  vmw_validation_bo_validate+0xa9/0xf0
> Aug 14 15:26:39 localhost.localdomain kernel:  ? ttm_eu_reserve_buffers+0xfa/0x2d0
> Aug 14 15:26:39 localhost.localdomain kernel:  vmw_execbuf_process+0x696/0x1120
> Aug 14 15:26:39 localhost.localdomain kernel:  ? pat_enabled+0x10/0x10
> Aug 14 15:26:39 localhost.localdomain kernel:  ? insert_pfn+0xe6/0x2c0
> Aug 14 15:26:39 localhost.localdomain kernel:  vmw_execbuf_ioctl+0x7c/0x150
> Aug 14 15:26:39 localhost.localdomain kernel:  ? vmw_execbuf_release_pinned_bo+0x50/0x50
> Aug 14 15:26:39 localhost.localdomain kernel:  drm_ioctl_kernel+0x86/0xd0
> Aug 14 15:26:39 localhost.localdomain kernel:  ? do_wp_page+0x1a9/0x720
> Aug 14 15:26:39 localhost.localdomain kernel:  drm_ioctl+0x20f/0x39a
> Aug 14 15:26:39 localhost.localdomain kernel:  ? vmw_execbuf_release_pinned_bo+0x50/0x50
> Aug 14 15:26:39 localhost.localdomain kernel:  ? do_user_addr_fault+0x1cc/0x3ed
> Aug 14 15:26:39 localhost.localdomain kernel:  __x64_sys_ioctl+0x83/0xb0
> Aug 14 15:26:39 localhost.localdomain kernel:  do_syscall_64+0x33/0x40
> Aug 14 15:26:39 localhost.localdomain kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Aug 14 15:26:39 localhost.localdomain kernel: RIP: 0033:0x7fb56608658b
> Aug 14 15:26:39 localhost.localdomain kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b>
> Aug 14 15:26:39 localhost.localdomain kernel: RSP: 002b:00007ffd0e2b4988 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Aug 14 15:26:39 localhost.localdomain kernel: RAX: ffffffffffffffda RBX: 00007ffd0e2b4a10 RCX: 00007fb56608658b
> Aug 14 15:26:39 localhost.localdomain kernel: RDX: 00007ffd0e2b4a10 RSI: 000000004028644c RDI: 000000000000000e
> Aug 14 15:26:39 localhost.localdomain kernel: RBP: 000000004028644c R08: 0000000000000000 R09: 0000000000000002
> Aug 14 15:26:39 localhost.localdomain kernel: R10: 0000562e521dead8 R11: 0000000000000246 R12: 0000000000000028
> Aug 14 15:26:39 localhost.localdomain kernel: R13: 000000000000000e R14: 00007ffd0e2b4a10 R15: 0000000000000001
> Aug 14 15:26:39 localhost.localdomain kernel: ---[ end trace 28b9197fbfdd95be ]---
> Aug 14 15:26:39 localhost.localdomain kernel: ioremap: invalid physical address f91ab40ed1340000
> Aug 14 15:26:39 localhost.localdomain audit[1093]: ANOM_ABEND auid=4294967295 uid=42 gid=42 ses=4294967295 pid=1093 comm="Xwayland" >
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 12: /usr/lib64/dri/vmwgfx_dri.so (__driDriverGetExtensions>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 13: /usr/bin/Xwayland (fbClearVisualTypes+0x1c79) [0x562e5>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 14: /usr/bin/Xwayland (glamor_destroy_gc+0x508c) [0x562e51>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 15: /usr/bin/Xwayland (QueryColors+0x4f17) [0x562e51c52eb7]
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 16: /usr/bin/Xwayland (SetPictureClipRects+0x223c) [0x562e>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 17: /usr/bin/Xwayland (ReplyNotSwappd+0x184e) [0x562e51b36>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 18: /lib64/libc.so.6 (__libc_start_main+0xf2) [0x7fb565fb6>
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) 19: /usr/bin/Xwayland (_start+0x2e) [0x562e51b364ee]
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE)
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE)
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: Fatal server error:
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE) Caught signal 6 (Aborted). Server aborting
> Aug 14 15:26:39 localhost.localdomain org.gnome.Shell.desktop[1093]: (EE)
> ===================================================================================
> 

