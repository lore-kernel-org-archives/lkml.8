Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E05C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AE520725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nCFlOJzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgBQK5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:57:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41383 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBQK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:57:38 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200217105736epoutp01185bad2d883e4844526e5c57d3067236~0K18NN0-22561625616epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:57:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200217105736epoutp01185bad2d883e4844526e5c57d3067236~0K18NN0-22561625616epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581937056;
        bh=flRtUgtOzt68ZWflEOBlwHLR4yZjl2aD182nmWPyiNA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nCFlOJzzo0Uo8IbnzLKEnypte/MjNxDwiDaqU5pGJRqw4uV5JkdDeQOJYSDczm02V
         h8gcjNOopu5wRjrgspBPGBkGsfURarkDUq05PF7hBn7NFlKSdihjx/Zn/0sNAfsEzB
         uqiTHkRZiUFr7kZova2QnQrBHL9G9etU2M2//3Jw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200217105736epcas1p308c95d5c7ec8f4afabeb7b902171302a~0K175UpZl1995819958epcas1p3T;
        Mon, 17 Feb 2020 10:57:36 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48LgtP5Jf4zMqYlp; Mon, 17 Feb
        2020 10:57:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.46.51241.D917A4E5; Mon, 17 Feb 2020 19:57:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200217105732epcas1p2b8704ad2ac31f5b8b5a4f43269cf375e~0K141yoaY0732807328epcas1p2b;
        Mon, 17 Feb 2020 10:57:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200217105732epsmtrp258f683d8089c70f8239c75e68c75caa9~0K141MgsD1221912219epsmtrp2n;
        Mon, 17 Feb 2020 10:57:32 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-e1-5e4a719d0543
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.57.06569.C917A4E5; Mon, 17 Feb 2020 19:57:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200217105732epsmtip23bebebc408c21e415324393fd0d96343~0K14p3m8I1552715527epsmtip2I;
        Mon, 17 Feb 2020 10:57:32 +0000 (GMT)
