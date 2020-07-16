Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9DFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38102065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WnesXrzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgGPMdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:33:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60337 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:33:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200716123320euoutp015fc311df005f470ebcda70ba4ec391d3~iO6Wlkd5e2227922279euoutp01a
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200716123320euoutp015fc311df005f470ebcda70ba4ec391d3~iO6Wlkd5e2227922279euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594902800;
        bh=9DnYj/Mcnl7D+N2vvSUiF6bYj4ztAICZv91rvBzSS78=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WnesXrzb1QcYuaPgyeVOlr5pBdu2o8m97EmP2JI4tkskq58+r5F1FdpfyUssUjZ2+
         rJgCcpHf5MaY6rjB3aPXd7MftcuzX7u9F9m4fdSW4rHchtVbAAlJJdpaVAADgb+KOT
         Oa2paJhKhAHFMXH7g4rgspTLaoA21MjJXOic4FGY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200716123320eucas1p24638efb7279e556c85901f5a890f6def~iO6WbjzTi1698816988eucas1p2G;
        Thu, 16 Jul 2020 12:33:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AB.AF.06456.019401F5; Thu, 16
        Jul 2020 13:33:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200716123319eucas1p219d57ab8efe9028686f2536e4ec935fa~iO6V4LNTj1227712277eucas1p2P;
        Thu, 16 Jul 2020 12:33:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716123319eusmtrp2fb3e7f43ba9a46631d7c04f4c0bc9eb3~iO6V3k-qT3164831648eusmtrp2a;
        Thu, 16 Jul 2020 12:33:19 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-d8-5f1049105e59
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.A9.06314.F09401F5; Thu, 16
        Jul 2020 13:33:19 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200716123319eusmtip2982c127d4f33a99ab59c352ee23a8364~iO6VeV0dN1703317033eusmtip2t;
        Thu, 16 Jul 2020 12:33:19 +0000 (GMT)
Subject: Re: [PATCH v2] usb: dwc2: Fix error path in gadget registration
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4741f20f-6e8e-157b-6ecb-828ad4423210@samsung.com>
Date:   Thu, 16 Jul 2020 14:33:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b7571d9c-95ac-26ec-538e-60e1aae0cddb@synopsys.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7oCngLxBvO7ZCw2zljPanGs7Qm7
        RfPi9WwWl3fNYbNYtKyV2eLdlNvMDmwem1Z1snnsn7uG3aNvyypGjy37PzN6fN4kF8AaxWWT
        kpqTWZZapG+XwJXxvs2hoFWp4sjh98wNjJ9luhg5OSQETCSeHTnL3sXIxSEksIJR4uHy3UwQ
        zhdGibPPV7JAOJ8ZJTpO3WKDafmx7QJUYjmjxM7jF6Fa3jNKzHg3iR2kSljAQ+J682ZGEFtE
        oFDixdvjYB3MAmcZJW52bWcCSbAJGEp0ve0CG8srYCdx8fg1sDiLgKrE5N2PmUFsUYE4ifUv
        Iep5BQQlTs58wgJicwo4SLzbuASsl1lAXmL72znMELa4xK0n88EukhBYxS5x4sUyFoi7XSTO
        L4WxhSVeHd/CDmHLSPzfCdPQDAyCc2vZIZweRonLTTMYIaqsJe6c+wW0jgNohabE+l36EGFH
        iR0vFjOBhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSF6bheSd
        WUjemYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzA5HP63/FPOxi/Xko6xCjA
        wajEw6vwky9eiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9
        jBUSSE8sSc1OTS1ILYLJMnFwSjUwLjdbe6TFWPmq8jq912/zmLTbqw76/NVQSpnNyeD767fn
        02nxd5U9XR/8Pc1WfHK30pYVRk8LLx/e42i2rqj7yxUn8dAzf6SO3Cqpmzg7Kzm4Qfy8jePk
        B5smqHQ52etVSO04/pLjs1nXpxxHe6lGyY38bc8jBC2Cr8/cfibS3+jzN04G4cvMSizFGYmG
        WsxFxYkACyxw8ToDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7r8ngLxBl3vjSw2zljPanGs7Qm7
        RfPi9WwWl3fNYbNYtKyV2eLdlNvMDmwem1Z1snnsn7uG3aNvyypGjy37PzN6fN4kF8AapWdT
        lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxvs2hoFWp
        4sjh98wNjJ9luhg5OSQETCR+bLvAAmILCSxllLh9UgAiLiNxcloDK4QtLPHnWhdbFyMXUM1b
        Rok57e+YQBLCAh4S15s3M4LYIgKFEiu7L4IVMQucZ5SYfuQjI0THcUaJ5weOgFWxCRhKdL0F
        GcXJwStgJ3Hx+DWwSSwCqhKTdz9mBrFFBeIklm+Zzw5RIyhxcuYTsPM4BRwk3m1cAtbLLGAm
        MW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yY
        W1yal66XnJ+7iREYa9uO/dy8g/HSxuBDjAIcjEo8vAo/+eKFWBPLiitzDzFKcDArifA6nT0d
        J8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wDSQVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBMUVFmXn29v8rk4Ikm99XL/mh46F/8trTXfsuxb688i5S/hrr
        dyWNZ8kP7gaUuORMlxBQvxrwtuTI2q5NS67v7+uWN7C7773ILK2KT9BO8dyFL0XV9y7wHw1q
        z8zKmnOr5vR+jnKeO8evv1wj1GTMltCt9XtuYnWU5MfmqlnhqV8M45eHJIdJKLEUZyQaajEX
        FScCAFwdyUXLAgAA
