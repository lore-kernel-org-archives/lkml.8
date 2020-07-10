Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED04820720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YeAyM9S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJPZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:25:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53080 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:25:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200710152549euoutp02289ca16ed50ad804624d08301d444df3~gbZPK646j1309713097euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:25:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200710152549euoutp02289ca16ed50ad804624d08301d444df3~gbZPK646j1309713097euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594394749;
        bh=Fb5i/uEYICrQeDrDUdo/YiKSlYt/GhBcG7hnIOec6Cw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YeAyM9S7SLX0FVJQjzqKeMYDPHNslHXhLdfbvJvw0BwAwtu2v/1e5fhL4B/6Fs5gE
         acNZCDZ0hLMv72snapAzXwnHhQSysQmtBB9m8vvLb98xShs3m/tQoydBm6BBSokMEK
         WHqY7G72oa6qHYeOclrbn4Zx5qMz6vUhh4AUGLAY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710152549eucas1p21e7270b75ab42af952ed2b54425468b8~gbZOvNNOE1359713597eucas1p2A;
        Fri, 10 Jul 2020 15:25:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.A5.06318.D78880F5; Fri, 10
        Jul 2020 16:25:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710152548eucas1p23ed7203d6f74470a95f0eb704ed7536c~gbZOZr84T2840528405eucas1p2d;
        Fri, 10 Jul 2020 15:25:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710152548eusmtrp17d6a60179098edaeda95b657eb95e50a~gbZOY8mRN1963519635eusmtrp13;
        Fri, 10 Jul 2020 15:25:48 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-52-5f08887d12aa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.68.06314.C78880F5; Fri, 10
        Jul 2020 16:25:48 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200710152547eusmtip1c927cdd0ea431ba1339e05a7c577869c~gbZMu_kGX0688606886eusmtip1e;
        Fri, 10 Jul 2020 15:25:46 +0000 (GMT)
Subject: Re: [PATCH v8 2/5] driver core: add deferring probe reason to
 devices_deferred property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <dd5133d5-56a3-0308-ea7b-bfeee7c47f7d@samsung.com>
