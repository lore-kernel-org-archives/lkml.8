Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4050C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8687420767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y3kpXiR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIBP21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:28:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59004 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgIBP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:27:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FF2YH056382;
        Wed, 2 Sep 2020 15:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7mXV32r5WePgEqMjkjtjpSfMQCIPNlhHlW2fZ3SX8iQ=;
 b=y3kpXiR6YF9xZQ9hHoCoVTSPxO+FfvCQYqpEjsVslFRjqX5dkvFb0ASrLwArCCGZo1Gf
 s/c7XUeWuUvYYuh74+XMkHWm205a4lcO8jNEjy6JVP9SszCEP02aNyqhtbpF20cW5Sbb
 s5XunusU62ASPdJDA6IhmdKDBjfKEdfWTYzOuUyr7YNDJszct7ncGewYn3f3Z5Xn0KXk
 ARJ+c+Nloc+HPjB/CMhREjbDih8RSxb+XnCifbS4n2brpfjv5vyIS7M8ovboLSmKCAsr
 AdPZ3ecLm3QqOoapgb2jOsIG54UZ9n5Pr9y/bfQ+G/+IEgm8AcqfPEraFbpX7hSHW6Mr 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer3adr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 15:27:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FPUMv115239;
        Wed, 2 Sep 2020 15:27:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380kq640u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 15:27:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082FR2iH032138;
        Wed, 2 Sep 2020 15:27:02 GMT
Received: from [10.175.214.7] (/10.175.214.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 08:27:02 -0700
Subject: Re: [PATCH 2/2] iommu: amd: Use cmpxchg_double() when updating
 128-bit IRTE
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, sean.m.osborne@oracle.com,
        james.puthukattukaran@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com
References: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
 <20200902045110.4679-3-suravee.suthikulpanit@amd.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <6f65bd13-08fc-45d9-8e80-b64499f010e0@oracle.com>
Date:   Wed, 2 Sep 2020 16:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200902045110.4679-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 5:51 AM, Suravee Suthikulpanit wrote:
> When using 128-bit interrupt-remapping table entry (IRTE) (a.k.a GA mode),
> current driver disables interrupt remapping when it updates the IRTE
> so that the upper and lower 64-bit values can be updated safely.
> 
> However, this creates a small window, where the interrupt could
> arrive and result in IO_PAGE_FAULT (for interrupt) as shown below.
> 
>   IOMMU Driver            Device IRQ
>   ============            ===========
>   irte.RemapEn=0
>        ...
>    change IRTE            IRQ from device ==> IO_PAGE_FAULT !!
>        ...
>   irte.RemapEn=1
> 
> This scenario has been observed when changing irq affinity on a system
> running I/O-intensive workload, in which the destination APIC ID
> in the IRTE is updated.
> 
> Instead, use cmpxchg_double() to update the 128-bit IRTE at once without
> disabling the interrupt remapping. However, this means several features,
> which require GA (128-bit IRTE) support will also be affected if cmpxchg16b
> is not supported (which is unprecedented for AMD processors w/ IOMMU).
> 
Probably requires:

 Fixes: 880ac60e2538 ("iommu/amd: Introduce interrupt remapping ops structure")

?

> Reported-by: Sean Osborne <sean.m.osborne@oracle.com>
> Tested-by: Erik Rockstrom <erik.rockstrom@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

With the comments below addressed, FWIW:

 Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c652f16eb702..ad30467f6930 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1511,7 +1511,14 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
>  		else
>  			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
> -		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
> +
> +		/*
> +		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
> +		 * GAM also requires GA mode. Therefore, we need to
> +		 * check cmbxchg16b support before enabling it.
> +		 */

s/cmbxchg16b/cmpxchg16b

> +		if (!boot_cpu_has(X86_FEATURE_CX16) ||
> +		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
>  			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
>  		break;
>  	case 0x11:
> @@ -1520,8 +1527,18 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
>  		else
>  			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
> -		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
> +
> +		/*
> +		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
> +		 * XT, GAM also requires GA mode. Therefore, we need to
> +		 * check cmbxchg16b support before enabling them.

s/cmbxchg16b/cmpxchg16b

> +		 */
> +		if (boot_cpu_has(X86_FEATURE_CX16) ||

You probably want !boot_cpu_has(X86_FEATURE_CX16) ?

> +		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
>  			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
> +			break;
> +		}
> +
>  		/*
>  		 * Note: Since iommu_update_intcapxt() leverages
>  		 * the IOMMU MMIO access to MSI capability block registers
