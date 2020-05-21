Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEFC2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="nwKIRUi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgEUIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:10:05 -0400
Received: from mail.xenproject.org ([104.130.215.37]:53910 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgEUIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eK8mUW3fF6LfxGwGD9YQ3A/OYObovV5a54tgN2SqYBY=; b=nwKIRUi1vyafg76NV78jcGDCFA
        khx1OwBDchZUUlFGvdTu/PCztlgnrvzIBAO4tBR/q1eQ3Z/wYi5GX4y38lAQfzrwGTtD+4EsmzR5v
        s80ZBeqel/JjmG+KlgZ2jEHrvhTMJZEVO4RZ3BH4eEoL9b5/2w+aCYk5Hzh7MLyqiGtY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1jbgCT-0004HF-5A; Thu, 21 May 2020 08:05:09 +0000
Received: from 54-240-197-225.amazon.com ([54.240.197.225] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <julien@xen.org>)
        id 1jbgCS-0006Wj-V5; Thu, 21 May 2020 08:05:09 +0000
Subject: Re: [PATCH 02/10] swiotlb-xen: remove start_dma_addr
To:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-2-sstabellini@kernel.org>
From:   Julien Grall <julien@xen.org>
Message-ID: <6241b8f6-5c51-0486-55ae-d571b117a184@xen.org>
Date:   Thu, 21 May 2020 09:05:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520234520.22563-2-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/2020 00:45, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> It is not strictly needed. Call virt_to_phys on xen_io_tlb_start
> instead. It will be useful not to have a start_dma_addr around with the
> next patches.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
>   drivers/xen/swiotlb-xen.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index a42129cba36e..b5e0492b07b9 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -52,8 +52,6 @@ static unsigned long xen_io_tlb_nslabs;
>    * Quick lookup value of the bus address of the IOTLB.
>    */
>   
> -static u64 start_dma_addr;
> -
>   /*
>    * Both of these functions should avoid XEN_PFN_PHYS because phys_addr_t
>    * can be 32bit when dma_addr_t is 64bit leading to a loss in
> @@ -241,7 +239,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>   		m_ret = XEN_SWIOTLB_EFIXUP;
>   		goto error;
>   	}
> -	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
>   	if (early) {
>   		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
>   			 verbose))
> @@ -389,7 +386,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   	 */
>   	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
>   
> -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
> +	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start), phys,

xen_virt_to_bus() is implemented as xen_phys_to_bus(virt_to_phys()). Can 
you explain how the two are equivalent?

Cheers,

-- 
Julien Grall
