Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2246E21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZtRlF1+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCBPlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:41:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46744 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCBPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:41:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154141euoutp02b8cf56f7ffda8f751246ef5d7db93396~4hv_JimJn1202812028euoutp02c
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302154141euoutp02b8cf56f7ffda8f751246ef5d7db93396~4hv_JimJn1202812028euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163701;
        bh=qUmOCHgcBWEf5NAWKlfzof+Y+Hp4MNzKCtSaHKb2HWU=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=ZtRlF1+HXXpbVQOygNz/K5K9ClzTNrJPD6FVR7ix+IKRSYFb4xBb5QapAFnJYXMPa
         OVAbGBMKsX1R08l4mW7TrxrzbDf+6BXlQrxuX9M6wakJsfC00Ww7cK42KfvvHm2WuF
         XAUvdSWwiua9KbHKS2b9dg8MVbIPCV+ss7HqTdrE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154140eucas1p2d7b7733fc4d8dcffe7f017262b19f6af~4hv9zq2Sw2399323993eucas1p2X;
        Mon,  2 Mar 2020 15:41:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.00.60679.4392D5E5; Mon,  2
        Mar 2020 15:41:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154140eucas1p2d8edc3a93878743aec8c0872cc0f7e83~4hv9hQOaE0750207502eucas1p2Z;
        Mon,  2 Mar 2020 15:41:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154140eusmtrp1f345a0e531ee2a79360a1b33d21f9210~4hv9gmJbj2837828378eusmtrp1B;
        Mon,  2 Mar 2020 15:41:40 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-86-5e5d29344b35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.EF.07950.4392D5E5; Mon,  2
        Mar 2020 15:41:40 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154140eusmtip14410efcd0ece13a0f69e968b1514c93c~4hv9Li_zm2417824178eusmtip1f;
        Mon,  2 Mar 2020 15:41:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] video: fbdev: sh_mobile_lcdcfb: fix sparse warnings
 about using incorrect types
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <25ce3896-7f70-7638-8c53-1b1c984ff2cd@samsung.com>
Date:   Mon, 2 Mar 2020 16:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0qSAn3S+bpFieP=xukK5SapAq1oRC8XouuMJ6fgqOBA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO7edjSbHqfiiobHCMrxlUjPFNAomKNg/KVwtPXnJTducZRFY
        5FwmIzWL5lKxy3SJyhjqBJEmqSFMZJoxDENE8rLKNEJZkvNM8t/zPpfvfR/4aFxkJEPoQmUZ
        q1LKi8WUgOgd2ZyITojMkcV91x6TuLocpGTq9w9KsugaxCRj+p+kxDlgpFJJqX1Yh6Rzj0cx
        qd5qRtJ1S1gWcUmQnMcWF5azqtiUq4KCrdl3VKmLuG1ds2KV6A9eg/g0MAnwZWSQqEECWsS0
        I3BMWnjcsIHAY1r0KesImhqrqL1I7bQLcYIJwcqWjeIGN4K6+5uY10UxZ6Cu2oy8OIApgvn2
        hh0TTQcy0WD0WgQ0zkwhaDNX7R4iZFJgsbKF9HoI5gjMO8ReOojJhl9fh0nO4g8fXywQXsxn
        LoKueWg3ijPB4FpowTgcDn1uI+59H5g2Hnyam/FdfR46La98pQNgedTK4/BBGG+oJbhAF4K/
        um++dB8CU8O2L50Es46t3QY4EwndA7EcnQaDunqelwbGDz67/bkj/KC+9znO0ULQaUWcOwJ6
        3vZQe2trbB34EyQ27Ktm2FfHsK+O4f/eVkSYUTCrUSvyWXW8kr0Vo5Yr1BplfkxuicKCdv7M
        +PboRj8a8FyzI4ZG4gPCLDxHJiLl5eoKhR0BjYsDhZn8yzKRME9ecYdVlVxRaYpZtR2F0oQ4
        WHiybSlHxOTLy9gbLFvKqvZUjOaHVKKzTWF1zc4H2qgPRa9n9O3ppozoTtvDxqRpvpR8KsDe
        5CbmLouGMmx5Ky9bOq57kgW2sqSwQG3iudZDpyexid6p1Yr41ajU2DFN/zIfW7qQPr/Ro88c
        Dq8/5XfYlUUEVR9tTuu7p+vOdj7rjnOaXcaIRy3uVs972c3QtbvItSQm1AXyE8dxlVr+D/zs
        kR0vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7ommrFxBpdfi1jcWneO1eLK1/ds
        Fs9u7WWyONH3gdXi8q45bA6sHocOdzB63O8+zuTRt2UVo8fnTXIBLFF6NkX5pSWpChn5xSW2
        StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb/urGYruMVSseXjFqYGxu/M
        XYycHBICJhI9V28xdjFycQgJLGWUmNd5jLWLkQMoISNxfH0ZRI2wxJ9rXWwgtpDAa0aJrv9q
        IDabgJXExPZVjCC2sECWxKMVk9lAWkUEdCXm/GQCGckscI1R4tz3eWwQ828ySmyd3gfWwCtg
        J/GsYT7YLhYBFYlH55RAwqICERKHd8yCKhGUODnzCQuIzSkQKNExbz/YzcwC6hJ/5l2CssUl
        bj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5
        uZsYgTG17djPLTsYu94FH2IU4GBU4uH9wRAbJ8SaWFZcmXuIUYKDWUmE15czOk6INyWxsiq1
        KD++qDQntfgQoynQbxOZpUST84HxnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
        ILUIpo+Jg1OqgVG4RNfsVPpevl93lh9cIb6w5XrI2xbVvIvm56aqZq0R3L7i9ep+scg8Ly7n
        /zOXvRLYvtp/aqRZP9frjQctjrv0vdnuaZ68rTZn3oW55a+OrNSQPajSuOqn56oMnxbJnETG
        GWxLDsRpzw8wq1o1219a+Zz6bqWGLZXuFdVT7W9FljucuPqVU1iJpTgj0VCLuag4EQDG9ah9
        vwIAAA==
X-CMS-MailID: 20200302154140eucas1p2d8edc3a93878743aec8c0872cc0f7e83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3
References: <CGME20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3@eucas1p2.samsung.com>
        <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
        <CAMuHMdW0qSAn3S+bpFieP=xukK5SapAq1oRC8XouuMJ6fgqOBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/20 3:08 PM, Geert Uytterhoeven wrote:
> On Thu, Jan 16, 2020 at 3:51 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
