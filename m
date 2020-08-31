Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE5C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C9D2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oS6Iro0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHaIon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:44:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59792 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHaIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:44:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200831084441euoutp027dfcf276de3f8ca6e3c05596c67003a3~wTd1lgFxY3272932729euoutp025
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200831084441euoutp027dfcf276de3f8ca6e3c05596c67003a3~wTd1lgFxY3272932729euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598863481;
        bh=kEAACSpDUP9iD+P6ziLCS1tlWwTb6u8yQL3yoqPQHso=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oS6Iro0dE+Qtro7p5IAkUjCF5RQB2fgJOngUQwhkrVdN1anoeA6GsWtzOxhwtSKSJ
         R/brZLGdKjnVKh7DE1VlUkE36FkgA3oAyiD4UuG76dJOZXvjpGcZAdqpOUu6NVtWku
         y3aSMLOQTAvuYAssSJb55JLmrruyPuyLrBpMdmhA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200831084440eucas1p1f578012994a77cab14d7e9264faa4f0c~wTd1U3wx31400814008eucas1p1u;
        Mon, 31 Aug 2020 08:44:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.6D.06456.878BC4F5; Mon, 31
        Aug 2020 09:44:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200831084440eucas1p168ff4960505f1350d35746343a61d19b~wTd0rgc381357513575eucas1p1y;
        Mon, 31 Aug 2020 08:44:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831084440eusmtrp24d2f9a40bf2392721e8bf5c3a86f9430~wTd0qsuWp2515925159eusmtrp2k;
        Mon, 31 Aug 2020 08:44:40 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-3b-5f4cb878b04a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.F1.06017.778BC4F5; Mon, 31
        Aug 2020 09:44:39 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200831084439eusmtip2358c9e420a371bb2d56d43bf45373be8~wTd0FKpCx2809128091eusmtip2B;
        Mon, 31 Aug 2020 08:44:39 +0000 (GMT)
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5d0ce951-4472-f7f4-31be-b1f7dc8f05cb@samsung.com>
Date:   Mon, 31 Aug 2020 10:44:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Xa2s+NsdpyWLyqFC0UzXVLQCS+paAwyKISoIHXqQSU3bceZ
        RpG6TB2SIpQ2pFKE8lLqGssLirc5vJsrFQvKtNC8QZaloOV2svzv9z7v894+PgITdfOciSRF
        Gq1UyJLFuIBr6F0f8cloiog+WpjjRTWW1fOoxz3DPCp3YoZPFc0sYNTISAOf0s2M8yhzSzlO
        lY20c6jcth4+pR98h1N5n+exYFupsSMbk+pqCnDpnXodLn1ZdVt6T1+DpKu6A+fwy4KAeDo5
        KZ1WSoJiBImL9w0odcgmY8U4gGehDb4G2RBAHgdDXSvSIAEhIp8hWK4owdjgO4LNuUEeG6wi
        ME3N4jsl2V8mORYWkU8RjBfgrGkFQXtOP7IkHMgEWBo1YhZ2JL1gYvOntRNGvsZgvanNWo2T
        fqBZ0li7CskgaH2r51qYS7pDdve4Vd9HRkFv/ycu67GHvoezVrYhz4P6Y6O1D0YehFdL5RjL
        TjA1+5jDbjrOh7mxQyyHQW/fIsayA3w16f8+gCv8brb4BdusRjA9/JzPBoUIzDlliHX5w/vh
        je2NiO0JXlDfImHlECgub+RbZCDtYHLJnt3BDkoMpRgrCyH/roh1e4DW9OLf2M7RMawYibW7
        LtPuuka76xrt/7lPELcGOdEqRp5AM34K+rovI5MzKkWCb1yKXIe2v9bAlulbE/oxFtuFSAKJ
        9wh/Gc9Ei3iydCZT3oWAwMSOwtChgSiRMF6WeYNWpkQrVck004VcCK7YSXiscv6KiEyQpdFX
        aTqVVu5kOYSNcxa6mLpVtz81/hZ+StzkYeeTOBo6XdTsXZnf0RlP7T2rjHogNdRx1mpPvMmr
        dC0yO6K1sEsxcZHrao3JMTxkgdNVLa6qQsmNEvXkYINbt+fpWFeFKqZCEBGs8ZCsuJNutsvX
        /D8EYierkwJQoLHUXHszt5dJD/eMvODyqEN/xFvMZRJlfocxJSP7A6CAB0tWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7rlO3ziDV5ts7HYOGM9q8X8I+dY
        LVqvP2a36H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsWvceYbfYcuY2m0X705fMDtweRw80
        MntsWtXJ5tGyfhObx+Yl9R59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WbqNsaCs5wV74+eZmtg/MXexcjJISFgItH47AZT
        FyMXh5DAUkaJG8vfsUAkZCROTmtghbCFJf5c62KDKHrLKHHtyTVGkISwQLrE2wtHmUFsEQFN
        iet/v7OCFDELXGaW2L2inx2iYwOTxJuDh8Gq2AQMJbregozi5OAVsJPYfXUL2DoWAVWJxsPX
        wOKiAnESZ3peQNUISpyc+QSshlMgUKL5wUYmEJtZwExi3uaHzBC2vMT2t3OgbHGJW0/mM01g
        FJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBStx37uWUHY9e7
        4EOMAhyMSjy8P456xwuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMT
        maVEk/OBSSSvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAMjX3SY
        ZPL0mPD0VsbzitWv/3ffbS6a3mDdMVVw2SXLpWvW7HHJOSaZ7/B/jpRU7eGj01OZopWTT8xr
        qa6ZNb0l+l/AwiMhz+eKS379vlTkamjn6x0vf5l5l1tEnneYXxu+wVRs462Ec/GMfx4xhbvd
        ia/pWq1c05WVFqz+okRv/QaprqJjkdOUWIozEg21mIuKEwEwl2Y26gIAAA==
X-CMS-MailID: 20200831084440eucas1p168ff4960505f1350d35746343a61d19b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
        <20200830135200.24304-23-krzk@kernel.org>
        <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
        <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 31.08.2020 10:38, Krzysztof Kozlowski wrote:
> On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
>>> The camera's pinctrl configuration is simply empty and not effective.
>>> Remove it to fix dtbs_check warning:
>>>
>>>     arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> I think that this was intentional to properly enable support for
>> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
>> default values if no pinctrl properties are provided. Sylwester, could
>> you comment?
> Indeed it could be intentional... I see now errors:
> [   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19
>
> I wonder why getting an empty pinctrl is needed... maybe the driver
> should accept missing pinctrl?

Please ensure that you have those patches applied:

https://patchwork.kernel.org/patch/11707579/

https://patchwork.kernel.org/patch/11707577/

https://patchwork.kernel.org/patch/11705409/


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

