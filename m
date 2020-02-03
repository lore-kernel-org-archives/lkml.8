Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB9C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230822082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kOsyjS85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBCMS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:18:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44579 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgBCMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:18:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200203121854euoutp0131deff131aa3d87a3f350f98bfa280cf~v467hlalO1237212372euoutp01D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Feb 2020 12:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200203121854euoutp0131deff131aa3d87a3f350f98bfa280cf~v467hlalO1237212372euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580732334;
        bh=nVHc7TNUpkm72Mun7ZmXUnvu4a84X6jq4GG/T7+SKzk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kOsyjS85rLNrGx47rgfsWViavL7eQRfgZfOW3MDr44iIhex7fCnl+NgI4OYrJuEpd
         xcjnErqARhQZUuInNJR14pHio4n/Oi2QG6crlmtC8MI2FE2oJCJPg1cae/DmXP+E1K
         zqDl3BRJ+BMHKviJnhmJl8xY41Tz46DoK4/nlySk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200203121854eucas1p2a78af2c53f1afd13bfd3ba7ed83a7e07~v467WQ3WP0539105391eucas1p2p;
        Mon,  3 Feb 2020 12:18:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.F4.61286.EAF083E5; Mon,  3
        Feb 2020 12:18:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200203121853eucas1p12ff6f2623c024dffd68fca8c3e619d03~v466XF1-P0343703437eucas1p1W;
        Mon,  3 Feb 2020 12:18:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200203121853eusmtrp12eaa68abc80a5e7653730f3f73b2f603~v466WcCVx2323823238eusmtrp1C;
        Mon,  3 Feb 2020 12:18:53 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-62-5e380fae6763
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.3B.08375.DAF083E5; Mon,  3
        Feb 2020 12:18:53 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200203121852eusmtip1a34c24fcedeedadc0f7cea192d2648de~v4654QfDA3085730857eusmtip1T;
        Mon,  3 Feb 2020 12:18:52 +0000 (GMT)
Subject: Re: [PATCH v5] platform: cros_ec: Query EC protocol version if EC
 transitions between RO/RW
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <093ac3c3-204f-3f85-af0f-ac5b17512708@samsung.com>
Date:   Mon, 3 Feb 2020 13:18:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAFqH_5307FZ2njAhAUJ011usvfiuBZ9cd10yNRLVPuMZNHWD4w@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7rr+C3iDF5f5bOY/uQyi8WF3yvZ
        LGYvPspicXnXHDaLGef3MVl8bv3HZjH3+B12B3aP2Q0XWTx2zrrL7vF5k1wAcxSXTUpqTmZZ
        apG+XQJXxumNOxkLXvBULNl8ka2BcT9XFyMnh4SAicTbD0vZuxi5OIQEVjBK3Jt0gRnC+cIo
        0d2+AMr5zCjxte0PK0zLl7aNjBCJ5YwSx77fZoJw3jJKNDU9YgGpEhZIk/i37DdQOweHiICe
        xOd7QiA1zALfGSXaGyYygtSwCRhKdL3tYgOxeQXsJM68gtjAIqAicfXUQrA5ogKxEmeOfWeF
        qBGUODnzCVicUyBQ4t7iBnYQm1lAXmL72znMELa4xK0n88EOkhBYxi6x7vEXqLNdJJ5sO8QG
        YQtLvDq+hR3ClpE4PbmHBaKhmVHi4bm17BBOD6PE5aYZjBBV1hJ3zv1iA3mHWUBTYv0ufYiw
        o8SWO+9ZQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPSLCSvzULy
        ziwk78xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMo5/e/4px2MXy8lHWIU
        4GBU4uGd8dAsTog1say4MvcQowQHs5IIb52VaZwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNF
        L2OFBNITS1KzU1MLUotgskwcnFINjPor0+K2f79+3yB+2uoJt3ocXL45JJT6L1q767vBxDfS
        3DF/qzffvHJs6xShYtmS+UciH1+7N0ElPFjwSJbT55McsTMsp7PmRGzW2lXMoSv3q/Khx9E5
        a9w29U/zV9TbZrlpTmX9nyXp0zWe8K3sfPQ68MX76YVi7bomXSzpF9pdzjo95zy4L1GJpTgj
        0VCLuag4EQDCRRxRNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pr+S3iDC6+57CY/uQyi8WF3yvZ
        LGYvPspicXnXHDaLGef3MVl8bv3HZjH3+B12B3aP2Q0XWTx2zrrL7vF5k1wAc5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexumNOxkLXvBULNl8
        ka2BcT9XFyMnh4SAicSXto2MXYxcHEICSxklHv8+zwyRkJE4Oa2BFcIWlvhzrYsNoug1o8Su
        RyAdnBzCAmkS/5b9Bmrg4BAR0JP4fE8IpIZZ4DujxOLvH5khGjqZJPZ2HQebxCZgKNH1FmQS
        JwevgJ3EmVd/wOIsAioSV08tZAGxRQViJY5tb2OHqBGUODnzCVicUyBQ4t7iBrA4s4CZxLzN
        D5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgjG079nPzDsZLG4MPMQpwMCrx8M54aBYnxJpYVlyZe4hRgoNZSYS3zso0Tog3
        JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgfGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBsbGtOLrX4EB15fG4uaU/n2nYrHn+9N3Z21J3vDzWNj2QVLGPKupZ
        dODyjBeeLD8aFdnztZ6vyV6S5bPPdlWO3D/ri+kJxyvLY0SuaZbM4vA2ZbNktggJCHf0798w
        682Jucxt26p/p8Yx7NA2mXDj4Q/pH+9+2jvyzT0joGlyK4936oT+grO2SizFGYmGWsxFxYkA
        6uSMW8cCAAA=
