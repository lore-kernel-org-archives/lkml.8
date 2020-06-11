Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69532072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cCqXHmSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFKBnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:43:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36165 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:43:39 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200611014336epoutp040aa0d6d94b5334a06ca455655817f60e~XWeETKmx70592005920epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:43:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200611014336epoutp040aa0d6d94b5334a06ca455655817f60e~XWeETKmx70592005920epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591839816;
        bh=IXq3Fhg8fJgbzV9gLay0eeT5K9GzGHQPNtgl6WtI5fQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cCqXHmSorpDioaOoqMsOZBPSZLCr+yIZeVFy1XuTCcS7OMwFzIEyZIppq/nenL7mI
         R2iVJcAhtxaEyi8qvq6GyUeyF3rvPGFt0X/1j1xi+xbaNDfk+E2w4PVYeYi5EKLCa0
         eQgCqqhB/LomU5i2GDx2wz0w4yHb8anI/DC77y54=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200611014335epcas1p11bd9541fd35eee3f5f095eba35b842fb~XWeDfClw30870908709epcas1p1o;
        Thu, 11 Jun 2020 01:43:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49j6865RgMzMqYlt; Thu, 11 Jun
        2020 01:43:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.F6.18978.64C81EE5; Thu, 11 Jun 2020 10:43:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200611014334epcas1p389f55a80344b4066e4685038bfc5054a~XWeCJyWY42553325533epcas1p3D;
        Thu, 11 Jun 2020 01:43:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200611014334epsmtrp25b378b9fbd7e4481c1ecf93711573b5e~XWeCI-el91129911299epsmtrp2_;
        Thu, 11 Jun 2020 01:43:34 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-e2-5ee18c463439
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.05.08382.64C81EE5; Thu, 11 Jun 2020 10:43:34 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200611014332epsmtip2bac26047a77080ecb4f71e6b06f46fbf~XWeAuU-Dk0859408594epsmtip2P;
        Thu, 11 Jun 2020 01:43:32 +0000 (GMT)
Subject: Re: [PATCH] page_alloc: consider highatomic reserve in wmartermark
 fast
To:     Mel Gorman <mgorman@techsingularity.net>,
        Baoquan He <bhe@redhat.com>
Cc:     minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5EE18C38.3090601@samsung.com>
Date:   Thu, 11 Jun 2020 10:43:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200609151330.GL3127@techsingularity.net>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmnq5bz8M4g8XbtC3mrF/DZnH+wS82
        i5XzzrFZrN7ka9G9eSajxeVdc9gs7q35z2ox+d0zRosdS/cxWSz7+p7d4vF6bgduj8Nv3jN7
        7Jx1l91j06pONo9Nnyaxe5yY8ZvF4/2+q2wefVtWMXpsPl3tsfWXncfnTXIBXFE5NhmpiSmp
        RQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA9yoplCXmlAKFAhKL
        i5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iyvk2dy1Zw
        WqDi9JFjzA2MO3i7GDk5JARMJJr2b2PuYuTiEBLYwSjRt301G4TziVHi36kdUM43RolzPd9Y
        YVq+rv4FldjLKPH20h4WCOcto8Tqs0eYQaqEBYIk1tycDmaLCHhKnLr3gBWkiFngEqPElOsg
        czk52AS0Jd4vmAQ2lldAS+LrhDlgNouAqsTrOefZQWxRgQiJHXM/MkLUCEqcnPmEBcTmFLCQ
        +NO5AGwBs4C8RPPW2WBfSAgc4ZB4un0dM8StLhLPmiZB3S0s8er4FnYIW0ri87u9bBB2vcSe
        /X+h6hsYJf5/FICwjSXmtywEinMALdCUWL9LHyKsKLHz91xGiL18Eu++9rCClEgI8Ep0tAlB
        lKhJtDz7CrVVRuLvv2dQtofEtubfYJuEBJ4zSjw6JzOBUWEWks9mIflmFsLiBYzMqxjFUguK
        c9NTiw0LDJGjeBMjOAVrme5gnPj2g94hRiYOxkOMEhzMSiK8guIP44R4UxIrq1KL8uOLSnNS
        iw8xmgLDdyKzlGhyPjAL5JXEG5oaGRsbW5iYmZuZGiuJ84rLXIgTEkhPLEnNTk0tSC2C6WPi
        4JRqYHJfc+GN57dDRjuLrvgzre4qXhEodXS/tKXgvzm5r0q5M44s+JSl5Wce/1jr5GJBtcf3
        hNWbo+W+hCS7PHd51NfwYMq+Y5ui17pwiBR51jm9tnUI3rdSdK+XxvZPuUydKX4BSxWqPbXj
        y+amvhB4xczsNH23Kc+x/Rqr/MIWq6Ws5+8S2jL369W7Wv+tPy0r3XlR7rbK3tfv0zebd56T
        cug4Gi4Rz7T2lcmuSbsZdv/tWFp35KugT3hQGL+d0Fs1rpvzXx5OsBewNf/Y8jT66aOfPNo/
        j6TebvHa7FGarCJydJt5HCPDpxw/7vCyK7O2NatF3TR1WjLjdersR+X8268dcH/9o2GN+rU9
        6xkuySixFGckGmoxFxUnAgAkpa+XSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtet52Gcwd+TrBZz1q9hszj/4Beb
        xcp559gsVm/ytejePJPR4vKuOWwW99b8Z7WY/O4Zo8WOpfuYLJZ9fc9u8Xg9twO3x+E375k9
        ds66y+6xaVUnm8emT5PYPU7M+M3i8X7fVTaPvi2rGD02n6722PrLzuPzJrkArigum5TUnMyy
        1CJ9uwSujG9T57IVnBaoOH3kGHMD4w7eLkZODgkBE4mvq3+xdTFycQgJ7GaUuPt3EStEQkbi
        zfmnLF2MHEC2sMThw8UQNa8ZJT4+284CUiMsECSx5uZ0ZhBbRMBT4tS9B6wQRc8ZJe70n2QG
        cZgFLjFKtO4/wAZSxSagLfF+wSSwDbwCWhJfJ8wBs1kEVCVezznPDmKLCkRIrF53jRmiRlDi
        5MwnYNs4BSwk/nQuYAa5iFlAXWL9PCGQMLOAvETz1tnMExgFZyHpmIVQNQtJ1QJG5lWMkqkF
        xbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFxpaW5g3H7qg96hxiZOBgPMUpwMCuJ8AqKP4wT
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkznujcGGckEB6YklqdmpqQWoRTJaJg1OqgWl9/eXHzfeP
        Tb7Prbxsf0ZksUHN7DLR/Y3XJ/7cs4pHYmu48M7/edL6eyaI+ZUbrovf032SV2fNkh/uEgqz
        G+Lk6o3+aV5ZPH0j053Wf+wvDh1P102Nn3ho7tXHr1gYIi7/XNsTs9aC1VvTJLsnflpjcrrP
        gVXvcyuT0sKTJ5utjT4adO/+0blqEsvCHsTdVvjEHnxjpre3Gc/V36U288W8uu88iFjSezx+
        Z9oNh+nMz2JO2Rze1ZvRtu3d/jPijecYTptn/SkXPfRG2z3q0H2Op0tSPKLFo794zzLYvpUp
        ahXfUl7hM5tv7vp8UTH9iWVEtnz5buXVXfY3C/LfG0zl+8NyeKEtr3VJF9us1cpKLMUZiYZa
        zEXFiQDDFUGDGgMAAA==
