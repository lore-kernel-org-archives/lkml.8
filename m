Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A722D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Okos5qou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHEQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:35:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58002 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgHEQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200805142610euoutp02c8d7294eb754701a26059e38182eab8b~oZWlRf7D41552415524euoutp024
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:26:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200805142610euoutp02c8d7294eb754701a26059e38182eab8b~oZWlRf7D41552415524euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596637570;
        bh=gjhBwwgPlUZEYSWjIb4aDpMpOOLI4HYQ7gqDYEGNrtc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Okos5qou1WX6fBINRIkuhwhp2TbM9kAZzAT921REnzoubMGQdEMxAP7Ejp0Uo+6NG
         WWd95WuvR9k0APe5pr4ZkHfNKKVeFrnwIPGo/muWsPOKrsbw57Kzv4IAAsrNYuunc+
         KQqaODF/CUxOFmXjgsrMsqMSzHTbL6L8iJVlr+rs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200805142610eucas1p2c1456071b4639a0ce881db0f0ad68b89~oZWlBOxBB2990729907eucas1p2S;
        Wed,  5 Aug 2020 14:26:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.EC.06318.281CA2F5; Wed,  5
        Aug 2020 15:26:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200805142610eucas1p1dd85e87d57dab1433d3d31a9c0ec49d6~oZWkjAiLC1890318903eucas1p1g;
        Wed,  5 Aug 2020 14:26:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200805142610eusmtrp183e03cba612bfb8a51a6e6ab435272f1~oZWkiac_90665906659eusmtrp1L;
        Wed,  5 Aug 2020 14:26:10 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-59-5f2ac1829217
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.6A.06314.281CA2F5; Wed,  5
        Aug 2020 15:26:10 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200805142609eusmtip2a46f6651d1b46b3aa1ded3af2def4e88~oZWkJo5Pb2968329683eusmtip2G;
        Wed,  5 Aug 2020 14:26:09 +0000 (GMT)
Subject: Re: [PATCH 1/1] mfd: core: Fix memory leak of 'cell'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <072c29cf-b842-28b7-6abb-99ff8f2f5d57@samsung.com>
Date:   Wed, 5 Aug 2020 16:26:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200716142851.1669946-1-lee.jones@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7pNB7XiDfb+V7XYOGM9q8X58xvY
        Le5/PcposenxNVaLy7vmsFkcftPO6sDmsWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ANYoLpuU
        1JzMstQifbsErozzp98yF2xRrZh5WKeB8YhCFyMnh4SAicTaO6dZuxi5OIQEVjBKzFt0mgXC
        +cIocfP+RXYI5zOjxM8ts1lgWt7+WsYIkVjOKLGk+wyU855R4tS8T0xdjBwcwgK2EucmZIGY
        IgIqEufemIOUMAtcYZR4ueA7G8ggNgFDia63XWA2r4CdROucU4wgNgtQ/a2rW5lAbFGBOImt
        x68yQdQISpyc+YQFZCangI3Eyq9BIGFmAXmJ5q2zmSFscYlbT+YzgeySEFjFLvFg1242iKNd
        JK5daGOEsIUlXh3fwg5hy0icntzDAtHQzCjx8Nxadginh1HictMMqA5riTvnfrGBbGYW0JRY
        v0sfIuwosXnFXrCDJAT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlI
        PpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMCkc/rf8a87GPf9
        STrEKMDBqMTDu2CFVrwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7Ao
        ifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamCUbAo8s9FSmP/vxeDQD7d8hefblt/6dGX2Bv03
        PSl/5GveP5uvN+PQAyWFXvWUMh0GzlLJdQyPhJMD5eymtPLdi7ee4uUdsEPpSvYehVV7/L/s
        LjuzTM67io/jzJuybXFn7Vh79+/i3tC/wGJ7ottawWRJG4Vsq0Mainu1mqzmT9qZqihUqKTE
        UpyRaKjFXFScCAB4axm9NgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7pNB7XiDRYuYbXYOGM9q8X58xvY
        Le5/PcposenxNVaLy7vmsFkcftPO6sDmsWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzzp98yF2xR
        rZh5WKeB8YhCFyMnh4SAicTbX8sYQWwhgaWMEi3LYiHiMhInpzWwQtjCEn+udbF1MXIB1bxl
        lDj46DmQw8EhLGArcW5CFogpIqAice6NOUgJs8A1RolTk7ewQcy0lph2aSHYfDYBQ4mut11g
        cV4BO4nWOafA4ixAvbeubmUCsUUF4iQe9/5nhqgRlDg58wkLyHxOARuJlV+DQMLMAmYS8zY/
        ZIaw5SWat86GssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMAI23bs5+YdjJc2Bh9iFOBgVOLhXbBCK16INbGsuDL3EKMEB7OSCK/T2dNxQrwp
        iZVVqUX58UWlOanFhxhNgX6byCwlmpwPjP68knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2Mk+6VpH1RF9tfd8x5z8K8Oa3G+jamQktjI2bmf/s0Z+6k+AVCexfc
        +NIz7ept5rkrvv09O+Hiro/GNy/v0/oz82mNhW5O7f2XWlknq1a/4OXT2GH8YXLCRDMrDrbo
        5SJ6Cw6v6jZUi3HylXOqXLi5LvB2Zez0fNspj1b9nNi3ZFHTcaH5SponniqxFGckGmoxFxUn
        AgCsrDlxxgIAAA==