X-CMS-MailID: 20200203121853eucas1p12ff6f2623c024dffd68fca8c3e619d03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200131073925eucas1p25bde5452aaa821435367dbfa9904a476
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200131073925eucas1p25bde5452aaa821435367dbfa9904a476
References: <CGME20200131073925eucas1p25bde5452aaa821435367dbfa9904a476@eucas1p2.samsung.com>
        <20200107220640.834-1-yichengli@chromium.org>
        <5bbca1db-d99b-9adc-b623-8f5ae1b1bb86@samsung.com>
        <CAFqH_5307FZ2njAhAUJ011usvfiuBZ9cd10yNRLVPuMZNHWD4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

On 03.02.2020 10:33, Enric Balletbo Serra wrote:
> Missatge de Marek Szyprowski <m.szyprowski@samsung.com> del dia dv.,
> 31 de gen. 2020 a les 8:41:
>> On 07.01.2020 23:06, Yicheng Li wrote:
>>> RO and RW of EC may have different EC protocol version. If EC transitions
>>> between RO and RW, but AP does not reboot (this is true for fingerprint
>>> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
>>> still uses the protocol version queried before transition, which can
>>> cause problems. In the case of fingerprint microcontroller, this causes
>>> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
>>> interrupt handler, which in turn prevents RO to clear the interrupt
>>> line to AP, in an infinite loop.
>>>
>>> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
>>> might have been a transition between RO and RW, so re-query the protocol.
>>>
>>> Change-Id: I49a51cc10d22a4ab9e75204a4c0c8819d5b3d282
>>> Signed-off-by: Yicheng Li <yichengli@chromium.org>
>> This patch landed recently in linux-next as commit
>> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
>> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
>> Peach-Pit and Peach-Pi):
> Many thanks for report the issue, we will take a look ASAP and revert
> this commit meanwhile.

Simply removing the BUG_ON() from cros_ec_get_host_event() function 
fixes the issue, but I don't know the protocol details to judge if this 
is the correct way of fixing it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

