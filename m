Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663EAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A7520767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GhKY1Yfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGJKrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:47:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37494 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:47:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710104753euoutp01a4d0b9dfc8693d9c01214efa8dc766be~gXmj9sbj51403714037euoutp012
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:47:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710104753euoutp01a4d0b9dfc8693d9c01214efa8dc766be~gXmj9sbj51403714037euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594378073;
        bh=RtxoUKE87gFlyT59BFvpAR+iia+diYv92+gIByfRBLQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GhKY1YfrptDJH1VJZ7n+PLk9gRofV1IX1UHwt82r4HWxzGoUNsn7mIIUETLY+x55J
         1dPVw5WoP4DBagwRXIRVVRu0yS9h/MIYQAeEpSfxbSdTb0NJ7XuHjvDYs4vRjJeiFB
         49D8AESQc/6qFyL93dt33rB9ziN+0WlutK7ZrWNw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710104752eucas1p2de08837e071c11ee56b748261e510c47~gXmj1N4i42726727267eucas1p2N;
        Fri, 10 Jul 2020 10:47:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.0F.06456.857480F5; Fri, 10
        Jul 2020 11:47:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710104752eucas1p1523dc0542caaff8dd8fd0404ee3121f3~gXmjjCFQT3245232452eucas1p1s;
        Fri, 10 Jul 2020 10:47:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710104752eusmtrp1fda5f068816581fabe4700da527744e6~gXmjifnXE3060330603eusmtrp1j;
        Fri, 10 Jul 2020 10:47:52 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-df-5f084758dd2f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.34.06017.857480F5; Fri, 10
        Jul 2020 11:47:52 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200710104752eusmtip10fca965377950395baf1f725011486ea~gXmjTolxW2814628146eusmtip1U;
        Fri, 10 Jul 2020 10:47:52 +0000 (GMT)
Subject: Re: [PATCH] vgacon: fix a UAF in do_update_region()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cb94f58d-28be-6dcc-4159-ee56359fe20d@samsung.com>
Date:   Fri, 10 Jul 2020 12:47:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1591281524-114053-1-git-send-email-yangyingliang@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd0Id454gwN7LSwu75rDZrHl0zUm
        ByaPliNvWT0+b5ILYIrisklJzcksSy3St0vgynj1dQF7wTT5inmf2BoYL0p2MXJySAiYSOz5
        fYodxBYSWMEo8fpQRhcjF5D9hVGi4f5fJgjnM6PE4pdTGWE6Pm+czgKRWM4ocer4OijnLaPE
        6WPf2ECqhAVsJA6/3MwKYosI6Ep8frWaCcRmFlCQ+HVvE1icTcBKYmL7KqCpHBy8AnYS7Z+l
        QcIsAqoS0z6sACsXFYiQ+PTgMFg5r4CgxMmZT1hAbE4BL4m/12axQ4wUl7j1ZD7UeHmJ7W/n
        MIPcIyHwnU3iefcqNoirXSSWTWlhgrCFJV4d38IOYctInJ7cwwLRsI5R4m/HC6ju7YwSyyf/
        g+q2lrhz7hcbyKXMApoS63fpQ4QdJdZPaWACCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVq
        EhuWbWCDWdu1cyXzBEalWUhem4XknVlI3pmFsHcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0
        veT83E2MwIRx+t/xTzsYv15KOsQowMGoxMO74z9bvBBrYllxZe4hRgkOZiURXqezp+OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYDQK3hckuijXMFD5
        xD89mZ1fDax/WNxnrD7C8VL3VsUrbl7jV7zLWJJPOUm6KR7tD7zr2rL5bo/0gsXlqe37Dmh3
        vvQ6nbNT9shKBa+3GSt/hYWavDzOcHn9mvb99h/bbTuOCe49UlnGWapQU+Qnp73j55SvBq0f
        W4MnVP/js+KWFzmpztvJosRSnJFoqMVcVJwIAFSiJwgUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7oR7hzxBlfalS0u75rDZrHl0zUm
        ByaPliNvWT0+b5ILYIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJ
        zcksSy3St0vQy3j1dQF7wTT5inmf2BoYL0p2MXJySAiYSHzeOJ0FxBYSWMoo8WOmTRcjB1Bc
        RuL4+jKIEmGJP9e62LoYuYBKXgOVtKxiBkkIC9hIHH65mRXEFhHQlfj8ajUTRNFcRolJMz4x
        gSSYBRQkft3bBFbEJmAlMbF9FSPIAl4BO4n2z9IgYRYBVYlpH1aAlYsKREgc3jGLEcTmFRCU
        ODnzCdhtnAJeEn+vzWKHGKku8WfeJWYIW1zi1pP5UKvkJba/ncM8gVFoFpL2WUhaZiFpmYWk
        ZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA+Nh27OeWHYxd74IPMQpwMCrx8Cb8ZYsX
        Yk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA2M3ryTe0NTQ
        3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD4+L3lUcMP+017L67aInrG9NZ
        O0/NUf6aq7k4N2iN8xlJR//y+77ujSwnDbcJeC0TteNZnihUcvxRuOf7oJJFZX/ilZ6fZ3m9
        622VloLDw6oLp89zdC098GeTg8OjQ7NmqklwyHzfxe7Q0zPnVOH56/LyC9icHD1Cbx2PXcoU
        rWt5hXGX7eZ/6kosxRmJhlrMRcWJADZC5KqlAgAA
