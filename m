Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F52AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24440206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F9sTFviQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIAIgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:36:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50537 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:36:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200901083620euoutp01c4828bf6831b8b7ed6f58e56c461131a~wm-2GGWXR0695506955euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:36:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200901083620euoutp01c4828bf6831b8b7ed6f58e56c461131a~wm-2GGWXR0695506955euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598949380;
        bh=xR60+7s8BqCjxeWnqjPQ9S9O7uBfe2TsKeQWYCRE+y0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F9sTFviQk9qjms2b3QsgQLf/8dVZQmNWuUp/XXiAfX2mFvsva446HHFTeyIwW9hZR
         kEDwRJxWiD8rpftHk+4d/Mcq0yY1qt90FAVyYvpYAZ/oxxJRltdV1uLnQVPghpmYcc
         pvdapM1D/8yEQtdal2aTBtmgg9BAbf2vDjoyzpRM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200901083620eucas1p2823474dfa00527a05d1c42b1f61056fb~wm-1w6lq51367313673eucas1p2m;
        Tue,  1 Sep 2020 08:36:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1C.05.06318.4080E4F5; Tue,  1
        Sep 2020 09:36:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901083620eucas1p2a570a3d06b998cb77d166e8945842dad~wm-1XEf2w1248912489eucas1p2j;
        Tue,  1 Sep 2020 08:36:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901083620eusmtrp2157a3ac1522f540976297c5cd27e8ebf~wm-1WagBQ2805528055eusmtrp2i;
        Tue,  1 Sep 2020 08:36:20 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-23-5f4e080405fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.35.06017.4080E4F5; Tue,  1
        Sep 2020 09:36:20 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200901083619eusmtip2ac6b59d9e62cfbcec465bff0a6e29d5d~wm-0Ylgq90125801258eusmtip2g;
        Tue,  1 Sep 2020 08:36:18 +0000 (GMT)
Subject: Re: [PATCH 11/13] ARM: dts: exynos: Silence SATA PHY warning in
 Exynos5250 Arndale
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4836dc12-df88-5936-c208-8f6ff2a6bdc1@samsung.com>
Date:   Tue, 1 Sep 2020 10:36:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfKnzsRA3D8b3z=iG4oD6P+M7Q7YMVbrOAmLTiNgZ5mXA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zlnOxvNPufKL4uiUdGFnGLRIUO8FEwou9CvQNfSg0pukx21
        lCLRtFpiZYFzk7SSlHmftxJcZcNVQ1eJOkq7bf7Qmv5Ymkq23I6W/573uXzv+8BHYqIWIoRM
        V2XRGpUiQ8IV4J198/a9OJkgD3tesYFq1TUTVJVlgKBuOb9jlN3ewqNMzmGCGuyu5FI6u5lD
        FfVYeNS18Qksmi8zGW9wZW01V2Sl7UYg85g2n8DPCA6l0BnpObRGGnVWkOadMIDMEvHFLy0f
        iXxghFrAJxHch37M9hBaICBFsA6gubaC5eEnQOVXp3B28AA0aTYQK5ESazXGCrVLQmXTcmQa
        oAZbFdfnCoKJyFv0iOfDYrgLjSz+8pswOMdB9W4D5hO4MBxp3dqlAEkKYRS6/+yUj8bhNlSq
        a8d9eB1MQn1vvvmxEAai1xUuP+bDk2iotd7/Pga3oC53JcbiYPTBVcXx7UKwm4dqpheWzz6M
        iqd6cBYHoUlrO4/Fm5D36UqgEKCvA408digBaLBAB1hXJBodWPBfii3Vae6WsnQM8oyU+2kE
        A5DDHcgeEYDKOssxlhai68Ui1r0D6a1N/9a+ePseuw0k+lXV9Kvq6FfV0f/fWw1wIwimsxll
        Ks1EqOgLoYxCyWSrUkOT1UoTWPpHtj/WmSfA/PtcL4AkkKwR1s0elYsIRQ6Tq+wFiMQkYmFs
        vy1JJExR5ObRGrVck51BM71gI4lLgoURDycSRTBVkUWfp+lMWrOickh+SD446H0Z55l9F+zw
        7LQd//wpekjNaKf2yPmRJaOqxy5cPVa3Xz8eEWCZuXeavEvFxJnjU10Wd2HsvGBG6rzkCK9Y
        m3DnVbUhL1EP1gdt1deWJTOLxptSUZjOZu4fs6jbttd2PKh0ZnKOpAwnXG7oSmtMPxDfgRMN
        4r4wh9d9TIIzaYrw3ZiGUfwFYE+O8EMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7osHH7xBg9aWCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JonXvEXaL9qcvmR04PTat6mTz2Lyk3qNvyypG
        j8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQy/r+czVjQI1LxYMNt1gbGVQJdjJwcEgImEj3HFzCD2EICSxkl2o4zQcRlJE5Oa2CFsIUl
        /lzrYuti5AKqecso0bz9JFhCWCBW4n/rYnYQW0RAU+L63++sIEXMAj+YJKb/mM8I0fGdSWLy
        he9gY9kEDCW63oKM4uDgFbCTmLc/CCTMIqAi0TdjCwuILSoQJ3Gm5wUbiM0rIChxcuYTsDin
        QKDE1Y2rwZYxC5hJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGK
        pJYW56bnFhvpFSfmFpfmpesl5+duYgRG37ZjP7fsYOx6F3yIUYCDUYmHN+CLT7wQa2JZcWXu
        IUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmBjySuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwHpkcxyUva2FyzylEYrOyUP669Z0TlvSu
        XFVu4bWP2W7lr7hVTs6ykbJyzjp6RiqXbUVP33p/VEWaP9xcQmDKl9z3Jo37s42axXV+PZzc
        Iu+wOTjhpInClE96KsqyJ9z+Okoocv88N1tlVVrzKf4dh5cueXsi7RafTNRlWXGRWIZHazS4
        rFYqsRRnJBpqMRcVJwIAtNCFL9QCAAA=
