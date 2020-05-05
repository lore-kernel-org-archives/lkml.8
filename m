Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D5E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CIg0h4qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgEEKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:44:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36852 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEEKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:44:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200505104449euoutp02fdc4c173021fb21eb8cd6b1fe1475c1b~MG-DXLUe90463504635euoutp02B
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200505104449euoutp02fdc4c173021fb21eb8cd6b1fe1475c1b~MG-DXLUe90463504635euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588675489;
        bh=4zaPs3Z9slWwLwaCtTCwkNSjU0e+c0O/4EL1XzMdquE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CIg0h4qspAOP9PZ82sJOaI/2DsGbHTgNqWFMrh5M+re3Qd7FExXbAYky4eH266SQD
         FJwbT/FBNMgQTD7Jk/LrW2zvV/HSE+BlOJqWdq62IPKRHIp8SCgdmfROg+kD/XUe0e
         IS4ZWloYuR4DCJPju0icBGuirNxWFROtFn/1fe5E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200505104449eucas1p2d3c3f4831806c8ab1593eaa897fcd6bf~MG-C_m4Lg2225722257eucas1p2I;
        Tue,  5 May 2020 10:44:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.33.60679.1A341BE5; Tue,  5
        May 2020 11:44:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200505104448eucas1p2c685623a3df9ea52315da9da96ab16c0~MG-Cm5Skk3246232462eucas1p2y;
        Tue,  5 May 2020 10:44:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200505104448eusmtrp1e4d85cba64f6a7780d3fb10e753c0c1b~MG-CjTOx_2386723867eusmtrp1d;
        Tue,  5 May 2020 10:44:48 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-83-5eb143a1f511
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.91.07950.0A341BE5; Tue,  5
        May 2020 11:44:48 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200505104447eusmtip2cdb5cf9630df80a6721b078e97316a11~MG-Bpa7J_2913229132eusmtip2p;
        Tue,  5 May 2020 10:44:47 +0000 (GMT)
Subject: Re: [PATCH v3 01/25] dma-mapping: add generic helpers for mapping
 sgtable objects
