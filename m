Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000BC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077A920663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrhdsM1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgCPIp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:45:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44135 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgCPIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:45:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id b186so13157962lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbPOrLTDflRMIXVCgXxGt3q4D6fBoL1+kTbcT/fs+e8=;
        b=NrhdsM1O5fuk70cIcP925XOSaLKArpCNd7ZChK0c1kQrVnfRjdFve4BkF/rxpafkvc
         ff5Xkv+Xb5Gpwgk7ChlQvnko2S2PJ89ynzcnhg4rTvummOH2nr1fAJnoMvv3ORddLqTt
         VCw1Xm23BWbjzVcRrPIU97wnn0JiPZxwdL/cHn0UCaYL9ODZd6QWtKBuzWETJ6VlFpyH
         8x6VTLvKjb0eQvf+St3qY35Xp9n/EF29UBcs3REgtKASSoDuWTEU13ZjeLvf1d9WQ+3D
         aAOvnj3vpI1JpLzH7l5q/P+CrsGmDpQBTR1VVOn3nr2rjgCwyrCXmj+JNIx7DsAqPW08
         Iimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbPOrLTDflRMIXVCgXxGt3q4D6fBoL1+kTbcT/fs+e8=;
        b=po0+p3p9qvx/x7p6bGl0b93ZwLBB+6AlMrrQsQrw1jkMYooGji8SyThFtD/WqBBru0
         XxzxkL2zMX0/iM0z5spJbI6BVFhbveYitmpUmE3FFZ2uDa26KQYCDNmURZ5BTQkdvlUK
         o12hgMS1u1SnteBZ88etxBKntPxHWywRP4ndZwYOEsTSf6sr9PPzexAjUt5eI+Dz69iR
         NkM+JC5q/TiC8t6FORq/gEzR/Bdm1pOqQCTjahs0Wv41uPIXziTtp+nyYrfbnoM1FaSD
         uUwKwjI0UWSh92etIXUeMNyKSHeccmAjcFin4+gl9PLhhCVuVbg5KH91A5MINaIp34IN
         abmQ==
X-Gm-Message-State: ANhLgQ2cUxUlw0OHHUvcZFGUXGOtbHMlNE92HpzxXOgribvhGa3VwS02
        NzQrs+XuHhkFjgFKJSfwJk6VXyUiFXnM9FD1Mbj7zg==
X-Google-Smtp-Source: ADFU+vvW3hiCzm1lUutqZ11zdckt3xuMIygrF8Z+L9edgJDTIy9KtXNnlIt5x8fcAg1u04wt6PZMDgbDq29UnCi4v9I=
X-Received: by 2002:a19:6d0d:: with SMTP id i13mr16203783lfc.105.1584348352715;
 Mon, 16 Mar 2020 01:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
 <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
 <20200226164206.GA10128@bogus> <60024e70-0abc-4a06-cd14-42c61a2d2597@gmail.com>
In-Reply-To: <60024e70-0abc-4a06-cd14-42c61a2d2597@gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 16 Mar 2020 09:45:41 +0100
Message-ID: <CADYN=9+kVpW_n8drzbKWn1gEn270mj5dmR95+4B9GbU6n-cK3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     robh@kernel.org, atull@kernel.org, devicetree@vger.kernel.org,
        geert+renesas@glider.be,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pantelis.antoniou@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 17:40, Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Anders,
>
> On 3/13/20 4:51 AM, Anders Roxell wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> >> On Thu, 20 Feb 2020 12:40:20 -0600, frowand.list@gmail.com wrote:
> >>> From: Frank Rowand <frank.rowand@sony.com>
> >>>
> >>> Geert reports that gpio hog nodes are not properly processed when
> >>> the gpio hog node is added via an overlay reply and provides an
> >>> RFC patch to fix the problem [1].
> >>>
> >>> Add a unittest that shows the problem.  Unittest will report "1 failed"
> >>> test before applying Geert's RFC patch and "0 failed" after applying
> >>> Geert's RFC patch.
> >>>
> >>> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
> >>>
> >>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >
> > I'm building arm64 on tag next-20200312, and booting in qemu, and I see
> > this "Kernel panic":
>
> Thank you for the panic report.
>
> There has also been an x86_64 failure (with a very different stack trace).
> I am going to investigate the x86_64 failure first.

