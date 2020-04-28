Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F6C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B688206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD1IJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:09:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:50608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD1IJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:09:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E629AC4A;
        Tue, 28 Apr 2020 08:09:09 +0000 (UTC)
Subject: Re: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
To:     peng.fan@nxp.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
Date:   Tue, 28 Apr 2020 10:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.20 09:33, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When booting xen on i.MX8QM, met:
> "
> [    3.602128] Unable to handle kernel paging request at virtual address 0000000000272d40
> [    3.610804] Mem abort info:
> [    3.613905]   ESR = 0x96000004
> [    3.617332]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    3.623211]   SET = 0, FnV = 0
> [    3.626628]   EA = 0, S1PTW = 0
> [    3.630128] Data abort info:
> [    3.633362]   ISV = 0, ISS = 0x00000004
> [    3.637630]   CM = 0, WnR = 0
> [    3.640955] [0000000000272d40] user address but active_mm is swapper
> [    3.647983] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    3.654137] Modules linked in:
> [    3.677285] Hardware name: Freescale i.MX8QM MEK (DT)
> [    3.677302] Workqueue: events deferred_probe_work_func
> [    3.684253] imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
> [    3.688297] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    3.688310] pc : xen_swiotlb_free_coherent+0x180/0x1c0
> [    3.693993] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    3.701002] lr : xen_swiotlb_free_coherent+0x44/0x1c0
> "
> 
> In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask) or
> range_straddles_page_boundary(phys, size) are true, it will
> create contiguous region. So when free, we need to free contiguous
> region use upper check condition.

No, this will break PV guests on x86.

I think there is something wrong with your setup in combination with
the ARM xen_create_contiguous_region() implementation.

Stefano?


Juergen

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/xen/swiotlb-xen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index b6d27762c6f8..ab96e468584f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>   	/* Convert the size to actually allocated. */
>   	size = 1UL << (order + XEN_PAGE_SHIFT);
>   
> -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> -		     range_straddles_page_boundary(phys, size)) &&
> +	if (((dev_addr + size - 1 > dma_mask) ||
> +	    range_straddles_page_boundary(phys, size)) &&
>   	    TestClearPageXenRemapped(virt_to_page(vaddr)))
>   		xen_destroy_contiguous_region(phys, order);
>   
> 

