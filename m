Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B539C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E082073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eAH2o6eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHaJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:16:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47114 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHaJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:16:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200831091611euoutp0156a984a7270c0e8035324cf59a73446d~wT5WASiCo2486924869euoutp01l
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:16:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200831091611euoutp0156a984a7270c0e8035324cf59a73446d~wT5WASiCo2486924869euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598865371;
        bh=uEv4mRNARVrH1pGeF1D9VS4PlE2P5tcROsx7w9b3Gqc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eAH2o6eWT7DKWOirYFX7ZCd9jABljAafHHO/rcnl+FPBv6oHIne15jBiyIquJCDcc
         n2YSWq4hQYnMYkFO5IlJMQnVUvYrzo3RVKD9PJlkyCwz+0v6dMci7CBKdjmRPKXA51
         cC9cWCxIuSBwX3CKFObWv9lB/UbZw4FqRvE1oTUA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200831091610eucas1p1650cbe1f0f0cecd0d88a505da6826134~wT5VqhPTN0532005320eucas1p1B;
        Mon, 31 Aug 2020 09:16:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 86.20.05997.ADFBC4F5; Mon, 31
        Aug 2020 10:16:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831091610eucas1p2b5b8c3d7229f1f38609deebb5a0dc28c~wT5VENLkN0155001550eucas1p2D;
        Mon, 31 Aug 2020 09:16:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831091610eusmtrp238db72ac8b0b6fa2813b6d9428ec6c10~wT5VDhcAn1178611786eusmtrp2j;
        Mon, 31 Aug 2020 09:16:10 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-3b-5f4cbfdaebf6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.03.06314.ADFBC4F5; Mon, 31
        Aug 2020 10:16:10 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200831091609eusmtip18267f5839469d0502083de4160185b6d~wT5Ueffj90646006460eusmtip1C;
        Mon, 31 Aug 2020 09:16:09 +0000 (GMT)
Subject: Re: [PATCH 09/33] ARM: dts: exynos: Add and enable 32 kHz modem
 clock in Origen
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0f898c36-714c-43ef-2afc-7843d444b41b@samsung.com>
Date:   Mon, 31 Aug 2020 11:16:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-9-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7q39vvEG9xdYWSxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr49WWRuaCBo6KFx+b
        WRoYF7J1MXJySAiYSDxsWMjexcjFISSwglFi9pupTBDOF0aJS0efMIJUCQl8ZpRoWBcH0zFx
        yio2iKLljBJ333WxQDjvGSUOTu9gBqkSFoiSuHxtC1iViMAZJom/366AJZgFUiV2vz3GCmKz
        CRhKdL3tAjuEV8BOYu7KvWA1LAKqEnfO/2cBsUUF4iSOnXrEAlEjKHFy5hMwm1PAVOL/zQNs
        EDPlJba/nQM1X1zi1pP5YD9ICFxil9h6+j9QggPIcZF4e9Eb4gVhiVfHt7BD2DIS/3fC1Dcz
        Sjw8t5YdwulhlLjcNIMRospa4s65X2wgg5gFNCXW79KHCDtKvF7Wwgoxn0/ixltBiBv4JCZt
        mw61lleio00IolpNYtbxdXBrD164xDyBUWkWks9mIflmFpJvZiHsXcDIsopRPLW0ODc9tdgo
        L7Vcrzgxt7g0L10vOT93EyMwaZ3+d/zLDsZdf5IOMQpwMCrx8P446h0vxJpYVlyZe4hRgoNZ
        SYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoY
        CyRmb/wRdNHLWfTr+ubVN6/vCZ+wwOqQzI3uUAt9j1pZZqPKi0J+Lx9VSPs9c577UuhFydP9
        3B8f5Zac3RMfERA09X3QjBVZW5RqrdLyj38PVPbhXN7b/dhSrPT+xaMfNTx6JqUt+b9E3XH2
        /fsrKz0VvrvtWGkXsX+qud7BBd+PuViHTu9arcRSnJFoqMVcVJwIAPyHHCdWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7q39vvEG5yaxW2xccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49WWRuaCBo6KFx+bWRoYF7J1MXJySAiYSEycsgrI
        5uIQEljKKLHhwXZ2iISMxMlpDawQtrDEn2tdUEVvGSW+THvN0sXIwSEsECXx9aofSFxE4ByT
        xMyF/WDNzAKpEhObpjJBNGxmlJh07zIzSIJNwFCi620X2GpeATuJuSv3gsVZBFQl7pz/zwJi
        iwrESZzpeQFVIyhxcuYTsDingKnE/5sH2CAWmEnM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQ
        tM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbptmM/N+9gvLQx+BCj
        AAejEg/vj6Pe8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR
        5HxgCskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAoOzNIe3vb
        LQk3t/N9E9tPLa+IKF4ovo1be90Uqd9inHZlYY3aIcV9nJHHZrWpqbq88gnT/zArOOOXUnFw
        6s6+830B2ksjWR6HyAfzS2z/Yx4nacK1QPvI8pXNWsn7vhz/GL9MZK3xqnkCBYxBZx/qisVe
        2rC14velWKsZ4RUfN7y9JCpvraTEUpyRaKjFXFScCADzEa0M6QIAAA==
X-CMS-MailID: 20200831091610eucas1p2b5b8c3d7229f1f38609deebb5a0dc28c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135426eucas1p19a79abc3fcc3580f466782a856eb0c78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135426eucas1p19a79abc3fcc3580f466782a856eb0c78
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135426eucas1p19a79abc3fcc3580f466782a856eb0c78@eucas1p1.samsung.com>
        <20200830135200.24304-9-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> The PMIC has a 32768 Hz clock used by the modem which is implemented by
> driver as a regulator.  Add and enable it to be sure modem get's its
> signal.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Origen board doesn't have any modem/cp, so I see no point in enabling 
this clock.

> ---
>   arch/arm/boot/dts/exynos4210-origen.dts | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 747221bbb856..fcf45619a3e4 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -298,6 +298,11 @@
>   				regulator-name = "EN32KHZ_AP";
>   				regulator-always-on;
>   			};
> +
> +			EN32KHZ_CP {
> +				regulator-name = "EN32KHZ_CP";
> +				regulator-always-on;
> +			};
>   		};
>   	};
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