X-CMS-MailID: 20200716123319eucas1p219d57ab8efe9028686f2536e4ec935fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44
References: <CGME20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44@eucas1p1.samsung.com>
        <20200716120948.28180-1-m.szyprowski@samsung.com>
        <b7571d9c-95ac-26ec-538e-60e1aae0cddb@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 16.07.2020 14:19, Minas Harutyunyan wrote:
> On 7/16/2020 4:09 PM, Marek Szyprowski wrote:
>> When gadget registration fails, one should not call usb_del_gadget_udc().
>> Ensure this by setting gadget->udc to NULL. Also in case of a failure
>> there is no need to disable low-level hardware, so return immiedetly
>> instead of jumping to error_init label.
>>
>> This fixes the following kernel NULL ptr dereference on gadget failure
>> (can be easily triggered with g_mass_storage without any module
>> parameters):
>>
>> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=1
>> dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
>> dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
>> Mass Storage Function, version: 2009/09/11
>> LUN: removable file: (no medium)
>> no file given for LUN0
>> g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
>> 8<--- cut here ---
>> Unable to handle kernel NULL pointer dereference at virtual address 00000104
>> pgd = (ptrval)
>> [00000104] *pgd=00000000
>> Internal error: Oops: 805 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.8.0-rc5 #3133
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events deferred_probe_work_func
>> PC is at usb_del_gadget_udc+0x38/0xc4
>> LR is at __mutex_lock+0x31c/0xb18
>> ...
>> Process kworker/0:1 (pid: 12, stack limit = 0x(ptrval))
>> Stack: (0xef121db0 to 0xef122000)
>> ...
>> [<c076bf3c>] (usb_del_gadget_udc) from [<c0726bec>] (dwc2_hsotg_remove+0x10/0x20)
>> [<c0726bec>] (dwc2_hsotg_remove) from [<c0711208>] (dwc2_driver_probe+0x57c/0x69c)
>> [<c0711208>] (dwc2_driver_probe) from [<c06247c0>] (platform_drv_probe+0x6c/0xa4)
>> [<c06247c0>] (platform_drv_probe) from [<c0621df4>] (really_probe+0x200/0x48c)
>> [<c0621df4>] (really_probe) from [<c06221e8>] (driver_probe_device+0x78/0x1fc)
>> [<c06221e8>] (driver_probe_device) from [<c061fcd4>] (bus_for_each_drv+0x74/0xb8)
>> [<c061fcd4>] (bus_for_each_drv) from [<c0621b54>] (__device_attach+0xd4/0x16c)
>> [<c0621b54>] (__device_attach) from [<c0620c98>] (bus_probe_device+0x88/0x90)
>> [<c0620c98>] (bus_probe_device) from [<c06211b0>] (deferred_probe_work_func+0x3c/0xd0)
>> [<c06211b0>] (deferred_probe_work_func) from [<c0149280>] (process_one_work+0x234/0x7dc)
>> [<c0149280>] (process_one_work) from [<c014986c>] (worker_thread+0x44/0x51c)
>> [<c014986c>] (worker_thread) from [<c0150b1c>] (kthread+0x158/0x1a0)
>> [<c0150b1c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>> Exception stack(0xef121fb0 to 0xef121ff8)
>> ...
>> ---[ end trace 9724c2fc7cc9c982 ]---
>>
>> While fixing this also fix the double call to dwc2_lowlevel_hw_disable()
>> if dr_mode is set to USB_DR_MODE_PERIPHERAL. In such case low-level
>> hardware is already disabled before calling usb_add_gadget_udc(). That
>> function correctly preserves low-level hardware state, there is no need
>> for the second unconditional dwc2_lowlevel_hw_disable() call.
>>
>> Fixes: 207324a321a8 ("usb: dwc2: Postponed gadget registration to the udc class driver")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>    drivers/usb/dwc2/platform.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
>> index cb8ddbd53718..db9fd4bd1a38 100644
>> --- a/drivers/usb/dwc2/platform.c
>> +++ b/drivers/usb/dwc2/platform.c
>> @@ -582,6 +582,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
>>    	if (hsotg->gadget_enabled) {
>>    		retval = usb_add_gadget_udc(hsotg->dev, &hsotg->gadget);
>>    		if (retval) {
>> +			hsotg->gadget.udc = NULL;
> Consider your recently sent patch "[PATCH] usb: gadget: udc: Flush
> pending work also in error path", more probably it's not required,
> because root cause of observed dwc2 issue comes from udc.
> Am I wrong?

They are two independent issues, both fatal on my test system.

The first one (the lack of NULLing gadget->udc) can be easily triggered 
on any system. The latter one (lack of flush in UDC core) depends on the 
luck and memory layout on the test system.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

