Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5169CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272122083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AgWPVT2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAQO4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:56:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:56:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HEr9gs170370;
        Fri, 17 Jan 2020 14:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=RDYxmTVi6oTBCZ/d+490GqYHOHA9lPToi4gO08lPyRM=;
 b=AgWPVT2XCVmAXkqITfU70s/3cCF8Sp0GY33C70RcH0SMhQwG7itGReWnDR5elNp9POcd
 C515OTVt5ANzeQJ6+iytxN56YsmbdjQQhGRXoDQ/XqeGVxJpKt9jur7muPeJeYK4gcXe
 2x3RegrwIWpwmSktWpe5av0hWsLqsNs+35dJ4SZLF7aAyVI2O+KIFess/Y0GuRwC73iC
 +tARVqkzGDGCH2jTjZbSwmkE3UqFTj9Mci7Wld5D9x1+RbwZKBFvoyra6XWYWMs/3vs+
 vHJrZweJDTdVe5yQWPTDkRXyNdgQ/wW9/LqmUx3CjqZRXpNjvt86zG3BPhIjIp4WEH9J JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73u91uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 14:56:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HEsBST166391;
        Fri, 17 Jan 2020 14:56:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xk24f4w2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 14:56:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HEuH6G006884;
        Fri, 17 Jan 2020 14:56:17 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 06:56:17 -0800
Subject: Re: [PATCH v2 2/4] x86/xen: add basic KASAN support for PV kernel
To:     Sergey Dyasli <sergey.dyasli@citrix.com>, xen-devel@lists.xen.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200117125834.14552-1-sergey.dyasli@citrix.com>
 <20200117125834.14552-3-sergey.dyasli@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <28aba070-fa53-5677-c2d2-97d06514dda8@oracle.com>
Date:   Fri, 17 Jan 2020 09:56:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117125834.14552-3-sergey.dyasli@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/20 7:58 AM, Sergey Dyasli wrote:
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -13,6 +13,9 @@
>   #include <linux/sched/task.h>
>   #include <linux/vmalloc.h>
>   
> +#include <xen/xen.h>
> +#include <xen/xen-ops.h>
> +
>   #include <asm/e820/types.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlbflush.h>
> @@ -332,6 +335,11 @@ void __init kasan_early_init(void)
>   	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
>   		kasan_early_shadow_p4d[i] = __p4d(p4d_val);
>   
> +	if (xen_pv_domain()) {
> +		pgd_t *pv_top_pgt = xen_pv_kasan_early_init();
> +		kasan_map_early_shadow(pv_top_pgt);
> +	}
> +


I'd suggest replacing this with xen_kasan_early_init() and doing 
everything, including PV check, there. This way non-Xen code won't need 
to be aware of Xen-specific details such as guest types.


>   	kasan_map_early_shadow(early_top_pgt);
>   	kasan_map_early_shadow(init_top_pgt);
>   }
> @@ -369,6 +377,8 @@ void __init kasan_init(void)
>   				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
>   	}
>   
> +	xen_pv_kasan_pin_pgd(early_top_pgt);
> +

And drop "_pv" here (and below) for the same reason.

-boris

>   	load_cr3(early_top_pgt);
>   	__flush_tlb_all();
>   
> @@ -433,6 +443,8 @@ void __init kasan_init(void)
>   	load_cr3(init_top_pgt);
>   	__flush_tlb_all();
>   
> +	xen_pv_kasan_unpin_pgd(early_top_pgt);
> +
>
