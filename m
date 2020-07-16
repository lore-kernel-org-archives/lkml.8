Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF35C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E8D20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fneybB8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGPMDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:03:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58026 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgGPMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:03:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200716120327euoutp02790b5d625e48dc46a6bac7fed2a2f113~iOgQmDrQj1945319453euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200716120327euoutp02790b5d625e48dc46a6bac7fed2a2f113~iOgQmDrQj1945319453euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594901007;
        bh=Dx/x4PyK9ZlwqsswqvNgEBetNV5cgzNuWobXocpwcro=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fneybB8cBTNNbIfEhsh+ro01REnzf12yh7djor5XuVGKHVN/zVgMJp0O/2EXPwar+
         3cSqznsQxG9z/uHoLX/AXDpM1tExhS9weurTw4pAGRux+9lWL4LdYyGvYTVCOJzIGS
         pV104ohE/21m1AYILQfzbFNJxUr7+q6AdTPLH7UI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200716120327eucas1p2c87b5818646c906942711e0cc5ad2eae~iOgQTajQd0939709397eucas1p2W;
        Thu, 16 Jul 2020 12:03:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.4D.06318.F02401F5; Thu, 16
        Jul 2020 13:03:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200716120326eucas1p1c0a76ebefa78876a8a240ea4d3c77f5e~iOgQCC2q52583525835eucas1p1Y;
        Thu, 16 Jul 2020 12:03:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716120326eusmtrp23943d392d0ccf96db2c220b82c400594~iOgQBZfmn1499214992eusmtrp29;
        Thu, 16 Jul 2020 12:03:26 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-10-5f10420fe54d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.15.06314.E02401F5; Thu, 16
        Jul 2020 13:03:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200716120326eusmtip24cda26939667d0133cd147d277ac064b~iOgPj6_ZK0039000390eusmtip2q;
        Thu, 16 Jul 2020 12:03:26 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Fix error path in gadget registration
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <fd2de8d2-99ef-6992-02c2-aded6337d39f@samsung.com>
Date:   Thu, 16 Jul 2020 14:03:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3bfb9bf3-3139-6447-fe0b-25473dabb0a0@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7r8TgLxBpsecllsnLGe1eJY2xN2
        i+bF69ksLu+aw2axaFkrs8W7KbeZHdg8Nq3qZPPYP3cNu0ffllWMHlv2f2b0+LxJLoA1issm
        JTUnsyy1SN8ugSvj1qb/TAWbIyr2z/zG0sD40KeLkZNDQsBE4tWnJ+xdjFwcQgIrGCV2tB9l
        g3C+MEosXLOMFcL5zCjx9Ow0VpiWOY+eMUMkljNKzFv7EarqPaPE+TPnmUCqhAVcJfa9es0G
        YrMJGEp0ve0Cs0UECiVevD3OAtLALHCWUeJm13agBg4OXgE7iR8HLEBqWARUJXbNnMoOYosK
        xEmsf7kdbCavgKDEyZlPWEBsTgF7iY62FrCLmAXkJZq3zmaGsMUlbj2ZzwRx6Tp2icPzmEHG
        Swi4SDQ8soIIC0u8Or6FHcKWkfi/E6ScC8huZpR4eG4tO4TTwyhxuWkGI0SVtcSdc7/YQAYx
        C2hKrN+lDxF2lOh/8o0RYj6fxI23ghAn8ElM2jYdai0v0JlCENVqErOOr4Nbe/DCJeYJjEqz
        kDw2C8kzs5A8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBief0v+NfdzDu
        +5N0iFGAg1GJh7fiN1+8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg7Lp7qzTtt380222OXVaVgrNnNtn1TFlqIHhH
        pu+ayqc7fWGWLhMta31v3jt0fLdBX9eqAzJ7fOfzMBvfv9LT1v5yU9VT2zU5Lx3XfJaZPEdF
        Pdte5Niqlx84ervzjunnP3luXpZfaLbvwpKiVSvClwtsCRL7J7zMjOOo32/lw47iWzLTpd2/
        K7EUZyQaajEXFScCABQah9M4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7p8TgLxBh0dRhYbZ6xntTjW9oTd
        onnxejaLy7vmsFksWtbKbPFuym1mBzaPTas62Tz2z13D7tG3ZRWjx5b9nxk9Pm+SC2CN0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4tek/U8Hm
        iIr9M7+xNDA+9Oli5OSQEDCRmPPoGXMXIxeHkMBSRokj1xazQSRkJE5Oa2CFsIUl/lzrYoMo
        essoMXPrHSaQhLCAq8S+V6/BGtgEDCW63naB2SIChRIruy+CNTALnGeUmH7kIyNE93MmiXnv
        VgE5HBy8AnYSPw5YgDSwCKhK7Jo5lR3EFhWIk1i+ZT6YzSsgKHFy5hMWEJtTwF6io60F7CJm
        ATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFe
        cWJucWleul5yfu4mRmC0bTv2c/MOxksbgw8xCnAwKvHwKvzkixdiTSwrrsw9xCjBwawkwut0
        9nScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDE0FeSbyhqaG5haWhubG5sZmFkjhvh8DB
        GCGB9MSS1OzU1ILUIpg+Jg5OqQbG8KNM2QasIhq6LdGnnlbc5vr5pFLetH7byb18ltrGX9gF
        9y9wL3DkXnfE7mTwj9MNh92XPvG1blbcF6NoWy8V3bTvy3WZ/iM7HCU+pgbutXgh802yynDV
        2fqHXAdnCcXyXg/Ofb7y3bGuv9se79xbUZX05FbvubAyp9VJ/6wCOE56xuukBpxRYinOSDTU
        Yi4qTgQAIE+tL8wCAAA=
