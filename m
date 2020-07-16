Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F15AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51022074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GMNbWsWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGPMJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:09:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50830 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgGPMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:09:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200716120957euoutp01c3e366379c3baaa2a57e7a6e0f46487a~iOl7bP-0W0249102491euoutp01q
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:09:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200716120957euoutp01c3e366379c3baaa2a57e7a6e0f46487a~iOl7bP-0W0249102491euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594901397;
        bh=qV/2zLgNvC0a3UfT7Zky5MCOQpz0Ag3pF7I6DZ5fm1s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GMNbWsWaqZ9GuLmZU3sVeZE3Lq1sE+7Lo/LhrnDVp8htNyf7lZ0pes+u7sm17AwL8
         R0xZkMnBI33E7I5VKdWOTdYf+uaqYChZkE/+0NN4c4VYB7lZ2JTjFFcyjomQTwMORP
         NI2BXmEU2NlDOtUcHz+G5kxd+SNwmOHm2K6mQqTg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200716120956eucas1p182b19f804e68f5e7359a54077682e848~iOl7KjAvP1344213442eucas1p1V;
        Thu, 16 Jul 2020 12:09:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.5E.06318.493401F5; Thu, 16
        Jul 2020 13:09:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44~iOl60-zXW1000010000eucas1p1C;
        Thu, 16 Jul 2020 12:09:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716120956eusmtrp28afd21a2b3556b05592dd73f0f68640a~iOl60a8Kt1849418494eusmtrp2U;
        Thu, 16 Jul 2020 12:09:56 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-0e-5f1043948671
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.16.06314.493401F5; Thu, 16
        Jul 2020 13:09:56 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200716120956eusmtip2c7234882333b6b2ce6f3b01c7cd3e0dc~iOl6Z26RE0100101001eusmtip2h;
        Thu, 16 Jul 2020 12:09:55 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] usb: dwc2: Fix error path in gadget registration
Date:   Thu, 16 Jul 2020 14:09:48 +0200
Message-Id: <20200716120948.28180-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7pTnAXiDQ4/1rPYOGM9q8Wxtifs
        Fs2L17NZNP7ay25xedccNotFy1qZLdYeucvuwO6xaVUnm8f+uWvYPfq2rGL02LL/M6PH501y
        AaxRXDYpqTmZZalF+nYJXBlrT05iKVguVzFzmmID42KpLkZODgkBE4m3866xdDFycQgJrGCU
        WPf2ECOE84VR4vKRb1CZz4wSUzf1s8C0LH7SDFW1nFHi7/dNzCAJsJa700xAbDYBQ4mut11s
        ILaIgKzE4Su/mUEamAVamCQWnz8A1iAs4CIxaW4XE4jNIqAq8WJpD1icV8BWYub/z1Db5CVW
        bzgA1iwhcJ1NYvLfi6wQCReJrasOskHYwhKvjm9hh7BlJP7vnM8E0dDMKPHw3Fp2CKcH6KOm
        GYwQVdYSd879AurmALpJU2L9Ln2IsKPEjheLmUDCEgJ8EjfeCoKEmYHMSdumM0OEeSU62oQg
        qtUkZh1fB7f24IVLzBC2h0RD50YmSKDESpzY+Id1AqPcLIRdCxgZVzGKp5YW56anFhvnpZbr
        FSfmFpfmpesl5+duYgQmg9P/jn/dwbjvT9IhRgEORiUe3orffPFCrIllxZW5hxglOJiVRHid
        zp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoExR6wn
        Tcde6ssqrsrvXtOdhW7ps4TyPk+fddhn5s815Z7Fs9YXNBY2vTJTyvuzy/J22oS+/c4Cz05a
        vWtQE4z/VZ/pebbz2NlFZlmsHKu+rHVlctikUBG2N8RL7Hum188bLCvn7QhL3pnaciti98eD
        d171y7e83H5COPpNmKXCs+hdJYUTmhSUWIozEg21mIuKEwGE4vyFAgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xe7pTnAXiDSbOErfYOGM9q8Wxtifs
        Fs2L17NZNP7ay25xedccNotFy1qZLdYeucvuwO6xaVUnm8f+uWvYPfq2rGL02LL/M6PH501y
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlr
        T05iKVguVzFzmmID42KpLkZODgkBE4nFT5oZuxi5OIQEljJKHDj4kwkiISNxcloDK4QtLPHn
        WhcbiC0k8IlRYsYSSRCbTcBQoustRFxEQFbi8JXfzCCDmAU6mCR6e34ygiSEBVwkJs3tAhvK
        IqAq8WJpDzOIzStgKzHz/2cWiAXyEqs3HGCewMizgJFhFaNIamlxbnpusaFecWJucWleul5y
        fu4mRmAIbjv2c/MOxksbgw8xCnAwKvHwKvzkixdiTSwrrsw9xCjBwawkwut09nScEG9KYmVV
        alF+fFFpTmrxIUZToOUTmaVEk/OB8ZFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1
        tSC1CKaPiYNTqoExo9XhsGrrpyKlXdn8mTlJRjnvzt86veaXBb9G9OJDa/mvpX1eeuGSbOtc
        Wb/XKfaiycfu/75zV8DKa8P7/5M4ZYX1+RMYjN4knDcvsvkU6D67Re9NiIPHv3ojSQ4evmcz
        fFjfaq3/EFwZX/+c/5i0+72v+/9IVwU99DE+yurIN9UpiO+7xWwlluKMREMt5qLiRAANp9JC
        VwIAAA==