X-CMS-MailID: 20200611014334epcas1p389f55a80344b4066e4685038bfc5054a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0
References: <CGME20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0@epcas1p1.samsung.com>
        <20200609095128.8112-1-jaewon31.kim@samsung.com>
        <20200609142747.GA3346@MiWiFi-R3L-srv>
        <20200609151330.GL3127@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 06월 10일 00:13, Mel Gorman wrote:
> On Tue, Jun 09, 2020 at 10:27:47PM +0800, Baoquan He wrote:
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 13cc653122b7..00869378d387 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -3553,6 +3553,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>>  {
>>>  	long free_pages = zone_page_state(z, NR_FREE_PAGES);
>>>  	long cma_pages = 0;
>>> +	long highatomic = 0;
>>> +	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>>> +
>>> +	if (likely(!alloc_harder))
>>> +		highatomic = z->nr_reserved_highatomic;
>>>  
>>>  #ifdef CONFIG_CMA
>>>  	/* If allocation can't use CMA areas don't use free CMA pages */
>>> @@ -3567,8 +3572,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>>  	 * the caller is !atomic then it'll uselessly search the free
>>>  	 * list. That corner case is then slower but it is harmless.
>>>  	 */
>>> -	if (!order && (free_pages - cma_pages) > mark + z->lowmem_reserve[classzone_idx])
>>> -		return true;
>>> +	if (!order) {
>>> +		long fast_free = free_pages - cma_pages - highatomic;
>>> +
>>> +		if (fast_free > mark + z->lowmem_reserve[classzone_idx])
>> This looks reasonable to me. However, this change may not be rebased on
>> top of the latest mainline tree or mm tree. E.g in this commit 97a225e69a1f8
>> ("mm/page_alloc: integrate classzone_idx and high_zoneidx"), classzone_idx
>> has been changed to highest_zoneidx.

Hello Baoquan

Thank you for the review.
I may change code to high_zoneidx in next version.
By the way let me consider Minchan's comment regarding sharing code.
>>
> That's fine, I simply wanted to illustrate where I thought the check
> should go to minimise the impact to the majority of allocations.
Hello Mel.
Can I understand that you also agrees on checking highatomic reserved?

Additionally I've wondered why the number of  highatomic free pages is not
accurately counted like cma free. Is there any concern on counting it?
>

Thank you
Jaewon Kim
