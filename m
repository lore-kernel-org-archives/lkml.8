Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F49C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEEA207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aZ2FKdnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHZPCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:02:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52793 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHZPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:02:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200826150240euoutp02e073690fc002f70610499b1eefd31fdf~u2Zb4yj1S0188101881euoutp021
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:02:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200826150240euoutp02e073690fc002f70610499b1eefd31fdf~u2Zb4yj1S0188101881euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598454160;
        bh=AnqgXR1jaSuuRzSKvONAM2hbRlyOfZRnyduwYHQ+Y04=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aZ2FKdnESBQCijAah/OInsG3Wj+Zj4w6znWg/VaVKRoWI934tX0ZrjLeU3YTha9IM
         G1I/pnnPpFflxAufGOv1+mok1LcCcliWrPffdfUsJJQAVjk1wr3Wh7c4xiwj9KJBeF
         GrDYlgIqqe3AI4sl+kxm+r1w6y2FEqV3RHftywWg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826150239eucas1p23d55fb1283b4f7a17777a041069efecb~u2ZbhSg0u2929429294eucas1p2h;
        Wed, 26 Aug 2020 15:02:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.99.06456.F89764F5; Wed, 26
        Aug 2020 16:02:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93~u2ZbEozfT2929429294eucas1p2g;
        Wed, 26 Aug 2020 15:02:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826150239eusmtrp14fe134f37dcf3e4c3f8174afd0fad106~u2ZbD5L6t1852018520eusmtrp1o;
        Wed, 26 Aug 2020 15:02:39 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-13-5f46798f3c6e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.11.06314.F89764F5; Wed, 26
        Aug 2020 16:02:39 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200826150238eusmtip17a0afbc7db4bf0165e046b9bf806f665~u2ZaeJipO2285522855eusmtip14;
        Wed, 26 Aug 2020 15:02:38 +0000 (GMT)
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
Date:   Wed, 26 Aug 2020 17:02:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826134315.GA3882506@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7r9lW7xBh8ua1nMWb+GzWLjjPWs
        FsfanrBbLG29wGzRvHg9m8Wd21+ZLM5051pc3jWHzWLRslZmi0d9b9kduDxmN1xk8dg56y67
        x/UD11g9Nq3qZPM4MeM3i8f+uWvYPfq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvj+YYLrAXN
        NhU/th5hbGBcot/FyMkhIWAi8WPpTeYuRi4OIYEVjBI/fv9igXC+MEr8PzEFKvOZUWJjczc7
        TMu5O2uYIBLLGSVOv/sP1fKeUeLtnq1MIFXCAroSvYc7WEFsEYEoiU0vPjCCFDEL7GeS6Dv5
        jw0kwSZgKNH1tgvM5hWwkzh17TnYChYBVYnTJ2cxgtiiAnESW49fZYKoEZQ4OfMJC4jNCdLb
        dx5sAbOAvETz1tnMELa4xK0n88HOkxC4xi7x4n8zC8TdLhLtVyezQtjCEq+Ob4H6R0bi9OQe
        FoiGZkaJh+fWskM4PYwSl5tmMEJUWUvcOfcL6FQOoBWaEut3QcPPUaLj3BUWkLCEAJ/EjbeC
        EEfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5a
        WpybnlpsmJdarlecmFtcmpeul5yfu4kRmMJO/zv+aQfj10tJhxgFOBiVeHg14t3ihVgTy4or
        cw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKY
        LBMHp1QDo0Gny8efv35Y+ynU3EyYUHdulqS+8pbLGZZi8eX/vMQ297F7B8tF6q2cvcU+rVqh
        cdMCptLkBP5fZ5JUhT9sL1grYSZpVfxv/Y2WpxccQ9OcLoX9XyspfVPAjmlB/KP8u0u1xST9
        YsuDnm/kEFxV8GXJDUYmAeNphV+1XhxV2L3hR22o2OnTSizFGYmGWsxFxYkA6KpVe10DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7r9lW7xBhPe8FrMWb+GzWLjjPWs
        FsfanrBbLG29wGzRvHg9m8Wd21+ZLM5051pc3jWHzWLRslZmi0d9b9kduDxmN1xk8dg56y67
        x/UD11g9Nq3qZPM4MeM3i8f+uWvYPfq2rGL0+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j+YYLrAXNNhU/th5hbGBcot/FyMkhIWAi
        ce7OGqYuRi4OIYGljBLnf3ewQyRkJE5Oa2CFsIUl/lzrYoMoessosaz/AxNIQlhAV6L3cAdY
        kYhAlMTmC39ZQGxmgf1MEv+mCIDYQgIGEn86W9hAbDYBQ4mut11gNq+AncSpa8/BlrEIqEqc
        PjmLEcQWFYiTeNz7nxmiRlDi5MwnYDM5QXr7zrNCzDeTmLf5ITOELS/RvHU2lC0ucevJfKYJ
        jEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG67ZjPzfvYLy0
        MfgQowAHoxIPr0a8W7wQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAj03
        kVlKNDkfmErySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw5k04
        0f5vjsr9iIPGxdGHt1bH3dtX2fn8n1eN0aH8XM/ESway0tp1236eLZp6T6r4aqGsO3PO/dOn
        Z2ovmMjc4bPZ9dPj9PxP8pkSF+dzZqx+kvch7qv8urjk6spjC7Kd1ghue58jVOdhMO+zSM6e
        mdW5mvd/5t6rPNvP/X9x1F7Vgx3tXWJKSizFGYmGWsxFxYkAuELi+u0CAAA=
