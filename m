Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16420C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB36F2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lUUpUDvp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ie6X6wu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFJWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:00:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgFJWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:00:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05ALxavX007493;
        Wed, 10 Jun 2020 15:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5YTgurXbjj/Sz+426K/l26OJasudHbFNjqbtIZIK06o=;
 b=lUUpUDvpcoGDOgZ/Gq8Fn13Y8uawLpKbA9+cE6ZpGTVYriewRhClk1587eb3bShfTOyH
 ofI27AFr3WDD7I+V/OBO5icmwImxvqTBIqzt/8H02n010TvVrLGwNGl3goJelQ0Z/rG7
 qAXstekSGslcg4L39nADqzvHQNHJzM80fZU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31k3wj1bdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jun 2020 15:00:01 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Jun 2020 15:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3T1T/ZlALn7ymyGb+Q/n3s3jvOGEoocMb3hPRnsdMP9jPjjDKntPA+Yveeg/bU37neEzzasidY+McZ+Eux0A+wk+Vo1eOhta6R1olIh85vgGhJCuKd1VdV3689sJLJebOIA1+NIpiBT5pKbRuTeVnN6fwYkfrk78ycnYoX2hq52bigoDkZHlpiB6gmHTEqx3lgaO1YVt903nX0/SVf9sF14lYGlyZk10ImHN/J/1wwsGYqcQyD4jOUVbTStKpeelwDzwz2zaa3LtfK/HotqFNs3Ga7Y64379LcjgbZPdFsTuyUN3ocNzdofPyF8jXQwGpaOm8jyVHNMUBMj6133Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTgurXbjj/Sz+426K/l26OJasudHbFNjqbtIZIK06o=;
 b=fZy4vJ5I7zrNb/MkOaWLwY4rbjc02AI55fWL+4ypKJwGqCQ2kVKCx6iY5J94azUcp7FQH7yyJ01baQR7V1M4YXGaMOjQt4+pk8Qr89kz1t5QHOtMnqlM+znQY8rC5JUfyUIW9aUxRYF/+jaP9T6WjjZxTGeaoYZofFWC3cfVAS3/rNuemJa1qv4MW8wJquLo8GB8wX8gqtxUa5veo7+Id1H0BTUjyFNwe8ahDf/LucQh9ZWZleux0MNjhnfVLqj2XDVJOF2jQDS8pHqcLBoCnme2tyK4rKiMd0Ge2Gy+B5bDmGlmQZGTghMJ5NnMOWKMUFlIFobwUF95C/+yWtYx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTgurXbjj/Sz+426K/l26OJasudHbFNjqbtIZIK06o=;
 b=Ie6X6wu2/EZ8jszxfbo3EPSSQZvnwgn+y1xQcG165Es6opniusH8Beb4ZwobEN0dvoqY9jjBqhrUjYZTyK8iLGePxfEDnWq5soLOMHCYnZmDLx57oZOOdkSjLDuoL/vyHz/eMbeDjqLiAAhSQfx2QrcuGDDvIvCh9AwluqJAumQ=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2950.namprd15.prod.outlook.com (2603:10b6:a03:f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 21:59:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 21:59:59 +0000
Date:   Wed, 10 Jun 2020 14:59:55 -0700
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
Subject: Re: [PATCH 6/9] mm, slub: introduce static key for slub_debug()
Message-ID: <20200610215955.GA702969@carbon.DHCP.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-7-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-7-vbabka@suse.cz>
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5be9) by BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 21:59:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:5be9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6080eb26-df06-4a94-ccfa-08d80d899e28
X-MS-TrafficTypeDiagnostic: BYAPR15MB2950:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2950560058745712E176B0A9BE830@BYAPR15MB2950.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJFfNoAC5ETfxxVruh4s3EhC/4fwkCz/ZJT15dGNwN3nLAgktVYkn9WjBa1Ip0JZsgWRFbslJuhd6ptH81BORd9HGWeaXvPF4xGWMKvUO5AtfHKphlDPUnSsS4IuIFu+qETZzcIsJJ3vANxsXui52Xq6oXYpfCaWjnqLWLOdSiiLCyJ5GDHFc/c+l9vyhCg8GZkS4b0YVYxVcAWlIQg9U+NbpvE0e8/N3XUhBhHoot2Flq4J9H4xtAR2CXNKrVJPUqvu3NyIem2F/dfpaS8eJKGRmja1wKRfpKpkyYEpDkDYJ0W6YRUADh3/LZSrU6CrholUWx8JAmlpFa0P/u1Tcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(4326008)(9686003)(478600001)(186003)(316002)(2906002)(54906003)(8676002)(7416002)(7696005)(6916009)(55016002)(16526019)(8936002)(1076003)(66556008)(66476007)(86362001)(5660300002)(33656002)(6666004)(66946007)(83380400001)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CpScBxOYZY6m8CjHuc8ifyknpnakUQG42TKqTX3XBUjegbOnklm/9h+1sOB/FULEFtbJo3BL4ePBsR2ATVG85PgFL1A4zp1y46tP44BBVY5rbAgdbWgtHvV0XdXwQ6PA0J2dxR9BUiWcZ/KywkYXj3RtCMNAZeLH96/e0nHC4Z9QE0ACEL9Efed2iF661QQSTPwovD2veCFQ0v79OUNvkiPbzATqhYUPc4vFeoGZ3fsCP+H0M4r+gyhT0ziL8HUM5E0JWtGDgyxarsLxk+Wu9gsBfIhYh1MkXiLJY9hc1JHYa+vuq3QQdxJpVrw4NtSaVmFyiK1qpeCUCUwAVNeCEuuCmYMBZX/AQNtsO7/CnJPAK1OioTiihdBDXC+8Yt7eGQI5q3MjFIUj8SBHHzopZ27kxZOedspY1Pazs4YTbWVu6+SgtRxqyN0ByhTiqoy3itX6mQDoHrvuGDPoEmrUxe32PFvvE8rkeKUWlb7sf17kzpEjaJDCJofmmvWKNN3MZTfcR4fP/rAUaErtfLp+DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6080eb26-df06-4a94-ccfa-08d80d899e28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 21:59:59.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSl34w51XOqDiQzVX2YalxSrjrOQkquTbZs0C/T1uUTsh3m2dLyfhAtqAgaBEFO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=924
 cotscore=-2147483648 suspectscore=5 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:32PM +0200, Vlastimil Babka wrote:
