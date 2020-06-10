Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334DE2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Uxt1WUjV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z0xnZhd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFJWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:10:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbgFJWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:10:24 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AMA5nE032760;
        Wed, 10 Jun 2020 15:10:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=GnIFDipEJl3zWc514mIfT4EZvbUFYVIwYlkOIdsCyFo=;
 b=Uxt1WUjVuXNBUDxTWtdVmlIwRTxI7xZv76/g9HIBMwHWqUT9PSle3V+QQ71wCnt6HhVX
 S19jRkmfBdUDtJ8qxbt8ds7ViMbe+pxgbcCcK286E09IJOjdlhe2dVnwuH0VaGoFTE3C
 tmKG4Z9wMZfajoT2ZToJtr3DWyj4FZppgFM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31gu02juhc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jun 2020 15:10:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Jun 2020 15:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md1I51KoPY8xp0z2JJ9lSCHdrTkrqEsVKd62rL55TPC/tZ4BmqJ2Cjf4mYXZPrJkRmciAwt8s0unmqSNofuFbTLXjLmblZIxUYzNZ7ZIVBMZEOaTDYwy4psSk90AMolZ++SRygyTKfp0I0f1lual2LZkP2afogorA+3tt67eFc6Dh03lRJPHpYFBgNl129krDps2ckxizTlhjH6gEPZLtWVX0MDCpXWa5SE/vIX7txvZsu6a9P+/1FLplyFRZRbGKUIWhsccWCr/EhNjqOBiaYyO8LfBqPpqEe4Fk3oXsEhs2+l2KmUTA+cKC3Q+JSDOD4T5cg6N+C/QB07rzCdPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnIFDipEJl3zWc514mIfT4EZvbUFYVIwYlkOIdsCyFo=;
 b=FPiS4fiohqCgUZroHtX5xW8ra+9sSjP5YpNjMmVAJKJG7/7PjrwWDMIP8A4smukwVESHB/JUcU9DtmIFAoG/9qxUg7wU3ijmbyEtmeAWCycR2k+r7sj003j7q/ot+puhp81pxj2Da3Kmm6e2hDOKtgSO0Lkz1FrtwGkAdmeycTSkPDk9SW/Pa1AYbOTaB476giN1w/vRQLpeBAVPhkh71HLI23YAexvViL7nXa8eU1E9wr0ZjKahBpLhmiRqQTM344EzkhJ8u4etfrh1GGMSdhfPYjL/jGODPOCq8bBS7fLK2foUmY3x38dLbF4Qxv3uo5GwXGt7lHxGI2D4Ytnh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnIFDipEJl3zWc514mIfT4EZvbUFYVIwYlkOIdsCyFo=;
 b=Z0xnZhd7n4HhlSSHGsuCm1IUiadBGfXALCipkrwKbp2spckPbZsw8rq5m2obaz4cnrF5hju7Hk98ZMeFxfcKm2DOwucYDupiyvCoA4NXHfy3FLkZ113ruxXWhBXA7JcpJ5nObG5kGuKeMQBE+kHDr3B/Bz+sYJODSNX4tT8yZ3o=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3221.namprd15.prod.outlook.com (2603:10b6:a03:102::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Wed, 10 Jun
 2020 22:09:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 22:09:51 +0000
Date:   Wed, 10 Jun 2020 15:09:47 -0700
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
Subject: Re: [PATCH 8/9] mm, slub: extend checks guarded by slub_debug static
 key
Message-ID: <20200610220947.GC702969@carbon.DHCP.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-9-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-9-vbabka@suse.cz>
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:902b) by BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 22:09:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:902b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47a0bd2-6249-4788-83df-08d80d8aff02
X-MS-TrafficTypeDiagnostic: BYAPR15MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32219F859A3730004D288928BE830@BYAPR15MB3221.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lwgeV/5Y0vdo9RTAbWELnbRUmyjRCo+rxPZZ1CLiwGjXr867C1KBxdobIspx0FdE4pDuzc4xRWDBV/A5xMlgwE8ufst1RfRrMuJpJn5Ucl7ge5jBB+EIgAR+JHJxDmFXomI5gnpa0n/v1U8Eyh2EnG6wE6CbYwCBRby8pK3dcArfBIhaHCVL5i5RiC2cI1H+8x8hmBsmZHAJ9xDAJe3zsPAQfv2nuxWyoS5y+UXjHSsdqbDy2kztxDhzKan44+gT/EGkrr5mq9hI4z8sZXdx5+eCW9/vh6VVgqjnBqFN1jcxFVCP+e7EDrQBJ1fmxGL5Ugp+Dd2Xotriih9L8AY8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(6666004)(7416002)(478600001)(86362001)(1076003)(54906003)(66556008)(66476007)(2906002)(9686003)(4326008)(5660300002)(6506007)(66946007)(8676002)(6916009)(7696005)(33656002)(186003)(83380400001)(8936002)(16526019)(52116002)(316002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oXdLDEiwzUYDXphEC9VZPg5Vwmi232KsKrlEoYTcJ7sdAnE3sQmjsbaRO7IAacFOqy4JPB8WrmlryZxOtrri8V2Uda6Y+XXirvRGqFzIZpbagoUb1MNcgi8iQlUmNNjVjIWqrVld/kVF6NvmaNJWLHUW0AW1i8fOCopvNqcj0D0rxg6YZboaZnZ67u3tV3f9P9Fp/cYPgsy+ctemPGzdUPe2ZfbfJULYhIHUO4wPT6d06MBV+EkvZMUdIP8pfoNMyf0OBjCjwFk/8Am0nVfEWl4+52J6rFDEONZyqxNiA1vIBYbjT2Ua0HvGKapBeAZV7TdaapxhIX5HdLxTQfxSdir+udWBsHLnEfraSRJjGOdoaUlWfIeP8y8H5Je5CyW/FEkFbl3YGT9I6BKpjhqSm2NxcAOWslajRwAeqO957D5J4Bun2XKVm5pKBinrQGexudMNj57kPHdYMW119ebOcTeHFGw+7aReqfXinzFfUuPRN7jW/qPY+qB+u0n5KJ62ExsJuvi1kiGEmGdgF4+WdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a47a0bd2-6249-4788-83df-08d80d8aff02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 22:09:50.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfpWGXkpkYKj7ZUVs+s0+yqR5fpdVNeBwrClfNzDGTB9zJ0qY9BwsxG1c4EtPvKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 cotscore=-2147483648 phishscore=0
 mlxlogscore=920 mlxscore=0 suspectscore=5 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:34PM +0200, Vlastimil Babka wrote:
> There are few more places in SLUB that could benefit from reduced overhead of
> the static key introduced by a previous patch:
> 
> - setup_object_debug() called on each object in newly allocated slab page
> - setup_page_debug() called on newly allocated slab page
> - __free_slab() called on freed slab page
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c8e8b4ae2451..efb08f2e9c66 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1130,7 +1130,7 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
>  static void setup_object_debug(struct kmem_cache *s, struct page *page,
>  								void *object)
>  {
> -	if (!(s->flags & (SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON)))
> +	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
>  		return;

This part is nice! It might bring some perf improvements.

>  
>  	init_object(s, object, SLUB_RED_INACTIVE);
> @@ -1140,7 +1140,7 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
>  static
>  void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr)
>  {
> -	if (!(s->flags & SLAB_POISON))
> +	if (!kmem_cache_debug_flags(s, SLAB_POISON))
>  		return;
>  
>  	metadata_access_enable();
> @@ -1857,7 +1857,7 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
>  	int order = compound_order(page);
>  	int pages = 1 << order;
>  
> -	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> +	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
>  		void *p;
>  
>  		slab_pad_check(s, page);
> -- 
> 2.26.2
> 