OK.

>
> Can you please send the kernel .config?

https://s3.amazonaws.com/builds.tuxbuild.com/43BB3Qry46bSzMK82iPbBg/kernel.config


Cheers,
Anders

>
> Thanks,
>
> Frank
>
>
> >
> > [...]
> > [  172.779435][    T1] systemd[1]: Mounted POSIX Message Queue File System.
> > [[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
> > [  172.844551][    T1] systemd[1]: Mounted Huge Pages File System.
> > [[0;32m  OK  [0m] Mounted Huge Pages File System.
> > [  172.917332][    T1] systemd[1]: Mounted Debug File System.
> > [[0;32m  OK  [0m] Mounted Debug File System.
> > [  173.465694][  T251] _warn_unseeded_randomness: 6 callbacks suppressed
> > [  173.465803][  T251] random: get_random_u64 called from arch_mmap_rnd+0x94/0xb0 with crng_init=1
> > [  173.466000][  T251] random: get_random_u64 called from randomize_stack_top+0x4c/0xb0 with crng_init=1
> > [  173.466163][  T251] random: get_random_u32 called from arch_align_stack+0x6c/0x88 with crng_init=1
> > [  173.544157][    T1] systemd[1]: Started Create Static Device Nodes in /dev.
> > [[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
> > [  174.283422][  T240] Unable to handle kernel paging request at virtual address 978061b552800000
> > [  174.286169][  T240] Mem abort info:
> > [  174.303268][  T240]   ESR = 0x96000004
> > [  174.304652][  T240]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  174.323298][  T240]   SET = 0, FnV = 0
> > [  174.324677][  T240]   EA = 0, S1PTW = 0
> > [  174.325937][  T240] Data abort info:
> > [  174.345383][  T240]   ISV = 0, ISS = 0x00000004
> > [  174.359310][  T240]   CM = 0, WnR = 0
> > [  174.360641][  T240] [978061b552800000] address between user and kernel address ranges
> > [  174.378712][  T240] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [  174.381030][  T240] Modules linked in:
> > [  174.382362][  T240] CPU: 0 PID: 240 Comm: systemd-journal Tainted: G    B   W         5.6.0-rc5-next-20200312-00018-g5c00c2e7cf27 #6
> > [  174.386251][  T240] Hardware name: linux,dummy-virt (DT)
> > [  174.388056][  T240] pstate: 40400005 (nZcv daif +PAN -UAO)
> > [  174.389892][  T240] pc : sysfs_kf_seq_show+0x114/0x250
> > [  174.391638][  T240] lr : sysfs_kf_seq_show+0x114/0x250
> > [  174.393325][  T240] sp : ffff00006374faa0
> > [  174.394697][  T240] x29: ffff00006374faa0 x28: ffff000062620040
> > [  174.396751][  T240] x27: ffff000062b0a010 x26: 978061b552800000
> > [  174.398779][  T240] x25: ffff000068aae020 x24: ffff000068aae010
> > [  174.400798][  T240] x23: ffff00006311c000 x22: ffff000064f4f800
> > [  174.402794][  T240] x21: 0000000000001000 x20: ffff000068aae008
> > [  174.404820][  T240] x19: 0000000000001000 x18: 0000000000000000
> > [  174.406792][  T240] x17: 0000000000000000 x16: 0000000000000000
> > [  174.408814][  T240] x15: 0000000000000000 x14: 0000000000000000
> > [  174.410805][  T240] x13: ffff80000c623a00 x12: 1fffe0000c623800
> > [  174.412829][  T240] x11: 1fffe0000c6239ff x10: ffff80000c6239ff
> > [  174.414821][  T240] x9 : 0000000000000000 x8 : ffff00006311d000
> > [  174.416865][  T240] x7 : 0000000000000000 x6 : 000000000000003f
> > [  174.418907][  T240] x5 : 0000000000000040 x4 : 000000000000002d
> > [  174.420932][  T240] x3 : ffffa000109a1274 x2 : 0000000000000001
> > [  174.422924][  T240] x1 : ffffa00016010000 x0 : 0000000000000000
> > [  174.424954][  T240] Call trace:
> > [  174.426097][  T240]  sysfs_kf_seq_show+0x114/0x250
> > [  174.427769][  T240]  kernfs_seq_show+0xa4/0xb8
> > [  174.429306][  T240]  seq_read+0x3a4/0x8e8
> > [  174.430678][  T240]  kernfs_fop_read+0x8c/0x6e0
> > [  174.432244][  T240]  __vfs_read+0x64/0xc0
> > [  174.433622][  T240]  vfs_read+0x158/0x2b0
> > [  174.435014][  T240]  ksys_read+0xfc/0x1e0
> > [  174.436427][  T240]  __arm64_sys_read+0x50/0x60
> > [  174.437944][  T240]  el0_svc_common.constprop.1+0x294/0x330
> > [  174.439795][  T240]  do_el0_svc+0xe4/0x100
> > [  174.441218][  T240]  el0_svc+0x70/0x80
> > [  174.442550][  T240]  el0_sync_handler+0xd0/0x7b4
> > [  174.444143][  T240]  el0_sync+0x164/0x180
> > [  174.445578][  T240] Code: aa1703e0 97f6e03a aa1a03e0 97f6e880 (f9400355)
> > [  174.447885][  T240] ---[ end trace 5bcb796ff4270d74 ]---
> > [  174.449629][  T240] Kernel panic - not syncing: Fatal exception
> > [  174.451590][  T240] Kernel Offset: disabled
> > [  174.453005][  T240] CPU features: 0x80002,20002004
> > [  174.454597][  T240] Memory Limit: none
> > [  174.455955][  T240] ---[ end Kernel panic - not syncing: Fatal exception ]---
> >
> > When I say CONFIG_OF_UNITTEST=n it works.
> > If I revert there it starts to work when I revert the last one,
> > f4056e705b2e, from the list below:
> >
> > 485bb19d0b3e of: unittest: make gpio overlay test dependent on CONFIG_OF_GPIO
> > 0ac174397940 of: unittest: annotate warnings triggered by unittest
> > f4056e705b2e of: unittest: add overlay gpio test to catch gpio hog problem
> >
> > Cheers,
> > Anders
> >
> >>> ---
> >>>
> >>> changes since v1:
> >>>   - base on 5.6-rc1
> >>>   - fixed node names in overlays
> >>>   - removed unused fields from struct unittest_gpio_dev
> >>>   - of_unittest_overlay_gpio() cleaned up comments
> >>>   - of_unittest_overlay_gpio() moved saving global values into
> >>>     probe_pass_count and chip_request_count more tightly around
> >>>     test code expected to trigger changes in the global values
> >>>
> >>> v1 of this patch incorrectly reported that it had made changes
> >>> since the RFC version, but it was mistakenly created from the
> >>> wrong branch.
> >>>
> >>> There are checkpatch warnings.
> >>>   - New files are in a directory already covered by MAINTAINERS
> >>>   - The undocumented compatibles are restricted to use by unittest
> >>>     and should not be documented under Documentation
> >>>   - The printk() KERN_<LEVEL> warnings are false positives.  The level
> >>>     is supplied by a define parameter instead of a hard coded constant
> >>>   - The lines over 80 characters are consistent with unittest.c style
> >>>
> >>> This unittest was also valuable in that it allowed me to explore
> >>> possible issues related to the proposed solution to the gpio hog
> >>> problem.
> >>>
> >>>
> >>>  drivers/of/unittest-data/Makefile             |   8 +-
> >>>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
> >>>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
> >>>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
> >>>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
> >>>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
> >>>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
> >>>  drivers/of/unittest.c                         | 253 ++++++++++++++++++++++++++
> >>>  8 files changed, 370 insertions(+), 1 deletion(-)
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
> >>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
> >>>
> >>
> >> Applied, thanks.
> >>
> >> Rob
> >
> >
>