Subject: Re: [PATCH] extcon: Remove unneeded extern keyword from
 extcon-provider.h
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <28e13524-7879-e40a-1585-cba1dca4cda7@samsung.com>
Date:   Mon, 17 Feb 2020 20:05:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200217104516.GA94720@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURiGOzvjOFqTp83ya4naJiQ11J10bQ2t6MZm/lgrooy0aT2puLd2
        diMNul9USiyLSJLCjFIUScStSJbsxkKlppYYhaagRVYkllBEOztK/nu+97ud95zDUupyRsPm
        21zEaRMtPBNKtzyO1sVWHUjL0nlqlhku9HbThpM3GxlD14NrjOHd8TvMWtrYVFfCGL1V9cHG
        suY6ZBxrWmSiMwtS8oiYQ5xaYjPbc/Jtuan8lm3Z67P1STohVkg2rOS1NtFKUvkN6abYTfkW
        /0pee1C0uP2SSZQkPn51itPudhFtnl1ypfLEkWNxJDviJNEquW25cWa7dZWg063Q+wv3FuT1
        nfeoHLWhhz5O1KFjqJ4tRSEs4EQYHv0SXIpCWTW+h6DkRTulBD8QPB94olKCnwgqejvoqZaa
        sSuMkmhFMFD/gZITavwNwcvOGJnn4u1QPVwWLHM4joJPT/sCzRQ2wcjwGZXMDI4B70gvI3MY
        XgI9E4OoFLEsh1fDn7JVskzjSLjbUB0YPw/vAF/LKSQzh+eA7+pQYGQIjodP/S9VyvgI6Bu6
        PsmLwTN6LeAG8FsGfK9vM4qBDdB56/Mkz4XPz5uDFdbA2NfWSf0w1PqeMEpzMYJmb0eQkkgA
        760KlXxQCkdD44N4RV4C939XIWXxbPg6fi5ILgHMQfEZtVKyFLr636sUXgA3z5Yw5YivnGan
        cpqFymkWKv8vu4HoOjSfOCRrLpEEh376YzehwG+MSb6Hnr1Kb0OYRfwsbiRjc5Y6SDwoFVrb
        ELAUH85tiUjLUnM5YmERcdqznW4LkdqQ3n/bFyjNPLPd/7dtrmxBvyIhIcGQKCTpBYGP4AZ2
        RWepca7oIgWEOIhzqk/FhmiOoRbL/Ddgtq9bc2Lr2rQaV/XtwgztzIsVdO36jH02Ka5k0NGf
        VPwrLpx4yg9rzo3X96TufpiyPzHzeocnrOtIYfvp9KNFE+4U6tK45nLYLNfyR0B8R3ZGmkcH
        vXbTUMNjd/fS5a3dp/ZEdS/c/9dS3aNyZvbkz/jObGziZqcf54w8LeWJQgzllMR/jB8BgqMD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO6cQq84g+dP1Cwm3rjCYtG8eD2b
        xeVdc9gsbjeuYHNg8di0qpPNY//cNewefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXGrdztT
        wUquikc/VjE2MK7h6GLk5JAQMJFY8nk6WxcjF4eQwG5GiSV/njJCJCQlpl08ytzFyAFkC0sc
        PlwMUfOWUWL2gVdgNcICIRKLnvexg9giAhoSL4/eYgGxmQX8JN682QY1dDOjxOKV58GK2AS0
        JPa/uMEGYvMLKEpc/fGYEWQBr4CdxJ8+K5Awi4CqxMa1i5hBbFGBMImdSx4zgdi8AoISJ2c+
        AZvPKaAv8fLBWSaIXeoSf+ZdYoawxSVuPZkPFZeX2P52DvMERuFZSNpnIWmZhaRlFpKWBYws
        qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNES2sH44kT8YcYBTgYlXh4HUI844RY
        E8uKK3MPMUpwMCuJ8HqLe8UJ8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpa
        kFoEk2Xi4JRqYGxv3n+ltuyM77yYBZVscndtGxYt28ud8GL/XZUp5077iB6VWx4tu8hq2/ag
        43NLRezCOt9+KbV1DzquPO2ln1P+s81GPy5fbpom1LjW6UndmV/KlpxzahkMSt5aeJ8oyfUp
        WOYasvrcgmX8fcvCapbNydPlOVPw5NS1vwxs+7Ikff9dvvLkZ4QSS3FGoqEWc1FxIgB2z8c0
        jgIAAA==
X-CMS-MailID: 20200217105732epcas1p2b8704ad2ac31f5b8b5a4f43269cf375e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd
References: <CGME20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd@epcas1p2.samsung.com>
        <20200217104728.29330-1-cw00.choi@samsung.com>
        <20200217104516.GA94720@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 7:45 PM, Greg KH wrote:
> On Mon, Feb 17, 2020 at 07:47:28PM +0900, Chanwoo Choi wrote:
>> The commit tb7365587f513 ("extcon: Remove unneeded extern keyword
>> from extcon.h") removes the unneeded extern keyword from extcon header
>> file. But, The commit tb7365587f513 has missed that deletes 'extern'
>> keyword from extcon-provider.h. So that it deletes extern keyword
>> from extcon-provider.h.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> Dear Greg,
>>
>> When I removed the unneeded extern keyword from extcon hearder file for
>> v5.6-rc1, although I should remove 'extern' keyword on both extcon.h
>> and extcon-provider.h, I only removed them from extcon.h. It was my mistake.
>>
>> So that I send this patch for v5.6-rc3 release.
>> Could you review and apply it to char-misc git repository directly?
> 
> Sure, but it's not really a bugfix, I'll queue it up for 5.7-rc1, ok?

Right. It is not bugfix. Just This patch is related to patch[1]
which was merged to v5.6-rc1.
[1] commit tb7365587f513 ("extcon: Remove unneeded extern keyword
from extcon.h")

If you think that it is not needed to be merged for v5.6-rc3,
I think that it is better to apply it to extcon-next branch
for v5.7-rc1.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
