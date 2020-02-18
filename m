Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A1C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95A52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sbd4QaAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRLIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:08:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:60055 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:08:30 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200218110827epoutp01049aec39c4e97db9f9e0bd73d6e07074~0eotQgKnn0367303673epoutp01R
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:08:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200218110827epoutp01049aec39c4e97db9f9e0bd73d6e07074~0eotQgKnn0367303673epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582024107;
        bh=5BHF8sxffFwnmAXK8ugvrthLsppbzxxxoZDHAX3S8qw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sbd4QaAlLIxX1/ADmWxvqtH4JeVDzAUoNAFWY8S3tt7KoWjI2wQBD1WtZigmyclKQ
         H3k25RwsbBIlZQ0FfNDDrZK3a0lSqo5q6C5WBJL/73O1S4b/ScDY3PFB55kGCHDX5p
         KUsyGlOCRem/PvNI+m82blaFlGVuzk/tFMyQU5zM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200218110827epcas1p2d476d2fed5bb7fce223cd3fe6fc85ec1~0eos4Hjjk0618006180epcas1p2n;
        Tue, 18 Feb 2020 11:08:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48MJ4T2lLyzMqYkW; Tue, 18 Feb
        2020 11:08:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.0D.57028.9A5CB4E5; Tue, 18 Feb 2020 20:08:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200218110823epcas1p1881cca768305c71c23ca161e35919a7e~0eopXL_T-1086810868epcas1p1B;
        Tue, 18 Feb 2020 11:08:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200218110823epsmtrp125af98158c0172719fbc7a0862f05b6f~0eopWhHMx2413024130epsmtrp1B;
        Tue, 18 Feb 2020 11:08:23 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-4d-5e4bc5a9edff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.6E.10238.7A5CB4E5; Tue, 18 Feb 2020 20:08:23 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200218110823epsmtip1c7059f2c7263044569e0b024e139f34c~0eopLbBnO3234732347epsmtip1T;
        Tue, 18 Feb 2020 11:08:23 +0000 (GMT)
Subject: Re: RPI4: fail too boot with an initrd
To:     Matthias Brugger <mbrugger@suse.com>,
        LABBE Corentin <clabbe@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, James Morse <james.morse@arm.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <901d17c4-8265-a2a2-313b-cd9aeb7ecd63@samsung.com>
Date:   Tue, 18 Feb 2020 20:08:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d9727fac-e7fd-7dfb-ce39-da0c5b0d12a2@suse.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmge7Ko95xBl9XC1us7T3KYnFp7Sw2
        i/v7ljNZbHp8jdXi8q45bBYTb29gt2hqMbZYMPkJq8XbvZ3sDpwea+atYfR4f6OV3WPW/bNs
        Hjtn3WX3OHtnB6PH5iX1Huu3XGXx+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xu+FPxkL7hhUNC3rYWlgPKraxcjJISFgItG9
        7TlrFyMXh5DADkaJyZ/us4EkhAQ+MUrc3eYIkfjGKNF8fTs7TMe6nXOgOvYySnxY3cQO0fGe
        UeL25lAQW1hAX6Lp5TxmEFtEoFri2LLZYA3MAhcYJVr7/oCtYBPQkdj+7TgTiM0rYCexpHEn
        2CAWAVWJW//XATVzcIgKREic/poIUSIocXLmExYQm1PARmLeG4i9zALiEreezGeCsOUltr+d
        wwyyS0KgmV1i4ec1jBBXu0isOzKPDcIWlnh1fAvUN1ISL/vboOxqiV3NZ6CaOxglbm1rYoJI
        GEvsXzqZCeQgZgFNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImKxKXXL5lgVt19
        8p8VwvaQmPt+C/sERsVZSF6bheSdWUjemYWweAEjyypGsdSC4tz01GLDAkPkyN7ECE64WqY7
        GKec8znEKMDBqMTDG9DnFSfEmlhWXJl7iFGCg1lJhNdbHCjEm5JYWZValB9fVJqTWnyI0RQY
        8BOZpUST84HZIK8k3tDUyNjY2MLE0MzU0FBJnPdhpGackEB6YklqdmpqQWoRTB8TB6dUA6P0
        0RlBp9a+/Cli8Wrr5Ly/Qf1rcv9prjeWCbjhcE3lbZcQz0R/D/Hm+JfH3r+el3vw7KxKi7yK
        J3XrDaSvsIk0Wl//o3EkW6nwZNCGtPatXAu9nwSfPla4WSL15I2Q0B8+7q+jq7MPB7453mI+
        ITjS83rW834NfumNRxuc9nqUHhZ0fZcfnqfEUpyRaKjFXFScCABjCnbpzgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7yo95xBv/uqFqs7T3KYnFp7Sw2
        i/v7ljNZbHp8jdXi8q45bBYTb29gt2hqMbZYMPkJq8XbvZ3sDpwea+atYfR4f6OV3WPW/bNs
        Hjtn3WX3OHtnB6PH5iX1Huu3XGXx+LxJLoAjissmJTUnsyy1SN8ugSvj98KfjAV3DCqalvWw
        NDAeVe1i5OSQEDCRWLdzDmsXIxeHkMBuRondp6ayQySkJD4/ncrWxcgBZAtLHD5cDFHzllHi
        Ut8uJpAaYQF9iaaX85hBbBGBaokLL3tYQWxmgQuMEsv6BCEa5jBLbJ79CKyBTUBHYvu342A2
        r4CdxJLGnWDLWARUJW79Xwc2SFQgQuL59huMEDWCEidnPmEBsTkFbCTmvWlih1igLvFn3iVm
        CFtc4taT+UwQtrzE9rdzmCcwCs1C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlec
        mFtcmpeul5yfu4kRHGVamjsYLy+JP8QowMGoxMO7YoJXnBBrYllxZe4hRgkOZiURXm9xoBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MFe+U+BtrZp1l
        uG7qO3fOfN2vH/n+S9bJsd1NP2UTNM9pgtzOMO1ah3VbH/59/TkuqiKI8/CcbUJ5byeyPDmX
        HZ64e1sRw/uZ+gIvuY3tOfuuS/G5bS6bl31E78hZDeUS/z0H5DRXGhe+zFvSUhPx5pbRObmp
        WnxPi7c3hmVPbjhecN0g6qCwEktxRqKhFnNRcSIA+A1GfK4CAAA=
