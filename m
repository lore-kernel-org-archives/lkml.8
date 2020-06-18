Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0016B20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZYi8UE06";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iJhlbkKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgFRTzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:55:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728283AbgFRTzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:55:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IJs0wv004617;
        Thu, 18 Jun 2020 12:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ux7sihKwAyrCzi34HLwS6l1UjgbSlP1pMKAwl5xVHKU=;
 b=ZYi8UE06Z4LuWV0FdWeSughA7p7GAApBDeW8DCv+Yn9Mvp6KELZ0Jt/nDReLIFYOfc2S
 6wQyf0FaYkJTlD2xEt9my8H6ArE5J+zQ6CDqebCJArwjJdXz2t0bYkKBnbTg7EtR4DPO
 TOWGHrBBZgo9LcnG/iLs/cdkZm+PnweJ8Uc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q644p8sm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 12:55:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 12:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIu7I6DYffLwNbDUKZ/VGmEayhs0RO3TAcgEh9YLd/SqUGH9Zo45vV/7XrYr6TemZCxnIzsq2u41Lti5a6MegYhPHY4CHPJPOgjVA5K8xcDucZ2h6/4LDQJ/s/U99wqmeTtJndsMqkOUPM3DeqDHuCN6yVIuOcB3V9J6itYTtZkiVwPeMl2pkSF3Pojoqa+J39ztS2X+lsWgfM0lzrweaOufMbmRfFs5nhSH2vcpp5i27VXHScrFo6Hf4Hx7pL6cGfznVqAZySQcGcqstA8Ujno8npV6zy79/tDRU9TBKSoKrrwo2h7279YqKpGErwPkyROWxnm3rSCFlAY1WpRb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux7sihKwAyrCzi34HLwS6l1UjgbSlP1pMKAwl5xVHKU=;
 b=UL3GjmJ+eS3xmQ8A8X+kb3na5++K2GHsNtXgxVFBe+r3ghmiLDtUJ2I7jmAS9hSDjL5BB6UlVU0B0jkbP0rkdsivyrPvVdfC8bFUMA4xrIQzswGfwrvVB8MZ5jgtvjM+WrX9sdj/HzFtoJLiegrerva+cII2jtmrxqfV1IPXCCyeS3GmHq27+rRMeOtUqIpOtaDm1IzhLy9/BGuRdspCwYacbBStEhNTuibPdNOC/B7b2S3AsYNy9dtojP1e6bDQFUiHC86DMo4HXCBr8Ph7AxG/JK9MaXItH7k8PqC+i9VYuerCOevbb+sxizQQpIfq0688uBK8jVbr6RU0G+HfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux7sihKwAyrCzi34HLwS6l1UjgbSlP1pMKAwl5xVHKU=;
 b=iJhlbkKJYirlYVKHUNGiS4NVKEjC4JcehwWkv8GDzGS67HvdvD2a4zywxBjBuNBI5M/lC5EyueajNyYgUofpyiEAoKkSqEH+CVXv4m2NRAxIXl6mx5lmS3SBlLrSUmsGqrFHnbm1yuLpormWbbSsIEwmDlvC3Uz9VZjheu4dK9Q=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2983.namprd15.prod.outlook.com (2603:10b6:a03:f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:54:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:54:58 +0000
Date:   Thu, 18 Jun 2020 12:54:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
Message-ID: <20200618195453.GD110603@carbon.dhcp.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz>
 <949b90ed-e0f0-07d7-4d21-e30ec0958a7c@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949b90ed-e0f0-07d7-4d21-e30ec0958a7c@suse.cz>
X-ClientProxiedBy: SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:632d) by SN4PR0701CA0027.namprd07.prod.outlook.com (2603:10b6:803:2d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:54:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:632d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee2455e-7c10-4fae-a3a5-08d813c17b08
X-MS-TrafficTypeDiagnostic: BYAPR15MB2983:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29839C6BEC42D4683236A83ABE9B0@BYAPR15MB2983.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OjUmRcA8up0TmtoE7eBDxhUMCMQTZUQ/snfFUIs37aiofqk0XkIkG5orviKn0/zEqNdtrEh91RPRVsOP3ySKPrmQPQgPB/A0SQZs9VqCF9ZxUMyMbWQQRH0hauFGPVn2LIp5sRulMYNsknYT+Qb88OaKOfeGG9wH5AXlKIfx9dvhdF1Tzop8zekC2qNMcBZs9iq9BKmcWY4Fbxb8Mc060friIFHUxwc1txh7VAAkkthpctakJGHZva2s2nUIg+FbWhE8erHQE9nu6CQTlV7NHUtXHXnX45jx77gVo0a4sFH5/DAI6nlK6wHkBYkvDfb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(2906002)(9686003)(55016002)(6506007)(53546011)(4326008)(5660300002)(478600001)(6916009)(8676002)(54906003)(8936002)(52116002)(86362001)(316002)(7696005)(7416002)(6666004)(1076003)(186003)(66946007)(16526019)(66476007)(33656002)(66556008)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nzuBj5Ssj00fROKUSfKM8/mPVsh3QvMgQOjRHdbonNfcK1EOGgVdS7GcM/yTFyulNgpcDizjlM9FjjY72m1aAM4/ZGkqIa2I2BgsW4vDFi9xLRjWfFFC9oKRUWzWNjALLiDsCKKHLf1XrXxKzMvcFGeNCAkBcvm9TRMLryt6iSuryGtPr3OiUDq1lsh5fbptzC05rY4THurT7vYaVcJFUmMSBnaJEBxbUbASrkICnD2dOL/Wsp8NCMBcj2heSdAcMbREoBJm3TI14COffasgBXWQlUF5SMrjlD0W0//IMlTNCXykW1Cc0RXLfxad3nES450yVxvrsrsyR+m461dhz63WZ8HEtp+h2rvbDD14vd0C4edqtTS+xtTjTVFoVjh4gcqnkyVFvAQL+9BHglDwscs+kbteWZAxz2blGkEAi1ooAVI1vTVXNxPiq0S//CzZClupH5ZgDc5T0NrfdUz6PoRjFMtHnd9E57jFQqwZQo0oNae6WFDw8crpNdrRymrkiU008s+eqiuP+Eh84gAnzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aee2455e-7c10-4fae-a3a5-08d813c17b08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:54:58.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tFoK+cZ2mZ5t+1gXTDa3P2AJvfW+wiNGlQtVCvr3BPUzsUdz6exn/2ac9P4IoPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2983
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 cotscore=-2147483648 suspectscore=1 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:37:07AM +0200, Vlastimil Babka wrote:
> On 6/10/20 6:31 PM, Vlastimil Babka wrote:
> > There are few places that call kmem_cache_debug(s) (which tests if any of debug
> > flags are enabled for a cache) immediatelly followed by a test for a specific
> > flag. The compiler can probably eliminate the extra check, but we can make the
> > code nicer by introducing kmem_cache_debug_flags() that works like
> > kmem_cache_debug() (including the static key check) but tests for specifig
> > flag(s). The next patches will add more users.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Please add this fixup per reviews.
> ----8<----
> From 25793252a31a36f8d1d4ccf0f27ed3e43fba54d8 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 18 Jun 2020 10:34:53 +0200
> Subject: [PATCH] mm, slub: introduce kmem_cache_debug_flags()-fix
> 
> Change return from int to bool, per Kees.
> Add VM_WARN_ON_ONCE() for invalid flags, per Roman.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c8e8b4ae2451..59d19c64069e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -127,16 +127,17 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>   * cache. Use only for flags parsed by setup_slub_debug() as it also enables
>   * the static key.
>   */
> -static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> +static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
>  {
> +	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (static_branch_unlikely(&slub_debug_enabled))
>  		return s->flags & flags;
>  #endif
> -	return 0;
> +	return false;
>  }
>  
> -static inline int kmem_cache_debug(struct kmem_cache *s)
> +static inline bool kmem_cache_debug(struct kmem_cache *s)
>  {
>  	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
>  }
> -- 
> 2.27.0
> 
> 
