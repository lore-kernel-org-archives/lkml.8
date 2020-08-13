Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F476C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B24F20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nvlrdXtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMHYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:24:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43654 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHMHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:24:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200813072410euoutp01c054853b031563df0b360478bcdf3b26~qwwZrAvc82724027240euoutp014
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200813072410euoutp01c054853b031563df0b360478bcdf3b26~qwwZrAvc82724027240euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597303450;
        bh=eVCSw6PtZQlLDjFtEVgkls9HTWFwHbrkskZlHGt/JL0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nvlrdXtj/klkfJziPiIgstvDb5t6bJHk9U0vUBy6oUYQy681z5VyaDCEP+sT1MX14
         NjijX8DPwOAzEg8HXwDpbhWmaE5MjVLWORKau6hWKkchTNIaCY5fW7Jgti3Y22g5BT
         05GuyV26DnE5C+5DSSXRWw5xwtexoLwKrmeS6DtA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813072409eucas1p1cd0e690efdb4b8429f1d8119f1aa1061~qwwZcmdgy2279322793eucas1p19;
        Thu, 13 Aug 2020 07:24:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4F.29.06318.99AE43F5; Thu, 13
        Aug 2020 08:24:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843~qwwZC7CpE0934409344eucas1p1i;
        Thu, 13 Aug 2020 07:24:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200813072409eusmtrp22ea5fc65422ac4c94f5b6b6a6fe274a8~qwwZCUFZo2206322063eusmtrp2Q;
        Thu, 13 Aug 2020 07:24:09 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-f6-5f34ea998d12
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.4F.06017.99AE43F5; Thu, 13
        Aug 2020 08:24:09 +0100 (BST)
