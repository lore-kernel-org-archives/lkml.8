Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4814BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0295320732
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NeNlj47Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIGIfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:35:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48914 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgIGIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:35:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200907083530euoutp02a547904d783153951b88b9b13fb7a6a9~yc20_JJoI3268832688euoutp02D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200907083530euoutp02a547904d783153951b88b9b13fb7a6a9~yc20_JJoI3268832688euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599467730;
        bh=5eUqfqOe8KGV5WESEo8yTEImYqkmT94n8f1isYRbGf4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NeNlj47YxY0RenF7NKJ+DqOisirtTWY3apIWH8D2PYIzEYShIRXMBwXsGDVo3ljBq
         gr48kyvpYc/kGhZ21fwg7fOaMIYsj9qReIHMO7DxpXZewV2QSVIinJn1fVySSFskh2
         68aVh7qRwSON6+XmeASU43Oh+piRptTI+4W6PHOc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200907083530eucas1p237c4cbc69058f967d229bfa4b86a248c~yc20ndh810572005720eucas1p2J;
        Mon,  7 Sep 2020 08:35:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.4C.05997.2D0F55F5; Mon,  7
        Sep 2020 09:35:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200907083530eucas1p20417143367abaf397e2145aeccf4f623~yc20Vibeq1868418684eucas1p2k;
        Mon,  7 Sep 2020 08:35:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200907083530eusmtrp26a357786861b079524ee9d055f7bdd53~yc20U0uU-0775907759eusmtrp2g;
        Mon,  7 Sep 2020 08:35:30 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-1f-5f55f0d2ecbf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 76.27.06017.1D0F55F5; Mon,  7
        Sep 2020 09:35:29 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200907083529eusmtip1e49293f67772ae653c3a7a58cd3fd7e9~yc2zpkSL12715127151eusmtip1i;
        Mon,  7 Sep 2020 08:35:29 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos3250
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b092ef9e-b403-751e-22c3-65aa840267e6@samsung.com>
Date:   Mon, 7 Sep 2020 10:35:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906124407.GA4829@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87qXPoTGG+xYL2gx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFq17j7BbtD99yezA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CV8fh0WcEFjoonOztYGhh/sXUxcnJICJhIPDp8g7mLkYtD
        SGAFo8SRBUdYIJwvjBLPnrxjh3A+M0rsmLmAFaale/cMVojEckaJ1ivvoVo+Mkr8XvccbLCw
        QJzEwcbvQO0cHCICERLbV4JNYhb4zijxtG0/WA2bgKFE79E+RhCbV8BO4t+8lSwgNouAisTC
        y31gtijQnGOnHrFA1AhKnJz5BMzmFNCTuPbpNNgcZgFxiVtP5jNB2PIS29/OAXtIQmATu8SV
        qTdYIM52kVjXuoEJwhaWeHV8CzuELSPxfydIM0hDM6NEz+7b7BDOBEaJ+8cXMEJUWUvcOQcK
        Mw6gFZoS63fpQ4QdJRYvOAr2pYQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0i8XvVdKgTpCS6
        n/xnmcCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZiM
        Tv87/mUH464/SYcYBTgYlXh4X4iHxguxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBsYZk+tsAlg2umwO0pp3pN+69ebj
        VlMBM6fJzMa+ci8vMHJbyoeGOHlLr8i/UffOa+FUpb2/djt1HWZPn3k5eV7/PjYP49uzJXwF
        FrModMVsO6qs47vmlFpVd9s8yXvrD9jLsUc9vSlUoPjmRPPype7rgr7MfrNwz7KCzi8qVxkW
        +osy1+8OOqjEUpyRaKjFXFScCADXSpoCQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7oXP4TGG3w7ZGMx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFq17j7BbtD99yezA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CX8fh0WcEFjoonOztYGhh/sXUxcnJICJhIdO+ewdrFyMUhJLCUUWLlmhlMXYwcQAkpifkt
        ShA1whJ/rnWxQdS8Z5SY23uAHSQhLBAnsebEShYQW0QgQuL1nXtgNrPAd0aJswuZIBoeMEpM
        2rSAESTBJmAo0Xu0D8zmFbCT+DcPoplFQEVi4eU+MFsUaOiZnhdsEDWCEidnPgGLcwroSVz7
        dJoNYoG6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYOxtO/Zzyw7GrnfBhxgFOBiVeHhfiIfGC7EmlhVX5h5ilOBg
        VhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84FpIa8k3tDU0NzC0tDc2NzYzEJJ
        nLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+NeVuZp4il+Jtyiroe8QvvM+6fW3b9u4ZKQ7uV1
        2Ur5cZfhRG2XstW/IpN+1LHqHaqwFo6adNT29RUd2dJf6mu19/7mXeeUvSxEf48uu/f9jMIk
        oxVzak0DGRNWfjZWqH2RcE/CJvDVRMHr2ReVDcwbe/c9t9V0MnOwnHd41RZnIwaln44TlViK
        MxINtZiLihMB2NFKB9MCAAA=
X-CMS-MailID: 20200907083530eucas1p20417143367abaf397e2145aeccf4f623
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200903181437eucas1p16b97d1c425672700bac7ece19084584c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200903181437eucas1p16b97d1c425672700bac7ece19084584c
References: <CGME20200903181437eucas1p16b97d1c425672700bac7ece19084584c@eucas1p1.samsung.com>
        <20200903181425.5015-1-krzk@kernel.org>
        <4bc2ea2e-65a2-6c0b-9557-5777e359241a@samsung.com>
        <20200906124407.GA4829@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2020 14:44, Krzysztof Kozlowski wrote:
>>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>>> index a1e93fb7f694..89b160280469 100644
>>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>>> @@ -214,6 +214,7 @@
>>>   			compatible = "samsung,exynos3250-cmu";
>>>   			reg = <0x10030000 0x20000>;
>>>   			#clock-cells = <1>;
>>> +			clocks = <&cmu CLK_FIN_PLL>;
>> This is not a correct input clock for this CMU. Please assign it to 
>> xusbxti, xxti or xtcxo in the respective board dts, as this is a board 
>> property.

> Makes sense, although all this is kind of a hack as neither the bindings
> nor the driver take the input clock.

I think we should update the bindings so possible input clocks
to the CMU are documented for all SoCs. This is actually a bug 
in the clock controller DT bindings that the input clocks are
missing. Then the driver would handle both the old and the 
updated bindings but the "clocks" property would be documented 
as mandatory. I will try to have a look at this. 
