Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FF820748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZZQdUqIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJKrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:47:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47033 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:47:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200710104711euoutp02de8227861fdf236da76dfa624e09f550~gXl9MrNbf3057330573euoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200710104711euoutp02de8227861fdf236da76dfa624e09f550~gXl9MrNbf3057330573euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594378031;
        bh=E2gTfuRFR2rYoNTWkbhXFInbLfvfyq4TLgS2DQ4s6VU=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=ZZQdUqIJVKsZyXFWS7OCqx8nGw9bMkynnSsw2iHwAz2TaMq0HrYOKg7MS6Of7N7b+
         CV+b1ssaPBLrfCm0tX6/u6XAcgGQp2sfwFWyk+oTWdXTDm0MXCIxBDGsuw8TRp5V8C
         qoX1qh5oJBXz1DuIJzuJR53uadP5Y2tVSjaivDPU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710104711eucas1p21049405b89b8aaed52a3c2ec60e7b1c5~gXl86tdZw2726127261eucas1p26;
        Fri, 10 Jul 2020 10:47:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.EE.06456.F27480F5; Fri, 10
        Jul 2020 11:47:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200710104710eucas1p1b4c30662cdee32f4a2f14ed05c48b9ec~gXl8jDLuN2629726297eucas1p1a;
        Fri, 10 Jul 2020 10:47:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710104710eusmtrp1e2823004f5f08a0877ad36160a2bdfb9~gXl8ig9lK3000530005eusmtrp12;
        Fri, 10 Jul 2020 10:47:10 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-6f-5f08472f6e2a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.14.06017.E27480F5; Fri, 10
        Jul 2020 11:47:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200710104710eusmtip1965475f747b43bd3f836fafe66fac92e~gXl8TmPPu2143021430eusmtip1Z;
        Fri, 10 Jul 2020 10:47:10 +0000 (GMT)
Subject: Re: [PATCH -next] vgacon: Fix an out-of-bounds in
 vgacon_scrollback_update()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <62544bd9-e47d-e7f9-92f2-49b8dbb132c1@samsung.com>
Date:   Fri, 10 Jul 2020 12:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1589336932-35508-1-git-send-email-yangyingliang@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV19d454gxcn2S0u75rDZrHl0zUm
        ByaPliNvWT0+b5ILYIrisklJzcksSy3St0vgynj5rZWt4I5xxf7LH1kbGBdqdTFyckgImEis
        62xi72Lk4hASWMEo8eTyfzYI5wujxP9P81ghnM+MEp2Hm1hhWmae2MYIkVjOKPFm/hSolreM
        EotOdrGAVAkLhEvcvv+OEcQWEfCWeD73FDuIzSZgJTGxfRVYnFfATuLYn+NgcRYBVYn/376B
        bRAViJD49OAwK0SNoMTJmU/AZnIKeEo0LjkP1sssIC5x68l8JghbXmL72znMIEdICLxnk/h0
        fyrUqS4Su5YtZYewhSVeHd8CZctInJ7cwwLRsI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4XkM0B
        tEJTYv0ufYiwo8S7hyuZQcISAnwSN94KQhzBJzFp23SoMK9ER5sQRLWaxIZlG9hg1nbtBOkE
        sT0kni+fzTiBUXEWkjdnIXltFpLXZiHcsICRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
        JkZg2jj97/inHYxfLyUdYhTgYFTi4d3xny1eiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwJpT5zpBLeuqQFdb2dcv7
        sOqnRmnpnzJ3dvv8ZWo5sup+4AvPp24nrxZxcK87PGvdYpuNvlP4d8ffj31+7/W8ms8sleHv
        z13ivbnk5Lk5KRs/J51/8obX2VzxzMFlrCK5/9TN1uV/PFF7amaT/knlAlF1+0eNG1fN+fZl
        8wPrxKLs7OTGG4zeEUosxRmJhlrMRcWJALakbJ4XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4XV09d454gwlXNS0u75rDZrHl0zUm
        ByaPliNvWT0+b5ILYIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJ
        zcksSy3St0vQy3j5rZWt4I5xxf7LH1kbGBdqdTFyckgImEjMPLGNsYuRi0NIYCmjxInFO9i7
        GDmAEjISx9eXQdQIS/y51sUGUfOaUaK1t5UdJCEsEC5x+/47RhBbRMBb4vncU+wQRXMYJU71
        /mMCSbAJWElMbF8FVsQrYCdx7M9xsGYWAVWJ/9++sYLYogIREod3zIKqEZQ4OfMJC4jNKeAp
        0bjkPFicWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnIWkfRaSlllIWmYhaVnAyLKKUSS1
        tDg3PbfYSK84Mbe4NC9dLzk/dxMjMBq2Hfu5ZQdj17vgQ4wCHIxKPLwJf9nihVgTy4orcw8x
        SnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBIzSuJNzQ1NLewNDQ3Njc2
        s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwMjLxl1YIFSutZUt1e3AY55puUovc84cmD5N
        INntgsDZokVt3rue3md6t7B7Tsj23hXLlyzL9mt/pfvlnsdx+Y/ravr/q2cd/BRxUTB4Ds+/
        WcekeJRWmiSveH7jmORf7utBgRMX+0w+/PHBv8kJyiJH+YQfi12/ePSsiesGv1bXv390nW5/
        f/hPiaU4I9FQi7moOBEAPxTcYZwCAAA=
