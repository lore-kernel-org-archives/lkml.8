Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ED2206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="slIeKbSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGCHo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:44:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40315 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgGCHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:44:28 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703074426epoutp029905a2d747445d32c7499bcdd8eebd71~eLlZJPtgE0270102701epoutp02_
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:44:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703074426epoutp029905a2d747445d32c7499bcdd8eebd71~eLlZJPtgE0270102701epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593762266;
        bh=lPMeYwOy7PJvL4PiGPR3iEpjHHoNHu6J67zq0+kO+uE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=slIeKbSsWtaPI9u3CSE4sKNIz5tv1MnT2yEFnPLvqKUROHzmUCaASut6+RgQrIiI4
         5ZL61vIc0ceTnUgwlGot6VXRvS27gVKA3MWMtlJLvw20mn7a8U3hw3Fk3FQtOE/4W2
         ddx04ikzpk4C16fRsc3WFtwBp0BK30px5BKSOVHA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200703074426epcas2p2fd6f37284ed2d91e6eb8dde36fafd9df~eLlY7D_kH1385713857epcas2p2z;
        Fri,  3 Jul 2020 07:44:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49yn6H6csHzMqYkr; Fri,  3 Jul
        2020 07:44:23 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.F1.19322.5D1EEFE5; Fri,  3 Jul 2020 16:44:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703074421epcas2p177b67a55997c00b3b6ad8126a7ce8a6d~eLlU0mzK21152511525epcas2p1p;
        Fri,  3 Jul 2020 07:44:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703074421epsmtrp1660b8e4d153784c690d62529a1a0413b~eLlUz-14j0579405794epsmtrp1F;
        Fri,  3 Jul 2020 07:44:21 +0000 (GMT)
