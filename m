Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C6CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36E020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHDVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:30:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgHDVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:30:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074L2Epd193418;
        Tue, 4 Aug 2020 17:29:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qcaed7j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 17:29:32 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074L2CwG193219;
        Tue, 4 Aug 2020 17:29:32 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qcaed7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 17:29:32 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074LFmEi017538;
        Tue, 4 Aug 2020 21:29:31 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 32n019aaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 21:29:31 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074LTQDY58786138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 21:29:26 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20AA1136053;
        Tue,  4 Aug 2020 21:29:30 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8903B136055;
        Tue,  4 Aug 2020 21:29:28 +0000 (GMT)
Received: from oc3560204572.ibm.com (unknown [9.85.148.242])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 21:29:28 +0000 (GMT)
Message-ID: <c55250b704d6012413b5b36fea34bc57c98756ce.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/7] powerpc/pseries/iommu: Create defines for
 operations in ibm, ddw-applicable
From:   David Dai <zdai@linux.vnet.ibm.com>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 16:27:45 -0500
In-Reply-To: <20200716071658.467820-2-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
         <20200716071658.467820-2-leobras.c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 04:16 -0300, Leonardo Bras wrote:
> Create defines to help handling ibm,ddw-applicable values, avoiding
> confusion about the index of given operations.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 43 ++++++++++++++++------
> ----
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c
> b/arch/powerpc/platforms/pseries/iommu.c
> index 6d47b4a3ce39..ac0d6376bdad 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -39,6 +39,14 @@
>  
>  #include "pseries.h"
>  
> +enum {
> +	DDW_QUERY_PE_DMA_WIN  = 0,
> +	DDW_CREATE_PE_DMA_WIN = 1,
> +	DDW_REMOVE_PE_DMA_WIN = 2,
> +
> +	DDW_APPLICABLE_SIZE
> +};
> +
>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>  {
>  	struct iommu_table_group *table_group;
> @@ -771,12 +779,12 @@ static void remove_ddw(struct device_node *np,
> bool remove_prop)
>  {
>  	struct dynamic_dma_window_prop *dwp;
>  	struct property *win64;
> -	u32 ddw_avail[3];
> +	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>  	u64 liobn;
>  	int ret = 0;
>  
>  	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> -					 &ddw_avail[0], 3);
> +					 &ddw_avail[0],
> DDW_APPLICABLE_SIZE);
>  
>  	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
>  	if (!win64)
> @@ -798,15 +806,15 @@ static void remove_ddw(struct device_node *np,
> bool remove_prop)
>  		pr_debug("%pOF successfully cleared tces in window.\n",
>  			 np);
>  
> -	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> +	ret = rtas_call(ddw_avail[DDW_REMOVE_PE_DMA_WIN], 1, 1, NULL,
> liobn);
>  	if (ret)
>  		pr_warn("%pOF: failed to remove direct window: rtas
> returned "
>  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> -			np, ret, ddw_avail[2], liobn);
> +			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN],
> liobn);
>  	else
>  		pr_debug("%pOF: successfully removed direct window:
> rtas returned "
>  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> -			np, ret, ddw_avail[2], liobn);
> +			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN],
> liobn);
>  
>  delprop:
>  	if (remove_prop)
> @@ -889,11 +897,11 @@ static int query_ddw(struct pci_dev *dev, const
> u32 *ddw_avail,
>  	buid = pdn->phb->buid;
>  	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
>  
> -	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
> -		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
> +	ret = rtas_call(ddw_avail[DDW_QUERY_PE_DMA_WIN], 3, 5, (u32
> *)query,
> +			cfg_addr, BUID_HI(buid), BUID_LO(buid));
>  	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
> -		" returned %d\n", ddw_avail[0], cfg_addr,
> BUID_HI(buid),
> -		BUID_LO(buid), ret);
> +		" returned %d\n", ddw_avail[DDW_QUERY_PE_DMA_WIN],
> cfg_addr,
> +		 BUID_HI(buid), BUID_LO(buid), ret);
>  	return ret;
>  }
>  
> @@ -920,15 +928,16 @@ static int create_ddw(struct pci_dev *dev,
> const u32 *ddw_avail,
>  
>  	do {
>  		/* extra outputs are LIOBN and dma-addr (hi, lo) */
> -		ret = rtas_call(ddw_avail[1], 5, 4, (u32 *)create,
> -				cfg_addr, BUID_HI(buid), BUID_LO(buid),
> -				page_shift, window_shift);
> +		ret = rtas_call(ddw_avail[DDW_CREATE_PE_DMA_WIN], 5, 4,
> +				(u32 *)create, cfg_addr, BUID_HI(buid),
> +				BUID_LO(buid), page_shift,
> window_shift);
>  	} while (rtas_busy_delay(ret));
>  	dev_info(&dev->dev,
>  		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned
> %d "
> -		"(liobn = 0x%x starting addr = %x %x)\n", ddw_avail[1],
> -		 cfg_addr, BUID_HI(buid), BUID_LO(buid), page_shift,
> -		 window_shift, ret, create->liobn, create->addr_hi,
> create->addr_lo);
> +		"(liobn = 0x%x starting addr = %x %x)\n",
> +		 ddw_avail[DDW_CREATE_PE_DMA_WIN], cfg_addr,
> BUID_HI(buid),
> +		 BUID_LO(buid), page_shift, window_shift, ret, create-
> >liobn,
> +		 create->addr_hi, create->addr_lo);
>  
>  	return ret;
>  }
> @@ -996,7 +1005,7 @@ static u64 enable_ddw(struct pci_dev *dev,
> struct device_node *pdn)
>  	int page_shift;
>  	u64 dma_addr, max_addr;
>  	struct device_node *dn;
> -	u32 ddw_avail[3];
> +	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>  	struct direct_window *window;
>  	struct property *win64;
>  	struct dynamic_dma_window_prop *ddwprop;
> @@ -1029,7 +1038,7 @@ static u64 enable_ddw(struct pci_dev *dev,
> struct device_node *pdn)
>  	 * the property is actually in the parent, not the PE
>  	 */
>  	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
> -					 &ddw_avail[0], 3);
> +					 &ddw_avail[0],
> DDW_APPLICABLE_SIZE);
>  	if (ret)
>  		goto out_failed;
>  
Tested-by: David Dai <zdai@linux.vnet.ibm.com>

