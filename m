Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66D92073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="joaEHRjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHDGBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:01:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56788 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHDGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:01:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200804060148euoutp015dfa2e77705ac45d03af2c478542cb78~n_07UQ-O33108531085euoutp01_
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:01:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200804060148euoutp015dfa2e77705ac45d03af2c478542cb78~n_07UQ-O33108531085euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596520908;
        bh=kzgLDXR1KCs9nds/AsklhENC8LndGd3HWtHi/4wKZU0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=joaEHRjn6GAV10zjxTR/r66/s/QLcIWCBFx4L4iMJv3j//eSmyy6KThokasunccp4
         3bPsEPjnhZ1i3+d5YT42g8Amkal0j/eOg3/UHHGXvurKPlm17m+YkxBy4uqijBXeKE
         MVHy/BcKxtPhjnCoKNn5unTs0Wdsm3wvhmP37r3Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200804060148eucas1p2def809de912c8e418481630191628011~n_07HMUCu0199801998eucas1p2n;
        Tue,  4 Aug 2020 06:01:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.22.06456.CC9F82F5; Tue,  4
        Aug 2020 07:01:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200804060148eucas1p1e88fb4817903f756c86a39260d0f239e~n_065l5Gv0386703867eucas1p19;
        Tue,  4 Aug 2020 06:01:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200804060148eusmtrp2c9e38b9eee0740a5b9833e020f9cfc9b~n_064_O6q1137911379eusmtrp2P;
        Tue,  4 Aug 2020 06:01:48 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-66-5f28f9cc2171
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.EA.06314.CC9F82F5; Tue,  4
        Aug 2020 07:01:48 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200804060148eusmtip21040dc1ef574b5d57778d2a28233dd3f~n_06nWHKl1112311123eusmtip2K;
        Tue,  4 Aug 2020 06:01:48 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: enlist Greg formally for console stuff
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <42015d40-2f21-4c72-4c6e-3c27776423a4@samsung.com>
Date:   Tue, 4 Aug 2020 08:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200803141142.1606661-1-daniel.vetter@ffwll.ch>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7pnfmrEG8w4o2Gx8OFdZovlZ9Yx
        W1z5+p7N4tyCGYwWl3fNYXNg9dj7bQGLx+I9L5k83j4M8LjffZzJ4/MmuQDWKC6blNSczLLU
        In27BK6Mff3HWAvWclc82VXXwDiHs4uRk0NCwERiYsMj9i5GLg4hgRWMEs2L/jKDJIQEvjBK
        nL8hAZH4zCjR+eYkI0zHwkvL2CASyxklZi17ywLhvGWUOLD6B1iVsICHxN7WP0wgtoiAlkTH
        /xawImaBXkaJlSdusIAk2ASsJCa2rwJr4BWwk/h9YBJYA4uAisTexVPB7hAViJD49OAwK0SN
        oMTJmU/AejmB6j/c6gerYRYQl7j1ZD4ThC0vsf3tHGaQZRICi9glfizpZ4K420Vi2+sLLBC2
        sMSr41vYIWwZif87QZpBGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879ArI5gFZoSqzfpQ8RdpSY
        +OUqC0hYQoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tosJO/M
        QvLOLIS9CxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmm9P/jn/awfj1UtIhRgEO
        RiUe3gWsGvFCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhl
        rJBAemJJanZqakFqEUyWiYNTqoExapmcsuXMNT1fn/+bsW3x8+8qJ36ZOeX4LHvSzutwSdt5
        zwHeIjWO3vNNasG/vr6R6WJPmPW2/e6ClNdiBh3rdlX/Xf8xoWqiSPXBi9OEt576rMLbtaRm
        MVt6Wmg278PjBUeXaOyd6N5/Wfjqp9pPaaUNbcnTJgZYxv1wvLG10vtO5R5BtuDVSizFGYmG
        WsxFxYkABOcIhDMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7pnfmrEG/S+kLBY+PAus8XyM+uY
        La58fc9mcW7BDEaLy7vmsDmweuz9toDFY/Gel0webx8GeNzvPs7k8XmTXABrlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gvv5jrAVruSue7Kpr
        YJzD2cXIySEhYCKx8NIyti5GLg4hgaWMEqv/NzN2MXIAJWQkjq8vg6gRlvhzrQuq5jWjxJ6G
        5cwgCWEBD4m9rX+YQGwRAS2Jjv8tLCBFzAK9jBI35/1jheiYyChx7tpvFpAqNgEriYntqxhB
        bF4BO4nfByaBdbMIqEjsXTwVbKqoQITE4R2zoGoEJU7OfALWywlU/+FWP1gNs4C6xJ95l6Bs
        cYlbT+YzQdjyEtvfzmGewCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgfG079nPzDsZLG4MPMQpwMCrx8C5g1YgXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJl
        VWpRfnxRaU5q8SFGU6DnJjJLiSbnA2M/ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QDY/TdunjNByeXfrWTvbTn2/pjb3//O+m9tPGASOXxPuemxiPhmiJtLm1N
        VdnFXxvmG07yU9/ydu4UOZVTrxK2LMlxzjHY6dp73tIxZPMficUXdp0yma8o4L08pu+EcI+v
        WcaHhQ9Wxk4qrnzxwXSr9GJ3vTNd1zJdDJ32exmsvGc6i/Vno89OBiWW4oxEQy3mouJEAKyx
        Z07FAgAA
X-CMS-MailID: 20200804060148eucas1p1e88fb4817903f756c86a39260d0f239e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200803141200eucas1p1181045e1d41a1780db15677778209d45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200803141200eucas1p1181045e1d41a1780db15677778209d45
References: <CGME20200803141200eucas1p1181045e1d41a1780db15677778209d45@eucas1p1.samsung.com>
        <20200803141142.1606661-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/20 4:11 PM, Daniel Vetter wrote:
> I did a few greps for main console data structures, and there's a few
> places outside of drivers/video/console:
> - a braille driver
> - a sisusbvga driver
> - fbcon, but I think that's fine if we leave that officially under
>   fbdev maintainership
> - lots of stuff in drivers/tty/vt, which is already under Greg's
>   maintainership.
> 
> So I think this match gives reasonably useful Cc: lists for the files
> and places I've tested.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Greg KH <greg@kroah.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ab94723c0cae..8084d118892c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4343,6 +4343,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/connector/
>  
> +CONSOLE SUBSYSTEM
> +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +S:	Supported
> +F:	drivers/video/console/
> +F:	include/linux/console*
> +
>  CONTROL GROUP (CGROUP)
>  M:	Tejun Heo <tj@kernel.org>
>  M:	Li Zefan <lizefan@huawei.com>
> 

