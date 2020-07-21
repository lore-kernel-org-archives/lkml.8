Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF0CC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A0D20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgGUKqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:46:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42252 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgGUKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:46:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LAVMdK103884;
        Tue, 21 Jul 2020 06:45:52 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5k0v2wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 06:45:52 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LAVlc2024333;
        Tue, 21 Jul 2020 10:45:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh3qj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:45:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LAik3M59900018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 10:44:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D379A4054;
        Tue, 21 Jul 2020 10:44:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E50BA405C;
        Tue, 21 Jul 2020 10:44:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jul 2020 10:44:44 +0000 (GMT)
Date:   Tue, 21 Jul 2020 13:44:36 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/mm/64: Remove vmalloc/ioremap pgtable
 synchronization
Message-ID: <20200721104436.GE802087@linux.ibm.com>
References: <20200721095953.6218-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721095953.6218-1-joro@8bytes.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_03:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=906 suspectscore=1 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:59:50AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> here is the third version of the patches to pre-allocate P4D/PUD pages
> for the vmalloc/ioremap areas on x86-64. This makes the page-table
> synchronization code obsolete and so it is also removed.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Changes to v2:
> 
> 	- Rebased to tip/master
> 	- Some rewording of the commit-messages 

I have a small nitpick for the commit message of the first patch,
otheriwise,

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

 
> Joerg Roedel (3):
>   x86/mm: Pre-allocate p4d/pud pages for vmalloc area
>   x86/mm/64: Do not sync vmalloc/ioremap mappings
>   x86/mm/64: Make sync_global_pgds() static
> 
>  arch/x86/include/asm/pgtable_64.h       |  2 -
>  arch/x86/include/asm/pgtable_64_types.h |  2 -
>  arch/x86/mm/init_64.c                   | 59 ++++++++++++++++++++++---
>  3 files changed, 53 insertions(+), 10 deletions(-)
> 
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