X-CMS-MailID: 20200710104752eucas1p1523dc0542caaff8dd8fd0404ee3121f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200604141553eucas1p185479b18995247931b3e79288f2496a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200604141553eucas1p185479b18995247931b3e79288f2496a9
References: <CGME20200604141553eucas1p185479b18995247931b3e79288f2496a9@eucas1p1.samsung.com>
        <1591281524-114053-1-git-send-email-yangyingliang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please re-send adding the correct mailing lists:

* dri-devel@lists.freedesktop.org

* linux-fbdev@vger.kernel.org

to Cc: so the patch can be reviewed/merged.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On 6/4/20 4:38 PM, Yang Yingliang wrote:
> I got a UAF report in do_update_region() when I doing fuzz test.
> 
> [   51.161905] BUG: KASAN: use-after-free in do_update_region+0x579/0x600
> [   51.161918] Read of size 2 at addr ffff888000100000 by task test/295
> 
> [   51.161957] CPU: 2 PID: 295 Comm: test Not tainted 5.7.0+ #975
> [   51.161969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [   51.161976] Call Trace:
> [   51.162001]  dump_stack+0xc6/0x11e
> [   51.162019]  ? do_update_region+0x579/0x600
> [   51.162047]  print_address_description.constprop.6+0x1a/0x220
> [   51.162083]  ? vprintk_func+0x66/0xed
> [   51.162100]  ? do_update_region+0x579/0x600
> [   51.162112]  ? do_update_region+0x579/0x600
> [   51.162128]  kasan_report.cold.9+0x37/0x7c
> [   51.162151]  ? do_update_region+0x579/0x600
> [   51.162173]  do_update_region+0x579/0x600
> [   51.162207]  ? con_get_trans_old+0x230/0x230
> [   51.162229]  ? retint_kernel+0x10/0x10
> [   51.162278]  csi_J+0x557/0xa00
> [   51.162307]  do_con_trol+0x49af/0x5cc0
> [   51.162330]  ? lock_downgrade+0x720/0x720
> [   51.162347]  ? reset_palette+0x1b0/0x1b0
> [   51.162369]  ? lockdep_hardirqs_on_prepare+0x379/0x540
> [   51.162393]  ? notifier_call_chain+0x11b/0x160
> [   51.162438]  do_con_write.part.24+0xb0a/0x1a30
> [   51.162501]  ? do_con_trol+0x5cc0/0x5cc0
> [   51.162522]  ? console_unlock+0x7b8/0xb00
> [   51.162555]  ? __mutex_unlock_slowpath+0xd4/0x670
> [   51.162574]  ? this_tty+0xe0/0xe0
> [   51.162589]  ? console_unlock+0x559/0xb00
> [   51.162605]  ? wait_for_completion+0x260/0x260
> [   51.162638]  con_write+0x31/0xb0
> [   51.162658]  n_tty_write+0x4fa/0xd40
> [   51.162710]  ? n_tty_read+0x1800/0x1800
> [   51.162730]  ? prepare_to_wait_exclusive+0x270/0x270
> [   51.162754]  ? __might_fault+0x175/0x1b0
> [   51.162783]  tty_write+0x42b/0x8d0
> [   51.162795]  ? n_tty_read+0x1800/0x1800
> [   51.162825]  ? tty_lookup_driver+0x450/0x450
> [   51.162848]  __vfs_write+0x7c/0x100
> [   51.162875]  vfs_write+0x1c9/0x510
> [   51.162901]  ksys_write+0xff/0x200
> [   51.162918]  ? __ia32_sys_read+0xb0/0xb0
> [   51.162940]  ? do_syscall_64+0x1a/0x520
> [   51.162957]  ? lockdep_hardirqs_on_prepare+0x379/0x540
> [   51.162984]  do_syscall_64+0xa1/0x520
> [   51.163008]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> After vgacon_set_origin() is called in set_origin(), the vc_origin is
> set to vga_vram_base, the vc_pos should between vga_vram_base and
> vga_vram_end. But we still use vc_screenbuf_size, if the vga_vram_size
> is smaller than vc_screenbuf_size, vc_pos may be out of bound, using it
> will cause a use-after-free(or out-of-bounds). Fix this by calling
> vc_resize() if vga_vram_size is smaller than vc_screenbuf_size.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/video/console/vgacon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index 998b0de..2ee3d62 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -1336,6 +1336,9 @@ static int vgacon_set_origin(struct vc_data *c)
>  	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
>  	    (console_blanked && !vga_palette_blanked))	/* Nor we write to blanked screens */
>  		return 0;
> +
> +	if (c->vc_screenbuf_size > vga_vram_size)
> +		vc_resize(c, screen_info.orig_video_cols, screen_info.orig_video_lines);
>  	c->vc_origin = c->vc_visible_origin = vga_vram_base;
>  	vga_set_mem_top(c);
>  	vga_rolled_over = 0;
> 