Received: from [106.116.148.33] (unknown [106.116.148.33]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200813072409eusmtip2bff3c762015a1ac7a1ef1b2cb1ae6d64~qwwYsCCYZ1112611126eusmtip2K;
        Thu, 13 Aug 2020 07:24:09 +0000 (GMT)
Subject: Re: [PATCH 1/1] mfd: core: Fix memory leak of 'cell'
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <79bcd1b5-2247-5e00-7d49-2f94f9b40744@samsung.com>
Date:   Thu, 13 Aug 2020 09:24:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <072c29cf-b842-28b7-6abb-99ff8f2f5d57@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7ozX5nEGzzdZW6xccZ6Vovz5zew
        W9z/epTRYtPja6wWl3fNYbM4/Kad1YHNY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAaxRXDYp
        qTmZZalF+nYJXBmTNlxnKtjbyFjx6XcHawNjU34XIyeHhICJxNT1z1m6GLk4hARWMEr0Xd/I
        BuF8YZTY8XkFI4TzmVFiTs8fVpiWf41XWCESyxklXky+CpYQEnjPKHHsXWwXIweHsICtxLkJ
        WSBhNgFDia63XWwgYREBFYlzb8xBWpkFrjBKvFzwnQ2khlfATmLDhkksIDUsAqoSl2arg4RF
        BeIkth6/ygRRIihxcuYTFhCbU8BeYt+Eg2BxZgF5ieats5khbHGJW0/mM4HMlxBYxS5xaf8X
        JoibXSR+nn0OZQtLvDq+hR3ClpH4vxOmoZlR4uG5tewQTg+jxOWmGYwQVdYSd879AvuAWUBT
        Yv0ufYiwo8Scl0eYQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPS
        LCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYNo5/e/41x2M
        +/4kHWIU4GBU4uGd8Ms4Xog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MG72bHnL1v22u+Np8uffn9zMpksL5Ykd+uvG
        dN3sqO7BgNaFEin9T1c8CP7pyB0meGOm4i2ZwN/s1SdP8Hxubk39pGPxhf9Zo9N++9ht2wLE
        TqScqdSvOuATZuw7S+xLuJKWFE/vmSVcydcbLmsfnDZ3j1Dv5BctjqVN726YJk/gPNp8Vz9k
        nRJLcUaioRZzUXEiAK8VNxA3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7ozX5nEG8zvlLXYOGM9q8X58xvY
        Le5/PcposenxNVaLy7vmsFkcftPO6sDmsWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxJG64zFext
        ZKz49LuDtYGxKb+LkZNDQsBE4l/jFdYuRi4OIYGljBKLF95ggkjISJyc1sAKYQtL/LnWxQZR
        9JZRouHgLCCHg0NYwFbi3IQskBo2AUOJrrddYGERARWJc2/MQcqZBa4xSpyavAUsLiRQIDFn
        ph9IOa+AncSGDZNYQMIsAqoSl2arg4RFBeIkHvf+Z4YoEZQ4OfMJC4jNKWAvsW/CQbDLmAXM
        JOZtfsgMYctLNG+dDWWLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJ
        ucWleel6yfm5mxiBUbbt2M8tOxi73gUfYhTgYFTi4Z3wyzheiDWxrLgy9xCjBAezkgiv09nT
        cUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wAeSXxhqaG5haWhubG5sZmFkrivB0CB2OE
        BNITS1KzU1MLUotg+pg4OKUaGNe1RYsvPHn/k/upjkcujJ2RZozZn0r1TsxX7xP9J/s8NP9M
        5qIHdxdeKD4XYz8zNlxW5O/kw5yeHyMaDFQSnGT6LnkusTsmavn/yDVWZT9XofbffzdUOd45
        1n+9XegJ47Ok3+bHTlvJFJpd+r0y3zQ/I+b0xjyRlTJ7PQt+q7lE/f5qrXZ0nRJLcUaioRZz
        UXEiAAEs0t/IAgAA
X-CMS-MailID: 20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843
References: <20200716142851.1669946-1-lee.jones@linaro.org>
        <072c29cf-b842-28b7-6abb-99ff8f2f5d57@samsung.com>
        <CGME20200813072409eucas1p1dd94af95802a53a5b5f2991cd535d843@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 05.08.2020 16:26, Marek Szyprowski wrote:
> On 16.07.2020 16:28, Lee Jones wrote:
>> When creating a platform device from an MFD cell description, we
>> allocate some memory and make a copy which is then stored inside the
>> platform_device's structure.  However, care is not currently taken to
>> free the allocated memory when the platform device is torn down.
>>
>> This patch takes care of the leak.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> This patch landed recently in linux-next as commit 126f33704d9d ("mfd: 
> core: Fix memory leak of 'cell'"). Sadly it causes a regression on 
> Samsung Exynos4412-based Trats2 board:
> ...
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> I suspect that this is somehow related to the deferred probe and/or 
> devm_ helpers, but I didn't analyze it further yet. Reverting it on 
> top of current linux-next (and resolving conflict) fixes the boot. 
> Bisecting it was really hard because the issue is not fully 
> reproducible, what suggests memory trashing. Various tests of 
> linux-next with the reverted patch have shown at least that the issue 
> is gone.
>
> I've compiled the kernel from exynos_defconfig, the dts used for the 
> test is arch/arm/boot/dts/exynos4412-trats2.dts

Finally I've found some time to analyze this issue.

Indeed this patch is wrong it causes double free on the mfd_cell. 
mfd_cell is already properly freed by the platform_device_release() 
function when kref of the pdev goes down to zero: 
https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L426

I will send a revert with the explaination.

Here is a better log I've captured with more debugging options enabled:

=============================================================================
BUG kmalloc-128 (Not tainted): Object already free
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: Allocated in kobject_get_path+0x60/0xfc age=2 cpu=2 pid=1
  __kmalloc+0x298/0x544
  kobject_get_path+0x60/0xfc
  kobject_uevent_env+0x140/0x684
  device_del+0x264/0x39c
  device_unregister+0x24/0x64
  regulator_unregister+0xb8/0xe4
  release_nodes+0x18c/0x238
  device_release_driver_internal+0x104/0x1bc
  bus_remove_device+0xe4/0x13c
  device_del+0x158/0x39c
  platform_device_del+0x20/0x88
  platform_device_unregister+0xc/0x18
  mfd_remove_devices_fn+0x9c/0xcc
  device_for_each_child_reverse+0x60/0x9c
  mfd_remove_devices+0x30/0x4c
  wm8994_i2c_probe+0x318/0x8f8
INFO: Freed in kobject_uevent_env+0x178/0x684 age=2 cpu=2 pid=1
  kobject_uevent_env+0x178/0x684
  device_del+0x264/0x39c
  device_unregister+0x24/0x64
  regulator_unregister+0xb8/0xe4
  release_nodes+0x18c/0x238
  device_release_driver_internal+0x104/0x1bc
  bus_remove_device+0xe4/0x13c
  device_del+0x158/0x39c
  platform_device_del+0x20/0x88
  platform_device_unregister+0xc/0x18
  mfd_remove_devices_fn+0x9c/0xcc
  device_for_each_child_reverse+0x60/0x9c
  mfd_remove_devices+0x30/0x4c
  wm8994_i2c_probe+0x318/0x8f8
  i2c_device_probe+0x254/0x2bc
  really_probe+0x200/0x4fc
INFO: Slab 0x(ptrval) objects=16 used=9 fp=0x(ptrval) flags=0x10201
INFO: Object 0x(ptrval) @offset=3712 fp=0x00000000

Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 
kkkkkkkkkkkkkkk.
Redzone (ptrval): bb bb bb bb ....
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a ZZZZZZZZ
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G    B 5.8.0-next-20200812 #8987
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111b08>] (unwind_backtrace) from [<c010d32c>] (show_stack+0x10/0x14)
[<c010d32c>] (show_stack) from [<c054d994>] (dump_stack+0xbc/0xe8)
[<c054d994>] (dump_stack) from [<c02c8860>] 
(free_debug_processing+0x24c/0x3c0)
[<c02c8860>] (free_debug_processing) from [<c02c8ca0>] 
(__slab_free+0x2cc/0x4bc)
[<c02c8ca0>] (__slab_free) from [<c02c9144>] (kfree+0x2b4/0x480)
[<c02c9144>] (kfree) from [<c0688134>] (platform_device_release+0x18/0x34)
[<c0688134>] (platform_device_release) from [<c067ea8c>] 
(device_release+0x28/0x98)
[<c067ea8c>] (device_release) from [<c05542bc>] (kobject_put+0x104/0x288)
[<c05542bc>] (kobject_put) from [<c0553ac4>] (klist_prev+0xd8/0x16c)
[<c0553ac4>] (klist_prev) from [<c067f148>] 
(device_for_each_child_reverse+0x6c/0x9c)
[<c067f148>] (device_for_each_child_reverse) from [<c06bab74>] 
(mfd_remove_devices+0x30/0x4c)
[<c06bab74>] (mfd_remove_devices) from [<c06b9be8>] 
(wm8994_i2c_probe+0x318/0x8f8)
[<c06b9be8>] (wm8994_i2c_probe) from [<c080d6c8>] 
(i2c_device_probe+0x254/0x2bc)
[<c080d6c8>] (i2c_device_probe) from [<c06858b4>] (really_probe+0x200/0x4fc)
[<c06858b4>] (really_probe) from [<c0685d78>] 
(driver_probe_device+0x78/0x1fc)
[<c0685d78>] (driver_probe_device) from [<c0686160>] 
(device_driver_attach+0x58/0x60)
[<c0686160>] (device_driver_attach) from [<c0686244>] 
(__driver_attach+0xdc/0x174)
[<c0686244>] (__driver_attach) from [<c068363c>] 
(bus_for_each_dev+0x68/0xb4)
[<c068363c>] (bus_for_each_dev) from [<c0684970>] 
(bus_add_driver+0x158/0x214)
[<c0684970>] (bus_add_driver) from [<c0687358>] (driver_register+0x78/0x110)
[<c0687358>] (driver_register) from [<c080e508>] 
(i2c_register_driver+0x3c/0xac)
[<c080e508>] (i2c_register_driver) from [<c010254c>] 
(do_one_initcall+0x94/0x53c)
[<c010254c>] (do_one_initcall) from [<c1101200>] 
(kernel_init_freeable+0x190/0x1dc)
[<c1101200>] (kernel_init_freeable) from [<c0b18024>] 
(kernel_init+0x8/0x118)
[<c0b18024>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef1bbfb0 to 0xef1bbff8)
bfa0:                                     00000000 00000000 00000000 
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
FIX kmalloc-128: Object at 0x(ptrval) not freed
=============================================================================
BUG kmalloc-128 (Tainted: G    B            ): Wrong object count. 
Counter is 9 but counted were 14
-----------------------------------------------------------------------------

INFO: Slab 0x(ptrval) objects=16 used=9 fp=0x(ptrval) flags=0x10201
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G    B 5.8.0-next-20200812 #8987
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111b08>] (unwind_backtrace) from [<c010d32c>] (show_stack+0x10/0x14)
[<c010d32c>] (show_stack) from [<c054d994>] (dump_stack+0xbc/0xe8)
[<c054d994>] (dump_stack) from [<c02c35c4>] (slab_err+0x80/0xa4)
[<c02c35c4>] (slab_err) from [<c02c8234>] (on_freelist+0x1a8/0x23c)
[<c02c8234>] (on_freelist) from [<c02c8774>] 
(free_debug_processing+0x160/0x3c0)
[<c02c8774>] (free_debug_processing) from [<c02c8ca0>] 
(__slab_free+0x2cc/0x4bc)
[<c02c8ca0>] (__slab_free) from [<c02c9144>] (kfree+0x2b4/0x480)
[<c02c9144>] (kfree) from [<c06bad14>] (mfd_remove_devices_fn+0x94/0xcc)
[<c06bad14>] (mfd_remove_devices_fn) from [<c067f13c>] 
(device_for_each_child_reverse+0x60/0x9c)
[<c067f13c>] (device_for_each_child_reverse) from [<c06bab74>] 
(mfd_remove_devices+0x30/0x4c)
[<c06bab74>] (mfd_remove_devices) from [<c06b9be8>] 
(wm8994_i2c_probe+0x318/0x8f8)
[<c06b9be8>] (wm8994_i2c_probe) from [<c080d6c8>] 
(i2c_device_probe+0x254/0x2bc)
[<c080d6c8>] (i2c_device_probe) from [<c06858b4>] (really_probe+0x200/0x4fc)
[<c06858b4>] (really_probe) from [<c0685d78>] 
(driver_probe_device+0x78/0x1fc)
[<c0685d78>] (driver_probe_device) from [<c0686160>] 
(device_driver_attach+0x58/0x60)
[<c0686160>] (device_driver_attach) from [<c0686244>] 
(__driver_attach+0xdc/0x174)
[<c0686244>] (__driver_attach) from [<c068363c>] 
(bus_for_each_dev+0x68/0xb4)
[<c068363c>] (bus_for_each_dev) from [<c0684970>] 
(bus_add_driver+0x158/0x214)
[<c0684970>] (bus_add_driver) from [<c0687358>] (driver_register+0x78/0x110)
[<c0687358>] (driver_register) from [<c080e508>] 
(i2c_register_driver+0x3c/0xac)
[<c080e508>] (i2c_register_driver) from [<c010254c>] 
(do_one_initcall+0x94/0x53c)
[<c010254c>] (do_one_initcall) from [<c1101200>] 
(kernel_init_freeable+0x190/0x1dc)
[<c1101200>] (kernel_init_freeable) from [<c0b18024>] 
(kernel_init+0x8/0x118)
[<c0b18024>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef1bbfb0 to 0xef1bbff8)
bfa0:                                     00000000 00000000 00000000 
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
FIX kmalloc-128: Object count adjusted.
=============================================================================
BUG kmalloc-128 (Tainted: G    B            ): Object already free
-----------------------------------------------------------------------------

