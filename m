Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E67C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2099920768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCRHgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgCRHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:36:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I7aATG113937
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:36:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu96ejywk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:36:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 18 Mar 2020 07:36:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 07:36:25 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I7aOS247579388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 07:36:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9B96A4054;
        Wed, 18 Mar 2020 07:36:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD24A4066;
        Wed, 18 Mar 2020 07:36:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.35])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Mar 2020 07:36:23 +0000 (GMT)
Date:   Wed, 18 Mar 2020 09:36:22 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Guo Ren <guoren@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, trivial@kernel.org
Subject: Re: [PATCH] csky: delete redundant micro io_remap_pfn_range
References: <20200318044702.104793-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318044702.104793-1-wenhu.wang@vivo.com>
X-TM-AS-GCONF: 00
x-cbid: 20031807-0020-0000-0000-000003B65568
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031807-0021-0000-0000-0000220EBD63
Message-Id: <20200318073622.GB17919@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=747 bulkscore=0
 malwarescore=0 suspectscore=1 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:47:01PM -0700, Wang Wenhu wrote:
> Same definition exists in "include/asm-generic/pgtable.h",
> which is included just below the lines to be deleted.
> 
> #ifndef io_remap_pfn_range
> #define io_remap_pfn_range remap_pfn_range
> #endif
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/csky/include/asm/pgtable.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index 9b7764cb7645..bde812a785c8 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -306,9 +306,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
>  #define kern_addr_valid(addr)	(1)
>  
> -#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
> -	remap_pfn_range(vma, vaddr, pfn, size, prot)
> -
>  #include <asm-generic/pgtable.h>
>  
>  #endif /* __ASM_CSKY_PGTABLE_H */
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