X-CMS-MailID: 20200218110823epcas1p1881cca768305c71c23ca161e35919a7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200218103651epcas1p4b6a9d599ec3577f1407ebc5b781c127f
References: <20200214132748.GA23276@Red>
        <b726290c-1038-3771-5187-6ac370bc92c9@arm.com> <20200217103733.GA11379@Red>
        <c5a959d7-44b2-fab9-8269-d8e858790925@gmail.com>
        <20200217125301.GA31847@Red>
        <982c710c-d606-2c04-03ee-604626230bbc@gmail.com>
        <20200218100128.GB10369@Red>
        <CGME20200218103651epcas1p4b6a9d599ec3577f1407ebc5b781c127f@epcas1p4.samsung.com>
        <d9727fac-e7fd-7dfb-ce39-da0c5b0d12a2@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/20 7:36 PM, Matthias Brugger wrote:
> 
> 
> On 18/02/2020 11:01, LABBE Corentin wrote:
>> On Mon, Feb 17, 2020 at 02:07:09PM +0100, Matthias Brugger wrote:
>>>
>>>
>>> On 17/02/2020 13:53, LABBE Corentin wrote:
>>>> On Mon, Feb 17, 2020 at 11:50:04AM +0100, Matthias Brugger wrote:
>>>>>
>>>>>
>>>>> On 17/02/2020 11:37, LABBE Corentin wrote:
>>>>>> On Fri, Feb 14, 2020 at 06:15:27PM +0000, James Morse wrote:
>>>>>>> Hi Corentin,
>>>>>>>
>>>>>>> On 14/02/2020 13:27, LABBE Corentin wrote:
>>>>>>>> Since the inclusion of the "enable network support in RPi4 config" serie on uboot, I
>>>>>>>> have started to work on adding the rpi4 in kernelCI.
>>>>>>>> But I fail to succeed in using a kernel/dtb/ramdisk downloaded via tftp.
>>>>>>>>
>>>>>>>> Using booti I hit:
>>>>>>>> [    0.000000] Linux version 5.6.0-rc1-next-20200212 (clabbe@build2-bionic-1804) (gcc version 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4] (Linaro    GCC 7.4-2019.02)) #66 SMP PREEMPT Wed Feb 12 10:14:20 UTC 2020
>>>>>>>> [    0.000000] Machine model: Raspberry Pi 4 Model B
>>>>>>>> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fe215040 (options '')
>>>>>>>> [    0.000000] printk: bootconsole [uart0] enabled
>>>>>>>> [    0.000000] efi: Getting EFI parameters from FDT:
>>>>>>>> [    0.000000] efi: UEFI not found.
>>>>>>>
>>>>>>> So no EFI,
>>>>>>>
>>>>>>>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'linux,cma'
>>>>>>>
>>>>>>> Out of memory.
>>>>>>>
>>>>>>>> [    0.000000] cma: Failed to reserve 32 MiB
>>>>>>>> [    0.000000] Kernel panic - not syncing: Failed to allocate page table page
>>>>>>>
>>>>>>> Out of memory...
>>>>>>>
>>>>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.6.0-rc1-next-20200212 #66
>>>>>>>> [    0.000000] Hardware name: Raspberry Pi 4 Model B (DT)
>>>>>>>> [    0.000000] Call trace:
>>>>>>>> [    0.000000]  dump_backtrace+0x0/0x1a0
>>>>>>>> [    0.000000]  show_stack+0x14/0x20
>>>>>>>> [    0.000000]  dump_stack+0xbc/0x104
>>>>>>>> [    0.000000]  panic+0x16c/0x37c
>>>>>>>> [    0.000000]  early_pgtable_alloc+0x30/0xa0
>>>>>>>
>>>>>>> ... really early!
>>>>>>>
>>>>>>>> [    0.000000]  __create_pgd_mapping+0x36c/0x588
>>>>>>>> [    0.000000]  map_kernel_segment+0x70/0xa4
>>>>>>>> [    0.000000]  paging_init+0xf4/0x528
>>>>>>>> [    0.000000]  setup_arch+0x250/0x5d8
>>>>>>>> [    0.000000]  start_kernel+0x90/0x6d8
>>>>>>>>
>>>>>>>>  
>>>>>>>> Since the same kernel boot with bootefi and that bootefi lack ramdisk address,
>>>>>>>
>>>>>>> Booting with EFI will cause linux to use the EFI memory map.
>>>>>>>
>>>>>>> Does your DT have a memory node? (or does it expect EFI to provide the information)
>>>>>>>
>>>>>>>
>>>>>>>> I tried to add the address in the dtb via:
>>>>>>>> fdt addr 0x02400000; fdt resize; fdt set /chosen linux,initrd-start 0x02700000; fdt set /chosen linux,initrd-end 0x10000000; bootefi 0x00080000 0x02400000
>>>>>>>> But with that, I get:
>>>>>>>> initrd not fully accessible via the linear mapping -- please check your bootloader ...
>>>>>>>
>>>>>>> So this one is an EFI boot, but you can't find where to put the initramfs such that the
>>>>>>> kernel agrees its in memory.
>>>>>>>
>>>>>>> If you boot with 'efi=debug', linux will print the EFI memory map. Could you compare that
>>>>>>> to where U-Boot thinks memory is?
>>>>>>>
>>>>>>> (it sounds like your DT memory node is missing, and your EFI memory map is surprisingly small)
>>>>>>
>>>>>> Hello
>>>>>>
>>>>>> Thanks for your advices.
>>>>>>
>>>>>> In the dtb of mainline linux:
>>>>>> 	/* Will be filled by the bootloader */
>>>>>> 	memory@0 {
>>>>>> 		device_type = "memory";
>>>>>> 		reg = <0 0 0>;
>>>>>> 	};
>>>>>>
>>>>>> In uboot I have:
>>>>>> static struct mm_region bcm2711_mem_map[] = {
>>>>>>         {
>>>>>>                 .virt = 0x00000000UL,
>>>>>>                 .phys = 0x00000000UL,
>>>>>>                 .size = 0xfe000000UL,
>>>>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>>>>                          PTE_BLOCK_INNER_SHARE
>>>>>>         }, {
>>>>>>                 .virt = 0xfc000000UL,
>>>>>>                 .phys = 0xfc000000UL,
>>>>>>                 .size = 0x03800000UL,
>>>>>>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>>                          PTE_BLOCK_NON_SHARE |
>>>>>>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>>>>         }, {
>>>>>>                 /* List terminator */
>>>>>>                 0,
>>>>>>         }
>>>>>> };
>>>>>> But I dont know if uboot use that for filling the memory node.
>>>>>
>>>>> No it doesn't. U-Boot uses the DT from the firmware and passes this to the
>>>>> kernel. But it seems you pass instead your own device-tree to the kernel, so you
>>>>> will need to update the memory node to show the available memory on you board.
>>>>>
>>>>
>>>> I dont understand, in the Linux commit "ARM: dts: Add minimal Raspberry Pi 4 support" I read:
>>>> The RPi 4 is available in 3 different variants (1, 2 and 4 GB RAM), so leave the memory size to zero and let the bootloader take care of it.
>>>> But if uboot dont fill that...
>>>> So the DTB in mainline is wrong, right ?
>>>>
>>>
>>> How do you pass your DTB to the kernel? Does the FW uses your DTB by putting it
>>> as bcm2711-rpi-4-b.dtb in the first FAT partition? Or do you load it from U-Boot
>>> afterwards? In the latter case you have to take care to add the needed size of
>>> memory. In the first case you use what is the default behavior for U-Boot; the
>>> RPi FW updates the node and then passes it to U-Boot then it get's passed to the
>>> kernel.
>>>
>>
>> Hello
>>
>> I load the dtb via uboot/tftp.
>> On another thread, I got the hint to enable CONFIG_ARCH_FIXUP_FDT_MEMORY and it made my problem solved.
> 
> Hm, so should we enable that for all RPi3/4/arm64 configs then?

In u-boot, it's already enabled, except RPI4. I didn't check in more detail.

In RPI4's case, it doesn't set in config
# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set

Best Regards,
Jaehoon Chung

> 
> Regards,
> Matthias
> 
> 
> 

