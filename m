Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97016C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC802074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QhC6+qWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFAJkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:40:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60871 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:40:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601094036euoutp02b9d584dbf242a82a4f2c37df47ac100d~UYhr5cxjS0927009270euoutp023
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601094036euoutp02b9d584dbf242a82a4f2c37df47ac100d~UYhr5cxjS0927009270euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591004436;
        bh=7+7sAqKdtpUyE9Y+G6uecmH6w5SBJ4dd6ctVUsyQ5MQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QhC6+qWzTvxkxpyDEyHzCE0l8I7aQLsY5buKIqBWKezLxlZTr2q2KWguvOCrZ+RcG
         Zjb5CJkUYGT0GESRRqOjE8z2qs4FDH8N2hfK7ENSX28I5LerX5MBxyOVMLyo+ziUPl
         y/kSJtcHKImAyY8NuT/CAPo7M6jbDtN2RK06obaw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601094035eucas1p2509b4f2af9aa82256ab306be995165b7~UYhrc3fDK2474124741eucas1p2Y;
        Mon,  1 Jun 2020 09:40:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.88.60679.31DC4DE5; Mon,  1
        Jun 2020 10:40:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601094035eucas1p190c4ca53a456987cd0d3475a245e4b5b~UYhrBs3ov2842228422eucas1p17;
        Mon,  1 Jun 2020 09:40:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601094035eusmtrp2cbc573ff7ede1b18c077d3c5ec02bf31~UYhrAmo0F0503605036eusmtrp2Z;
        Mon,  1 Jun 2020 09:40:35 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-bc-5ed4cd13e371
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.CD.07950.31DC4DE5; Mon,  1
        Jun 2020 10:40:35 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601094034eusmtip1a1126fe153f8bd615b392e3fbe9914f4~UYhpzJRwv0220402204eusmtip1Z;
        Mon,  1 Jun 2020 09:40:34 +0000 (GMT)