To:     Christoph Hellwig <hch@lst.de>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <908eedcb-00df-3467-40fc-b15d91c7e625@samsung.com>
Date:   Tue, 5 May 2020 12:44:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505102234.GA15038@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH+e3M7I5rGz9XZV8WBVtkSnlUxJAhRQfzV0YERaa16qDmVTtq
        KUHmkWlm1v5RbuaVZd5lth4ZpVCTaItk2KGl4qZoea5Gmh3ujpb/vePz3vd94dGEsotyokMj
        ozltpCZcLZWThpczxk0Fux/6e9QL9swVY4uEeXizimL+GK4RzNvpMSlTUvZCwuQ/82LSbj2Q
        MVNv+yRMdX8nxXQ05EiZpnETtdOWNTXlStjy3HLEPv2eT7K133sptueyIGEfFZ1nu373E6zu
        fTFin3xIkLKZNaWINVevPmB7VL4jiAsPjeW07t4n5CGtQid1qpA+a5roIhPQO2k6sqEBb4Xn
        7YOydCSnlfg+gm/GRkJMphBkfm1bSMwIuvqzyMWRuuQaSmwUI/iZp1ugxhAUdTwjLJQ9PgYp
        nQPIEjtgNXwZfo0sEIHHJTB0vc/akGJPSB9Jt16iwN7wM6HMWifxOrg9q5uXo2lH7Ac3Og+J
        iB20ZJusV9jgjaBLGreOEngN1I7kEGKsgo+mPIlFC/AFGq5OPZZa9gDeAyVCoOjAHoaFGpkY
        r4JWXQYp8kkI+owVMjHJQNCReBOJlBd0G2etiwjsAlUN7mJ5F0w+Tl7Yvxzej9iJNyyH64Yb
        hFhWwKWLSpFeD3qh8p9sU/sbIgup9Uuc6Ze40S9xo/+vm4/IUqTiYviIYI7fHMmdceM1EXxM
        ZLBbYFRENZp/udbfwlQdapgLaEaYRupliiPmKn8lpYnl4yKaEdCE2kFx78cDf6UiSBMXz2mj
        jmtjwjm+Ga2kSbVKsaVwyE+JgzXRXBjHneK0i10JbeOUgEB9qG2tT+D4PreA/YmuQoNhQFV/
        5+k+FOab2us4F20WiEoHOwYqYGWQrPB0RYps++Fg33OjycQKfyZ+2uEkPuj8CXqyXmUXVGyg
        +NOp8s0eLq4uidmNJFEwOBEy46ydju++a1jjszOg53OcfvK4ee/tlm2/qtJym0a9VChITfIh
        Gk9XQstr/gL8Y+P1bgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7oLnDfGGfQ9N7XoPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le26Jy9gd3iy5WHTBabHl9jtbi8aw6bxcEPT1gduD2eHJzH
        5LFm3hpGj73fFrB4bP/2gNXjfvdxJo/NS+o9bv97zOwx+cZyRo/dNxvYPPq2rGL0+LxJLoA7
        Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j9PFr
        rAWLOCqefLzN0sB4na2LkZNDQsBEYkfLFtYuRi4OIYGljBJbV81ggkjISJyc1sAKYQtL/LnW
        xQZR9JZRYu3ra8wgCWGBGInWa88YQWwRASWJp6/OMoIUMQt8YJJ4NnMlWEJI4DmjxJS9niA2
        m4ChRNfbLrDVvAJ2Er8bVoPVsAioSMz9NZmli5GDQ1QgVqLloiZEiaDEyZlPWEBsTgEdicnN
        H8BamQXMJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PT
        c4uN9IoTc4tL89L1kvNzNzECo3rbsZ9bdjB2vQs+xCjAwajEw7vh6/o4IdbEsuLK3EOMEhzM
        SiK8y35siBPiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGDCySuJNzQ1NLewNDQ3Njc2s1AS
        5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwOhb+2Dighh70z3Lt+7bPPepsGqK2oT3qmsbrzj+
        P1vK94zf7NdU+323DefPK70+xfO304qzNgayXGxXVhxYI8yZr26Yyd68WeT5olM8EiKdeR+n
        3nXV9nXo/taf6X8q6s7BmNmyzMKSJ87uLfZLC/D2ZldO2NIWJbLfa2X0tsxJAguFz7ilhCmx
        FGckGmoxFxUnAgA0vfUqAAMAAA==
X-CMS-MailID: 20200505104448eucas1p2c685623a3df9ea52315da9da96ab16c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200505084624eucas1p2a9a5c4d2aece2c1555a5480c19c2e050
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084624eucas1p2a9a5c4d2aece2c1555a5480c19c2e050
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
        <CGME20200505084624eucas1p2a9a5c4d2aece2c1555a5480c19c2e050@eucas1p2.samsung.com>
        <20200505084614.30424-1-m.szyprowski@samsung.com>
        <20200505102234.GA15038@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 05.05.2020 12:22, Christoph Hellwig wrote:
>> +static inline int dma_map_sgtable_attrs(struct device *dev,
>> +	struct sg_table *sgt, enum dma_data_direction dir, unsigned long attrs)
> Two tab indents for parameter continuation, please.
>
> Can we also skip the separate _attrs version?  The existing ones have the
> separate _attrs variant as there were pre-existing versions without the
> attrs argument and lots of users, but that doesn't really apply here as
> an extra 0 argument isn't really an issue.

Okay.

>> +static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
>> +			unsigned long iova, struct sg_table *sgt, int prot)
>> +{
>> +	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
>> +}
> Should this be a separate patch due to the different subsystems?
>
> FYI, I'll happily pick up the prep patches in an immutable branch of
> the dma-mapping tree one we have settled on the details.

Okay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