INFO: Allocated in kobject_get_path+0x60/0xfc age=2 cpu=2 pid=1
  __kmalloc+0x298/0x544
  kobject_get_path+0x60/0xfc
  kobject_uevent_env+0x140/0x684
  device_del+0x264/0x39c
  device_unregister+0x24/0x64
  regulator_unregister+0xb8/0xe4
  release_nodes+0x18c/0x238
  device_release_driver_internal+0x104/0x1bc
  bus_remove_device+0xe4/0x13c
  device_del+0x158/0x39c
  platform_device_del+0x20/0x88
  platform_device_unregister+0xc/0x18
  mfd_remove_devices_fn+0x9c/0xcc
  device_for_each_child_reverse+0x60/0x9c
  mfd_remove_devices+0x30/0x4c
  wm8994_i2c_probe+0x318/0x8f8
INFO: Freed in kobject_uevent_env+0x178/0x684 age=2 cpu=2 pid=1
  kobject_uevent_env+0x178/0x684
  device_del+0x264/0x39c
  device_unregister+0x24/0x64
  regulator_unregister+0xb8/0xe4
  release_nodes+0x18c/0x238
  device_release_driver_internal+0x104/0x1bc
  bus_remove_device+0xe4/0x13c
  device_del+0x158/0x39c
  platform_device_del+0x20/0x88
  platform_device_unregister+0xc/0x18
  mfd_remove_devices_fn+0x9c/0xcc
  device_for_each_child_reverse+0x60/0x9c
  mfd_remove_devices+0x30/0x4c
  wm8994_i2c_probe+0x318/0x8f8
  i2c_device_probe+0x254/0x2bc
  really_probe+0x200/0x4fc
