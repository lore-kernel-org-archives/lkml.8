Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5962F20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgFCRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:06:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgFCRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:06:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053H5cOs013441;
        Wed, 3 Jun 2020 13:06:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dr8hybfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 13:06:34 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 053H61kr019644;
        Wed, 3 Jun 2020 13:06:34 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dr8hybej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 13:06:33 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053H1HIo026166;
        Wed, 3 Jun 2020 17:06:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 31bf483e2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 17:06:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053H6SvZ852442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jun 2020 17:06:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E31EDA4057;
        Wed,  3 Jun 2020 17:06:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4197BA404D;
        Wed,  3 Jun 2020 17:06:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.63.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Jun 2020 17:06:27 +0000 (GMT)
Date:   Wed, 3 Jun 2020 20:06:24 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm/memblock: export max_pfn for kernel modules
Message-ID: <20200603170624.GA202648@linux.ibm.com>
References: <20200603161132.2441-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603161132.2441-1-miles.chen@mediatek.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_13:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=1
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 12:11:32AM +0800, Miles Chen wrote:
> max_pfn is uesd to get the highest pfn in the system. Drivers like
> drivers/iommu/mtk_iommu.c checks max_pfn to see if it should enable
> its "4GB mode".
> 
> This patch exports the max_pfn symbol, so we can build the driver as
> a kernel module.

You can use totalram_pages(), like e.g.
drivers/media/platform/mtk-vpu/mtk_vpu.c:

$ git grep -np totalram_pages drivers/media/
drivers/media/platform/mtk-vpu/mtk_vpu.c=779=static int mtk_vpu_probe(struct platform_device *pdev)
drivers/media/platform/mtk-vpu/mtk_vpu.c:861:   vpu->enable_4GB = !!(totalram_pages() > (SZ_2G >> PAGE_SHIFT));


> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  mm/memblock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c79ba6f9920c..3b2b21ecebb6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -99,6 +99,7 @@ EXPORT_SYMBOL(contig_page_data);
>  unsigned long max_low_pfn;
>  unsigned long min_low_pfn;
>  unsigned long max_pfn;
> +EXPORT_SYMBOL(max_pfn);
>  unsigned long long max_possible_pfn;
>  
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> -- 
> 2.18.0

-- 
Sincerely yours,
Mike.
