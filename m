Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C98C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BFA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bXUKKyiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgGOIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:42:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37663 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgGOImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:42:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200715084238euoutp02af3b94f4079ad24bedecdae096004b73~h4Hob8pqM2066120661euoutp02i
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:42:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200715084238euoutp02af3b94f4079ad24bedecdae096004b73~h4Hob8pqM2066120661euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594802558;
        bh=KM8YgZ+fT1a3O88ya1V5o/yuqDq8janedF7eqcG3A1w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bXUKKyiONFqzBuk+zRy0UrbFN7lKfnLmpIlPuTAoZsP2tjRXrWuI50nyBwksr3JIb
         9EbKml2xNtU5h6A4pt4CMGylQfKk23wtj7CkZ5ek5tsftKgxei7iknB45ICE66nUWa
         cLCs8Elj/+xo1FUFrQyqRotjHTDQCV/PpPBGflJI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200715084237eucas1p1387076b08ef8947e073afdbd0c2181d1~h4HoEknZg0960309603eucas1p1I;
        Wed, 15 Jul 2020 08:42:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.11.06456.D71CE0F5; Wed, 15
        Jul 2020 09:42:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200715084237eucas1p200265492474bf29401ff34ab61470e3b~h4HnumfSW2810728107eucas1p2n;
        Wed, 15 Jul 2020 08:42:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200715084237eusmtrp19db5c4b409ea2e1098bd45ed0ff401c3~h4Hnt6C631120111201eusmtrp1a;
        Wed, 15 Jul 2020 08:42:37 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-d6-5f0ec17da2c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.65.06314.D71CE0F5; Wed, 15
        Jul 2020 09:42:37 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200715084236eusmtip2a00501bc84fd4b3dca7a6a4bbb148fd4~h4HnQvD4J1891418914eusmtip2V;
        Wed, 15 Jul 2020 08:42:36 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Fix error path in gadget registration
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ad121efc-44a2-143a-84d3-afb0db03419f@samsung.com>
Date:   Wed, 15 Jul 2020 10:42:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <40bfbfd6-6516-5995-8250-c8e3df16e11e@synopsys.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87q1B/niDebd0rTYOGM9q8Wxtifs
        Fs2L17NZXN41h81i0bJWZot3U24zO7B5bFrVyeaxf+4ado++LasYPbbs/8zo8XmTXABrFJdN
        SmpOZllqkb5dAlfGo19vWQrmelc8/rWTtYFxhlMXIyeHhICJxN7e2UxdjFwcQgIrGCU+Lt/E
        BuF8YZS4tuovI0iVkMBnRonTdwJhOg53HmOBKFrOKPF3bxMzhPOeUWJy72NWkCphAVeJfa9e
        s4HYIgKFEi/eHgfrYBY4yyhxs2s7E0iCTcBQouttF1gRr4CdRN+JhewgNouAqkT7zE9gg0QF
        4iTWv4So5xUQlDg58wkLiM0p4CDRun0PM4jNLCAv0bx1NpQtLnHryXywhyQEVrFL3Jzdywpx
        t4vEz56pULawxKvjW9ghbBmJ05N7WCAamhklHp5byw7h9DBKXG6awQhRZS1x59wvoFM5gFZo
        SqzfpQ8RdpTof/KNESQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAq
        zULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCaf0/+Of9rB
        +PVS0iFGAQ5GJR5ei+m88UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgXHitL8PyjWWPntsMOevjaTXDE0Wnlcqm59O
        U3dbribq8vXXDo2Xf/ovrNG59eWAhtmfB2X338k5PVnz8e/iFzWxRnOmb0m2bGj1e/pbq+/A
        HX3hn7ndGp8TtvV3T15/b6K36OJlctbTvecrP1u2rPKXWattqnZ40pzbiWdDBD1s7nY+5/y2
        /+dyJZbijERDLeai4kQAieYEaDoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7q1B/niDVb9FbDYOGM9q8Wxtifs
        Fs2L17NZXN41h81i0bJWZot3U24zO7B5bFrVyeaxf+4ado++LasYPbbs/8zo8XmTXABrlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Go19vWQrm
        elc8/rWTtYFxhlMXIyeHhICJxOHOYyxdjFwcQgJLGSX6vx5hh0jISJyc1sAKYQtL/LnWxQZR
        9JZRomnCd7CEsICrxL5Xr9lAbBGBQomV3RfBipgFzjNKTD/ykREkISRwnFFiyqtSEJtNwFCi
        620XWAOvgJ1E34mFYNtYBFQl2md+AhsqKhAnsXzLfHaIGkGJkzOfsIDYnAIOEq3b9zCD2MwC
        ZhLzNj+EsuUlmrfOhrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE
        3OLSvHS95PzcTYzAaNt27OfmHYyXNgYfYhTgYFTi4Z0wkzdeiDWxrLgy9xCjBAezkgiv09nT
        cUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wEeSXxhqaG5haWhubG5sZmFkrivB0CB2OE
        BNITS1KzU1MLUotg+pg4OKUaGB3sksQeVXFuXNvo9uSFq/zCLHGLrAQ5/y3v2XiFp803Fl1w
        c8ds8yOvIhbs+pEU03HuX+rlNS8EnijVMHmdCen+MKOAo9OX54vgsrmrPhtkdpyWXG7ewb+J
        ybvrtIfLUtVFHnMfyrq8KnzG9Gx/ae/xmbPK2xbYX2zqKHrBKLfBijvZVUJBWomlOCPRUIu5
        qDgRAD3x8HjMAgAA