X-CMS-MailID: 20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44
References: <CGME20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gadget registration fails, one should not call usb_del_gadget_udc().
Ensure this by setting gadget->udc to NULL. Also in case of a failure
there is no need to disable low-level hardware, so return immiedetly
instead of jumping to error_init label.

This fixes the following kernel NULL ptr dereference on gadget failure
(can be easily triggered with g_mass_storage without any module
parameters):

dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=1
dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
no file given for LUN0
g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000104
pgd = (ptrval)
[00000104] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.8.0-rc5 #3133
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events deferred_probe_work_func
PC is at usb_del_gadget_udc+0x38/0xc4
LR is at __mutex_lock+0x31c/0xb18
...
Process kworker/0:1 (pid: 12, stack limit = 0x(ptrval))
Stack: (0xef121db0 to 0xef122000)
...
[<c076bf3c>] (usb_del_gadget_udc) from [<c0726bec>] (dwc2_hsotg_remove+0x10/0x20)
[<c0726bec>] (dwc2_hsotg_remove) from [<c0711208>] (dwc2_driver_probe+0x57c/0x69c)
[<c0711208>] (dwc2_driver_probe) from [<c06247c0>] (platform_drv_probe+0x6c/0xa4)
[<c06247c0>] (platform_drv_probe) from [<c0621df4>] (really_probe+0x200/0x48c)
[<c0621df4>] (really_probe) from [<c06221e8>] (driver_probe_device+0x78/0x1fc)
[<c06221e8>] (driver_probe_device) from [<c061fcd4>] (bus_for_each_drv+0x74/0xb8)
[<c061fcd4>] (bus_for_each_drv) from [<c0621b54>] (__device_attach+0xd4/0x16c)
[<c0621b54>] (__device_attach) from [<c0620c98>] (bus_probe_device+0x88/0x90)
[<c0620c98>] (bus_probe_device) from [<c06211b0>] (deferred_probe_work_func+0x3c/0xd0)
[<c06211b0>] (deferred_probe_work_func) from [<c0149280>] (process_one_work+0x234/0x7dc)
[<c0149280>] (process_one_work) from [<c014986c>] (worker_thread+0x44/0x51c)
[<c014986c>] (worker_thread) from [<c0150b1c>] (kthread+0x158/0x1a0)
[<c0150b1c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef121fb0 to 0xef121ff8)
...
---[ end trace 9724c2fc7cc9c982 ]---

While fixing this also fix the double call to dwc2_lowlevel_hw_disable()
if dr_mode is set to USB_DR_MODE_PERIPHERAL. In such case low-level
hardware is already disabled before calling usb_add_gadget_udc(). That
function correctly preserves low-level hardware state, there is no need
for the second unconditional dwc2_lowlevel_hw_disable() call.

Fixes: 207324a321a8 ("usb: dwc2: Postponed gadget registration to the udc class driver")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc2/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index cb8ddbd53718..db9fd4bd1a38 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -582,6 +582,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (hsotg->gadget_enabled) {
 		retval = usb_add_gadget_udc(hsotg->dev, &hsotg->gadget);
 		if (retval) {
+			hsotg->gadget.udc = NULL;
 			dwc2_hsotg_remove(hsotg);
 			goto error_init;
 		}
@@ -593,7 +594,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
 error:
-	dwc2_lowlevel_hw_disable(hsotg);
+	if (hsotg->dr_mode != USB_DR_MODE_PERIPHERAL)
+		dwc2_lowlevel_hw_disable(hsotg);
 	return retval;
 }
 
-- 
2.17.1

