Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF9C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E9720848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:10:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgCFHKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:10:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 52BDAEF5ED8D67856FF8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 15:10:47 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 15:10:40 +0800
Subject: Re: [PATCH] bus: hisi_lpc: Fixup IO ports addresses to avoid
 use-after-free in host removal
To:     John Garry <john.garry@huawei.com>
References: <1579200514-184352-1-git-send-email-john.garry@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5E61F770.2040101@hisilicon.com>
Date:   Fri, 6 Mar 2020 15:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1579200514-184352-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2020/1/17 2:48, John Garry wrote:
> Some released ACPI FW for Huawei boards describes incorrect the port IO
> address range for child devices, in that it tells us the IO port max range
> is 0x3fff for each child device, which is not correct. The address range
> should be [e4:e8) or similar. With this incorrect upper range, the child
> device IO port resources overlap.
> 
> As such, the kernel thinks that the LPC host serial device is a child of
> the IPMI device:
> 
> root@(none)$ more /proc/ioports
> [...]
> 00ffc0e3-00ffffff : hisi-lpc-ipmi.0.auto
>   00ffc0e3-00ffc0e3 : ipmi_si
>   00ffc0e4-00ffc0e4 : ipmi_si
>   00ffc0e5-00ffc0e5 : ipmi_si
>   00ffc2f7-00ffffff : serial8250.1.auto
>     00ffc2f7-00ffc2fe : serial
> root@(none)$
> 
> They should both be siblings. Note that these are logical PIO addresses,
> which have a direct mapping from the FW IO port ranges.
> 
> This shows up as a real issue when we enable CONFIG_KASAN and
> CONFIG_DEBUG_TEST_DRIVER_REMOVE - we see use-after-free warnings in the
> host removal path:
> 
> ==================================================================
> BUG: KASAN: use-after-free in release_resource+0x38/0xc8
> Read of size 8 at addr ffff0026accdbc38 by task swapper/0/1
> 
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc6-00001-g68e186e77b5c-dirty #1593
> Hardware name: Huawei Taishan 2180 /D03, BIOS Hisilicon D03 IT20 Nemo 2.0 RC0 03/30/2018
> Call trace:
> dump_backtrace+0x0/0x290
> show_stack+0x14/0x20
> dump_stack+0xf0/0x14c
> print_address_description.isra.9+0x6c/0x3b8
> __kasan_report+0x12c/0x23c
> kasan_report+0xc/0x18
> __asan_load8+0x94/0xb8
> release_resource+0x38/0xc8
> platform_device_del.part.10+0x80/0xe0
> platform_device_unregister+0x20/0x38
> hisi_lpc_acpi_remove_subdev+0x10/0x20
> device_for_each_child+0xc8/0x128
> hisi_lpc_acpi_remove+0x4c/0xa8
> hisi_lpc_remove+0xbc/0xc0
> platform_drv_remove+0x3c/0x68
> really_probe+0x174/0x548
> driver_probe_device+0x7c/0x148
> device_driver_attach+0x94/0xa0
> __driver_attach+0xa4/0x110
> bus_for_each_dev+0xe8/0x158
> driver_attach+0x30/0x40
> bus_add_driver+0x234/0x2f0
> driver_register+0xbc/0x1d0
> __platform_driver_register+0x7c/0x88
> hisi_lpc_driver_init+0x18/0x20
> do_one_initcall+0xb4/0x258
> kernel_init_freeable+0x248/0x2c0
> kernel_init+0x10/0x118
> ret_from_fork+0x10/0x1c
> 
> ...
> 
> The issue here is that the kernel created an incorrect parent-child
> resource dependency between two devices, and references the false parent
> node when deleting the second child device, when it had been deleted
> already.
> 
> Fix up the child device resources from FW to create proper IO port
> resource relationships for broken FW.
> 
> With this, the IO port layout looks more healthy:
> 
> root@(none)$ more /proc/ioports
> [...]
> 00ffc0e3-00ffc0e7 : hisi-lpc-ipmi.0.auto
>   00ffc0e3-00ffc0e3 : ipmi_si
>   00ffc0e4-00ffc0e4 : ipmi_si
>   00ffc0e5-00ffc0e5 : ipmi_si
> 00ffc2f7-00ffc2ff : serial8250.1.auto
>   00ffc2f7-00ffc2fe : serial
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Thanks!
Applied to the hisilicon arm64 driver tree.

Best Regards,
Wei

> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 8101df901830..08543579eefd 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -357,6 +357,26 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
>  	return 0;
>  }
>  
> +/*
> + * Released firmware describes the IO port max address as 0x3fff, which is
> + * the max host bus address. Fixup to a proper range. This will probably
> + * never be fixed in firmware.
> + */
> +static void hisi_lpc_acpi_fixup_child_resource(struct device *hostdev,
> +					       struct resource *r)
> +{
> +	if (r->end != 0x3fff)
> +		return;
> +
> +	if (r->start == 0xe4)
> +		r->end = 0xe4 + 0x04 - 1;
> +	else if (r->start == 0x2f8)
> +		r->end = 0x2f8 + 0x08 - 1;
> +	else
> +		dev_warn(hostdev, "unrecognised resource %pR to fixup, ignoring\n",
> +			 r);
> +}
> +
>  /*
>   * hisi_lpc_acpi_set_io_res - set the resources for a child
>   * @child: the device node to be updated the I/O resource
> @@ -418,8 +438,11 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
>  		return -ENOMEM;
>  	}
>  	count = 0;
> -	list_for_each_entry(rentry, &resource_list, node)
> -		resources[count++] = *rentry->res;
> +	list_for_each_entry(rentry, &resource_list, node) {
> +		resources[count] = *rentry->res;
> +		hisi_lpc_acpi_fixup_child_resource(hostdev, &resources[count]);
> +		count++;
> +	}
>  
>  	acpi_dev_free_resource_list(&resource_list);
>  
> 