Date:   Fri, 10 Jul 2020 17:25:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710133143.GA2085030@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt/vYdXrtOpN9mmSO+iOpLJS4YdiDoEsURBRB5WPlRc1HtpuV
        hVhpNs1MDatNBSurKdZ05jR72UotRPGRQ8Oyh5HLxwwVK8xyu4v87/zOOd/3nQM/CpOPET5U
        bOIxXp2oileSMtzU/LN9ZaqGilidqZey1rwXiK2+biDYwo+DJPtmykay6bcMJNszbcXY1yM9
        OJuVXyZljZ8tBNvdUEyy5sIniL338p2UNefuZ0smC7GN7ly3pRPjbL3npdxD3TspV6TREpyx
        IovkXuV1SbhnJZVSbuBii4SrKUvjch9UIK7x0hWcmzAu3um2T7Y+io+PPc6rA0MjZTHjP4aJ
        pCL6pMZy4AzKcc1GLhQwwfC2vITMRjJKzugRNDYWEeJjEsHLC2YkPiYQaHMb8H8j4/enJaJw
        F8Hsn0zniA1Bc2ehw+XJHIRPRTZkxwuZILjcppPaTRhjwsEwkoHZBZJZDr9r+kg7pplQ6Luj
        dwzgzDLIabY4Fnkx4WCw1klEjwe81g46eBdmDTxueuTYgzF+UDda7MQKODdZTohRtRQMTcSI
        eAtkXG928p7wreWBVMS+0Holx1ktDQb09myyOaxBUFv1EBOFEOhv/zUXlJo7sBwMDYEivQlq
        uizITgPjDr2jHmIEdygwXcNEmgZNplx0+8NAW61zoQJud0yReUipm1dMN6+Mbl4Z3f+7pQiv
        QAo+WUiI5oWgRP7EKkGVICQnRq86dCTBiOZ+Yetsy1Q9ejpz0IwYCind6FIVFSEnVMeFlAQz
        AgpTLqQ3t7WGy+koVcopXn0kQp0czwtmtIjClQo66KY1TM5Eq47xcTyfxKv/qRLKxecMCqFi
        X5UWmG6FL32ef1Ry37vqcPq4iTb37eG9ztqGXLZ/NQbcUeMjJza4+W8d2hu68WrTgvFd1d5r
        v0f2p3v3u/kOd6SNZVmWpeJC/XTYkrS4kuCmnnb9e/8bDR9mZvfs8Ai0ojLD4OkVAv1FM+qn
        5BUZhGRbsWumT7l23Wjl7gElLsSo1gRgakH1Fzh87tGBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd2aDo54g3f3NS1eTjjMaLFxxnpW
        i6kPn7BZXPn6ns2iefF6Nour318yW5x8c5XFonPiEnaLTY+vsVpc3jWHzeLQ1L2MFmuP3GW3
        ONQXbTH3y1RmBz6Py9cuMnu8v9HK7rFz1l12j9kdM1k9Nq3qZPM4MeESk8f+uWvYPe53H2fy
        2Lyk3qNvyypGjwO9k1k8Pm+SC+CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
        MlXSt7NJSc3JLEst0rdL0Mv48OM1a8Fs3oqOazENjD3cXYycHBICJhIf1n1n6mLk4hASWMoo
        0XF/KytEQlxi9/y3zBC2sMSfa11sEEVvGSVetb9nA0kICyRJPJr9nhHEFhEwlug/O4sdpIhZ
        YBeLxLp//9ghOn4ySnzYu5QFpIpNQFPi7+abYN28AnYSN5etAOtmEVCV6Dl2DaxGVCBOYvmW
        +ewQNYISJ2c+AYtzChhK7Dm6G+wkZgEziXmbH0LZ8hLb386BssUlmr6sZJ3AKDQLSfssJC2z
        kLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmD8bzv2c/MOxksbgw8xCnAwKvHw
        LkjkiBdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDU1Ne
        SbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGlstf7stfqy/l+L6V
        0Y7poe6yCp/ZuRefB+qfeX5V+dAmv6PL33X+iX/j4uJYdf+S11SR2z8vPdfYu8/ZLua3ncB3
        19c9G5dfyg1YubtKNHruhgnXD8rLrdF2//Npf1CdweO3W5fuMJRruWqXZlCwJODOuQeb34T8
        0dlW/mve8rASZhGeCRy77ymxFGckGmoxFxUnAgAvmfteFQMAAA==
X-CMS-MailID: 20200710152548eucas1p23ed7203d6f74470a95f0eb704ed7536c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702134434eucas1p233a3f66f5bdb4b97f4f49d2d43d45297
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702134434eucas1p233a3f66f5bdb4b97f4f49d2d43d45297
References: <CAHp75VegHLG5tgVFjwmpmDfSqELqNXcb9dFSM4jLRx+anW7Lsw@mail.gmail.com>
        <CGME20200702134434eucas1p233a3f66f5bdb4b97f4f49d2d43d45297@eucas1p2.samsung.com>
        <20200702134421.6412-1-a.hajda@samsung.com>
        <20200710133143.GA2085030@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.07.2020 15:31, Greg Kroah-Hartman wrote:
> On Thu, Jul 02, 2020 at 03:44:21PM +0200, Andrzej Hajda wrote:
>> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
>> This list does not contain reason why the driver deferred probe, the patch
>> improves it.
>> The natural place to set the reason is dev_err_probe function introduced
>> recently, ie. if dev_err_probe will be called with -EPROBE_DEFER instead of
>> printk the message will be attached to a deferred device and printed when user
>> reads devices_deferred property.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>> ---
>> v8:
>> - improved commit message
> I'm totally confused by this series.  Can you resend the whole thing,
> as a full series, not just random individual patches in the series
> incremented?  It's a pain to try to fish them all out as to which is the
> "latest" with all of the needed reviewed by lines :(


v7 is the latest except this one,which contains only commit message change.

Anyway I will send v8 to make things simple.


Regards

Andrzej


>
> thanks,
>
> greg k-h
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://protect2.fireeye.com/v1/url?k=563dadd0-0bf16175-563c269f-0cc47a30d446-7237066d193b28b5&q=1&e=54779b9e-347e-4d0c-9845-da31d4cce7e4&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
>