X-CMS-MailID: 20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93
References: <20200826134315.GA3882506@kroah.com>
        <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 26.08.2020 15:43, Greg KH wrote:
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
>
>    Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
>
> for you to fetch changes up to 23e26d0577535f5ffe4ff8ed6d06e009553c0bca:
>
>    usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures (2020-08-25 16:02:35 +0200)
>
> ----------------------------------------------------------------
> USB fixes for 5.9-rc3
>
> Here are a small set of USB fixes for 5.9-rc3.
>
> Like most set of USB bugfixes, they include the usual:
> 	- usb gadget driver fixes
> 	- xhci driver fixes
> 	- typec fixes
> 	- new qurks and ids
> 	- fixes for USB patches merged in 5.9-rc1
>
> Nothing huge, all of these have been in linux-next with no reported
> issues:
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ----------------------------------------------------------------
> Alan Stern (1):
>        USB: yurex: Fix bad gfp argument
>
> Andy Shevchenko (1):
>        usb: hcd: Fix use after free in usb_hcd_pci_remove()
>
> Badhri Jagan Sridharan (1):
>        usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures
>
> Bastien Nocera (2):
>        USB: Also match device drivers using the ->match vfunc
>        USB: Fix device driver race
>
> Brooke Basile (2):
>        USB: gadget: u_f: add overflow checks to VLA macros

Sorry, but the above patch breaks USB Ethernet Gadget operation. It also 
didn't get the proper testing in linux-next (next-20200826 is the first 
one with this patch).

This is how it explodes on Samsung Exynos (ARM 32bit) based board with 
g_ether module loaded:

------------[ cut here ]------------
kernel BUG at mm/slub.c:4116!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in: usb_f_ecm g_ether(+) usb_f_rndis u_ether libcomposite 
panel_samsung_s6e8aa0 s5p_csis s5p_fimc exynos4_is_common v4l2_fwnode 
max8997_regulator rtc_max8997 leds_max8997 max8
emless mms114 governor_simpleondemand s5p_mfc lima gpu_sched s5p_jpeg 
v4l2_mem2mem videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 
videobuf2_common phy_exynos_usb2 exynosdrm analogix_dp
  s3c2410_wdt
CPU: 0 PID: 616 Comm: modprobe Not tainted 5.9.0-rc1-00026-gb1cd1b65afba 
#9023
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at kfree+0x234/0x268
LR is at config_item_set_name+0x60/0xb0
...
Process modprobe (pid: 616, stack limit = 0x(ptrval))
...
[<c0494248>] (kfree) from [<c05347a0>] (config_item_set_name+0x60/0xb0)
[<c05347a0>] (config_item_set_name) from [<c0534844>] 
(config_group_init_type_name+0x1c/0x50)
[<c0534844>] (config_group_init_type_name) from [<bf14bc18>] 
(usb_os_desc_prepare_interf_dir+0x54/0x124 [libcomposite])
[<bf14bc18>] (usb_os_desc_prepare_interf_dir [libcomposite]) from 
[<bf15af9c>] (rndis_alloc_inst+0x100/0x150 [usb_f_rndis])
[<bf15af9c>] (rndis_alloc_inst [usb_f_rndis]) from [<bf1499dc>] 
(try_get_usb_function_instance+0x88/0xa4 [libcomposite])
[<bf1499dc>] (try_get_usb_function_instance [libcomposite]) from 
[<bf149ad8>] (usb_get_function_instance+0xc/0x44 [libcomposite])
[<bf149ad8>] (usb_get_function_instance [libcomposite]) from 
[<bf114164>] (eth_bind+0xdc/0x34c [g_ether])
[<bf114164>] (eth_bind [g_ether]) from [<bf1497cc>] 
(composite_bind+0x78/0x1a8 [libcomposite])
[<bf1497cc>] (composite_bind [libcomposite]) from [<c0c62a0c>] 
(udc_bind_to_driver+0x60/0x108)
[<c0c62a0c>] (udc_bind_to_driver) from [<c0c62ed8>] 
(usb_gadget_probe_driver+0x100/0x158)
[<c0c62ed8>] (usb_gadget_probe_driver) from [<c0301fd0>] 
(do_one_initcall+0x54/0x220)
[<c0301fd0>] (do_one_initcall) from [<c03de390>] (do_init_module+0x60/0x210)
[<c03de390>] (do_init_module) from [<c03dd0d4>] (load_module+0x2078/0x24c0)
[<c03dd0d4>] (load_module) from [<c03dd758>] (sys_finit_module+0xc8/0xd8)
[<c03dd758>] (sys_finit_module) from [<c03000c0>] 
(ret_fast_syscall+0x0/0x54)
Exception stack(0xedd1dfa8 to 0xedd1dff0)
...
---[ end trace 0dc21d79c1880545 ]---

