Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65764C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1E2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m2mgv3kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgBMHfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:35:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41893 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgBMHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:35:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200213073508euoutp02768fcc78e703300937c32ea9da22b989~y5gB8wQ4Y2826228262euoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:35:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200213073508euoutp02768fcc78e703300937c32ea9da22b989~y5gB8wQ4Y2826228262euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581579308;
        bh=yxhnnZFN4xpeYqDaqMbGXmr4Z8OKTV5vkdpP58BDZ5M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=m2mgv3kSEbxTscz3LG6e9/tq+1t3U6JNZz9LX7aCgI/4KEzqlMLwTJUo4H2fsWy9Q
         M7636dgSf2Fv9rqG15LeVYjvNIWpE6KEeGfkva4lLGSKfTjAqTJa8CY6GAXQr+0Jlx
         0YXzQm8VlxJdhusIMp0jZEW9h+TuI9nnSO/Cn4vo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200213073508eucas1p16e119f10904f7a049c539aed4f0f076c~y5gB4Nelh2164521645eucas1p1S;
        Thu, 13 Feb 2020 07:35:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 09.AE.61286.C2CF44E5; Thu, 13
        Feb 2020 07:35:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200213073508eucas1p22d36cf1b15ea9ecd7a22d245e145fe05~y5gBbADf61499814998eucas1p2A;
        Thu, 13 Feb 2020 07:35:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200213073508eusmtrp289c345422080c6de682e12c374c70169~y5gBaYfrZ0470804708eusmtrp20;
        Thu, 13 Feb 2020 07:35:08 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-85-5e44fc2c385c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.1A.08375.C2CF44E5; Thu, 13
        Feb 2020 07:35:08 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200213073507eusmtip1b413deaca0d82eef849bc98c225005d1~y5gBFDLWm1173711737eusmtip1g;
        Thu, 13 Feb 2020 07:35:07 +0000 (GMT)
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for
 Raspberry Pi4
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5adcb2de-3570-9c4d-5e5b-726b94fb2029@samsung.com>
Date:   Thu, 13 Feb 2020 08:35:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <a1d66025baa13b2276b12405544fc7107aac8d6c.camel@suse.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7o6f1ziDN7ON7DY9Pgaq8XlXXPY
        LCbe3sBusW3WcjaLTStusDmwemy9ZeqxeUm9x+bT1R6fN8kFsERx2aSk5mSWpRbp2yVwZSx9
        +oypoIuz4tOq+8wNjMvZuxg5OSQETCQuP//F2sXIxSEksIJRomP9D2YI5wujxLKORiaQKiGB
        z4wStz47wnR0TNrACBFfzihx4okpRMNbRolZU/6ygiSEBUIktnTOAZskIrCQUaL57kGgSRwc
        zAJaErOupILUsAkYSnS97WIDsXkF7CQmb78GtoxFQFXiw+4GMFtUIFbizLHvrBA1ghInZz5h
        AbE5BVwlDmz8AHYEs4C8xPa3ILtAbHGJW0/mM4HslRCYzi4x9csjFoirXSQad12DsoUlXh3f
        AvW/jMT/nTANzYwSD8+tZYdwehglLjfNYISospa4c+4XG8QHmhLrd+lDhB0lnm7bxA4SlhDg
        k7jxVhDiCD6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBMYlWYheW0WkndmIXlnFsLeBYws
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLTy+l/xz/tYPx6KekQowAHoxIPr8Rr5zgh
        1sSy4srcQ4wSHMxKIrzijUAh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YW
        pBbBZJk4OKUaGB0emwce4+98vOLeDkulHa+jJZdocK5S3JDluZJJaouF8fuaDfNU7gpac+/Q
        n37Ff7b/tIdTuCdsDt/66Ci3+i73ikcBlb1fFe/8X/2mrf+YevK8Ny/rCm44T9Fbkcte2Pd7
        0YZbirqLRe+dnhxl5iM0P+a5z9JZOVfklwbNFJrzWruyrl73KLcSS3FGoqEWc1FxIgAkZKGk
        KwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7o6f1ziDHYfFbTY9Pgaq8XlXXPY
        LCbe3sBusW3WcjaLTStusDmwemy9ZeqxeUm9x+bT1R6fN8kFsETp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSx9+oypoIuz4tOq+8wNjMvZuxg5
        OSQETCQ6Jm1g7GLk4hASWMooMe/rEyaIhIzEyWkNrBC2sMSfa11sEEWvGSW2HjzACJIQFgiR
        eNK7jB0kISKwkFFi9qe9QFUcHMwCWhKzrqRCNJxhlNg/7zDYOjYBQ4mutyCTODl4BewkJm+/
        BraNRUBV4sPuBjBbVCBW4tj2NnaIGkGJkzOfsIDYnAKuEgc2fgBbzCxgJjFv80NmCFteYvvb
        OVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GFPbjv3cvIPx0sbgQ4wCHIxKPLwSr53jhFgTy4orcw8xSnAwK4nwijcChXhTEiurUovy44tK
        c1KLDzGaAj03kVlKNDkfGO95JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6
        mDg4pRoYF63cvCfwQ3td9TW2JCnxQjfXzFtL9Ww/iu7/VVFx5rC5Z3FEelwnuy7TsU+Rr5Ze
        LN8b/l18f+GljD+Tn+y4f6fSuaruW0h/fBWrwp7Gdx2LfjTVLIhZlLz5seal6gV9bL+qbv/l
        99nI//51VYeE7/uZm8r47/9q7Z/l+M/vqlzi+p8+DD/MlViKMxINtZiLihMBqTtoY78CAAA=
X-CMS-MailID: 20200213073508eucas1p22d36cf1b15ea9ecd7a22d245e145fe05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
References: <CGME20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57@eucas1p1.samsung.com>
        <20200212102009.17428-1-m.szyprowski@samsung.com>
        <a1d66025baa13b2276b12405544fc7107aac8d6c.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

On 12.02.2020 19:31, Nicolas Saenz Julienne wrote:
> Hi Marek,
> On Wed, 2020-02-12 at 11:20 +0100, Marek Szyprowski wrote:
>> Add drivers for the minimal set of devices needed to boot Raspberry Pi4
>> board.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Just so you know, the amount of support on the RPi4 you might be able to get
> updating bcm2835_defconfig's config is very limited. Only 1GB of ram and no
> PCIe (so no USBs).

Yes, I know. A lots of core features is missing: SMP, HIGHMEM, LPAE, PCI 
and so on, but having a possibility to boot RPi4 with this defconfig 
increases the test coverage.

> FYI I've been working on getting a workable configuration for arm32, short of
> creating a new config altogether:
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg163770.html
>
> That said, if you insist on booting with bcm2835_defconfig, I have no problem
> with the patch.

Right, having a proper multi defconfig with LPAE is also needed on other 
boards. I would add VIRTUALIZATION and KVM to it too.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

