Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CDFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8924420829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SnuJpEY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgG2Nhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:37:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33965 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Nhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:37:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200729133747euoutp01063dbfefd6b78349440fd3015c34d3fd~mPLVACXWc2891328913euoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200729133747euoutp01063dbfefd6b78349440fd3015c34d3fd~mPLVACXWc2891328913euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596029867;
        bh=5QZzAlz44M8sYevS+mVA+JLffzyNd1liNMejy0cjMGg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SnuJpEY45DyIrqBvVltM8bPzATj9neshE42h2KQhIUbjdWWMOooxSMI4i8YqVbI4n
         zDjmAlGXO+hUcjGMBn3pVfji9YI+3+3lvh3FyAxldnvVJCAod+EyfI7iElEgk+MFqd
         bWTEcYp9Y1xgzLdwXPHeyfb8e1kNKjXgdXkDDsYU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200729133746eucas1p2c1752efd5cae4ad9022ca0083739a9f3~mPLUqvyIc1274912749eucas1p2z;
        Wed, 29 Jul 2020 13:37:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.A3.05997.AAB712F5; Wed, 29
        Jul 2020 14:37:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200729133746eucas1p1e779331cfa697b8d821536e58a08a172~mPLUWavK_2841728417eucas1p1r;
        Wed, 29 Jul 2020 13:37:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200729133746eusmtrp26806320807a884ca4074dd4723d95b4c~mPLUP-1uL3268532685eusmtrp27;
        Wed, 29 Jul 2020 13:37:46 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-d4-5f217baaa900
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.30.06017.AAB712F5; Wed, 29
        Jul 2020 14:37:46 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200729133745eusmtip225dbd063d8a509c328520fe042b3b699~mPLTkwibR0973809738eusmtip2N;
        Wed, 29 Jul 2020 13:37:45 +0000 (GMT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback
 buffer
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7a5fc007-f0dc-bc11-3d04-b987cc98e2bd@samsung.com>
Date:   Wed, 29 Jul 2020 15:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200729070249.20892-1-jslaby@suse.cz>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNY6bTgVAcC4QbVNAqJJqIIH5MQFEQkvkxEr+MCZQqI4u0YMtO
        IqCoWLARMYJVpNEoW8Iu2EY/gMqiUkhYJCyyutBYJKASwKK2UyJ/5957zj3nvjwSEy7x3Mk4
        WTIrl0kSRIQD3tK5ajhYnbVH7DuYd4AuKOhE9ODP7wRt0JQienldx6PXFnsxeq2qHtHdqkUe
        PaB7RNBD5nxEv+lUYnRPiT89ozLx6ealYTvaaC4hTjgxlf1KHvN4IZ7Rqif4TJ7exGMaq28R
        jGk6nOkuXceZyYIuO2b52zif+fR7gmDea/R8ZrnRg/nToMHCBeccjkazCXGprPxQUJRDbG6p
        nkgq3ps+vfiAyEF5u5SIJIE6Ak33w5TIgRRSlQhWVlU4V/xAMFa/YCuWEbR8fogpkb1VcXW8
        juAGFQhqRswYV5gQtKmeWlnO1Globh23s2AXyhO0G1+sGKNWMLhX62HBBBUARTerkQULqCDo
        yjHwLRinvKB4Zc7Kd6XOwtJUB4/jbIeeB3O4Jbf9vxQfhs5wK91gdK7ctt4Trr14aM0DVBkJ
        reuvCC51KOgqV/gcdgZjV7MN74Q/WovYIqhFYM7/alO3Iqgo3rCpA2HcsEZYnDFqP9TpDnHt
        YHg20IFxD+kEI6btXAgnuNtSYmsLIP+GkGN7Q/3zemLTVqmtwu4gkXrLZeot56i3nKP+76tB
        eDVyY1MU0hhWcVjGpvkoJFJFiizG50KitBH9+4nvNrp+vES63+fbEUUikaNgt2yPWMiTpCoy
        pO0ISEzkIgjpfRcpFERLMjJZeaJYnpLAKtrRDhIXuQn8n8xHCKkYSTJ7iWWTWPnm1I60d89B
        rtsM6xczixrSxdPGjADvq1nmicDy2XtEqLhMN5agOm40Zp+CvsmWU7WvlMPzIVHX40/W9KX1
        J5mkeGjVPlXE7PfcyMG2womdr7PfLsTnhTlleymv54umCgMv53ZP/brdm3bU7/hsVZI+1nsq
        1f2Kb+do9P0+x4Bzcs1MU/Ax+UcRroiV+B3A5ArJX6KG9sGFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd1V1YrxBktbBCy6u48xWlz5+p7N
        4tyCGYwWn3/vYrX49eEss8WvlRsYLU70fWC1uLxrDpvF1b8djBZHj3UxW5ycbmzxqO8tu8WW
        T9eYLF79nc7mwOex4kIXq8e8d1keO2fdZfdoOfKW1WPTqk42j7cPAzxOzPjN4nG/+ziTx+c3
        d9g9nv65y+ZxZsERdo/Pm+Q8/m9cwBzAG6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CX0TjjCFvBZOWKhx9msjUwtsh2MXJySAiYSDTdWc/WxcjF
        ISSwlFHi3YzXrF2MHEAJGYnj68sgaoQl/lzrgqp5DVSzZi4TSEJYwFdi8f8dbCC2iIC8xM5/
        z5lAipgFfjJLnN86AaqjnVHiZut0dpAqNgEriYntqxhBbF4BO4njDefA4iwCqhKTvz8Bmyoq
        ECFxeMcsqBpBiZMzn7CAXMQJdOr1q0EgYWYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDQL
        SfcsJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmAS2Hbs55YdjF3vgg8x
        CnAwKvHwKuQpxguxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0G8TmaVE
        k/OBCSqvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjuZ0BZ6b+
        pVOn99ZIPl05Uat6Vu/1VTsq2uZo/NcL8mc+vnGX7rP/M5KkDQoPv3h0Z+aFaXUt/+0ezlwa
        Gv4wJpml6GGs7HEjsR97puQ+dLaVN9ixkd8ixC2Vn7mMOXxt3NV/7tt7lr1XbHrIfsIhdZL4
        dtOXr56kq9pdXlAsfvJuxJYl8h+OKLEUZyQaajEXFScCAEJ1Mw4YAwAA
X-CMS-MailID: 20200729133746eucas1p1e779331cfa697b8d821536e58a08a172
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200729070257eucas1p1f5841756104301e67907136e45d6e9f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200729070257eucas1p1f5841756104301e67907136e45d6e9f5
References: <CGME20200729070257eucas1p1f5841756104301e67907136e45d6e9f5@eucas1p1.samsung.com>
        <20200729070249.20892-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jiri,

On 7/29/20 9:02 AM, Jiri Slaby wrote:
> The current vgacon's scroll up implementation uses a circural buffer
> in vgacon_scrollback_cur. It always advances tail to prepare it for the
> next write and caps it to zero if the next ->vc_size_row bytes won't fit.
> 
> But when we change the VT size (e.g. by VT_RESIZE) in the meantime, the new
> line might not fit to the end of the scrollback buffer in the next
> attempt to scroll. This leads to various crashes as
> vgacon_scrollback_update writes out of the buffer:
>  BUG: unable to handle page fault for address: ffffc900001752a0
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  RIP: 0010:mutex_unlock+0x13/0x30
> ...
>  Call Trace:
>   n_tty_write+0x1a0/0x4d0
>   tty_write+0x1a0/0x2e0
> 
> Or to KASAN reports:
> BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
> 
> So check whether the line fits in the buffer and wrap if needed. Do it
> before the loop as console_sem is held and ->vc_size_row cannot change
> during the execution of vgacon_scrollback_cur. If it does change, we
> need to ensure it does not change elsewhere, not here.
> 
> Also, we do not split the write of a line into chunks as that would
> break the consumers of the buffer. They expect ->cnt, ->tail and ->size
> to be in harmony and advanced by ->vc_size_row.
> 
> I found few reports of this in the past, some with patches included,
> some even 2 years old:
> https://lore.kernel.org/lkml/CAEAjamsJnG-=TSOwgRbbb3B9Z-PA63oWmNPoKYWQ=Z=+X49akg@mail.gmail.com/

Sorry but I don't work on fixing fbdev/console KASAN/syzbot/etc.
reports (-ENORESOURCES).  This has been made official in the past.

I'm happy to review/apply patches though.

> https://lore.kernel.org/lkml/1589336932-35508-1-git-send-email-yangyingliang@huawei.com/

This was the first time the patch for issue was submitted.

I tried to apply it to drm-misc but then I have noticed that
it has not been posted to linux-fbdev / dri-devel MLs (so it
was not possible to merge it using dim tool) and thus I've
requested the author to resend it:

https://lore.kernel.org/lkml/62544bd9-e47d-e7f9-92f2-49b8dbb132c1@samsung.com/

which he did:

https://lore.kernel.org/lkml/20200713105730.550334-1-yangyingliang@huawei.com/

and the patch is currently under review period (to give people
chance to comment on it) and in my "to apply if no objections"
folder.

I see that your/Yunhai patch addresses the root source of
the issue so I'll be happy to apply/ACK it instead of Yang's
patch once the final version is posted.

Thank you for working on this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> This fixes CVE-2020-14331.
> 
> Big thanks to guys mentioned in the Reported-and-debugged-by lines below
> who actually found the root cause.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
> Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Solar Designer <solar@openwall.com>
> Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: Security Officers <security@kernel.org>
> Cc: linux-distros@vs.openwall.org
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/console/vgacon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index f0f3d573f848..13194bb246f8 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -250,6 +250,11 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>  
>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>  
> +	/* vc_size_row might have changed by VT_RESIZE in the meantime */
> +	if ((vgacon_scrollback_cur->tail + c->vc_size_row) >=
> +			vgacon_scrollback_cur->size)
> +		vgacon_scrollback_cur->tail = 0;
> +
>  	while (count--) {
>  		scr_memcpyw(vgacon_scrollback_cur->data +
>  			    vgacon_scrollback_cur->tail,
> 