INFO: Slab 0x(ptrval) objects=16 used=12 fp=0x(ptrval) flags=0x10201
INFO: Object 0x(ptrval) @offset=1664 fp=0x00000000

Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Redzone (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
kkkkkkkkkkkkkkkk
Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 
kkkkkkkkkkkkkkk.
Redzone (ptrval): bb bb bb bb ....
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 
ZZZZZZZZZZZZZZZZ
Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a ZZZZZZZZ
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G    B 5.8.0-next-20200812 #8987
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111b08>] (unwind_backtrace) from [<c010d32c>] (show_stack+0x10/0x14)
[<c010d32c>] (show_stack) from [<c054d994>] (dump_stack+0xbc/0xe8)
[<c054d994>] (dump_stack) from [<c02c8860>] 
(free_debug_processing+0x24c/0x3c0)
[<c02c8860>] (free_debug_processing) from [<c02c8ca0>] 
(__slab_free+0x2cc/0x4bc)
[<c02c8ca0>] (__slab_free) from [<c02c9144>] (kfree+0x2b4/0x480)
[<c02c9144>] (kfree) from [<c0688134>] (platform_device_release+0x18/0x34)
[<c0688134>] (platform_device_release) from [<c067ea8c>] 
(device_release+0x28/0x98)
[<c067ea8c>] (device_release) from [<c05542bc>] (kobject_put+0x104/0x288)
[<c05542bc>] (kobject_put) from [<c0553ac4>] (klist_prev+0xd8/0x16c)
[<c0553ac4>] (klist_prev) from [<c067f148>] 
(device_for_each_child_reverse+0x6c/0x9c)
[<c067f148>] (device_for_each_child_reverse) from [<c06bab74>] 
(mfd_remove_devices+0x30/0x4c)
[<c06bab74>] (mfd_remove_devices) from [<c06b9be8>] 
(wm8994_i2c_probe+0x318/0x8f8)
[<c06b9be8>] (wm8994_i2c_probe) from [<c080d6c8>] 
(i2c_device_probe+0x254/0x2bc)
[<c080d6c8>] (i2c_device_probe) from [<c06858b4>] (really_probe+0x200/0x4fc)
[<c06858b4>] (really_probe) from [<c0685d78>] 
(driver_probe_device+0x78/0x1fc)
[<c0685d78>] (driver_probe_device) from [<c0686160>] 
(device_driver_attach+0x58/0x60)
[<c0686160>] (device_driver_attach) from [<c0686244>] 
(__driver_attach+0xdc/0x174)
[<c0686244>] (__driver_attach) from [<c068363c>] 
(bus_for_each_dev+0x68/0xb4)
[<c068363c>] (bus_for_each_dev) from [<c0684970>] 
(bus_add_driver+0x158/0x214)
[<c0684970>] (bus_add_driver) from [<c0687358>] (driver_register+0x78/0x110)
[<c0687358>] (driver_register) from [<c080e508>] 
(i2c_register_driver+0x3c/0xac)
[<c080e508>] (i2c_register_driver) from [<c010254c>] 
(do_one_initcall+0x94/0x53c)
[<c010254c>] (do_one_initcall) from [<c1101200>] 
(kernel_init_freeable+0x190/0x1dc)
[<c1101200>] (kernel_init_freeable) from [<c0b18024>] 
(kernel_init+0x8/0x118)
[<c0b18024>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef1bbfb0 to 0xef1bbff8)
bfa0:                                     00000000 00000000 00000000 
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
FIX kmalloc-128: Object at 0x(ptrval) not freed


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