X-CMS-MailID: 20200715084237eucas1p200265492474bf29401ff34ab61470e3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
References: <CGME20200714084807eucas1p1f6e680d162573c6a0660037172a65805@eucas1p1.samsung.com>
        <20200714084800.11340-1-m.szyprowski@samsung.com>
        <40bfbfd6-6516-5995-8250-c8e3df16e11e@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 14.07.2020 14:32, Minas Harutyunyan wrote:
> On 7/14/2020 12:48 PM, Marek Szyprowski wrote:
>> When gadget registration fails, one should not call usb_del_gadget_udc().
>> Ensure this by setting gadget->udc to NULL. Also in case of a failure
> I was able to reproduce issue. I'm Ok with this fix.
>
>> there is no need to disable low-level hardware, so return immiedetly
>> instead of jumping to error_init label.
>>
> Why do you think that disable low-level hardware not required which was
> enabled before? Also for some platforms required to call
> regulator_disable() which was enabled earlier in probe function.
> So, I suggest to keep jump to error_init label.

If I keep the jump to error_init label, then there is unbalanced call to 
dwc2_lowlevel_hw_disable(). usb_add_gadget_udc() can fail in 2 places: 
on gadget->bind() or during udc_start(). In the first case, the HW was 
not yet enabled, so there is no need to disable it. In the latter one, 
the error might be returned only from the dwc2_lowlevel_hw_enable(), so 
again there is no need to call dwc2_lowlevel_hw_disable().

If I keep the "goto error_init;" line, I get the following errors:

dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=1
dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter 
g_np_tx_fifo_size=1024
dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
no file given for LUN0
g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
------------[ cut here ]------------
WARNING: CPU: 3 PID: 49 at drivers/clk/clk.c:958 
clk_core_disable+0x1e4/0x314
usb_device already disabled
Modules linked in:
CPU: 3 PID: 49 Comm: kworker/3:1 Not tainted 
5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
[<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
[<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
[<c0126f64>] (warn_slowpath_fmt) from [<c056c338>] 
(clk_core_disable+0x1e4/0x314)
[<c056c338>] (clk_core_disable) from [<c056c480>] 
(clk_core_disable_lock+0x18/0x24)
[<c056c480>] (clk_core_disable_lock) from [<c073f9d4>] 
(__dwc2_lowlevel_hw_disable+0x3c/0xa0)
[<c073f9d4>] (__dwc2_lowlevel_hw_disable) from [<c0740188>] 
(dwc2_driver_probe+0x2d4/0x6ac)
[<c0740188>] (dwc2_driver_probe) from [<c0653640>] 
(platform_drv_probe+0x6c/0xa4)
[<c0653640>] (platform_drv_probe) from [<c0650bdc>] 
(really_probe+0x200/0x4fc)
[<c0650bdc>] (really_probe) from [<c0651040>] 
(driver_probe_device+0x78/0x1fc)
[<c0651040>] (driver_probe_device) from [<c064ea78>] 
(bus_for_each_drv+0x74/0xb8)
[<c064ea78>] (bus_for_each_drv) from [<c065093c>] 
(__device_attach+0xd4/0x16c)
[<c065093c>] (__device_attach) from [<c064fa3c>] 
(bus_probe_device+0x88/0x90)
[<c064fa3c>] (bus_probe_device) from [<c064ff54>] 
(deferred_probe_work_func+0x3c/0xd0)
[<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>] 
(process_one_work+0x234/0x7dc)
[<c0148a5c>] (process_one_work) from [<c0149048>] (worker_thread+0x44/0x51c)
[<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
[<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee923fb0 to 0xee923ff8)
...
irq event stamp: 36966
hardirqs last  enabled at (36965): [<c02b92d8>] kfree+0x1a4/0x3f0
hardirqs last disabled at (36966): [<c0569edc>] clk_enable_lock+0x14/0x134
softirqs last  enabled at (36814): [<c010174c>] __do_softirq+0x50c/0x608
softirqs last disabled at (36803): [<c0130218>] irq_exit+0x168/0x16c
---[ end trace f55f4b28f3080c12 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 49 at drivers/clk/clk.c:817 
clk_core_unprepare+0x33c/0x470
usb_device already unprepared
Modules linked in:
CPU: 3 PID: 49 Comm: kworker/3:1 Tainted: G        W 
5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
[<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
[<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
[<c0126f64>] (warn_slowpath_fmt) from [<c056dcb8>] 
(clk_core_unprepare+0x33c/0x470)
[<c056dcb8>] (clk_core_unprepare) from [<c056de10>] 
(clk_unprepare+0x24/0x2c)
[<c056de10>] (clk_unprepare) from [<c073f9dc>] 
(__dwc2_lowlevel_hw_disable+0x44/0xa0)
[<c073f9dc>] (__dwc2_lowlevel_hw_disable) from [<c0740188>] 
(dwc2_driver_probe+0x2d4/0x6ac)
[<c0740188>] (dwc2_driver_probe) from [<c0653640>] 
(platform_drv_probe+0x6c/0xa4)
[<c0653640>] (platform_drv_probe) from [<c0650bdc>] 
(really_probe+0x200/0x4fc)
[<c0650bdc>] (really_probe) from [<c0651040>] 
(driver_probe_device+0x78/0x1fc)
[<c0651040>] (driver_probe_device) from [<c064ea78>] 
(bus_for_each_drv+0x74/0xb8)
[<c064ea78>] (bus_for_each_drv) from [<c065093c>] 
(__device_attach+0xd4/0x16c)
[<c065093c>] (__device_attach) from [<c064fa3c>] 
(bus_probe_device+0x88/0x90)
[<c064fa3c>] (bus_probe_device) from [<c064ff54>] 
(deferred_probe_work_func+0x3c/0xd0)
[<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>] 
(process_one_work+0x234/0x7dc)
[<c0148a5c>] (process_one_work) from [<c0149048>] (worker_thread+0x44/0x51c)
[<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
[<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee923fb0 to 0xee923ff8)
...
irq event stamp: 37073
hardirqs last  enabled at (37081): [<c019d624>] console_unlock+0x430/0x6cc
hardirqs last disabled at (37108): [<c019d348>] console_unlock+0x154/0x6cc
softirqs last  enabled at (37124): [<c010174c>] __do_softirq+0x50c/0x608
softirqs last disabled at (37135): [<c0130218>] irq_exit+0x168/0x16c
---[ end trace f55f4b28f3080c13 ]---
------------[ cut here ]------------
WARNING: CPU: 3 PID: 49 at drivers/regulator/core.c:2603 
_regulator_disable+0x180/0x1d8
unbalanced disables for VUOTG_3.0V
Modules linked in:
CPU: 3 PID: 49 Comm: kworker/3:1 Tainted: G        W 
5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
[<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
[<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
[<c0126f64>] (warn_slowpath_fmt) from [<c0585e78>] 
(_regulator_disable+0x180/0x1d8)
[<c0585e78>] (_regulator_disable) from [<c0585f04>] 
(regulator_disable+0x34/0xe0)
[<c0585f04>] (regulator_disable) from [<c0587ef8>] 
(regulator_bulk_disable+0x28/0xb0)
[<c0587ef8>] (regulator_bulk_disable) from [<c0740188>] 
(dwc2_driver_probe+0x2d4/0x6ac)
[<c0740188>] (dwc2_driver_probe) from [<c0653640>] 
(platform_drv_probe+0x6c/0xa4)
[<c0653640>] (platform_drv_probe) from [<c0650bdc>] 
(really_probe+0x200/0x4fc)
[<c0650bdc>] (really_probe) from [<c0651040>] 
(driver_probe_device+0x78/0x1fc)
[<c0651040>] (driver_probe_device) from [<c064ea78>] 
(bus_for_each_drv+0x74/0xb8)
[<c064ea78>] (bus_for_each_drv) from [<c065093c>] 
(__device_attach+0xd4/0x16c)
[<c065093c>] (__device_attach) from [<c064fa3c>] 
(bus_probe_device+0x88/0x90)
[<c064fa3c>] (bus_probe_device) from [<c064ff54>] 
(deferred_probe_work_func+0x3c/0xd0)
[<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>] 
(process_one_work+0x234/0x7dc)
[<c0148a5c>] (process_one_work) from [<c0149048>] (worker_thread+0x44/0x51c)
[<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
[<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee923fb0 to 0xee923ff8)
...
irq event stamp: 37243
hardirqs last  enabled at (37251): [<c019d624>] console_unlock+0x430/0x6cc
hardirqs last disabled at (37274): [<c0ac0790>] __schedule+0xd8/0x860
softirqs last  enabled at (37270): [<c010174c>] __do_softirq+0x50c/0x608
softirqs last disabled at (37291): [<c0130218>] irq_exit+0x168/0x16c
---[ end trace f55f4b28f3080c14 ]---
Failed to disable vusb_a: -5
dwc2: probe of 12480000.hsotg failed with error -22
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = (ptrval)
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 3 PID: 87 Comm: kworker/3:2 Tainted: G        W 
5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue:  0x0 (rcu_gp)
PC is at process_one_work+0x44/0x7dc
LR is at 0xedc226d0
...
Process kworker/3:2 (pid: 87, stack limit = 0x(ptrval))
Stack: (0xeda03f00 to 0xeda04000)
...
[<c014886c>] (process_one_work) from [<c0149048>] (worker_thread+0x44/0x51c)
[<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
[<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xeda03fb0 to 0xeda03ff8)
...
---[ end trace f55f4b28f3080c15 ]---
note: kworker/3:2[87] exited with preempt_count 1

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

