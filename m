Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99CBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A022B49
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgH0HE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:04:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbgH0HE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:04:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3F14F159AA9C340ACAD;
        Thu, 27 Aug 2020 15:04:23 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 15:04:18 +0800
Subject: Re: [PATCH v3 5/7] libnvdimm: reduce an unnecessary if branch in
 nd_region_activate()
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
 <20200820021641.3188-6-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8027bff4-b100-2330-1bb6-5d0aa0215db3@huawei.com>
Date:   Thu, 27 Aug 2020 15:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200820021641.3188-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will drop this patch, because I have a doubt:
Suppose the nd_region->ndr_mappings is 4, and for each nd_region->mapping[],
the value of num_flush is "0, 0, 4, 0", so the flush_data_size is "1 + 1 + 5 + 1", * sizeof(void *).
But in ndrd_get_flush_wpq() or ndrd_set_flush_wpq(), the expression is
"ndrd->flush_wpq[dimm * num + (hint & mask)]", I don't think the memory "ndrd" allocated is enough.
Please refer call chain: nd_region_activate() --> nvdimm_map_flush() --> ndrd_set_flush_wpq()

	for (i = 0; i < nd_region->ndr_mappings; i++) {
                struct nd_mapping *nd_mapping = &nd_region->mapping[i];
                struct nvdimm *nvdimm = nd_mapping->nvdimm;

                /* at least one null hint slot per-dimm for the "no-hint" case */
                flush_data_size += sizeof(void *);
                num_flush = min_not_zero(num_flush, nvdimm->num_flush);
                if (!nvdimm->num_flush)
                        continue;
                flush_data_size += nvdimm->num_flush * sizeof(void *);
        }

        ndrd = devm_kzalloc(dev, sizeof(*ndrd) + flush_data_size, GFP_KERNEL);




On 2020/8/20 10:16, Zhen Lei wrote:
> According to the original code logic:
> if (!nvdimm->num_flush) {
> 	flush_data_size += sizeof(void *);
> 	//nvdimm->num_flush is zero now, add 1) have no side effects
> } else {
> 	flush_data_size += sizeof(void *);
> 1)	flush_data_size += nvdimm->num_flush * sizeof(void *);
> }
> 
> Obviously, the above code snippet can be reduced to one statement:
> flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/nvdimm/region_devs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 7cf9c7d857909ce..49be115c9189eff 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -77,11 +77,8 @@ int nd_region_activate(struct nd_region *nd_region)
>  		}
>  
>  		/* at least one null hint slot per-dimm for the "no-hint" case */
> -		flush_data_size += sizeof(void *);
> +		flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);
>  		num_flush = min_not_zero(num_flush, nvdimm->num_flush);
> -		if (!nvdimm->num_flush)
> -			continue;
> -		flush_data_size += nvdimm->num_flush * sizeof(void *);
>  	}
>  	nvdimm_bus_unlock(&nd_region->dev);
>  
> 

