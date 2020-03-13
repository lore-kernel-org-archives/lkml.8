Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF8920724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H/AkDgIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCMD2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:28:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14260 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCMD2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:28:11 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200313032809epoutp01057f1679a6e83f283d0b6ef564502d67~7v1qLut0l1569015690epoutp01F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:28:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200313032809epoutp01057f1679a6e83f283d0b6ef564502d67~7v1qLut0l1569015690epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584070089;
        bh=LumW01sok70NYv3csTOzeqtO4np/nnp3DVMEzFed64k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H/AkDgIrA923qgJs1Dx+ZgMq/B4tTE+2bGauIrE0r9TigPu9iX+y0fT7Z076rfAPS
         g0H/6Gq2jmGMiphWl2Zd+v9L4ffDVrymAwLoMquT1AC1jtbxjviDAoiLv3lqS4M9YK
         w+vcnxdPhyR34skSGbvciH0cypodfNNwIUJfOk58=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200313032809epcas1p2c78f8116541ff3e8773cd949099f5cca~7v1p0ci7L1233512335epcas1p2m;
        Fri, 13 Mar 2020 03:28:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48drkJ1JSBzMqYls; Fri, 13 Mar
        2020 03:28:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.64.57028.8CDFA6E5; Fri, 13 Mar 2020 12:28:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200313032807epcas1p266c68c32f767b2db2024f0a281cb2aa2~7v1oMnmZ_0717707177epcas1p2I;
        Fri, 13 Mar 2020 03:28:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200313032807epsmtrp23340cf1fc53fc4211aeffd67ca6aece5~7v1oL8a750478204782epsmtrp2O;
        Fri, 13 Mar 2020 03:28:07 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-0d-5e6afdc8285d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.A2.04215.7CDFA6E5; Fri, 13 Mar 2020 12:28:07 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313032806epsmtip20c1288afa4e7fd694c00e64296d5b8b8~7v1nTOeNc2399123991epsmtip2S;
        Fri, 13 Mar 2020 03:28:06 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] mmap: remove inline of vm_unmapped_area
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, walken@google.com, bp@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E6AFDBE.4090808@samsung.com>
Date:   Fri, 13 Mar 2020 12:27:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200312200259.7b79b38341bde97609fde99a@linux-foundation.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm9W53U5reptlhWa5LBS7UzTW7lkZQ1A2NhIKkwHmnt83aF7ub
        lGHND6Qv+7B+5LKQIpQypC1Tp0LOUCO0orIfVkIfSpFWihUNrd1dI/8955znnOc5532lmPw6
        rpAWW52sw8qYSTxKdL83SZ08MHswX322VUzVtzTj1IVzSdRpXx2invvrcept8x8xNVdbRgV/
        1eObJXSH542EbvC6aF+TivZO1UrogctBEe17fJSe9q7IlewzZ5pYpoh1KFlroa2o2GrMIrN3
        67fodelqTbImg1pPKq2Mhc0it+bkJm8rNoe8kMoSxuwKpXIZjiNTN2U6bC4nqzTZOGcWydqL
        zHaN2p7CMRbOZTWmFNosGzRqdZouxCwwm85O9orsv8WHP/fcRW70RXQKRUqBWAcPZ4OIx3Ki
        HcHgRziFokJ4CkHNZJ9YCH4guN/lj/jX4X7Cd/OFbgRzwS+YEEwgePluMDwrltgC068rxTyO
        I5Lh1rg/TMKICgTPhh9I+AJOrIWvDbVhkoxQQXP7U4zHImI1zDx9hfN4CZEH7Ve/I4GzGB7V
        fQgbjySy4f3QybAljEiEytYrYQEgRnAI+L/Ne90KP9quzW8aC5/770kErIDpyW5caKhEMFHn
        Q0JQheCNtwYJLC3UnOEtSUMSSdDiTxXSK6EjeBUJytEwOXNGzFOAkMGJarlAWQNVYzNiASfA
        7NzYPKbhxcn6+aNWR8CQt010Hik9C5bzLFjI81+5AWG3UDxr5yxGltPYNQsf2YvC/1Ola0eX
        hnICiJAicpFMHX8wXy5mSrgjlgACKUbGyfSJxny5rIg5Uso6bHqHy8xyAaQL3fsCplhSaAv9
        dqtTr9GlabVaal36+nSdllwqM0yF5hBGxskeYlk76/jXFyGNVLjRqtsZe6InhhqWj3283deZ
        cPliy2js/nJd+fZAGjXc0v2p8MOeRLl7deeuHeObCxTn0gwlo5eyZRk7h0fKHh8utdxQ5bnd
        rfSKA+PkjWO7D8TfvbNsY6Ohq6eyK0YeNZ7iuUmebzKYPKMV+qA/52deRO5IjGFHb8zP/uNr
        ogd8e4sbSRFnYjQqzMExfwEastRTtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO7xv1lxBtuuCFnMWb+GzWJiv6ZF
        9+aZjBaXd81hs7i35j+rxb9JtRa/f8xhc2D32DnrLrvHgk2lHptXaHls+jSJ3ePEjN8sHptP
        V3t83iQXwB7FZZOSmpNZllqkb5fAldH37jBLwS/WilcHNzI2ML5h6WLk5JAQMJFoOA9ic3EI
        CexmlFi6fzMzREJG4s35p0AJDiBbWOLw4WKQsJDAa0aJ9jmGILawgLPE5zvNrCC2iICuxKrn
        u5gh5rQxSXz7vIsdJMEs0MQo8WaxMojNJqAt8X7BJLAGXgEtiTU7LoDtYhFQlfh64TobiC0q
        ECGxet01ZogaQYmTM5+AHcop4C3x+FwnE8g9zALqEuvnCUGMl5do3jqbeQKj4CwkHbMQqmYh
        qVrAyLyKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4FrS0djCeOBF/iFGAg1GJh9dA
        LCtOiDWxrLgy9xCjBAezkghvvHx6nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQZGf7lrifwdXxcccz/36M1Bwc9O2p6n9wX92HuqeE30jj2aE/ze71hZ
        dv7QOx/1093MfzbPr45Yo20fX7bfzvsaz/rDe82Wu206f1LVtOXclmXcTGqGU1WEFi3qXeF0
        VK7/TlbvZv6akGxnDdttjEUJqzuZUgpjOzNZq268LVXeyVqw0XpZlXK3EktxRqKhFnNRcSIA
        tu0jKoECAAA=
X-CMS-MailID: 20200313032807epcas1p266c68c32f767b2db2024f0a281cb2aa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
        <CGME20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5@epcas1p1.samsung.com>
        <20200313011420.15995-2-jaewon31.kim@samsung.com>
        <20200312200259.7b79b38341bde97609fde99a@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 13일 12:02, Andrew Morton wrote:
> On Fri, 13 Mar 2020 10:14:19 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> In prepration for next patch remove inline of vm_unmapped_area and move
>> code to mmap.c. There is no logical change.
>>
>> Also remove unmapped_area[_topdown] out of mm.h, there is no code
>> calling to them.
>>
> Patches seem reasonable.
>
>> -extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
>> -extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
> I believe these can now be made static to mmap.c
Correct.
Let me wait for the 2/2 patch to be reviewed, and resubmit this 1/2 patch with having static if need.
Thank you for your comment.
>
>
>
>

