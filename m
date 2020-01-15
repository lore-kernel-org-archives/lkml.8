Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF00C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E7E2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H+Gb1ulH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAOObe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:31:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40769 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:31:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115143131euoutp0180d28281165fef163b4eb9d0ab2ce8dd~qFeTWPUS32290122901euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:31:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115143131euoutp0180d28281165fef163b4eb9d0ab2ce8dd~qFeTWPUS32290122901euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579098691;
        bh=1cw4JMKy1lErsNYO/NGq+Qbzm8WjBl+Evi60eX5AHHw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H+Gb1ulHlR0zP/LiOqkr2g7iidbvBUKzZ8i/eF5RJcfLLDaYdAXF/Nk/Xd5+lfvkm
         hCz+kXQ9LRT3nNMa27cA4sNkkndlAVsqI7c5PVM0HpFjVzQmRKmVn90Vbbqne0bLJf
         PseTHPwJMsvnY0X0vNrSTwG1bm5kXmYsjAPy30GE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115143131eucas1p25ddd1f5510a4c878dc4d029fba83b695~qFeTHeD-90399003990eucas1p2O;
        Wed, 15 Jan 2020 14:31:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.DB.61286.3422F1E5; Wed, 15
        Jan 2020 14:31:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115143131eucas1p11e74f62a262e12c8bf664e181384cfc1~qFeSy6NpB3147931479eucas1p1d;
        Wed, 15 Jan 2020 14:31:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115143131eusmtrp16383aedf24a8b1f5e3935b44e610ded1~qFeSxtlYC1089610896eusmtrp1E;
        Wed, 15 Jan 2020 14:31:31 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ac-5e1f22438f16
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.D7.08375.3422F1E5; Wed, 15
        Jan 2020 14:31:31 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115143130eusmtip1f078a4fb398be341001874dc8707ba6b~qFeSIQxju1623716237eusmtip1b;
        Wed, 15 Jan 2020 14:31:30 +0000 (GMT)
