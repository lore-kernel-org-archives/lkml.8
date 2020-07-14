Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7F12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fQNQBl07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgGNIsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:48:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51517 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:48:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200714084808euoutp02c7929af6b8e3e12b2a84e27a5d160c3c~hkjJpqXOA0706607066euoutp02u
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:48:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200714084808euoutp02c7929af6b8e3e12b2a84e27a5d160c3c~hkjJpqXOA0706607066euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594716488;
        bh=nf9+rmH806iB74WPwNFe4oqbior1dSEZhoJ7GlacjDk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fQNQBl071BT9nZGPGW5MqxTwd6FJBOO50PMkuGhb1BfM1KWFCnRQePG2aZGTa94w6
         GU26+9s9H2U0Jt8dyHtH6VOPxJ+Y3NMhGYhzovsdULRDmqPibkO9N6aXT4Cx9OHkOy
         YraeUZFUVK/gQGE3hKV6VTGTB5Lg1VosyUYRS6Jw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200714084808eucas1p19a340f9b3d245baa125565eafbc89992~hkjJeJzbP0985509855eucas1p1F;
        Tue, 14 Jul 2020 08:48:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.FA.06456.7417D0F5; Tue, 14
        Jul 2020 09:48:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200714084807eucas1p1f6e680d162573c6a0660037172a65805~hkjJGzWkA3158931589eucas1p1e;
        Tue, 14 Jul 2020 08:48:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200714084807eusmtrp19327fdb45397ddfab5ad9af6edb2ba27~hkjJGJcdw0886508865eusmtrp1T;
        Tue, 14 Jul 2020 08:48:07 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-a2-5f0d7147c03d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.49.06017.7417D0F5; Tue, 14
        Jul 2020 09:48:07 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200714084807eusmtip16580d3ed95cbdcd055ffd5bf2b5ca7df~hkjIq9KwM1330213302eusmtip1Y;
        Tue, 14 Jul 2020 08:48:07 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc2: Fix error path in gadget registration
Date:   Tue, 14 Jul 2020 10:48:00 +0200
Message-Id: <20200714084800.11340-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87ruhbzxBq9v2FhsnLGe1eJY2xN2
        i+bF69ksGn/tZbe4vGsOm8WiZa3MFmuP3GV3YPfYtKqTzWP/3DXsHn1bVjF6bNn/mdHj8ya5
        ANYoLpuU1JzMstQifbsEroymvrtsBQ8lKw788WxgXCfWxcjJISFgInH94hPGLkYuDiGBFYwS
        e47cYANJCAl8YZRouWcKkfjMKNHQ9YMZpqPrbSM7RGI5o8TLhd+hHKCOuf+2soBUsQkYAlV1
        gY0SEZCVOHzlNzNIEbNAC5PE4vMHwEYJCzhK7D77B2g5BweLgKrE2/NVIGFeAVuJV+cnM0Js
        k5dYveEA1ObrbBLN3zIhbBeJey2tLBC2sMSr41vYIWwZidOTe1hAdkkINDNKPDy3lh3C6WGU
        uNw0A2qqtcSdc7/YQBYzC2hKrN+lDxF2lOh/8g3sHgkBPokbbwVBwsxA5qRt05khwrwSHW1C
        ENVqErOOr4Nbe/DCJagzPSQOXT8ODcVYib3P2hgnMMrNQti1gJFxFaN4amlxbnpqsWFearle
        cWJucWleul5yfu4mRmAiOP3v+KcdjF8vJR1iFOBgVOLhlfDniRdiTSwrrsw9xCjBwawkwut0
        9nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYym5ie3
        nonubvZfEqoq31W7ePvMRy/8FxtbanbF/N+35/p5J8usYwdrVt7ccXCyKROD/7zyCpdvzh8V
        ImZJtfg81L3fEXU79d0WlQfnLBxbOmLMome58Oo2Bl9U9fvRYdmZePDsb8kPoUW2t/k8A+bO
        nXDD2Zr5GkPNpNNc0T1rj6h9WVwisVCJpTgj0VCLuag4EQD2V+OBAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xu7ruhbzxBgsmqFlsnLGe1eJY2xN2
        i+bF69ksGn/tZbe4vGsOm8WiZa3MFmuP3GV3YPfYtKqTzWP/3DXsHn1bVjF6bNn/mdHj8ya5
        ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYym
        vrtsBQ8lKw788WxgXCfWxcjJISFgItH1tpG9i5GLQ0hgKaNEd+MjZoiEjMTJaQ2sELawxJ9r
        XWwQRZ8YJQ41rWIDSbAJGAJ1d4HZIgKyEoev/GYGKWIW6GCS6O35yQiSEBZwlNh99g+QzcHB
        IqAq8fZ8FUiYV8BW4tX5yYwQC+QlVm84wDyBkWcBI8MqRpHU0uLc9NxiI73ixNzi0rx0veT8
        3E2MwBDcduznlh2MXe+CDzEKcDAq8fBK+PPEC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1
        KD++qDQntfgQoynQ7onMUqLJ+cD4yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpa
        kFoE08fEwSnVwFjz1++FelXa3pRNzZf1jRyPXlbf2NpyN5atgOfkih38MslJy1ODV3T2M835
        PY9X6frWfcFvTI032hou6fsVv+NhkGBX4Spl/6r/5tl8Hgyc0Xn3PFx2vBCXee8gtInz/o0b
        Z6LuhO5+93iO5bXI5X6dvu+qfRvX7Ft3e4nQgms7o5Qt5vdJ2iqxFGckGmoxFxUnAgDdMmdb
        VwIAAA==
X-CMS-MailID: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714084807eucas1p1f6e680d162573c6a0660037172a65805
References: <CGME20200714084807eucas1p1f6e680d162573c6a0660037172a65805@eucas1p1.samsung.com>
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

Fixes: 207324a321a8 ("usb: dwc2: Postponed gadget registration to the udc class driver")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc2/platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c347d93eae64..a6022dc4766d 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -581,8 +581,9 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (hsotg->gadget_enabled) {
 		retval = usb_add_gadget_udc(hsotg->dev, &hsotg->gadget);
 		if (retval) {
+			hsotg->gadget.udc = NULL;
 			dwc2_hsotg_remove(hsotg);
-			goto error_init;
+			return retval;
 		}
 	}
 #endif /* CONFIG_USB_DWC2_PERIPHERAL || CONFIG_USB_DWC2_DUAL_ROLE */
-- 
2.17.1

