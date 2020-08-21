Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C14207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSJhnAMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHUVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:13:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:13:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LL7N75053126;
        Fri, 21 Aug 2020 21:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PLoVUsTh268ZC/c6/jEXoez++/4ChE5ZLv+tte7j1qY=;
 b=HSJhnAMOqTI6sUkwKLAmS/tpB8HRw030RwV/a/Txksuiz3W//Lw9SLmuRBNaWabrAMCV
 Zj3tKbJeIjM0z1z6kEGe9TcmVc5fWOVLLS8kk0xDQg2tF8x5uJXHoOv0kiQ/C5ihKn7K
 7nYqrHLnC5puEEH/h/kjB1m6zrod4w17oMz4Z3Gm1s6WgVzaVh6ItBSyxUrTpGTbFI7W
 Fdd5JmN56BthFBGijV8Vmc9t2W8xOPtLpHlvoGjiiiAMSQKo5S7To8ORjkAJpYdLuORp
 sShjjanMi/PuDqHewRdUi0tTywp9JF/4gfPHittVnTpDDu31jCEa1KaOtsqvoMq9o5DH 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3327gcbua3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 21:12:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LL9Kwe081284;
        Fri, 21 Aug 2020 21:10:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsn2yjyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 21:10:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07LLAUMm004194;
        Fri, 21 Aug 2020 21:10:30 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 21:10:30 +0000
Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
 <0a1636c9a3cc4bafb64ef43bed19f2fe@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <55865fbf-d2a8-7f86-0f09-769bc904cb02@oracle.com>
Date:   Fri, 21 Aug 2020 14:10:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0a1636c9a3cc4bafb64ef43bed19f2fe@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 1:47 PM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Song Bao Hua (Barry Song)
>> Sent: Saturday, August 22, 2020 7:27 AM
>> To: 'Mike Kravetz' <mike.kravetz@oracle.com>; hch@lst.de;
>> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
>> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
>> akpm@linux-foundation.org
>> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
>> huangdaode <huangdaode@huawei.com>; Linuxarm <linuxarm@huawei.com>
>> Subject: RE: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by
>> per-NUMA CMA
>>
>>
>>
>>> -----Original Message-----
>>> From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
>>> Sent: Saturday, August 22, 2020 5:53 AM
>>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
>>> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
>>> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
>>> akpm@linux-foundation.org
>>> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
>>> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
>>> huangdaode <huangdaode@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>
>>> Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by
>>> per-NUMA CMA
>>>
>>> Hi Barry,
>>> Sorry for jumping in so late.
>>>
>>> On 8/21/20 4:33 AM, Barry Song wrote:
>>>>
>>>> with per-numa CMA, smmu will get memory from local numa node to save
>>> command
>>>> queues and page tables. that means dma_unmap latency will be shrunk
>>> much.
>>>
>>> Since per-node CMA areas for hugetlb was introduced, I have been thinking
>>> about the limited number of CMA areas.  In most configurations, I believe
>>> it is limited to 7.  And, IIRC it is not something that can be changed at
>>> runtime, you need to reconfig and rebuild to increase the number.  In
>> contrast
>>> some configs have NODES_SHIFT set to 10.  I wasn't too worried because of
>>> the limited hugetlb use case.  However, this series is adding another user
>>> of per-node CMA areas.
>>>
>>> With more users, should try to sync up number of CMA areas and number of
>>> nodes?  Or, perhaps I am worrying about nothing?
>>
>> Hi Mike,
>> The current limitation is 8. If the server has 4 nodes and we enable both
>> pernuma
>> CMA and hugetlb, the last node will fail to get one cma area as the default
>> global cma area will take 1 of 8. So users need to change menuconfig.
>> If the server has 8 nodes, we enable one of pernuma cma and hugetlb, one
>> node
>> will fail to get cma.
>>
>> We may set the default number of CMA areas as 8+MAX_NODES(if hugetlb
>> enabled) +
>> MAX_NODES(if pernuma cma enabled) if we don't expect users to change
>> config, but
>> right now hugetlb has not an option in Kconfig to enable or disable like
>> pernuma cma
>> has DMA_PERNUMA_CMA.
> 
> I would prefer we make some changes like:
> 
> config CMA_AREAS
> 	int "Maximum count of the CMA areas"
> 	depends on CMA
> +	default 19 if NUMA
> 	default 7
> 	help
> 	  CMA allows to create CMA areas for particular purpose, mainly,
> 	  used as device private area. This parameter sets the maximum
> 	  number of CMA area in the system.
> 
> -	  If unsure, leave the default value "7".
> +	  If unsure, leave the default value "7" or "19" if NUMA is used.
> 
> 1+ CONFIG_CMA_AREAS should be quite enough for almost all servers in the markets.
> 
> If 2 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*2 + 1 = 5
> If 4 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*4 + 1 = 9    -> default ARM64 config.
> If 8 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*8 + 1 = 17
> 
> The default value is supporting the most common case and is not going to support those servers
> with NODES_SHIFT=10, they can make their own config just like users need to increase CMA_AREAS
> if they add many cma areas in device tree in a system even without NUMA.
> 
> How do you think, mike?

I'm OK with that.  I really did not want to sidetrach this series.  It is
just something I thought about when looking at the hugetlb code.  My 'to do'
list includes looking at a way to make the number of CMA areas dynamic.
-- 
Mike Kravetz