> One advantage of CONFIG_SLUB_DEBUG is that a generic distro kernel can be built
> with the option enabled, but it's inactive until simply enabled on boot,
> without rebuilding the kernel. With a static key, we can further eliminate the
> overhead of checking whether a cache has a particular debug flag enabled if we
> know that there are no such caches (slub_debug was not enabled during boot). We
> use the same mechanism also for e.g.  page_owner, debug_pagealloc or kmemcg
> functionality.
> 
> This patch introduces the static key and makes the general check for per-cache
> debug flags kmem_cache_debug() use it. This benefits several call sites,
> including (slow path but still rather frequent) __slab_free(). The next patches
> will add more uses.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slub.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 8dd2925448ae..24d3e5f832aa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -114,13 +114,21 @@
>   * 			the fast path and disables lockless freelists.
>   */
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +#ifdef CONFIG_SLUB_DEBUG_ON
> +DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
> +#else
> +DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
> +#endif
> +#endif
> +
>  static inline int kmem_cache_debug(struct kmem_cache *s)
>  {
>  #ifdef CONFIG_SLUB_DEBUG
> -	return unlikely(s->flags & SLAB_DEBUG_FLAGS);
> -#else
> -	return 0;
> +	if (static_branch_unlikely(&slub_debug_enabled))
> +		return s->flags & SLAB_DEBUG_FLAGS;
>  #endif
> +	return 0;
>  }
>  
>  void *fixup_red_left(struct kmem_cache *s, void *p)
> @@ -1389,6 +1397,8 @@ static int __init setup_slub_debug(char *str)
>  		slub_debug_string = saved_str;
>  	}
>  out:
> +	if (slub_debug != 0 || slub_debug_string)
> +		static_branch_enable(&slub_debug_enabled);
>  	if ((static_branch_unlikely(&init_on_alloc) ||
>  	     static_branch_unlikely(&init_on_free)) &&
>  	    (slub_debug & SLAB_POISON))
> -- 
> 2.26.2
> 
