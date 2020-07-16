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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E5DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5406120739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PTV6kiSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGPLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:55:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgGPLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:55:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200716115547euoutp0201dd07ce81b1f9062b613c1c3b28fbcd~iOZkObQkF1423814238euoutp02I
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200716115547euoutp0201dd07ce81b1f9062b613c1c3b28fbcd~iOZkObQkF1423814238euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594900547;
        bh=cIRPYgYzinS3D/k4iPXOgxJ2xAK52n0VPhrt72zC4L8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PTV6kiSsaNe5BX/L9ICZVKWt7nwKVreSTu6SxkY2tnJbmLCunDv/6mAAZNhqV9Jov
         NpfsJCIRJMSzg8krfIsWsgEqNJBarKnJpTG3tkYv9NOwORR3CV5oDDyM8VeO7QDCtm
         OzqxRyVZpqWxx2kN4l/NU8l5V1IEro21BAH3NG0k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200716115547eucas1p11148d339d893a37a13328ca64197fbd1~iOZj8yLNt1829418294eucas1p1F;
        Thu, 16 Jul 2020 11:55:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.28.05997.340401F5; Thu, 16
        Jul 2020 12:55:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92~iOZi6UUr61630116301eucas1p1L;
        Thu, 16 Jul 2020 11:55:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200716115546eusmtrp1e873061868ffda7051f7fa8691a21d53~iOZi5tFY20277402774eusmtrp1M;
        Thu, 16 Jul 2020 11:55:46 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-5c-5f1040433071
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.55.06017.240401F5; Thu, 16
        Jul 2020 12:55:46 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200716115545eusmtip1731eb7b09a570f30eea725174084b560~iOZidUo1U1478814788eusmtip18;
        Thu, 16 Jul 2020 11:55:45 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: gadget: udc: Flush pending work also in error path
Date:   Thu, 16 Jul 2020 13:55:25 +0200
Message-Id: <20200716115525.27519-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87rODgLxBl++8VpsnLGe1eJY2xN2
        i+bF69ksGn/tZbe4vGsOm8WiZa3MFmuP3GV3YPfYtKqTzWP/3DXsHn1bVjF6bNn/mdHj8ya5
        ANYoLpuU1JzMstQifbsErow3fw+xFTwUqpj4cipzA2OjQBcjJ4eEgIlE/8N29i5GLg4hgRWM
        EhfX3WCFcL4wSrz5dwsq85lRYvmju0wwLdumz2SESCxnlLhw8iwzXMvF22cZQarYBAwlut52
        sYHYIgKyEoev/AYrYhZoYZK48O0zO0hCWMBD4tqvj6wgNouAqsTVlofMIDavgK3E2j+dbBDr
        5CVWbzgA1iwhcJ1NYvXVJ1B3uEi8fXgAqkhY4tXxLewQtozE6ck9LBANzYwSD8+tZYdwehgl
        LjfNYISospa4c+4XUDcH0E2aEut36UOEHSWm3OgDC0sI8EnceCsIEmYGMidtm84MEeaV6GgT
        gqhWk5h1fB3c2oMXLkGVeEg0/ckBCQsJxEosufOAeQKj3CyEVQsYGVcxiqeWFuempxYb5aWW
        6xUn5haX5qXrJefnbmIEpoPT/45/2cG460/SIUYBDkYlHl6Fn3zxQqyJZcWVuYcYJTiYlUR4
        nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBUc96
        luWf0vxpN3a2L1CXUn94Zl1clWvqEnG/6wr8nBtPH9dWWNi/y+S7bdT3P48O8u1xuRAYrbq2
        t2pJS/KBXQm5/1zuLnu/4Fbw6VrG8wneH3tn7nC+9eIpY/7ZmZ9j9VK/Wii9PPWnS9lr+Zkj
        PaXxy5iWc389qff5ckympcjOXAeBeoMpSUosxRmJhlrMRcWJAGjUnBIDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xu7pODgLxBm3drBYbZ6xntTjW9oTd
        onnxejaLxl972S0u75rDZrFoWSuzxdojd9kd2D02repk89g/dw27R9+WVYweW/Z/ZvT4vEku
        gDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PN
        30NsBQ+FKia+nMrcwNgo0MXIySEhYCKxbfpMRhBbSGApo8Sut1kQcRmJk9MaWCFsYYk/17rY
        uhi5gGo+AdXcnscGkmATMJToetsFZosIyEocvvKbGaSIWaCDSaL18SxmkISwgIfEtV8fwSax
        CKhKXG15CBbnFbCVWPunkw1ig7zE6g0HmCcw8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGITbjv3csoOx613wIUYBDkYlHl6Fn3zxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEot
        yo8vKs1JLT7EaAq0fCKzlGhyPjBC8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YW
        pBbB9DFxcEo1MJZteVus8f+3SGzRiante4XrWRaujw0wCjx49Z72xTSr93wVqirX+VkuLv0g
        1LZ36g0nab8/ditKc348cq7wORJr+SNH8PuHO5NuTjc8cFjTcE92800hvXkq7XcmbZA6HKZ+
        eee8X9N/PXrivenUjW7XpXbNs7bLtTvdn7Z0Q12Nys7WjjVH/hxUYinOSDTUYi4qTgQACLO1
        F1gCAAA=
X-CMS-MailID: 20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92
References: <CGME20200716115546eucas1p1deb159dd37bc1211f4579d4d85f9af92@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When binding an UDC driver to the pending gadget fails in
check_pending_gadget_drivers(), the usb_add_gadget_udc_release() function
ends without waiting for the usb_gadget_state_work to finish, what in
turn might cause the whole struct usb_gadget being freed by the caller
before the usb_gadget_state_work being executed.

This can be observed on some boards with USB Mass Storage gadget
compiled-in and kernel booted without the needed module parameters:

dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter besl=1
dwc2 12480000.hsotg: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
no file given for LUN0
g_mass_storage 12480000.hsotg: failed to start g_mass_storage: -22
dwc2: probe of 12480000.hsotg failed with error -22
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = (ptrval)
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 88 Comm: kworker/1:2 Not tainted 5.8.0-rc5-next-20200715-00062-gc5bb489ae825-dirty #8792
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue:  0x0 (rcu_gp)
PC is at process_one_work+0x44/0x7dc
...
Process kworker/1:2 (pid: 88, stack limit = 0x(ptrval))
Stack: (0xed9f1f00 to 0xed9f2000)
...
[<c0148590>] (process_one_work) from [<c0148d6c>] (worker_thread+0x44/0x51c)
[<c0148d6c>] (worker_thread) from [<c01500c0>] (kthread+0x158/0x1a0)
[<c01500c0>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xed9f1fb0 to 0xed9f1ff8)
...
---[ end trace 5033c1326a62e5f3 ]---
note: kworker/1:2[88] exited with preempt_count 1

Fix this by flushing pending work in error path.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/gadget/udc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index c33ad8a333ad..4f82bcd31fd3 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1230,6 +1230,7 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 	return 0;
 
  err_del_udc:
+	flush_work(&gadget->work);
 	device_del(&udc->dev);
 
  err_unlist_udc:
-- 
2.17.1

