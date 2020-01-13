Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445CC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0243D20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tzgXTIJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAMOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:02:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56742 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgAMOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:02:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200113140206euoutp02a261fb9260842716be398186f2f5f8f1~pdyCM63lb0696206962euoutp02t
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:02:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200113140206euoutp02a261fb9260842716be398186f2f5f8f1~pdyCM63lb0696206962euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578924126;
        bh=Q76juxHEkfagvYhP5sjzFgIpF/yAGbHi9ChyXpJi2so=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tzgXTIJIXYsaKO8a/feX4dBTzL+c1/1loNAr/bV2wOz+0Ymw1Q0fCAUUCcAxHlSuc
         ve0fqYTunXK0+fsUmtWze8gaSyQRlUx1kEgvq+dWiSgaUNgeLkb6NsSzkBSGUVNarG
         QglwRu9wXh1qO8evSNJZh78l+eU2ED4JtD821I8Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200113140205eucas1p1a4f06b8a8c8249831a4b33c7bb01dbf8~pdyCBMxS-0437304373eucas1p1P;
        Mon, 13 Jan 2020 14:02:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.04.61286.D587C1E5; Mon, 13
        Jan 2020 14:02:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200113140205eucas1p1ad988fd90cc2c9bf0efc28269a374bd0~pdyBozjN70437104371eucas1p1u;
        Mon, 13 Jan 2020 14:02:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200113140205eusmtrp2e51b92d9c8eda43b736af98ed1a3916b~pdyBoPk-f1632916329eusmtrp29;
        Mon, 13 Jan 2020 14:02:05 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-95-5e1c785d3bb4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.F3.07950.D587C1E5; Mon, 13
        Jan 2020 14:02:05 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200113140205eusmtip1fdc55511c22a6ebde4c2b8fb548c6de7~pdyBRd_oU1947319473eusmtip1L;
        Mon, 13 Jan 2020 14:02:05 +0000 (GMT)
Subject: Re: [PATCH RESEND] phy: exynos5-usbdrd: Calibrating makes sense
 only for USB2.0 PHY
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1c5da6e3-d62e-9aa9-8c0c-e028c2c8c444@samsung.com>
Date:   Mon, 13 Jan 2020 15:02:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191213083157.9220-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87qxFTJxBpNW6ltsnLGe1eLC0x42
        i/PnN7BbXN41h81ixvl9TBaLlrUyO7B5bFrVyebRt2UVo8fxG9uZPD5vkgtgieKySUnNySxL
        LdK3S+DK2PZjNnPBa86Ku0e3MzcwLuLoYuTkkBAwkTj8v4+1i5GLQ0hgBaPE9l1f2CGcL4wS
        VxpXQWU+M0q8WfydFaZl4YEDUFXLGSV27rgOVfWWUeLtx43sIFXCAnES299sYwOxRQQcJJYs
        vQNmMwusZJR4/9wdxGYTMJToetsFFucVsJPoO3IAbAOLgKrE696nLCC2qECsxP3VUxkhagQl
        Ts58AhbnFLCVaHj+mhFiprzE9rdzmCFscYlbT+YzgRwkIbCMXWLZvgdQZ7tITJo3mRnCFpZ4
        dXwLO4QtI/F/J0xDM6PEw3Nr2SGcHkaJy00zGCGqrCXunPsFdCoH0ApNifW79EFMCQFHid1f
        XCBMPokbbwUhbuCTmLRtOjNEmFeio00IYoaaxKzj6+C2HrxwiXkCo9IsJJ/NQvLNLCTfzEJY
        u4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgwjn97/inHYxfLyUdYhTgYFTi4W3I
        k4kTYk0sK67MPcQowcGsJMK76ZxUnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNL
        UrNTUwtSi2CyTBycUg2MHK5BetGneE2PmqoxSfVMs+Zc8zjmpItTzE1T6y7bzmIp5QvStxr7
        v2x4kW8e9aIhx6GX9f1j06BHvwqnT9Nd47TDu5PV8dNf4+oY71TDB6d5Tygprpg3bcLXkrgL
        Hu/Vw+t+p7Akr3I89+qXOZuivHWQxv5iDjOR1IvTyn31wxbULDsXWKDEUpyRaKjFXFScCAAj
        D3WTNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7qxFTJxBifWS1hsnLGe1eLC0x42
        i/PnN7BbXN41h81ixvl9TBaLlrUyO7B5bFrVyebRt2UVo8fxG9uZPD5vkgtgidKzKcovLUlV
        yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2PZjNnPBa86Ku0e3
        MzcwLuLoYuTkkBAwkVh44AB7FyMXh5DAUkaJpyf/MEMkZCROTmtghbCFJf5c62IDsYUEXjNK
        vJpkCmILC8RJnDndxwhiiwg4SCxZeocNZBCzwEpGiZ4JJ5kgpk5glJhypwNsEpuAoUTXW4hJ
        vAJ2En1HDoDFWQRUJV73PmUBsUUFYiX+n7kGVSMocXLmE7A4p4CtRMPz12DbmAXMJOZtfsgM
        YctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECY2zbsZ9bdjB2vQs+xCjAwajEw6uRIxMnxJpYVlyZe4hRgoNZSYR30zmpOCHelMTK
        qtSi/Pii0pzU4kOMpkDPTWSWEk3OB8Z/Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs
        1NSC1CKYPiYOTqkGRt67p1T7eRe83euxv2Gj3PsrHjffadhc3noxjjUm6+82ryOLVr6y+1Wn
        Ij8/febbM3dn3WVre7Xi3P4ztrcOaoYbFCUoxYW5z/w4+7pOis2fnKcRfpLB+5d2p0u7X9Zj
        0nyac+bclfue3j1V69SC39baMSouerZxdo62qt3ZXZG7vrvnP177ZbsSS3FGoqEWc1FxIgDF
        u2YtxwIAAA==
X-CMS-MailID: 20200113140205eucas1p1ad988fd90cc2c9bf0efc28269a374bd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191213083209eucas1p1459831639297fc7c37089c8fef4e0248
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191213083209eucas1p1459831639297fc7c37089c8fef4e0248
References: <CGME20191213083209eucas1p1459831639297fc7c37089c8fef4e0248@eucas1p1.samsung.com>
        <20191213083157.9220-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.12.2019 09:31, Marek Szyprowski wrote:
> PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
> calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.
>
> Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

gentle ping

> ---
>   drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 646259bee909..f07edd80d2f3 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -714,7 +714,9 @@ static int exynos5_usbdrd_phy_calibrate(struct phy *phy)
>   	struct phy_usb_instance *inst = phy_get_drvdata(phy);
>   	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
>   
> -	return exynos5420_usbdrd_phy_calibrate(phy_drd);
> +	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
> +		return exynos5420_usbdrd_phy_calibrate(phy_drd);
> +	return 0;
>   }
>   
>   static const struct phy_ops exynos5_usbdrd_phy_ops = {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

