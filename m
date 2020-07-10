Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D7FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450C920842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aclDKV5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGJOXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:23:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55012 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGJOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:23:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710142328euoutp015771872ef4147871c4c15b7339bdfae8~gaizWHk-s3218432184euoutp01L
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:23:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710142328euoutp015771872ef4147871c4c15b7339bdfae8~gaizWHk-s3218432184euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594391008;
        bh=WkcusuUfSpmRdHA4+MoHJqGH0lyu+gdsD+U9n4i9t0k=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=aclDKV5UtbzYf4g73VawWqOhsmBfCBEq2uB/eJ9Fvya/+CrE8HuAL1gSnsxgwOMtP
         oMCFRpEFyHoe3IlVOJMyYOdb7L0/dgSe3ZXc1yG0uZUx7GC1jc9nqkZQAIwFRldq+p
         Tyy/0lietsV3QdAddmd177cubfx9BxrmZBBiHpqo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710142328eucas1p2ec1735488894f3bec3d803aca8088541~gaizN3XxA2910929109eucas1p24;
        Fri, 10 Jul 2020 14:23:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.56.05997.0E9780F5; Fri, 10
        Jul 2020 15:23:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142328eucas1p2ae08e5c0fe341044248056d36a7eb239~gaiy3zM8r2122921229eucas1p23;
        Fri, 10 Jul 2020 14:23:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200710142328eusmtrp2d7784ffc41329d1a909640d305963680~gaiy3PrpD1267512675eusmtrp2M;
        Fri, 10 Jul 2020 14:23:28 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-2f-5f0879e0a0b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.61.06017.0E9780F5; Fri, 10
        Jul 2020 15:23:28 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710142327eusmtip2cc26778ca3a24b139fab77c1dd729a81~gaiygwVSF1365513655eusmtip2o;
        Fri, 10 Jul 2020 14:23:27 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS
 support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <ccb3ca73-8f22-990a-b8bd-1f9c8d642f10@samsung.com>
Date:   Fri, 10 Jul 2020 16:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRz3e948rs4eR/Mdqu02LQql/jgVU9O6P7NVU0s88QzlrXtQzJrM
        y41l9KJ1bpGVc9Z5S4RuLZrzkpcia9SQG8mkvA4h7jnLf5/v5/v5fL/fz/alcYmGdKAjouM4
        RTQbKaVERG3LUrfbcCIddOjT3f2yvvlpSjY2oMdkrTm/SVlvg5qSaYw6XNa9aiB9KXlTsxLJ
        h7INmLwtfYGQz1bvkVcbp7Cz5CXRiVAuMiKBU3j4BIvCx15UkrHZlrey27VYCpols5AVDcxR
        mCx9QGQhES1hShEMtjTiQjGHYH1ajwnFLIIZ/Wd8y9I5OWxuaBB0lyxQQjGF4GFqsWkwxRyD
        vMwytIltmXOgbi3YENG0HeMG6iWTGWdSMdDVVJmmihkfyOtZM2GCcYbpj+nUJt7FBMDMcDMp
        aGyg7bGR2MRWjD/0rTwx8ThjDwPGQkzAe6FuSm3KAEy5JXzLn7MUzvYD3eRTQsC28NNQY+ad
        YL2+EDMbEKwqf5jddQg099coQXUcvnYtmyLgjAtUNHgI9En40DOBbdLAWMOXKRvhCGu4V/sI
        F2gxKDMkgnofVJZUUltrs+q1eC6SqrZFU22Lo9oWR/V/bxEiypA9F89HhXG8ZzR3051no/j4
        6DD3kJioarTxPh1rhrnXqOHv1SbE0Ei6U1zE0kESkk3gE6OaENC41E58qrPjikQcyiYmcYqY
        IEV8JMc3IUeakNqLjxRPBEqYMDaOu85xsZxiq4vRVg4p6Ixdcmw9/x27cIDkndrfuTZeS5qe
        H022z0k6HXBDdblT9nyEvbM4Epz27NV7XzZ3QmRUHlQWWizmawN//Vl2NGQWe/WH611CzpO+
        iv7gqoEeC++VgreDnrv7+GTnuowdXRcXvfv0aTmlGr/RKq/5ipfeb8Zvpw2N9+aXT2j9dTVS
        gg9nD7viCp79B8pExAA6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7oPKjniDZY+FrG48vU9m8WzW3uZ
        LE70fWC1uLxrDpvF8idrmS3O/z3O6sDmcehwB6PH/e7jTB4nW7+xeHzeJOex6clbpgDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MZ2s2sBZ0
        s1d0n1rJ1MD4mbWLkZNDQsBE4uzrB0xdjFwcQgJLGSU2rfzD0sXIAZSQkTi+vgyiRljiz7Uu
        Noia14wS7XN/sYMk2ASsJCa2r2IEsYUFQiTmnJjNBtIrIqArMecnE0iYWaCFSWLxFx0QW0hg
        BpPEms3qIDavgJ3ExAv/mEFsFgFVifcXW9lAbFGBCInDO2YxQtQISpyc+YQFxOYUCJS48nse
        K8RMdYk/8y4xQ9jiEreezIfaJS+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBMbZtmM/t+xg7HoXfIhRgINRiYd3QSJHvBBrYllxZe4hRgkOZiUR
        Xqezp+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YAvJK4g1NDc0tLA3Njc2NzSyUxHk7
        BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDWLc7zmdnN/Vzx8JvLpjZxEa5uh50Xm995eOCuUp+5
        7SuudrUnCow3d/zxLNyhXFSU28tz2J9h23d5VuYfrscKWMNPWjSXR/W7LYo8fFQ7WUVaUXLD
        G40Fn82+f5KTYYn2XV4XWaYiIh4r+TGg1GjfJV6rUEddvh9mps0HL2T2b79bsCfjjBJLcUai
        oRZzUXEiANaxOpHJAgAA
X-CMS-MailID: 20200710142328eucas1p2ae08e5c0fe341044248056d36a7eb239
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
        <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
        <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
        <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/20 2:03 PM, Geert Uytterhoeven wrote:
> On Tue, Jun 2, 2020 at 1:50 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
>>> These #ifdefs are relics from APUS (Amiga Power-Up System), which
>>> added a PPC board.  APUS support was killed off a long time ago,
>>> when arch/ppc/ was still king, but these #ifdefs were missed, because
>>> they didn't test for CONFIG_APUS.
>>
>> Add FIXME about using the C code variants (APUS ones) in the future.
>>
>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to drm-misc-next tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
