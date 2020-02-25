Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFF9C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251C221927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgBYNYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:24:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgBYNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:24:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PDNlkL090235
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:24:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ycxcxvjwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:24:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Tue, 25 Feb 2020 13:24:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 13:24:01 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PDO0jc51773506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 13:24:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0CB611C05B;
        Tue, 25 Feb 2020 13:23:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C212811C058;
        Tue, 25 Feb 2020 13:23:58 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 13:23:58 +0000 (GMT)
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-5-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Tue, 25 Feb 2020 14:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022513-4275-0000-0000-000003A552DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022513-4276-0000-0000-000038B968AA
Message-Id: <4a29677a-885e-d493-c9f0-2698ea41a58c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_04:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=2 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/02/2020 à 04:26, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Function declarations don't need externs, remove the existing ones
> so they are consistent with newer code
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Thanks for the cleanup!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>




>   arch/powerpc/include/asm/pnv-ocxl.h | 32 ++++++++++++++---------------
>   include/misc/ocxl.h                 |  6 +++---
>   2 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 0b2a6707e555..b23c99bc0c84 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -9,29 +9,27 @@
>   #define PNV_OCXL_TL_BITS_PER_RATE       4
>   #define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
>   
> -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
> -			u16 *supported);
> -extern int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
> +int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled, u16 *supported);
> +int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
>   
> -extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
> +int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
>   			char *rate_buf, int rate_buf_size);
> -extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
> +int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
>   			uint64_t rate_buf_phys, int rate_buf_size);
>   
> -extern int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
> -extern void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
> -				void __iomem *tfc, void __iomem *pe_handle);
> -extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
> -				void __iomem **dar, void __iomem **tfc,
> -				void __iomem **pe_handle);
> +int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
> +void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
> +			     void __iomem *tfc, void __iomem *pe_handle);
> +int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
> +			  void __iomem **dar, void __iomem **tfc,
> +			  void __iomem **pe_handle);
>   
> -extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
> -			void **platform_data);
> -extern void pnv_ocxl_spa_release(void *platform_data);
> -extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> +int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask, void **platform_data);
> +void pnv_ocxl_spa_release(void *platform_data);
> +int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
>   
> -extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> -extern void pnv_ocxl_free_xive_irq(u32 irq);
> +int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> +void pnv_ocxl_free_xive_irq(u32 irq);
>   #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
>   u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
>   void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 06dd5839e438..0a762e387418 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -173,7 +173,7 @@ int ocxl_context_detach(struct ocxl_context *ctx);
>    *
>    * Returns 0 on success, negative on failure
>    */
> -extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
> +int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>   
>   /**
>    * Frees an IRQ associated with an AFU context
> @@ -182,7 +182,7 @@ extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>    *
>    * Returns 0 on success, negative on failure
>    */
> -extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
> +int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>   
>   /**
>    * Gets the address of the trigger page for an IRQ
> @@ -193,7 +193,7 @@ extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
>    *
>    * returns the trigger page address, or 0 if the IRQ is not valid
>    */
> -extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
> +u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
>   
>   /**
>    * Provide a callback to be called when an IRQ is triggered
> 