I also didn't manage to find any mailing list, where this patch has been 
initially posted...


>        USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()
>
> Christophe JAILLET (1):
>        usb: gadget: f_tcm: Fix some resource leaks in some error paths
>
> Ding Hui (1):
>        xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep reset failed
>
> Evgeny Novikov (1):
>        USB: lvtest: return proper error code in probe
>
> Greg Kroah-Hartman (1):
>        Merge tag 'fixes-for-v5.9-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus
>
> Hans de Goede (4):
>        usb: typec: ucsi: Fix AB BA lock inversion
>        usb: typec: ucsi: Fix 2 unlocked ucsi_run_command calls
>        usb: typec: ucsi: Rework ppm_lock handling
>        usb: typec: ucsi: Hold con->lock for the entire duration of ucsi_register_port()
>
> Heikki Krogerus (1):
>        tools: usb: move to tools buildsystem
>
> JC Kuo (2):
>        usb: host: xhci-tegra: otg usb2/usb3 port init
>        usb: host: xhci-tegra: fix tegra_xusb_get_phy()
>
> Kai-Heng Feng (2):
>        USB: quirks: Add no-lpm quirk for another Raydium touchscreen
>        xhci: Do warm-reset when both CAS and XDEV_RESUME are set
>
> Li Jun (1):
>        usb: host: xhci: fix ep context print mismatch in debugfs
>
> M. Vefa Bicakci (1):
>        usbip: Implement a match function to fix usbip
>
> Thinh Nguyen (4):
>        usb: dwc3: gadget: Don't setup more than requested
>        usb: dwc3: gadget: Fix handling ZLP
>        usb: dwc3: gadget: Handle ZLP for sg requests
>        usb: uas: Add quirk for PNY Pro Elite
>
> Tom Rix (1):
>        USB: cdc-acm: rework notification_buffer resizing
>
> Vinod Koul (1):
>        usb: renesas-xhci: remove version check
>
> å‘¨ç°æ° (Zhou Yanjie) (1):
>        USB: PHY: JZ4770: Fix static checker warning.
>
>   drivers/usb/class/cdc-acm.c          |  22 ++++---
>   drivers/usb/core/driver.c            |  40 ++++++++++++-
>   drivers/usb/core/generic.c           |   5 +-
>   drivers/usb/core/hcd-pci.c           |   5 +-
>   drivers/usb/core/quirks.c            |   2 +
>   drivers/usb/dwc3/gadget.c            | 107 +++++++++++++++++++++++++++++------
>   drivers/usb/gadget/function/f_ncm.c  |  81 ++++++++++++++++++++++----
>   drivers/usb/gadget/function/f_tcm.c  |   7 ++-
>   drivers/usb/gadget/u_f.h             |  38 +++++++++----
>   drivers/usb/host/xhci-debugfs.c      |   8 +--
>   drivers/usb/host/xhci-hub.c          |  19 ++++---
>   drivers/usb/host/xhci-pci-renesas.c  |  19 +------
>   drivers/usb/host/xhci-tegra.c        |   4 +-
>   drivers/usb/host/xhci.c              |   3 +-
>   drivers/usb/misc/lvstest.c           |   2 +-
>   drivers/usb/misc/yurex.c             |   2 +-
>   drivers/usb/phy/phy-jz4770.c         |   1 +
>   drivers/usb/storage/unusual_uas.h    |   7 +++
>   drivers/usb/typec/tcpm/tcpm.c        |  28 ++++++++-
>   drivers/usb/typec/ucsi/displayport.c |   9 +--
>   drivers/usb/typec/ucsi/ucsi.c        | 103 +++++++++++++++++----------------
>   drivers/usb/usbip/stub_dev.c         |   6 ++
>   tools/usb/Build                      |   2 +
>   tools/usb/Makefile                   |  53 ++++++++++++++---
>   24 files changed, 408 insertions(+), 165 deletions(-)
>   create mode 100644 tools/usb/Build
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