Subject: Re: [PATCH v2] fbdev: potential information leak in do_fb_ioctl()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Jani Nikula <jani.nikula@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ac5585a5-1670-92d2-c019-f349df123f47@samsung.com>
Date:   Wed, 15 Jan 2020 15:31:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200113100132.ixpaymordi24n3av@kili.mountain>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7OxMnp2X5pnZhZFBUJhl8lkpRxKEI7E90IWvpQSOndpZ2
        +VVkTVeEaanNOaddLLM0c0tNRSapQ51SVmoTDSq18pZ5t5XuKPnn43mf93ne93s+PpqQX6M8
        6dPR5zg+WhmloFxIc+2kbdNuxerQLVfH12J9YQGF/6TUSvAPRzqJG392SnDO504Ct44OUviv
        OUGCK+w/EDZ1eOFvHVYC198aEuN35XoK5wybSFxpyUbYUPORwo8nTWgnw05PpSA2rTpTwlaO
        GUm2TNcpYe9X9IlY+4cKiq3PmCZZg/Ug23WjTsQOf+0g2Qdp7yl2sGr2GClexd6xaMgQt6Mu
        geFc1Ol4jvcNPukSmfQ0XRJrlV6oTh6nLqMeiRZJaWD8oemOjtAiF1rOPEZwd3RMIhS/EWQ1
        DIqFYgSBNrOCWLCktltJoZGH4GZy83zRj8D80ugcvJTZBy2tjU6HO7MR3iVNOOcSjIWEbs19
        Z4NitsNtTT6awzImGLLe2Kg5TDI+UGNoIufwMuYw/OquEQuaJWC998XJS5lAmDZXOfUE4wEd
        X7JFAl4Nr/r1zkTAlNKQbSpBwr33QOe9drGAl8L3upL5J/CGhtSbpGB4juBPYu+8+xWCvFQH
        Jah2gN02NYvp2RXrobDcV6B3QZ8hTTRHA+MGbf1LhEu4QYo5nRBoGSRelwvqdVD0qIhaWKst
        e0IkI4VuUTTdoji6RXF0//caEZmPPLg4tSqCU/tFc+c3q5UqdVx0xOawGFUxmv2cDY66X6Vo
        9O0pC2JopHCVRc6sCpWLlfHqiyoLAppQuMusGStD5bJw5cVLHB9zgo+L4tQW5EWTCg/Z1ty+
        43ImQnmOO8NxsRy/0BXRUs/LiI9cz+sOtmmzsK57xCeh9UbQzqhU/2Zb1rFDPTbj/kszv3Ou
        2HZNvH7wMjfxWUvX2lvnFQN7Zd0BAxrXofzhXqMqNiUirEQfcrZsm1dhTsiVTy3HfOz6yYS9
        QXlnHRrvjOWcr+Ph+zVH6NARy5SBHLD3HnD9vuKIawFf/Ckz4IW/glRHKv02ELxa+Q8P2mGI
        mAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURyAO7vXe6e0uE7Fw/IRV6KQms5pO4qJVNQlCIogItM19OYk53R3
        E40iQcE0KrXysWwq9jATTENT0WWT1JVZqFmK0sslauUrNfNRmxrsn8PH+X3fgQM/PibMdxDx
        4xK0rCZBEU8TTvir1Y7h3ftp7yj/9iYKFVdXEWglr51EE6sFOOr6Pkyiss/DGOqbmyTQ3/oM
        EjUPTQBUN7gVfRs0Y6jz2pQD6m0qJlDZdB2OWkwlABna3hOoYrEOhFPM0p88wOS33iaZlvlS
        nGnUD5NMefMYjxnqbyaYzsIlnDGYjzEfr3TwmGnLIM7czX9HMJNG6zFb68XcNGXiR7ecEodq
        1Dotu02p5rR76QgJChBLgpE4IDBYLJHKIkMCgmi/sNAYNj4umdX4hZ0RK7MeFZCJZseU1pwF
        Ig2MktnAkQ+pQHhjwIxnAye+kLoH4NDoHC8b8K0DD9hRnbzuuMDl/mxi3ZkAsOjLqoNt4EId
        hm/7ujAbu1K7YG/Wb9ImYZQJhzOZNRuvXgewtPTWWkFQITA3sxLYWECFwTsvugkb49R22GZ4
        jdvYjToJ2xr0G44zNBeNrN07UqFwqd645mPUDrhs6MHW2R0OjpTw1tkbPv1RjOUAod4u19sl
        ertEb5eUArwSuLI6ThWr4iRiTqHidAmx4mi1qhZYd6K+ffFJA+ipOW4CFB/QmwXKZa8ooYMi
        mUtVmQDkY7SrwFzoGSUUxChSz7MatVyji2c5Ewiyfi4XE7lFq60blqCVS4IkMhQskUll0j2I
        dhdcpp6fFlKxCi17jmUTWc3/jsd3FKUBb8uFyojuxjJ5mnEfr8IyMIOU0y3kg45a1cX5g0Ob
        aCANv/Th04Ei6RvX1l9TjFNGvDnJf3y2ojFfUR7qqzMFJo0VLkR4nPgqZ8rP+owfyU0uuFqT
        I6/4GZW+ohepU0X9h4wjkfB+UevYdEbNQ8+6Kn8L+9LnGbbzcXqgc8o8jXNKhcQX03CKf53x
        gMwpAwAA
X-CMS-MailID: 20200115143131eucas1p11e74f62a262e12c8bf664e181384cfc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200113111044eucas1p2037e64332e79316dc0114d67a38400ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200113111044eucas1p2037e64332e79316dc0114d67a38400ab
References: <CGME20200113111044eucas1p2037e64332e79316dc0114d67a38400ab@eucas1p2.samsung.com>
        <20200113100132.ixpaymordi24n3av@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/20 12:08 PM, Dan Carpenter wrote:
> The "fix" struct has a 2 byte hole after ->ywrapstep and the
> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
> on the compiler.  The solution is just to replace the assignment with an
> memcpy().
> 
> Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> v2:  Use memcpy()
> 
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index d04554959ea7..bb8d8dbc0461 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1115,7 +1115,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		break;
>  	case FBIOGET_FSCREENINFO:
>  		lock_fb_info(info);
> -		fix = info->fix;
> +		memcpy(&fix, &info->fix, sizeof(fix));
>  		if (info->flags & FBINFO_HIDE_SMEM_START)
>  			fix.smem_start = 0;
>  		unlock_fb_info(info);
> 