X-CMS-MailID: 20200716120326eucas1p1c0a76ebefa78876a8a240ea4d3c77f5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
References: <CGME20200714084807eucas1p1f6e680d162573c6a0660037172a65805@eucas1p1.samsung.com>
        <20200714084800.11340-1-m.szyprowski@samsung.com>
        <40bfbfd6-6516-5995-8250-c8e3df16e11e@synopsys.com>
        <ad121efc-44a2-143a-84d3-afb0db03419f@samsung.com>
        <13bfcc28-17d6-f399-2617-2edfb0cb8819@synopsys.com>
        <3bfb9bf3-3139-6447-fe0b-25473dabb0a0@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.2020 13:58, Marek Szyprowski wrote:
> On 15.07.2020 15:54, Minas Harutyunyan wrote:
>> On 7/15/2020 12:42 PM, Marek Szyprowski wrote:
>>> On 14.07.2020 14:32, Minas Harutyunyan wrote:
>>>> On 7/14/2020 12:48 PM, Marek Szyprowski wrote:
>>>>> When gadget registration fails, one should not call 
>>>>> usb_del_gadget_udc().
>>>>> Ensure this by setting gadget->udc to NULL. Also in case of a failure
>>>> I was able to reproduce issue. I'm Ok with this fix.
>>>>
>>>>> there is no need to disable low-level hardware, so return immiedetly
>>>>> instead of jumping to error_init label.
>>>>>
>>>> Why do you think that disable low-level hardware not required which 
>>>> was
>>>> enabled before? Also for some platforms required to call
>>>> regulator_disable() which was enabled earlier in probe function.
>>>> So, I suggest to keep jump to error_init label.
>>> If I keep the jump to error_init label, then there is unbalanced 
>>> call to
>>> dwc2_lowlevel_hw_disable(). usb_add_gadget_udc() can fail in 2 places:
>>> on gadget->bind() or during udc_start(). In the first case, the HW was
>>> not yet enabled, so there is no need to disable it. In the latter one,
>>> the error might be returned only from the dwc2_lowlevel_hw_enable(), so
>>> again there is no need to call dwc2_lowlevel_hw_disable().
>>>
>>> If I keep the "goto error_init;" line, I get the following errors:
>>>
>>> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=1
>>> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter
>>> g_np_tx_fifo_size=1024
>>> dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
>>> Mass Storage Function, version: 2009/09/11
>>> LUN: removable file: (no medium)
>>> no file given for LUN0
>>> g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 3 PID: 49 at drivers/clk/clk.c:958
>>> clk_core_disable+0x1e4/0x314
>>> usb_device already disabled
>>> Modules linked in:
>>> CPU: 3 PID: 49 Comm: kworker/3:1 Not tainted
>>> 5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>> Workqueue: events deferred_probe_work_func
>>> [<c011184c>] (unwind_backtrace) from [<c010d250>] 
>>> (show_stack+0x10/0x14)
>>> [<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
>>> [<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
>>> [<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
>>> [<c0126f64>] (warn_slowpath_fmt) from [<c056c338>]
>>> (clk_core_disable+0x1e4/0x314)
>>> [<c056c338>] (clk_core_disable) from [<c056c480>]
>>> (clk_core_disable_lock+0x18/0x24)
>>> [<c056c480>] (clk_core_disable_lock) from [<c073f9d4>]
>>> (__dwc2_lowlevel_hw_disable+0x3c/0xa0)
>>> [<c073f9d4>] (__dwc2_lowlevel_hw_disable) from [<c0740188>]
>>> (dwc2_driver_probe+0x2d4/0x6ac)
>>> [<c0740188>] (dwc2_driver_probe) from [<c0653640>]
>>> (platform_drv_probe+0x6c/0xa4)
>>> [<c0653640>] (platform_drv_probe) from [<c0650bdc>]
>>> (really_probe+0x200/0x4fc)
>>> [<c0650bdc>] (really_probe) from [<c0651040>]
>>> (driver_probe_device+0x78/0x1fc)
>>> [<c0651040>] (driver_probe_device) from [<c064ea78>]
>>> (bus_for_each_drv+0x74/0xb8)
>>> [<c064ea78>] (bus_for_each_drv) from [<c065093c>]
>>> (__device_attach+0xd4/0x16c)
>>> [<c065093c>] (__device_attach) from [<c064fa3c>]
>>> (bus_probe_device+0x88/0x90)
>>> [<c064fa3c>] (bus_probe_device) from [<c064ff54>]
>>> (deferred_probe_work_func+0x3c/0xd0)
>>> [<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>]
>>> (process_one_work+0x234/0x7dc)
>>> [<c0148a5c>] (process_one_work) from [<c0149048>] 
>>> (worker_thread+0x44/0x51c)
>>> [<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
>>> [<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>> Exception stack(0xee923fb0 to 0xee923ff8)
>>> ...
>>> irq event stamp: 36966
>>> hardirqs last  enabled at (36965): [<c02b92d8>] kfree+0x1a4/0x3f0
>>> hardirqs last disabled at (36966): [<c0569edc>] 
>>> clk_enable_lock+0x14/0x134
>>> softirqs last  enabled at (36814): [<c010174c>] 
>>> __do_softirq+0x50c/0x608
>>> softirqs last disabled at (36803): [<c0130218>] irq_exit+0x168/0x16c
>>> ---[ end trace f55f4b28f3080c12 ]---
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 3 PID: 49 at drivers/clk/clk.c:817
>>> clk_core_unprepare+0x33c/0x470
>>> usb_device already unprepared
>>> Modules linked in:
>>> CPU: 3 PID: 49 Comm: kworker/3:1 Tainted: G        W
>>> 5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>> Workqueue: events deferred_probe_work_func
>>> [<c011184c>] (unwind_backtrace) from [<c010d250>] 
>>> (show_stack+0x10/0x14)
>>> [<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
>>> [<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
>>> [<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
>>> [<c0126f64>] (warn_slowpath_fmt) from [<c056dcb8>]
>>> (clk_core_unprepare+0x33c/0x470)
>>> [<c056dcb8>] (clk_core_unprepare) from [<c056de10>]
>>> (clk_unprepare+0x24/0x2c)
>>> [<c056de10>] (clk_unprepare) from [<c073f9dc>]
>>> (__dwc2_lowlevel_hw_disable+0x44/0xa0)
>>> [<c073f9dc>] (__dwc2_lowlevel_hw_disable) from [<c0740188>]
>>> (dwc2_driver_probe+0x2d4/0x6ac)
>>> [<c0740188>] (dwc2_driver_probe) from [<c0653640>]
>>> (platform_drv_probe+0x6c/0xa4)
>>> [<c0653640>] (platform_drv_probe) from [<c0650bdc>]
>>> (really_probe+0x200/0x4fc)
>>> [<c0650bdc>] (really_probe) from [<c0651040>]
>>> (driver_probe_device+0x78/0x1fc)
>>> [<c0651040>] (driver_probe_device) from [<c064ea78>]
>>> (bus_for_each_drv+0x74/0xb8)
>>> [<c064ea78>] (bus_for_each_drv) from [<c065093c>]
>>> (__device_attach+0xd4/0x16c)
>>> [<c065093c>] (__device_attach) from [<c064fa3c>]
>>> (bus_probe_device+0x88/0x90)
>>> [<c064fa3c>] (bus_probe_device) from [<c064ff54>]
>>> (deferred_probe_work_func+0x3c/0xd0)
>>> [<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>]
>>> (process_one_work+0x234/0x7dc)
>>> [<c0148a5c>] (process_one_work) from [<c0149048>] 
>>> (worker_thread+0x44/0x51c)
>>> [<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
>>> [<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>> Exception stack(0xee923fb0 to 0xee923ff8)
>>> ...
>>> irq event stamp: 37073
>>> hardirqs last  enabled at (37081): [<c019d624>] 
>>> console_unlock+0x430/0x6cc
>>> hardirqs last disabled at (37108): [<c019d348>] 
>>> console_unlock+0x154/0x6cc
>>> softirqs last  enabled at (37124): [<c010174c>] 
>>> __do_softirq+0x50c/0x608
>>> softirqs last disabled at (37135): [<c0130218>] irq_exit+0x168/0x16c
>>> ---[ end trace f55f4b28f3080c13 ]---
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 3 PID: 49 at drivers/regulator/core.c:2603
>>> _regulator_disable+0x180/0x1d8
>>> unbalanced disables for VUOTG_3.0V
>>> Modules linked in:
>>> CPU: 3 PID: 49 Comm: kworker/3:1 Tainted: G        W
>>> 5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>> Workqueue: events deferred_probe_work_func
>>> [<c011184c>] (unwind_backtrace) from [<c010d250>] 
>>> (show_stack+0x10/0x14)
>>> [<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
>>> [<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
>>> [<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
>>> [<c0126f64>] (warn_slowpath_fmt) from [<c0585e78>]
>>> (_regulator_disable+0x180/0x1d8)
>>> [<c0585e78>] (_regulator_disable) from [<c0585f04>]
>>> (regulator_disable+0x34/0xe0)
>>> [<c0585f04>] (regulator_disable) from [<c0587ef8>]
>>> (regulator_bulk_disable+0x28/0xb0)
>>> [<c0587ef8>] (regulator_bulk_disable) from [<c0740188>]
>>> (dwc2_driver_probe+0x2d4/0x6ac)
>>> [<c0740188>] (dwc2_driver_probe) from [<c0653640>]
>>> (platform_drv_probe+0x6c/0xa4)
>>> [<c0653640>] (platform_drv_probe) from [<c0650bdc>]
>>> (really_probe+0x200/0x4fc)
>>> [<c0650bdc>] (really_probe) from [<c0651040>]
>>> (driver_probe_device+0x78/0x1fc)
>>> [<c0651040>] (driver_probe_device) from [<c064ea78>]
>>> (bus_for_each_drv+0x74/0xb8)
>>> [<c064ea78>] (bus_for_each_drv) from [<c065093c>]
>>> (__device_attach+0xd4/0x16c)
>>> [<c065093c>] (__device_attach) from [<c064fa3c>]
>>> (bus_probe_device+0x88/0x90)
>>> [<c064fa3c>] (bus_probe_device) from [<c064ff54>]
>>> (deferred_probe_work_func+0x3c/0xd0)
>>> [<c064ff54>] (deferred_probe_work_func) from [<c0148a5c>]
>>> (process_one_work+0x234/0x7dc)
>>> [<c0148a5c>] (process_one_work) from [<c0149048>] 
>>> (worker_thread+0x44/0x51c)
>>> [<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
>>> [<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>> Exception stack(0xee923fb0 to 0xee923ff8)
>>> ...
>>> irq event stamp: 37243
>>> hardirqs last  enabled at (37251): [<c019d624>] 
>>> console_unlock+0x430/0x6cc
>>> hardirqs last disabled at (37274): [<c0ac0790>] __schedule+0xd8/0x860
>>> softirqs last  enabled at (37270): [<c010174c>] 
>>> __do_softirq+0x50c/0x608
>>> softirqs last disabled at (37291): [<c0130218>] irq_exit+0x168/0x16c
>>> ---[ end trace f55f4b28f3080c14 ]---
>>> Failed to disable vusb_a: -5
>>> dwc2: probe of 12480000.hsotg failed with error -22
>>> 8<--- cut here ---
>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>> 00000004
>>> pgd = (ptrval)
>>> [00000004] *pgd=00000000
>>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>> Modules linked in:
>>> CPU: 3 PID: 87 Comm: kworker/3:2 Tainted: G        W
>>> 5.8.0-rc5-next-20200714-00003-g105f360ba595-dirty #8758
>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>> Workqueue:  0x0 (rcu_gp)
>>> PC is at process_one_work+0x44/0x7dc
>>> LR is at 0xedc226d0
>>> ...
>>> Process kworker/3:2 (pid: 87, stack limit = 0x(ptrval))
>>> Stack: (0xeda03f00 to 0xeda04000)
>>> ...
>>> [<c014886c>] (process_one_work) from [<c0149048>] 
>>> (worker_thread+0x44/0x51c)
>>> [<c0149048>] (worker_thread) from [<c015039c>] (kthread+0x158/0x1a0)
>>> [<c015039c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>> Exception stack(0xeda03fb0 to 0xeda03ff8)
>>> ...
>>> ---[ end trace f55f4b28f3080c15 ]---
>>> note: kworker/3:2[87] exited with preempt_count 1
>>>
>>> Best regards
>>>
>> I guess you build driver in (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
>> and this is why call of dwc2_lowlevel_hw_disable() at 'error:' label
>> create issue. Could you please test on your setup follow implementation:
>> ...
>> error:
>>     if (hsotg->dr_mode != USB_DR_MODE_PERIPHERAL)
>>         dwc2_lowlevel_hw_disable(hsotg);
>>     return retval;
>> }
>> ...
>
> Right, this will work. However, I would also change the order of 
> operations - disabling usb33d regulator should be done after disabling 
> lowlevel hardware to properly pair with the enable operations.
>
My fault, I've mixed vbus and usb33d regulators. The order is correct.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