X-CMS-MailID: 20200710104710eucas1p1b4c30662cdee32f4a2f14ed05c48b9ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513020606eucas1p148e04f5d69e5c1d6a11f8dfd1604043c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513020606eucas1p148e04f5d69e5c1d6a11f8dfd1604043c
References: <CGME20200513020606eucas1p148e04f5d69e5c1d6a11f8dfd1604043c@eucas1p1.samsung.com>
        <1589336932-35508-1-git-send-email-yangyingliang@huawei.com>
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

On 5/13/20 4:28 AM, Yang Yingliang wrote:
> I got a slab-out-of-bounds report when I doing fuzz test.
> 
> [  334.989515] ==================================================================
> [  334.989577] BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
> [  334.989588] Write of size 1766 at addr ffff8883de69ff3e by task test/2658
> [  334.989593]
> [  334.989608] CPU: 3 PID: 2658 Comm: test Not tainted 5.7.0-rc5-00005-g152036d1379f #789
> [  334.989617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [  334.989624] Call Trace:
> [  334.989646]  dump_stack+0xe4/0x14e
> [  334.989676]  print_address_description.constprop.5+0x3f/0x60
> [  334.989699]  ? vgacon_scroll+0x57a/0x8ed
> [  334.989710]  __kasan_report.cold.8+0x92/0xaf
> [  334.989735]  ? vgacon_scroll+0x57a/0x8ed
> [  334.989761]  kasan_report+0x37/0x50
> [  334.989789]  check_memory_region+0x1c1/0x1e0
> [  334.989806]  memcpy+0x38/0x60
> [  334.989824]  vgacon_scroll+0x57a/0x8ed
> [  334.989876]  con_scroll+0x4ef/0x5e0
> [  334.989904]  ? lockdep_hardirqs_on+0x5e0/0x5e0
> [  334.989934]  lf+0x24f/0x2a0
> [  334.989951]  ? con_scroll+0x5e0/0x5e0
> [  334.989975]  ? find_held_lock+0x33/0x1c0
> [  334.990005]  do_con_trol+0x313/0x5ff0
> [  334.990027]  ? lock_downgrade+0x730/0x730
> [  334.990045]  ? reset_palette+0x440/0x440
> [  334.990070]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
> [  334.990095]  ? notifier_call_chain+0x120/0x170
> [  334.990132]  ? __atomic_notifier_call_chain+0xf0/0x180
> [  334.990160]  do_con_write.part.16+0xb2b/0x1b20
> [  334.990238]  ? do_con_trol+0x5ff0/0x5ff0
> [  334.990258]  ? mutex_lock_io_nested+0x1280/0x1280
> [  334.990269]  ? rcu_read_unlock+0x50/0x50
> [  334.990315]  ? __mutex_unlock_slowpath+0xd9/0x670
> [  334.990340]  ? lockdep_hardirqs_on+0x3a2/0x5e0
> [  334.990368]  con_write+0x36/0xc0
> [  334.990389]  do_output_char+0x561/0x780
> [  334.990414]  n_tty_write+0x58e/0xd30
> [  334.990478]  ? n_tty_read+0x1800/0x1800
> [  334.990500]  ? prepare_to_wait_exclusive+0x300/0x300
> [  334.990525]  ? __might_fault+0x17a/0x1c0
> [  334.990557]  tty_write+0x430/0x960
> [  334.990568]  ? n_tty_read+0x1800/0x1800
> [  334.990600]  ? tty_release+0x1280/0x1280
> [  334.990622]  __vfs_write+0x81/0x100
> [  334.990648]  vfs_write+0x1ce/0x510
> [  334.990676]  ksys_write+0x104/0x200
> [  334.990691]  ? __ia32_sys_read+0xb0/0xb0
> [  334.990708]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [  334.990725]  ? trace_hardirqs_off_caller+0x40/0x1a0
> [  334.990744]  ? do_syscall_64+0x3b/0x5e0
> [  334.990775]  do_syscall_64+0xc8/0x5e0
> [  334.990798]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [  334.990811] RIP: 0033:0x44f369
> [  334.990827] Code: 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> [  334.990834] RSP: 002b:00007ffe9ace0968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  334.990848] RAX: ffffffffffffffda RBX: 0000000000400418 RCX: 000000000044f369
> [  334.990856] RDX: 0000000000000381 RSI: 0000000020003500 RDI: 0000000000000003
> [  334.990865] RBP: 00007ffe9ace0980 R08: 0000000020003530 R09: 00007ffe9ace0980
> [  334.990873] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000402110
> [  334.990881] R13: 0000000000000000 R14: 00000000006bf018 R15: 0000000000000000
> [  334.990937]
> [  334.990943] The buggy address belongs to the page:
> [  334.990962] page:ffffea000f79a400 refcount:1 mapcount:0 mapping:000000002bff47b3 index:0x0 head:ffffea000f79a400 order:4 compound_mapcount:0 compound_pincount:0
> [  334.990973] flags: 0x2fffff80010000(head)
> [  334.990992] raw: 002fffff80010000 dead000000000100 dead000000000122 0000000000000000
> [  334.991006] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [  334.991013] page dumped because: kasan: bad access detected
> [  334.991017]
> [  334.991023] Memory state around the buggy address:
> [  334.991034]  ffff8883de6a0000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  334.991044]  ffff8883de6a0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  334.991054] >ffff8883de6a0100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
> [  334.991061]                                                              ^
> [  334.991071]  ffff8883de6a0180: fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00
> [  334.991082]  ffff8883de6a0200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  334.991088] ==================================================================
> 
> Because vgacon_scrollback_cur->tail plus memcpy size is greater than
> vgacon_scrollback_cur->size. Fix this by checking the memcpy size.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/video/console/vgacon.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index 998b0de1812f..b51ffb9a208d 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -243,6 +243,7 @@ static void vgacon_scrollback_startup(void)
>  static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  {
>  	void *p;
> +	int size;
>  
>  	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size ||
>  	    c->vc_num != fg_console)
> @@ -251,13 +252,17 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>  
>  	while (count--) {
> +		size = vgacon_scrollback_cur->size - vgacon_scrollback_cur->tail;
> +		if (size > c->vc_size_row)
> +			size = c->vc_size_row;
> +
>  		scr_memcpyw(vgacon_scrollback_cur->data +
>  			    vgacon_scrollback_cur->tail,
> -			    p, c->vc_size_row);
> +			    p, size);
>  
>  		vgacon_scrollback_cur->cnt++;
> -		p += c->vc_size_row;
> -		vgacon_scrollback_cur->tail += c->vc_size_row;
> +		p += size;
> +		vgacon_scrollback_cur->tail += size;
>  
>  		if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>  			vgacon_scrollback_cur->tail = 0;
> 

