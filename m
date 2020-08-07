Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FC42177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kj4HJv2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHGKII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50384 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgHGKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:08:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077A2Rk9046990;
        Fri, 7 Aug 2020 06:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Wnri4jM/HpyJsy42Pek8hL8LI9ZVlVXObiB7Ym3nAIU=;
 b=kj4HJv2CWlEcwTSfi2A+yTV/nPyRhXBoRJr7j0s3w6/n30WItssByyr1Zs883SEhIvdW
 rg48yIF1I+cOE7TrNA7hSn2Am/4JmLQVvGpAKfCrk/LDm+bDoqoIQo7bKBtZWB1PSIUK
 nk5ANcB+vIYo93b/1YCAlzf0e6DECLxJo+mJM5lfDdTEkQignBagSiaJC1w+0YeVAybd
 P2s1934cw7ivTrnIoRzpKpH1078mUR6cn3j2H+BITJhajjrrlyjq9bFXS21EqEyJcjyd
 3+FcOfC4Rth6Zi2oXYW0JEtT0tHc5GBN5nQ6e4EI9dYn0Brz4Y1HBIF5hXUXbnl5narR oA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rephnnk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 06:07:47 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 077A2nXt031808;
        Fri, 7 Aug 2020 10:07:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 32mynhc09w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 10:07:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 077A7hRv26149148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Aug 2020 10:07:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE9F9A4053;
        Fri,  7 Aug 2020 10:07:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACAC4A4059;
        Fri,  7 Aug 2020 10:07:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.24.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Aug 2020 10:07:41 +0000 (GMT)
Date:   Fri, 7 Aug 2020 13:07:39 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/64: Do not dereference non-present PGD entries
Message-ID: <20200807100739.GQ163101@linux.ibm.com>
References: <20200807084013.7090-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807084013.7090-1-joro@8bytes.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_05:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 mlxlogscore=833 clxscore=1011 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:40:13AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The code for preallocate_vmalloc_pages() was written under the
> assumption that the p4d_offset() and pud_offset() functions will perform
> present checks before dereferencing the parent entries.
> 
> This assumption is wrong an leads to a bug in the code which causes the
> physical address found in the PGD be used as a page-table page, even if
> the PGD is not present.
> 
> So the code flow currently is:
> 
> 	pgd = pgd_offset_k(addr);
> 	p4d = p4d_offset(pgd, addr);
> 	if (p4d_none(*p4d))
> 		p4d = p4d_alloc(&init_mm, pgd, addr);
> 
> This lacks a check for pgd_none() at least, the correct flow would be:
> 
> 	pgd = pgd_offset_k(addr);
> 	if (pgd_none(*pgd))
> 		p4d = p4d_alloc(&init_mm, pgd, addr);
> 	else
> 		p4d = p4d_offset(pgd, addr);
> 
> But this is the same flow that the p4d_alloc() and the pud_alloc()
> functions use internally, so there is no need to duplicate them.
> 
> Remove the p?d_none() checks from the function and just call into
> p4d_alloc() and pud_alloc() to correctly pre-allocate the PGD entries.
> 
> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

LGTM,

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/mm/init_64.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 3f4e29a78f2b..449e071240e1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1253,28 +1253,23 @@ static void __init preallocate_vmalloc_pages(void)
>  		p4d_t *p4d;
>  		pud_t *pud;
>  
> -		p4d = p4d_offset(pgd, addr);
> -		if (p4d_none(*p4d)) {
> -			/* Can only happen with 5-level paging */
> -			p4d = p4d_alloc(&init_mm, pgd, addr);
> -			if (!p4d) {
> -				lvl = "p4d";
> -				goto failed;
> -			}
> -		}
> +		lvl = "p4d";
> +		p4d = p4d_alloc(&init_mm, pgd, addr);
> +		if (!p4d)
> +			goto failed;
>  
> +		/*
> +		 * With 5-level paging the P4D level is not folded. So the PGDs
> +		 * are now populated and there is no need to walk down to the
> +		 * PUD level.
> +		 */
>  		if (pgtable_l5_enabled())
>  			continue;
>  
> -		pud = pud_offset(p4d, addr);
> -		if (pud_none(*pud)) {
> -			/* Ends up here only with 4-level paging */
> -			pud = pud_alloc(&init_mm, p4d, addr);
> -			if (!pud) {
> -				lvl = "pud";
> -				goto failed;
> -			}
> -		}
> +		lvl = "pud";
> +		pud = pud_alloc(&init_mm, p4d, addr);
> +		if (!pud)
> +			goto failed;
>  	}
>  
>  	return;
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
