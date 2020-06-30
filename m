Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC21BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C60620672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rb0Eu3zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgF3G1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:27:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgF3G1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:27:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200630062702euoutp011ad33b7fc74e2b0d5b1717f596b9d351~dPl9KPwkZ0984009840euoutp01j
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:27:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200630062702euoutp011ad33b7fc74e2b0d5b1717f596b9d351~dPl9KPwkZ0984009840euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593498422;
        bh=837mH5WoZoAfjQ/qyJerBSqKjDYL+ctM09x1q/ySjVk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Rb0Eu3zsNasSuDi2YnKXoNpZfNPm2JbY6puzIMp6Hbd/9H8o5wAJ4Ls/3CILmhIb5
         Qpp/L1KoFzzu+nGgqoBMTfOuhxtNE8qMqyVENcKE0fveHZPW7THZVD/8l9ELbdO/Tv
         wrc7oKXFFfar1RMmRB3aEepCOElr7Vksmo3qYZa0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630062701eucas1p1b691c1894216947d32cca0a029408300~dPl8eZ-jt1426414264eucas1p1Y;
        Tue, 30 Jun 2020 06:27:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C1.4D.06318.53BDAFE5; Tue, 30
        Jun 2020 07:27:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200630062700eucas1p26889ded55f324aa745bc914dcd1faed4~dPl79WWlp2732027320eucas1p2F;
        Tue, 30 Jun 2020 06:27:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200630062700eusmtrp2f1d0f04afba5316efc4a2f294370e3ba~dPl78ncSS3011830118eusmtrp2c;
        Tue, 30 Jun 2020 06:27:00 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-38-5efadb35f8aa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.0A.06017.43BDAFE5; Tue, 30
        Jun 2020 07:27:00 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630062700eusmtip1dcf28c8e096329f4a9f6145f772ef6f5~dPl7SBLzl0872808728eusmtip1X;
        Tue, 30 Jun 2020 06:27:00 +0000 (GMT)
Subject: Re: [PATCH v2] ARM: dts: exynos: Fix missing empty reg/ranges
 property regulators on Trats
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <97651868-30f3-6b91-1ea2-551ee1ebad8f@samsung.com>
Date:   Tue, 30 Jun 2020 08:27:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629205948.32250-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2xLYRjO13PantYq347VXiZIk80l2YaZHCGyiR8lEUQiIVbKjlm03dLa
        jEjsQlndSiKtGruwaJrsVlZMLNkxKxmtdNjCwlixmkZil24zRnuM/Xve532e73ne5KMIulk4
        m8rWHWT1OrVGIZKSrrZRT2LqmzHVkmGHnOm55hIxDdY6IdM5+FnIlLd6hMz53n6C8XrrxYyz
        95WQ6WgqEzFWb7OAqWocFDMnHrSKmZMfA0RalNLpKBUpb904pjx324GUA865m8kd0tWZrCY7
        n9Unr9kt3d9Z9J3MDQkL2rmngkI0QpqQhAK8HH51NApNSErR2I7gR+EtET8MIvCVDAvCKhoP
        IPh2ctmko8UVQrzoJoLHodNifviGoN/ujThmYBZeFdcQYRyDt0Eo8DjyLIHHBTDy5q0ovBDh
        pWAKmiJYhtdAF1caMZA4HiotzyIF5TgDzlVX/NVEw5PL/j88RUlwKpiD+8I0gefBnWAZweNY
        eO0vF4SzAPvE8OK6T8DXXgeWPjPB4xnwxX1bzOM5MHFv0lCC4L2nRswPZxB0FFsRr1oF3Z4x
        UTiZwIugrimZp9Oh+8KYOEwDng5dwWi+xHS46LIQPC2DU0aaVyeAzV37L7bluY8wI4VtymW2
        KefYppxj+59bgUgHimXzDNos1pCiYw8lGdRaQ54uK2lvjtaJ/vyq9l/uobuoeXwPhzCFFFGy
        3Z5RFS1U5xsOazkEFKGIka191q6iZZnqw0dYfc4ufZ6GNXAojiIVsbKUqkAGjbPUB9kDLJvL
        6ie3AkoyuxA9vEOrMlHasUDnzk/pwyuS7HTaUe5+QeuCoZWKCZtRdbyNbLpedmljQjWncebU
        c3V3N1ji46XrTWetukcp282s2z7ta4/xim8TSU+Le+DvspuXp17NlY9LEt/5G7S9C7lt8p/p
        3saXRa/z+7ZU9httH+bN2rP1fdnM+bUl6iFCQRr2q5cuJvQG9W/pUwM2UQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7omt3/FGXzbYWDxYN42NouNM9az
        Wlz/8pzVYv6Rc6wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFoq1f2C1a9x5ht2h/+pLZ
        gcdj06pONo/NS+o9+rasYvT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+N64yeWgu+sFacPnWFqYPzB0sXIySEhYCJxcNt3RhBbSGAp
        o8Trs/4QcRmJk9MaWCFsYYk/17rYuhi5gGreMkpMmLSaCSQhLJAqca1pLXMXIweHiECYxNpV
        5iA1zAJ/mCQ23HvDCNHQwSix/nsPG0gDm4ChRNfbLjCbV8BO4sahTmYQm0VAVWLh9LNgF4kK
        xEp8u7cFqkZQ4uTMJywgCzgFTCUmvE0DCTMLmEnM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQ
        dM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbmtmM/t+xg7HoXfIhR
        gINRiYc34dzPOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQF+m0is5Ro
        cj4waeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDc3rSoX+qh
        lcVz4wa2R//WLn56efMkrY0fdhssfHU75KVNrdZTF7Zfd1d9n3e7mDH6npNFyNYFYo82HUg8
        IHjc4Umb3dbSy0xOPf68kvv3HnqfLv9M3V79c8SJUj6V6hRO/3nbG0pP7ut61bq6dHJios0G
        0wt5lZcduw/wb1gulPU6h+3OugobJZbijERDLeai4kQADzbOMeICAAA=
X-CMS-MailID: 20200630062700eucas1p26889ded55f324aa745bc914dcd1faed4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629210025eucas1p219a52e75ecce9e813aa80f0126780189
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629210025eucas1p219a52e75ecce9e813aa80f0126780189
References: <CGME20200629210025eucas1p219a52e75ecce9e813aa80f0126780189@eucas1p2.samsung.com>
        <20200629205948.32250-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 29.06.2020 22:59, Krzysztof Kozlowski wrote:
> Remove the regulators node entirely because its children do not have any
> unit addresses.  This fixes DTC warning:
>
>      Warning (simple_bus_reg): /regulators/regulator-0: missing or empty reg/ranges property
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

What about removing the regulators node from other boards: 
exynos4412-origen.dts, exynos5420-smdk5420.dts and exynos5250-arndale.dts?

On the other hand, maybe it would be really easier to add missing 
address/size-cells properties to exynos4210-trats.dts/regulators node?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

