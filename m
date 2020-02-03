Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DAFC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CFA20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBCIjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:39:55 -0500
Received: from mail5.windriver.com ([192.103.53.11]:45936 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgBCIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:39:54 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0138cAeT031609
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 3 Feb 2020 00:38:20 -0800
Received: from [128.224.162.199] (128.224.162.199) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Mon, 3 Feb 2020
 00:37:59 -0800
Subject: Re: [PATCH] ubi: fix memory leak from ubi->fm_anchor
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200114093305.666-1-quanyang.wang@windriver.com>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <415718c7-4c55-fb5d-0b10-ad5323daa5a0@windriver.com>
Date:   Mon, 3 Feb 2020 16:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114093305.666-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 1/14/20 5:33 PM, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> Some ubi_wl_entry are allocated in erase_aeb() and one of them is
> assigned to ubi->fm_anchor in __erase_worker(). And it should be freed
> like others which are freed in tree_destroy(). Otherwise, it will
> cause a memory leak:
>
> unreferenced object 0xbc094318 (size 24):
>    comm "ubiattach", pid 491, jiffies 4294954015 (age 420.110s)
>    hex dump (first 24 bytes):
>      30 43 09 bc 00 00 00 00 00 00 00 00 01 00 00 00  0C..............
>      02 00 00 00 04 00 00 00                          ........
>    backtrace:
>      [<6c2d5089>] erase_aeb+0x28/0xc8
>      [<a1c68fb1>] ubi_wl_init+0x1d8/0x4a8
>      [<d4f408f8>] ubi_attach+0xffc/0x10d0
>      [<add3b5d8>] ubi_attach_mtd_dev+0x5b4/0x9fc
>      [<d375a11c>] ctrl_cdev_ioctl+0xb8/0x1d8
>      [<72b250f2>] vfs_ioctl+0x28/0x3c
>      [<b80095d7>] do_vfs_ioctl+0xb0/0x798
>      [<bf9ef69e>] ksys_ioctl+0x58/0x74
>      [<5355bdbe>] ret_fast_syscall+0x0/0x54
>      [<90c6c3ca>] 0x7eadf854
>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>   drivers/mtd/ubi/wl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 5d77a38dba54..a5e9d1e4dc34 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1885,6 +1885,7 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
>   	tree_destroy(ubi, &ubi->used);
>   	tree_destroy(ubi, &ubi->free);
>   	tree_destroy(ubi, &ubi->scrub);
> +	wl_entry_destroy(ubi, ubi->fm_anchor);
>   	kfree(ubi->lookuptbl);
>   	return err;
>   }
> @@ -1920,6 +1921,7 @@ void ubi_wl_close(struct ubi_device *ubi)
>   	tree_destroy(ubi, &ubi->erroneous);
>   	tree_destroy(ubi, &ubi->free);
>   	tree_destroy(ubi, &ubi->scrub);
> +	wl_entry_destroy(ubi, ubi->fm_anchor);
>   	kfree(ubi->lookuptbl);
>   }
>   
