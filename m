Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AE520812
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d3YYlPCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgEVH5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:57:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41908 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgEVH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:57:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522075716euoutp01102f226775c2b06380aaaf5e0a006ef7~RSqnPlvwd0806508065euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:57:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522075716euoutp01102f226775c2b06380aaaf5e0a006ef7~RSqnPlvwd0806508065euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590134236;
        bh=QSK4VP99XJMinqlR8VyUY3k2MmIr1hx8z98ev9pZpIY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d3YYlPCndeScCKGcr1f0Ue0qQjnnu2+Rn4Mj717TCFvgVFKBNdUdACeIiJbgR5jDn
         ioCZPSSMfenhhTCnuM+1A//lU6U3sIDQWn8WjI75IiJLPPRhBGok9PQLtnHTxBZZoF
         Rh0W8fio7CulaDcQokXshiU/P/tntB3ggx1KlGb0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200522075716eucas1p16210700c9960d257b14f5eab5c8fb831~RSqm05nKX1422014220eucas1p1o;
        Fri, 22 May 2020 07:57:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.0C.60679.CD587CE5; Fri, 22
        May 2020 08:57:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522075715eucas1p16dc9dbea28c77537cf5ed4c07486e56f~RSqmcgXf52433324333eucas1p1M;
        Fri, 22 May 2020 07:57:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200522075715eusmtrp221f80781a5f18060f152699e97a6b9c7~RSqmbz2V11941319413eusmtrp25;
        Fri, 22 May 2020 07:57:15 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-f0-5ec785dc382f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.5C.08375.BD587CE5; Fri, 22
        May 2020 08:57:15 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200522075715eusmtip1540626610ab65934ccfc25737849fc6b~RSql69mOU3177031770eusmtip1P;
        Fri, 22 May 2020 07:57:15 +0000 (GMT)
Subject: Re: [PATCH RESEND 0/4] Minor WM8994 MFD/codec fixes
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c4e8ce6f-f26c-110c-610b-3a86b13a95d9@samsung.com>
Date:   Fri, 22 May 2020 09:57:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200427074832.22134-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXfOzo7L2XEa/r1UMEgwyEv5YaFImsSQPgjrTlstPajlpmxq
        6SexTNMwLWU5lnnDa2mYTR2BOpsiylAnaTXJiRRGw2jeMde2o+W353n/v/f5vw+8JMbvYweQ
        aYosWqmQpQsILq4b3jSdsBSOSMPza9jC6UkDS1hlXSSE04VdSPh11YiEa9PFLKFZryWE9uV+
        tnDoZxH7DCl6Yy8gRH2aOY6oq+0RIbJ8fE+I1FoHEpV1tyGRvetIIucaNzqZTk/LoZVhMTe5
        qWMTv1CmHr+nNxeifDSFlSAPEqhIeFLW6NRckk+1IGgqNbEYs4KgaOEbzhg7gjlzL9q78mzD
        uDtoRtA+sbxrlhGsfx90Uz5UNGyt6AiX9qWk0NxQ687FqDEESz2VHNeAoCKgxFbihnhUDFR+
        aMFdGqeOwU6DwR10iJLAWMNbxDDeMFq96GRI0sPJ16nPuY4x6ij02LQYo/3g8+JL9y6ghjkw
        s9Ti5oGKh5pRMdPAB36MdHMYHQSOvj3+PgKr6TWHMY8RmAue73aOAotpi3AFYVQIdOrDmMxY
        qPjizUgvmLV5M0/wgqc6NcYc86D4IZ/JCAbNSMe/rYMTU1g5Emj29dLsK6PZV0bzf20twtuQ
        H52tkqfQqpMK+m6oSiZXZStSQpMy5F3I+aHGdkZWepF++5YBUSQSePLmk4alfLYsR5UrNyAg
        MYEvr+6gUcrnJcty82hlxg1ldjqtMqBAEhf48U7VL0n4VIosi75D05m0cm/KIj0C8hHb3i+d
        sQ0nHMBlSFy8JraetToa48qTPr27GG6P71R4tjYVigeg48rlEP+EZLn/hVnLgOTwtvWSMWBc
        Lbnavo5Fs4MbwpVazNobqdMt9HcMbeaVVs3f/h00+ce3vjRw/nRUYluUNq5m9UFsxcZS63iZ
        40X39fHtV+erM6gqLwGuSpVFHMeUKtlftCst/UwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7q3W4/HGbzZrG1x5eIhJoupD5+w
        WVxp3cRocf/rUUaLb1c6mCwu75rDZvH5/X5Wi8Nv2lkdODw2fG5i89g56y67x6ZVnWwed67t
        YfOYPuc/o0ffllWMHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlnL7wgbFgF0vFrsutjA2Ml5i7GDk5JARMJCb/OMrSxcjFISSwlFHi
        /8sDjBAJGYmT0xpYIWxhiT/XuthAbCGBt4wS376IgNjCAjYSv75sA4uLCMRJ3OppZQYZxCxw
        llHi2OuLLBANE4Ea/oENZRMwlOh6CzGIV8BOYsqRFWA1LAKqEv8WHwKrERWIlVh9rZURokZQ
        4uTMJ0A1HBycQPULp7uBhJkFzCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGoVlIumchaZmFpGUW
        kpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNy27Gfm3cwXtoYfIhRgINRiYf3QfKx
        OCHWxLLiytxDjBIczEoivAv5j8YJ8aYkVlalFuXHF5XmpBYfYjQF+m0is5Rocj4wWeSVxBua
        GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBU6yrkuHVw+lv3+I4/s7p3
        yesrftWasMNCrDFJleP0oST7VvXUlRsnW216rf75690nrCuko6cKKraI3Oq9cmTLnZM/d36d
        nFD1dfX34tpZ2/5fef8qov7Wt5VvRTv6aiuE57bMrlVQWdF/JSxQ+r66Qi6PgSQ/77e6+a/X
        3+IJn3FFaPbzj7F5SizFGYmGWsxFxYkAA+jM694CAAA=
X-CMS-MailID: 20200522075715eucas1p16dc9dbea28c77537cf5ed4c07486e56f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485
References: <CGME20200427074841eucas1p10523e8e342a8fa2d7cdfb2bc4e25d485@eucas1p1.samsung.com>
        <20200427074832.22134-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 27.04.2020 09:48, Marek Szyprowski wrote:
> This is a resend of the minor WM8994 MFD/codec driver fixes posted in
> last days of the February 2020:
>
> https://lore.kernel.org/patchwork/project/lkml/list/?series=431296
> https://lore.kernel.org/patchwork/project/lkml/list/?series=431721
>
> I hope this time the patches will find their way to mainline.

Gentle ping. Lee: could you queue at least the first 2 patches if you 
consider the latter 2 a bit controversial?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

