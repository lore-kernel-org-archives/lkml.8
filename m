Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56323C433FC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E402082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BCYLSUAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGJOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:23:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55123 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgGJOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:23:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142350euoutp01005e0c5dd1880fa3dfc480e06f4f5781~gajHcL03r3141431414euoutp01B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:23:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710142350euoutp01005e0c5dd1880fa3dfc480e06f4f5781~gajHcL03r3141431414euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391030;
        bh=wcpS6k1Ykt1y3vnMIGbauUhd3FyRkq8edvSKpMqac04=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=BCYLSUAKMBuCMWrwAMpQMyHDawNMKi2TMthPqhWzVQ1McvzHpMQjRPAMXiLEa8Wng
         EuiQ7y4kp/HHkNFBZ/NTeHhBDFo4sEVSCoGXBnyj7N/c+Xp/1tWrF8tJxcqc0lroox
         HdX4G+mESgJ5/MF0A9DffZHZ55cI6k5XD14uTtG0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710142350eucas1p22dd75b74c7b7bb7dd538746b11f5f728~gajHIPpTw0258502585eucas1p2y;
        Fri, 10 Jul 2020 14:23:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.DE.06318.5F9780F5; Fri, 10
        Jul 2020 15:23:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142349eucas1p2647e00300bd484a6a9ed420edd413cec~gajGvOVPI2124221242eucas1p2m;
        Fri, 10 Jul 2020 14:23:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710142349eusmtrp18952350534ee1fdde875ed88396fccf9~gajGunFG21135411354eusmtrp1R;
        Fri, 10 Jul 2020 14:23:49 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-34-5f0879f5cf4b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C9.D1.06314.5F9780F5; Fri, 10
        Jul 2020 15:23:49 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142349eusmtip2c3083710e4fe2af3f9ed9e208a861761~gajGNqE-z1081610816eusmtip2J;
        Fri, 10 Jul 2020 14:23:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: neofb: fix memory leak in
 neo_scan_monitor()
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Message-ID: <c07a27c2-3171-3f3a-6029-ef523cf889c4@samsung.com>
Date:   Fri, 10 Jul 2020 16:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200630195451.18675-1-novikov@ispras.ru>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG+XZmZ8elsc/V8M0sYSEhQU0MHFKkw2r/iqygEkrXHFbLqx2P
        NogWytTdCNPy2Cw3tSwLNS0vTPMoL1TUSo1NU0xSsSJTyGPJcZT87/me9/e8B3w0oWiWOtER
        0XGcNlodqaTkZOX7v93u8zo6eHdRrYTNLX1BsY9GvxDsh7mfFFtnmUZskdFAsm23f0nZ/tpc
        ii2o18vYwbt6ap+N6s28mVQV1E1KVNnWe0jVlr1IqtLy3yKVZXpZqhoxtkpUs+U7jtFBcr8w
        LjIigdN6+ofIw18PVKDYVvnlVGumTI/6aAOyoQHvgaUUK2VAclqBnyIY6CuVio8/CHIqCimB
        UuBZBMPXA9YTnekWiQgVIXjQnSQToRkEc1kaQVN4L9xJLkaCtseBUGh6uNrIAbuCPqmdFMIE
        Nksgo/HxKsRgf2iobFiFSLwTJgaMUkFvwafh99dmqcjYQXvO+EqYpm2wDww9txNsAjvC5/E8
        iahdoGomlxD6Ax6WQc90tlTcOgAm9GZK1PYw1fpKJmpn6My4RYqBEgTLKd/X0lUIijKsawlf
        sHQvUMJkAu+C0lpP0d4PN4xjMsEGbAuDM2sL2UJ6ZRYh2gyk3FSItCuUPSmj1scaap4RaUhp
        2nCZacM5pg3nmP7PNSOyGDly8XyUhuO9o7lED14dxcdHazzOx0SVo5Wv1WltnatG9UuhTQjT
        SLmJMavpYIVUncDropoQ0ITSgTnQ1XlOwYSpdVc4bUywNj6S45vQNppUOjLe+ZNnFVijjuMu
        clwsp12vSmgbJz1K3dpiVz7geyRzsWWwbsqbeXmNmp9PPGNf3TPqd7j+eFqw+7fGCz+4g85O
        y4E+HcmBhG+SrlgSmlMc4eE+cvSdf8l076c8VmYJKRgzgEui/ONmI0OMBnVphzoOufG6wK6l
        q5cYL/l215qJE3R/04zXfU3Lyd7eheEea/ijU2MKJcmHq73cCC2v/gezN+VwVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7pfKzniDZ5NVrGYs34Nm8XCh3eZ
        La58fc9msefOa0aL5d1dLBYn+j6wWlzeNYfNYvG+BnaLG1Ma2Bw4PfZ+W8DisXjPSyaPGf+m
        MnqcmPGbxWPCogOMHnde/2X1uN99nMnj8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyt1zczFhznquj8N429gfESRxcjJ4eEgInE6Ul3
        mLoYuTiEBJYySqz/dp+9i5EDKCEjcXx9GUSNsMSfa11sEDWvGSWmvF7OCpJgE7CSmNi+ihHE
        FhYIlFgyax4biC0ioCbR0HqSBaSBWWABk8SBjyuhursYJfY92AVWxStgJ7F/234wm0VAVeLZ
        9W6wqaICERKHd8xihKgRlDg58wkLyEWcAuYSN1cLgoSZBdQl/sy7xAxhi0vcejKfCcKWl9j+
        dg7zBEahWUi6ZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC43TbsZ+b
        dzBe2hh8iFGAg1GJh3dBIke8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8x
        mgL9NpFZSjQ5H5hC8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1
        MHq9M726e2raUeHNeiKZmfb6n/W/cMbnMn591b3u/G2tt73bAn9e2tYotWDuo9c+Xod7soxl
        eTWXNbktyE+UZF14P2z+DLOHMX5f6hRPrt9412ka5zuv65xNzxwnc63foHVxe0Z9VUnFpXP/
        2RalawXHvdgQnfTtx+otYhtauHqZt92plP1+8L4SS3FGoqEWc1FxIgBb5kyh6QIAAA==
X-CMS-MailID: 20200710142349eucas1p2647e00300bd484a6a9ed420edd413cec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200630195458eucas1p2fc508a96f648c8af44d5ed5ff906a103
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200630195458eucas1p2fc508a96f648c8af44d5ed5ff906a103
References: <CGME20200630195458eucas1p2fc508a96f648c8af44d5ed5ff906a103@eucas1p2.samsung.com>
        <20200630195451.18675-1-novikov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/20 9:54 PM, Evgeny Novikov wrote:
> neofb_probe() calls neo_scan_monitor() that can successfully allocate a
> memory for info->monspecs.modedb and proceed to case 0x03. There it does
> not free the memory and returns -1. neofb_probe() goes to label
> err_scan_monitor, thus, it does not free this memory through calling
> fb_destroy_modedb() as well. We can not go to label err_init_hw since
> neo_scan_monitor() can fail during memory allocation. So, the patch frees
> the memory directly for case 0x03.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/neofb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
> index f5a676bfd67a..09a20d4ab35f 100644
> --- a/drivers/video/fbdev/neofb.c
> +++ b/drivers/video/fbdev/neofb.c
> @@ -1819,6 +1819,7 @@ static int neo_scan_monitor(struct fb_info *info)
>  #else
>  		printk(KERN_ERR
>  		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
> +		kfree(info->monspecs.modedb);
>  		return -1;
>  #endif
>  	default:
> 