Subject: Re: [RFC PATCH v5 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <03bcd54f-d5de-1a09-f487-1f6f165c0b34@samsung.com>
Date:   Mon, 1 Jun 2020 11:40:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAGTfZH1yM0KRaEF5VTs2juTm+yrK9VqQZxWjdNf_ffjGHWPLsg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGOfdr19HkOCvfrAxGBoq5Sotbhn1SKwhMhDDKXHbRUqft+pFS
        ZFRa+ZGp4ZySGmZqlLZS1D7+MNNM3AKHSbqWNBIFq6UWWVjeXSP/+z3Ped73vO/hsKRyiPZm
        T+pSeL1Om6Bi5FRL10/zWs8+a9S6/o9qzn7rMuIeGhpp7sagleLeTo3SXGWnmeas018YrvSZ
        ieGK7IUUZ7E0yTjTxwGa62+vYDiD5TnB3e+0ybihC3UMd/lZp4wzFI8x27HG1HCV0QwPPGU0
        9txuQvOo5rym4HED0kyafMKYw/KtJ/iEk2m8Xh0aLY+bsTmJ5NaVZ36PX6ez0IOl15AbCzgY
        arJzZSIrcR0C26fwa0g+x1MILtV8oCQxiWDkdfWcYF0Vs8XbJf8uAkPlFSQJJ4Lpxg4ktvLE
        cdA6kk+KvBj7QtO3LloMkfgODT3ZDleIwesh/2UBErsqcCiYB71Fm8KrwZl1kxJ5CT4KefZx
        Vx8F9oCeMofLd8MH4d5EOSEyib3gnaNynlfBxeZyUrwL8AUWRgy1hLTnbij7aqQl9oTx7scy
        iVfAnzaxWCy4iCDvyZBMEoUI7N1VSEqFwLB5hhEnJbEfNLarJXsHOAYfENKzuMPghIc0hDsU
        tZSSkq2AK9lKKb0afjWUzo/jDbmOP1QhUhkXrGZcsI5xwTrG//dWIaoBefGpQmIsL2zQ8emB
        gjZRSNXFBsYkJZrQ3Jfrne2eakXtv493IMwi1SLFG0t/lJLWpgkZiR0IWFK1WLGzrzdKqTih
        zcjk9UnH9KkJvNCBlrOUyksRdHvsqBLHalP4eJ5P5vX/TgnWzTsLLWtPemi46qidfJ+ygY+Z
        zvmQHm1VB5U0+1Tv+ZS5Oa7+iF90mtzmKL65yLHl+ml1yCb3jR4/cnQ70auZmPBTzfv37jvk
        jDASn88pXwSnu/l+D5iNCLCOR3o6I+Mr6teMBpawhm2lPbldFU0HAqajxi4RtVvOhvn7CMfz
        Zu9pd7VtVlFCnHa9P6kXtH8BNJ1Ge24DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7rCZ6/EGfSuEre4P6+V0WLjjPWs
        FhNvXGGxuP7lOavF/CPnWC2ufH3PZjF97yY2i0n3J7BYnD+/gd1i0+NrrBaXd81hs5hxfh+T
        xdojd9ktbjeuYLNo3XuE3WLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j36tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49fd
        j0wFO2Qr/rzqZ21gXCfWxcjBISFgIvFvskMXIxeHkMBSRolVT8+wQ8SlJOa3KHUxcgKZwhJ/
        rnWxQdS8Z5RYdnMBK0hCWCBDomfvYTYQW0RAVWLDp2OsIEXMAstZJY4dWg/V0cEkMXnDbLAq
        NgFDid6jfYwgG3gF7CTO3ZACCbMIqEh8bJjKAmKLCsRKdC/+wQ5i8woISpyc+QQszikQKLH6
        7WwmEJtZQF3iz7xLzBC2uMStJ/Oh4vISzVtnM09gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzCqtx37uWUHY9e74EOMAhyMSjy8F85fjhNiTSwrrsw9xCjB
        wawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDE05eSbyhqaG5haWhubG5sZmF
        kjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGEau3OjIfq5h2/1fbcHwxf0lI8+nEQ2aWB+4/
        rZzBp96emRj9Wd6EV1Iy8sYZ84PMBvll7g4XdkV0JnzT1d7By2Vvssz71/XZefrKufyn+MJC
        Jljt2T4tsiracsNLXaEXJqqnnVgnprU6Zh/T3zRNQMWMUThvqqv586b/vrUpz002LftnFaHE
        UpyRaKjFXFScCABbTyrIAAMAAA==
X-CMS-MailID: 20200601094035eucas1p190c4ca53a456987cd0d3475a245e4b5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
References: <CGME20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e@eucas1p2.samsung.com>
        <20200529163200.18031-1-s.nawrocki@samsung.com>
        <20200529163200.18031-2-s.nawrocki@samsung.com>
        <CAGTfZH1yM0KRaEF5VTs2juTm+yrK9VqQZxWjdNf_ffjGHWPLsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 31.05.2020 02:01, Chanwoo Choi wrote:
> On Sat, May 30, 2020 at 1:32 AM Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>>
>> Add documentation for new optional properties in the exynos bus nodes:
>> samsung,interconnect-parent, #interconnect-cells.
>> These properties allow to specify the SoC interconnect structure which
>> then allows the interconnect consumer devices to request specific
>> bandwidth requirements.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Changes for v5:
>>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
>> ---
>>  Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index e71f752..e0d2daa 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -51,6 +51,11 @@ Optional properties only for parent bus device:
>>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>>                         the performance count against total cycle count.
>>
>> +Optional properties for interconnect functionality (QoS frequency constraints):
>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>> +  passive devices should point to same node as the exynos,parent-bus property.
>> +- #interconnect-cells: should be 0
>> +
>>  Detailed correlation between sub-blocks and power line according to Exynos SoC:
>>  - In case of Exynos3250, there are two power line as following:
>>         VDD_MIF |--- DMC
>> @@ -185,8 +190,9 @@ Example1:
>>         ----------------------------------------------------------
>>
>>  Example2 :
>> -       The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
>> -       is listed below:
>> +       The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi is
>> +       listed below. An interconnect path "bus_lcd0 -- bus_leftbus -- bus_dmc"
>> +       is defined for demonstration purposes.
>>
>>         bus_dmc: bus_dmc {
>>                 compatible = "samsung,exynos-bus";
>> @@ -376,12 +382,15 @@ Example2 :
>>         &bus_dmc {
>>                 devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>>                 vdd-supply = <&buck1_reg>;      /* VDD_MIF */
>> +               #interconnect-cells = <0>;
>>                 status = "okay";
>>         };
>>
>>         &bus_leftbus {
>>                 devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>>                 vdd-supply = <&buck3_reg>;
>> +               samsung,interconnect-parent = <&bus_dmc>;
>> +               #interconnect-cells = <0>;
>>                 status = "okay";
>>         };
>>
>> @@ -392,6 +401,8 @@ Example2 :
>>
>>         &bus_lcd0 {
>>                 devfreq = <&bus_leftbus>;
>> +               samsung,interconnect-parent = <&bus_leftbus>;
>> +               #interconnect-cells = <0>;
>>                 status = "okay";
>>         };
>>
>> --
>> 2.7.4
>>
> 
> If you add the usage example like the mixer device of patch5 to this
> dt-binding document,
> I think it is very beneficial and more helpful for user of
> exynos-bus/exynos-generic-icc.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for review. I will make sure the example includes a consumer
in next version. Will also mention ../interconnect/interconnect.txt
in description of the #interconnect-cells property.

-- 
Regards,
Sylwester