X-AuditID: b6c32a45-7adff70000004b7a-60-5efee1d5f596
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.AA.08303.5D1EEFE5; Fri,  3 Jul 2020 16:44:21 +0900 (KST)
Received: from KORDD001994 (unknown [12.36.185.71]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200703074421epsmtip1376f555c4bbf84a93d55be1b260127c5~eLlUo_p8K2985429854epsmtip1d;
        Fri,  3 Jul 2020 07:44:21 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sejDorHi?= <changki.kim@samsung.com>
To:     <mathieu.poirier@linaro.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suzuki.poulose@arm.com>,
        <alexander.shishkin@linux.intel.com>
Subject: Could you support the modules of the coresight drivers?
Date:   Fri, 3 Jul 2020 16:44:21 +0900
Message-ID: <000001d6510d$c3bfcd00$4b3f6700$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZRDahDmKGCDgDLQ6Oxikk2jlLrEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQvfaw39xBgenclh0bJrJarHp8TVW
        i8u75rBZbN1zgMli5u3bjA6sHmvmrWH0uHNtD5vHvJOBHpuX1Ht83iQXwBqVY5ORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFpJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYquUWpCSU2BoWKBXnJhbXJqXrpecn2tlaGBgZApUmZCTcXDyC7aCNpaK
        l0tEGxgXMHcxcnJICJhIXHnaA2YLCexglHixHcjmArI/MUr03t7NBuF8ZpSYe7iTHabjyccO
        RojELkaJjSsb2SDaXzBKrDzJCWKzCdhKtHc+AGrg4BARUJBoWWoOUs8s0MMoMePhRkaQGmEB
        B4llD7uYQGwWARWJ2ZeWsYDYvAKWEnvbprBB2IISJ2c+AYszCxhJLFk9nwnClpfY/nYO1AsK
        Ej+fLmMFsUUE9CR+3vvCCFEjIjG7sw3sHQmBt+wSvzc+gmpwkTjwcTsThC0s8er4FqjPpCRe
        9rdB2fUS3/oXsEA0A139t+s4G0TCWGLWs3ZGkM8kBJQljtyCOo5PouPwX3aIMK9ER5sQhKkq
        0T1ZH8KUlviwwwZihofEnOvvGScwKs5C8uQsJE/OQvLkLCTPLGBkWcUollpQnJueWmxUYIgc
        1ZsYwYlSy3UH4+S3H/QOMTJxMB5ilOBgVhLhTVD9FyfEm5JYWZValB9fVJqTWnyI0RQY7hOZ
        pUST84GpOq8k3tDUyMzMwNLUwtTMyEJJnDdX8UKckEB6YklqdmpqQWoRTB8TB6dUA1OhB99F
        5mYtg8tfjwq91J8cWjZPyXVr9GJ/m8xZk+ZUN34TWdp4c4L11q3vq7b/bqvg8L5gY71xboHJ
        w/YywY7vX2r/qTrn6kzUXfrTW6A2YeWb91sb/okWqDJeumAfeXLplSsXZufMWW3yf0FditxJ
        x9Xnjk97aOMSrZa1UULYvPC32Z2L1pmKjnU/Av9VFCVxyrySUs5NYMl/5cq1ak3PCiE91/D0
        jdbVb/2ZZnl43VM2LW3gOTWxa9q5X3Pmx0m6qEjPfWJ6zOFgUKP0nsCTXzPj/QViDvG+vmlz
        Y75By5zJp+0Npdu6fbKnf715pUbMouNomr59XuZcrZp2j8T/b7r7lbXvzkqQdYl4osRSnJFo
        qMVcVJwIAIOmrXsdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO7Vh//iDLp2KFl0bJrJarHp8TVW
        i8u75rBZbN1zgMli5u3bjA6sHmvmrWH0uHNtD5vHvJOBHpuX1Ht83iQXwBrFZZOSmpNZllqk
        b5fAlXFw8gu2gjaWipdLRBsYFzB3MXJySAiYSDz52MHYxcjFISSwg1Hi3MqXjBAJaYnjr2az
        Q9jCEvdbjrCC2EICzxglNj1VBbHZBGwl2jsfANVwcIgIKEi0LDUHmcMsMIFRovn+ZrA5wgIO
        EssedjGB2CwCKhKzLy1jAbF5BSwl9rZNYYOwBSVOznwCFmcGOqjxcDeULS+x/e0cqEMVJH4+
        XQZ2g4iAnsTPe18YIWpEJGZ3tjFPYBSchWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5
        qeV6xYm5xaV56XrJ+bmbGMExoKW1g3HPqg96hxiZOBgPMUpwMCuJ8Cao/osT4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzvt11sI4IYH0xJLU7NTUgtQimCwTB6dUA1Ny144X9gcjah+KM909v8f+
        1UnXZUmfH96IjMicWOxgGcvLOGXjsrjSMtlHc+dd5lYIWuUz48vCI2VyQr+WLTuQEi63OJEp
        UK7P+t7Tjus/NFLXfgi0PhfduHmKO8OOtDU3VdOWbfGfmOK2xdvRteDDujUH2kU01i99f/Lh
        lQtztoduNW/bpvp8yR2pDkWdjns1bA8fK8UfnWisd0WJqzxgZ4ZcZ8mCxZcnLzCud506de2f
        nyzpnxYdP8/n83WTUdsbF+2cEoEw58TlBnIW9jtWaR/4tmrSyQ0/Oetbb6xddP7Z1mVRmTE7
        bz7wzmo1PuheUWFyK19itnfTklnzeN0y+Ew133+SZ/317MCtYq4LSizFGYmGWsxFxYkAKmfc
        N/ACAAA=
X-CMS-MailID: 20200703074421epcas2p177b67a55997c00b3b6ad8126a7ce8a6d
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703074421epcas2p177b67a55997c00b3b6ad8126a7ce8a6d
References: <CGME20200703074421epcas2p177b67a55997c00b3b6ad8126a7ce8a6d@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am software engineer in charge of BSP (Samsung SOC vendor).

Recently, Google introduced GKI from Android 11(R) version.
So we can't modified kernel code except module drivers.

Coresight drivers doesn't support module.
I need the module support because our SoC should set value to vendor
specific register to run ETMv4.
And in GKI, ETM has disabled in recommend defconfig.
So if we use ETM in Android 12(S), it should support module.

Could you support the modules of the coresight drivers?

