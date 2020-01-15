Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FB4222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tkWAzMXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOQM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:12:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45005 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:12:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115161256euoutp01af73957a73c1930ef5df99c1142584ef~qG21oXO6o1100611006euoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 16:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115161256euoutp01af73957a73c1930ef5df99c1142584ef~qG21oXO6o1100611006euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579104776;
        bh=7K8V+tW7TPt/mT3FTdApFlmdZzjxlYBDMwhQOO1i+wA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tkWAzMXW+ni2AFPIOkZMx+hjf0bLXTBgi9MoScFLYkgZztMFpEYaiMSH0z7200A7R
         qIrxHHX5bBwf0dDypI4q63yJ57hP2h8EjUwRxe/JQkXu53Lx67c4WFsPlQWdjv+ctE
         DDeJ/WBhEhJebNXsW+qKa0+Q1ZwsQrSItMz2VrAM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115161255eucas1p1d845ebd36a560c382afdbf7360adcf01~qG21jEzjT0375803758eucas1p1s;
        Wed, 15 Jan 2020 16:12:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 93.15.60679.70A3F1E5; Wed, 15
        Jan 2020 16:12:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115161255eucas1p10e0c99e86d45f309dbc822e02bb7d7a4~qG21OFcQ-0378803788eucas1p1g;
        Wed, 15 Jan 2020 16:12:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115161255eusmtrp2deb727d845869980847c53a824071bff~qG21NjAiG2647826478eusmtrp2b;
        Wed, 15 Jan 2020 16:12:55 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-99-5e1f3a07d728
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.14.08375.70A3F1E5; Wed, 15
        Jan 2020 16:12:55 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115161254eusmtip1d4c73ba494c3e3ae23238be044efe1a4~qG20l9k7S1762817628eusmtip1d;
        Wed, 15 Jan 2020 16:12:54 +0000 (GMT)
Subject: Re: [PATCH v2 15/20] video: exynos: Rename Exynos to lowercase
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <aa7a3dc9-2ab1-1a5a-9c23-95226033cd98@samsung.com>
Date:   Wed, 15 Jan 2020 17:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200104152107.11407-16-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rsVvJxBo2vzC2ufH3PZnH+/AZ2
        ixN9H1gtLu+aw+bA4rFpVSebx/3u40wenzfJBTBHcdmkpOZklqUW6dslcGXM+PiJtaCVq6Lp
        9lTGBsZOji5GDg4JAROJVe9Vuhi5OIQEVjBKdH75zwjhfGGUOHj8MJTzmVHi8a3nTF2MnGAd
        G9ZvZ4VILGeUuH7sDRtIQkjgLaPE/pWJILawgLvEz/OTmEFsEQFNiet/v7OCrGMWSJDYvcgM
        JMwmYCUxsX0VI4jNK2Ancfb2dLByFgFViY1NK8FGigpESHx6cJgVokZQ4uTMJywgNqeAmcTj
        f8vA4swC4hK3nsxngrDlJba/ncMMcpuEQDe7xLvGI4wQR7tIzL23mhXCFpZ4dXwLO4QtI/F/
        J0gzSMM6Rom/HS+gurczSiyf/I8Nospa4s65X2wQH2hKrN+lDxF2lHh1+xUjJBz5JG68FYQ4
        gk9i0jaQZ0DCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS
        4tz01GKjvNRyveLE3OLSvHS95PzcTYzAdHL63/EvOxh3/Uk6xCjAwajEw5vxRy5OiDWxrLgy
        9xCjBAezkgjvyRmycUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJ
        MnFwSjUwVuxT5P/eMsn/zVajuTKPSzgtpjBd/Kb98uqR6Z4FYSWnpfY+3B9pusT5e1zmJVXh
        lJK/4dPCmTa+893HkbpedmP06n2Hfq830Gr48eDqFGPJeRPDpiuU3o5YYrjkoo5+2azJeYkL
        +SxMxN3KV855HHYit0mR50d5/UXtrLAWd+75zyZJXuw2VWIpzkg01GIuKk4EAHUbQ/UjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7rsVvJxBu3nVCyufH3PZnH+/AZ2
        ixN9H1gtLu+aw+bA4rFpVSebx/3u40wenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXM+PiJtaCVq6Lp9lTGBsZOji5GTg4JAROJDeu3
        s4LYQgJLGSW2L/TtYuQAistIHF9fBlEiLPHnWhdbFyMXUMlrRokdh86ygCSEBdwlfp6fxAxi
        iwhoSlz/+x1sDrNAgsSKt+2sEA1bGCXmPe4BK2ITsJKY2L6KEcTmFbCTOHt7OlicRUBVYmPT
        SjYQW1QgQuLwjllQNYISJ2c+AVvGKWAm8fjfMqgF6hJ/5l1ihrDFJW49mc8EYctLbH87h3kC
        o9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIERtO3Yz807GC9t
        DD7EKMDBqMTDm/FHLk6INbGsuDL3EKMEB7OSCO/JGbJxQrwpiZVVqUX58UWlOanFhxhNgZ6b
        yCwlmpwPjO68knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MGrzP
        vzSZ658quK7n3PrKS+b0+1XP2vQUXknOOH7rM/uaf6mzfiR35+7dGxu6JGquinu/rLLAkXk1
        M9s7596Y+J49qfHNAV/Gd122abmWk6//calcx3V4Tkl16V2jhHWrvl1uihXQOjDf5PKxoxd/
        bberydFYdMCir7AxZdu7IzJfXJm9XxiXKrEUZyQaajEXFScCAOFmNya2AgAA
X-CMS-MailID: 20200115161255eucas1p10e0c99e86d45f309dbc822e02bb7d7a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200104152253epcas3p364103342a5c96fd12d226be9fa5d4cba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200104152253epcas3p364103342a5c96fd12d226be9fa5d4cba
References: <20200104152107.11407-1-krzk@kernel.org>
        <CGME20200104152253epcas3p364103342a5c96fd12d226be9fa5d4cba@epcas3p3.samsung.com>
        <20200104152107.11407-16-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/20 4:21 PM, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
> 
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/video/samsung_fimd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
> index b6571c3cfa31..c4a93ce1de48 100644
> --- a/include/video/samsung_fimd.h
> +++ b/include/video/samsung_fimd.h
> @@ -10,7 +10,7 @@
>   *
>   * This is the register set for the fimd and new style framebuffer interface
>   * found from the S3C2443 onwards into the S3C2416, S3C2450, the
> - * S3C64XX series such as the S3C6400 and S3C6410, and EXYNOS series.
> + * S3C64XX series such as the S3C6400 and S3C6410, and Exynos series.
>  */
>  
>  /* VIDCON0 */
> 