X-CMS-MailID: 20200901083620eucas1p2a570a3d06b998cb77d166e8945842dad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196
References: <20200901075417.22481-1-krzk@kernel.org>
        <CGME20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196@eucas1p2.samsung.com>
        <20200901075417.22481-12-krzk@kernel.org>
        <800d8fa8-7fd4-6221-f8be-ef422e5642d9@samsung.com>
        <CAJKOXPd+Mr0c7ype1KTseBc2=qx0NNKKj5Ku0w0HBOgjEsGvKg@mail.gmail.com>
        <CAJKOXPfKnzsRA3D8b3z=iG4oD6P+M7Q7YMVbrOAmLTiNgZ5mXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2020 10:19, Krzysztof Kozlowski wrote:
> On Tue, 1 Sep 2020 at 10:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Tue, 1 Sep 2020 at 10:13, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> On 01.09.2020 09:54, Krzysztof Kozlowski wrote:
>>>> The SATA PHY in Exynos5250 SoCs has two interfaces and two device nodes:
>>>> 1. sata-phy@12170000
>>>> 2. i2c-9/i2c@38
>>>>
>>>> The first node represents the actual SATA PHY device with phy-cells.
>>>> The second represents additional I2C interface, needed by the driver
>>>> to communicate with the SATA PHY device.  It is not a PHY-provider in
>>>> the terms of dtschema so rename it to silence dtbs_check warning:
>>>>
>>>>     arch/arm/boot/dts/exynos5250-arndale.dt.yaml: sata-phy@38: '#phy-cells' is a required property
>>>>       From schema: lib/python3.6/site-packages/dtschema/schemas/phy/phy-provider.yaml
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> ---
>>>>    arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>>>> index f2bcce167b2d..3c401c82905c 100644
>>>> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
>>>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>>>> @@ -544,7 +544,7 @@
>>>>        samsung,i2c-max-bus-freq = <40000>;
>>>>        samsung,i2c-slave-addr = <0x38>;
>>>>
>>>> -     sata_phy_i2c: sata-phy@38 {
>>>> +     sata_phy_i2c: sata-phy-i2c@38 {
>>>>                compatible = "samsung,exynos-sataphy-i2c";
>>>>                reg = <0x38>;
>>>>        };
>>> I'm not against the rename, but frankly, the above node and all i2c
>>> parameters should be moved to exynos5250.dtsi. This is a SoC internal
>>> things (the same way as hdmiphy in exynos4.dtsi), so the board dts
>>> should only contain information like status = "enabled" for i2c_8 and
>>> hdmi_i2c_phy nodes. No need to duplicate it here and in smdk5250.dts.
>> Good point, the I2C bus used here is an internal part of SoC.
>>
>> I will squash these two changes into a new one. Thanks for the review!
> While at it, I wonder about the samsung,i2c-slave-addr property. Is it
> really needed? Are there multiple masters on this bus?

This might be some cargo-cult, probably copied from HDMI DDC (I'm not 
sure if it is needed there). I've removed it and SATA still works fine 
on Exynos5250 Arndale board.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