X-CMS-MailID: 20200805142610eucas1p1dd85e87d57dab1433d3d31a9c0ec49d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200805142610eucas1p1dd85e87d57dab1433d3d31a9c0ec49d6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200805142610eucas1p1dd85e87d57dab1433d3d31a9c0ec49d6
References: <20200716142851.1669946-1-lee.jones@linaro.org>
        <CGME20200805142610eucas1p1dd85e87d57dab1433d3d31a9c0ec49d6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 16.07.2020 16:28, Lee Jones wrote:
> When creating a platform device from an MFD cell description, we
> allocate some memory and make a copy which is then stored inside the
> platform_device's structure.  However, care is not currently taken to
> free the allocated memory when the platform device is torn down.
>
> This patch takes care of the leak.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This patch landed recently in linux-next as commit 126f33704d9d ("mfd: 
core: Fix memory leak of 'cell'"). Sadly it causes a regression on 
Samsung Exynos4412-based Trats2 board:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000023
pgd = (ptrval)
[00000023] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-00055-g126f33704d9d 
#1379
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at __kmalloc_track_caller+0xe0/0x454
LR is at __kmalloc_track_caller+0x60/0x454
...
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xef0f19d8 to 0xef0f2000)
...
[<c02b62ec>] (__kmalloc_track_caller) from [<c026e220>] (kstrdup+0x30/0x5c)
[<c026e220>] (kstrdup) from [<c0361250>] (__kernfs_new_node+0x2c/0x280)
[<c0361250>] (__kernfs_new_node) from [<c036247c>] 
(kernfs_new_node+0x40/0x60)
[<c036247c>] (kernfs_new_node) from [<c03643fc>] 
(kernfs_create_link+0x3c/0x90)
[<c03643fc>] (kernfs_create_link) from [<c0365460>] 
(sysfs_do_create_link_sd+0x64/0xd8)
[<c0365460>] (sysfs_do_create_link_sd) from [<c0646fe4>] 
(device_add+0x388/0x744)
[<c0646fe4>] (device_add) from [<c0583874>] 
(regulator_register+0xba8/0x1344)
[<c0583874>] (regulator_register) from [<c0585b74>] 
(devm_regulator_register+0x3c/0x78)
[<c0585b74>] (devm_regulator_register) from [<c058b448>] 
(max77686_pmic_probe+0xc8/0x140)
[<c058b448>] (max77686_pmic_probe) from [<c064d484>] 
(platform_drv_probe+0x6c/0xa4)
[<c064d484>] (platform_drv_probe) from [<c064aab8>] 
(really_probe+0x200/0x48c)
[<c064aab8>] (really_probe) from [<c064aeac>] 
(driver_probe_device+0x78/0x1fc)
[<c064aeac>] (driver_probe_device) from [<c0648998>] 
(bus_for_each_drv+0x74/0xb8)
[<c0648998>] (bus_for_each_drv) from [<c064a818>] 
(__device_attach+0xd4/0x16c)
[<c064a818>] (__device_attach) from [<c064995c>] 
(bus_probe_device+0x88/0x90)
[<c064995c>] (bus_probe_device) from [<c06470ec>] (device_add+0x490/0x744)
[<c06470ec>] (device_add) from [<c064d1e8>] 
(platform_device_add+0x114/0x258)
[<c064d1e8>] (platform_device_add) from [<c067d69c>] 
(mfd_add_devices+0x344/0x408)
[<c067d69c>] (mfd_add_devices) from [<c067d7c4>] 
(devm_mfd_add_devices+0x64/0xa4)
[<c067d7c4>] (devm_mfd_add_devices) from [<c067dfe4>] 
(max77686_i2c_probe+0xfc/0x19c)
[<c067dfe4>] (max77686_i2c_probe) from [<c07c5e40>] 
(i2c_device_probe+0x12c/0x2c4)
[<c07c5e40>] (i2c_device_probe) from [<c064aab8>] (really_probe+0x200/0x48c)
[<c064aab8>] (really_probe) from [<c064aeac>] 
(driver_probe_device+0x78/0x1fc)
[<c064aeac>] (driver_probe_device) from [<c064b294>] 
(device_driver_attach+0x58/0x60)
[<c064b294>] (device_driver_attach) from [<c064b378>] 
(__driver_attach+0xdc/0x174)
[<c064b378>] (__driver_attach) from [<c06488c4>] 
(bus_for_each_dev+0x68/0xb4)
[<c06488c4>] (bus_for_each_dev) from [<c0649bf8>] 
(bus_add_driver+0x158/0x214)
[<c0649bf8>] (bus_add_driver) from [<c064c24c>] (driver_register+0x78/0x110)
[<c064c24c>] (driver_register) from [<c07c6dac>] 
(i2c_register_driver+0x3c/0xac)
[<c07c6dac>] (i2c_register_driver) from [<c0102378>] 
(do_one_initcall+0x8c/0x424)
[<c0102378>] (do_one_initcall) from [<c1001158>] 
(kernel_init_freeable+0x190/0x204)
[<c1001158>] (kernel_init_freeable) from [<c0ab600c>] 
(kernel_init+0x8/0x118)
[<c0ab600c>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef0f1fb0 to 0xef0f1ff8)
...
---[ end trace 1d585642d0e3339f ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

I suspect that this is somehow related to the deferred probe and/or 
devm_ helpers, but I didn't analyze it further yet. Reverting it on top 
of current linux-next (and resolving conflict) fixes the boot. Bisecting 
it was really hard because the issue is not fully reproducible, what 
suggests memory trashing. Various tests of linux-next with the reverted 
patch have shown at least that the issue is gone.

I've compiled the kernel from exynos_defconfig, the dts used for the 
test is arch/arm/boot/dts/exynos4412-trats2.dts

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

