Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA130C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45162072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="DyxCae+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgEVSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:16:10 -0400
Received: from mail.xenproject.org ([104.130.215.37]:58818 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hLKSuZTQ4zo02OD599iePD2/rvDfeT9Ihh6Ut+Ss5iQ=; b=DyxCae+oxFpfbkgZWHTM5ZUy30
        QNvkMcKVhEsiKm65FENKqqRVklyCPJplTthhwbFSX5pNHFWGcMlwchcEd58WvagHoo2/Knwx0WCKi
        1VCuyhyQtCmyJ7q8REVY+XFLjUDnZloNlsyddVIjeKQZ4GLFweJW5+XnQUD1pO/1+JeU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1jcCDI-0001HQ-Sg; Fri, 22 May 2020 18:16:08 +0000
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <julien@xen.org>)
        id 1jcCDI-0004LV-Ix; Fri, 22 May 2020 18:16:08 +0000
Subject: Re: [PATCH 02/10] swiotlb-xen: remove start_dma_addr
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-2-sstabellini@kernel.org>
 <6241b8f6-5c51-0486-55ae-d571b117a184@xen.org>
 <alpine.DEB.2.21.2005211243060.27502@sstabellini-ThinkPad-T480s>
From:   Julien Grall <julien@xen.org>
Message-ID: <ab89bf08-a02f-85af-8f83-6a851d72ccf2@xen.org>
Date:   Fri, 22 May 2020 19:16:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005211243060.27502@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/05/2020 04:55, Stefano Stabellini wrote:
> On Thu, 21 May 2020, Julien Grall wrote:
>> Hi,
>>
>> On 21/05/2020 00:45, Stefano Stabellini wrote:
>>> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
>>>
>>> It is not strictly needed. Call virt_to_phys on xen_io_tlb_start
>>> instead. It will be useful not to have a start_dma_addr around with the
>>> next patches.
>>>
>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
>>> ---
>>>    drivers/xen/swiotlb-xen.c | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>> index a42129cba36e..b5e0492b07b9 100644
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -52,8 +52,6 @@ static unsigned long xen_io_tlb_nslabs;
>>>     * Quick lookup value of the bus address of the IOTLB.
>>>     */
>>>    -static u64 start_dma_addr;
>>> -
>>>    /*
>>>     * Both of these functions should avoid XEN_PFN_PHYS because phys_addr_t
>>>     * can be 32bit when dma_addr_t is 64bit leading to a loss in
>>> @@ -241,7 +239,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>>>    		m_ret = XEN_SWIOTLB_EFIXUP;
>>>    		goto error;
>>>    	}
>>> -	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
>>>    	if (early) {
>>>    		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
>>>    			 verbose))
>>> @@ -389,7 +386,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device
>>> *dev, struct page *page,
>>>    	 */
>>>    	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
>>>    -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
>>> +	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
>>> phys,
>>
>> xen_virt_to_bus() is implemented as xen_phys_to_bus(virt_to_phys()). Can you
>> explain how the two are equivalent?
> 
> They are not equivalent. Looking at what swiotlb_tbl_map_single expects,
> and also the implementation of swiotlb_init_with_tbl, I think
> virt_to_phys is actually the one we want.
> 
> swiotlb_tbl_map_single compares the argument with __pa(tlb) which is
> __pa(xen_io_tlb_start) which is virt_to_phys(xen_io_tlb_start).

I can't find such check in master. What is your baseline? Could you 
point to the exact line of code?

Cheers,

-- 
Julien Grall
