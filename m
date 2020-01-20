Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE24422525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ar8vgtEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgATRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:51:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48856 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:51:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200120175116euoutp02404df0e30ccfbd914a613f7994d4de28~rqbH7cLo62804728047euoutp024
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 17:51:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200120175116euoutp02404df0e30ccfbd914a613f7994d4de28~rqbH7cLo62804728047euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579542676;
        bh=LQu0WAK7L/G6p0pzpWUx1m8ZKHecfzvgq8NfbkxkCU0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ar8vgtECytJfvywEpNTjcLzPPy4YhgYqBqnmLZB+24xagcWdNkLH/qdm4tpq2nQgX
         ddj9O6xsUjNaRtLtSvOzqfDU0bWmlRfy4ctibvwTGQbakpLWOr1W3K2MG+XCJifRr/
         ZzrziM+Q0lmcxHW9wyeJXc2TG98tjgn/mMcFyZyQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200120175116eucas1p2f7a33189967472123183610637356d7d~rqbHvE8lL3191431914eucas1p2m;
        Mon, 20 Jan 2020 17:51:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.13.61286.398E52E5; Mon, 20
        Jan 2020 17:51:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200120175115eucas1p16442cb8229ee7e4c54459a67902e12ec~rqbHVEuxl3013830138eucas1p1Y;
        Mon, 20 Jan 2020 17:51:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200120175115eusmtrp2079e2c08a928be485a3beb72e37b7782~rqbHUf0L83183031830eusmtrp2F;
        Mon, 20 Jan 2020 17:51:15 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-e2-5e25e893b0d7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A8.B8.07950.398E52E5; Mon, 20
        Jan 2020 17:51:15 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200120175113eusmtip2d62b016876d122c0463336b601643865~rqbFXydCR2105521055eusmtip2J;
        Mon, 20 Jan 2020 17:51:13 +0000 (GMT)
Subject: Re: [PATCH] fbdev: wait for references go away
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     marmarek@invisiblethingslab.com,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
Date:   Mon, 20 Jan 2020 18:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200120100014.23488-1-kraxel@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7qTX6jGGaz4ZGZx5et7Notnt04y
        W5zo+8BqcXnXHDaLz427WBxYPXr33WP3uN99nMnj/b6rbB6fN8kFsERx2aSk5mSWpRbp2yVw
        Zfz6s5CpYJ1wxeSnX1kaGF/zdzFyckgImEjMb//P3MXIxSEksIJR4uj9/UwQzhdGiWfbf7JC
        OJ8ZJeZ9WMEO0/Lq0hKoluWMElPmv2WBcN4ySqzbcpoZpEpYwFzi0YdXYLaIgJvE5RmrwYqY
        BXoYJV4fnAOWYBOwkpjYvooRxOYVsJN4dv0bE4jNIqAqse7QGzYQW1QgQuLTg8OsEDWCEidn
        PmEBsTmBFpw61ARWwywgLnHryXwmCFteonnrbGaIUxexS/yfVQhhu0h8+Hka6gVhiVfHt0DZ
        MhL/d84He1pCYB2jxN+OF8wQznZGieWT/7FBVFlL3Dn3C8jmANqgKbF+lz5E2FHiS9MSdpCw
        hACfxI23ghA38ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LNZSL6ZheSbWQh7
        FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMNKf/Hf+0g/HrpaRDjAIcjEo8vA7T
        VOOEWBPLiitzDzFKcDArifAuaAIK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
        OzW1ILUIJsvEwSnVwDiho1misqlCL+bEMcuQV0ybmeYobAs4l6ry4abyntM/Req/7rzCrrv6
        k3nl/80Trc0PNXxU3JveLsAbHdR5O9XJjqlaq0Tn4/vbMrF9IauKWDv+l2y2U+kSf7nW57WX
        9rl0vhQj8yfdwou73srF6SlO+XWyhKNE9fLhwjUzX/34JNNdeyHcXImlOCPRUIu5qDgRAPmj
        oRYwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7qTX6jGGTx8I2dx5et7Notnt04y
        W5zo+8BqcXnXHDaLz427WBxYPXr33WP3uN99nMnj/b6rbB6fN8kFsETp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfz6s5CpYJ1wxeSnX1kaGF/z
        dzFyckgImEi8urSEuYuRi0NIYCmjxO+H6xm7GDmAEjISx9eXQdQIS/y51sUGUfOaUeLqwaWM
        IAlhAXOJRx9eMYPYIgJuEpdnrGYBKWIW6GOUuLFnPztERxejxN15X8A62ASsJCa2rwKzeQXs
        JJ5d/8YEYrMIqEqsO/SGDcQWFYiQOLxjFlSNoMTJmU9YQGxOoG2nDjWB1TALqEv8mXeJGcIW
        l7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS
        83M3MQIja9uxn1t2MHa9Cz7EKMDBqMTD6zBNNU6INbGsuDL3EKMEB7OSCO+CJqAQb0piZVVq
        UX58UWlOavEhRlOg5yYyS4km5wOjPq8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklqdmpq
        QWoRTB8TB6dUA6OuxtdCkZRrnVKb7NvK1j+xeaxurBa7fuVahvmmn+Y/eaK1rH7r8+JlSq48
        oY9r+xiWhOg4f+KKlhe12tD04oPLE/n1ye8K+d/rPq1dMS2nsD1mewjLtqKP6yK/Ju/s+9aa
        0SPCvOm4VvyHBxt4HR0EBS3PNH5N0psRu9p3HeMMBZFD+3YE6iuxFGckGmoxFxUnAgAK4CPR
        wgIAAA==
X-CMS-MailID: 20200120175115eucas1p16442cb8229ee7e4c54459a67902e12ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
        <20200120100014.23488-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 1/20/20 11:00 AM, Gerd Hoffmann wrote:
> Problem: do_unregister_framebuffer() might return before the device is
> fully cleaned up, due to userspace having a file handle for /dev/fb0

do_unregister_framebuffer() doesn't guarantee that fb_info is freed after
function's return (it only drops the kernel reference on fb_info).

> open.  Which can result in drm driver not being able to grab resources
> (and fail initialization) because the firmware framebuffer still holds
> them.  Reportedly plymouth can trigger this.

Could you please describe issue some more?

I guess that a problem is happening during DRM driver load while fbdev
driver is loaded? I assume do_unregister_framebuffer() is called inside
do_remove_conflicting_framebuffers()?

At first glance it seems to be an user-space issue as it should not be
holding references on /dev/fb0 while DRM driver is being loaded.

> Fix this by trying to wait until all references are gone.  Don't wait
> forever though given that userspace might keep the file handle open.

Where does the 1s maximum delay come from?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index d04554959ea7..2ea8ac05b065 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -35,6 +35,7 @@
>  #include <linux/fbcon.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  #include <asm/fb.h>
>  
> @@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb_info)
>  
>  static void do_unregister_framebuffer(struct fb_info *fb_info)
>  {
> +	int limit = 100;
> +
>  	unlink_framebuffer(fb_info);
>  	if (fb_info->pixmap.addr &&
>  	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
> @@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
>  	fbcon_fb_unregistered(fb_info);
>  	console_unlock();
>  
> +	/* try wait until all references are gone */
> +	while (atomic_read(&fb_info->count) > 1 && --limit > 0)
> +		msleep(10);
> +
>  	/* this may free fb info */
>  	put_fb_info(fb_info);
>  }
