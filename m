Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18727C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D837C2076D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FshpCzfy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HrX60xDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFFAcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:32:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38324 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgFFAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:32:54 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0560TVU5001878;
        Fri, 5 Jun 2020 17:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QBI6Eftf8Uhf6fRsGblGDrRBtvUQ6kEi7ZzAp+yvQKE=;
 b=FshpCzfygexsEgdJuftqkOGRHZ+9pjVUqXfbFI1Md38wEinfQczE/niu+hdHdxPzj94u
 T3dU7cXmyJZJXApxSOKaAMOazdCzIZj9ArRlRgmn0zI9JgCPVoJ/okXkWur/dRxS5vaF
 TxEEy4hQfDG95KutmfUheVtkFqAcZrUosPg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31f903659w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 17:32:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 17:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btjqqln/C9cbADw5mc//89R2fD0dUy/zPsrBmzrE5OHgEJwngwiFzpAGQlKMLgls4BcODUhZAGsCaGV/BKG61qSpZvoC368OsrQwqehL7FTQQc4rqVVkN4bd1ytVboSdCMAUG9O7GGyj2f2u3e9mMhWGiW1kExlHBYnhaAiGi7r2GGUCwdelqCIoIDuTLazUoFFqkpqaRYugHfd7l5K1fAwt7FkY8VeeVpPiQNSNImgK5z9LKCA8YYmJ57lvLjvv3hybHa8T2xwoHemajol2HmmSX0tKJnWqALwPBqNaqlQglEqg8I81bOLoNt+3dKTOf2nx9SIq8vSD6s9Kop14mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBI6Eftf8Uhf6fRsGblGDrRBtvUQ6kEi7ZzAp+yvQKE=;
 b=mo6so8n2/Fpw3toEIcf5YXn5ZH4btAvXO8CPbICumydrEBakO3wrDN1RHIyYzoslJ6FwdPBzuYOnRBDay42Gs/FLuc498XeRYJyaVgofYP/JkHjEnTNno9xPxSST+AiKF4RMJR8yYBvitLd1l2AE/8ZOxAdtU/c2aBq6Fmt0irHVFjl+8nxQRXDJcA2Tnazk45OLrPIXRSyOqn7b0UUl90VutVPB6QdqlOFfwtoCZK2PurryVgW0tyE7Ms8bLloHX3SpyPDvgkCgjgeb3j9IrZSOZLMVBR7RIVECVXoRQUvR3p9sQ38Te2GGlngPnp4TNEIu4JLBwn4DzNTSnQDHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBI6Eftf8Uhf6fRsGblGDrRBtvUQ6kEi7ZzAp+yvQKE=;
 b=HrX60xDArddttYEuQ//HilCuIpjuUp/lYTLDI5gUnclDspDyx49VEF8j9/w5dIeb5nZPcXsVGzrAnIweBIIqPMQLjoqD0SVCCc9wWw2wbEYhphGc5ZJmF3LnM13Nn5D6VvaKtHjc1F8bHCAEF/vymq+14KNBqvPruUkicHd91j0=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Sat, 6 Jun
 2020 00:32:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Sat, 6 Jun 2020
 00:32:34 +0000
Date:   Fri, 5 Jun 2020 17:32:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 2/5] mm, slub: make some slub_debug related
 attributes read-only
Message-ID: <20200606003231.GE561977@carbon.DHCP.thefacebook.com>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-3-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-3-vbabka@suse.cz>
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9cf1) by BY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:a03:167::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 00:32:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:9cf1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c5ee66d-7374-4ac2-4dbd-08d809b11b06
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22140AA46C4EBCC7166C675DBE870@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EY3l/Juuqqj7V9OWftYgCulguEOHmUlPm+F3DE5q9rAmGtDCEeyh3NYpKNihjZwvCX6tbhbMz+WKHdsyLSahLewJusZZb4OSEpnG6YoJQCXgtnsoV9ptsYw4AA2VrWxbglfmvZxnO5k6OAe4RDq13quv0+WTha7cfYeN+DI7H5mYay/QmNfiYNm2HwXqAUKlZyvml6KmuCQFke+VZUs1vVOobFCEnDUiq7XIlj7GD+UACYOV3xaGsbXo7is0217dSayk44R+iad5bj2g6xlHc8OJEsOL9eYl+0og4e7q/l6CJXaWy/y6K9Mskfti0Y40F7ijjxJCd2ir6i/4t0k8tA/IkD8b3yhbVL+JMHF6tp5eLndOXLjnq4WYk73OeAeV5tIXMg15OxEdoYR/4DzIKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(52116002)(7696005)(54906003)(2906002)(33656002)(6506007)(83380400001)(9686003)(6916009)(1076003)(16526019)(5660300002)(966005)(186003)(478600001)(4326008)(55016002)(66476007)(66556008)(8936002)(7416002)(66946007)(86362001)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: q5CTNkzNeOTMz9/aM/8xM7aZIsRcaXKJzR/LxtUQMjZDPxFIwPZGdnSye9O2WTLGy9jDXZFbRz9pXobbR/3V3LYj7tu4ad0Q/dZq2oCj1hO65Bq/B7TZiVKdctu8iL3QgeD66PzJ5sX0/kTVSjSu4ONm3e8M0Lv4XmY20mJPXYN5/f1jp2hxwy8ot/kBTv+p0scdhqQ/G96KCfimFIFXR3qH3w61BN2I0is6KiyfCeeUdMWYdaRNc6UqCNiAL/ABf1iB9JGD6kdmtzUp3+pRtmvFmMW9VcmLSLDq1c3gho3PKuwVGQLe7Y/W2SdQbjVuwbEIL4R6Fq828x1mDEWrMWLICAp8Iw6Zj0OhCvkNpHDjfd6kVSyza3ZWzrSEaYsbT9D71Mm0qAY+La4YzqJLRyxymfPBEnjaFww8fz9pnxldBi5kx3DYjBP/q1Wb3u+RdoUCPDEGJaUtyvFjVvmiRs/QJf4o53BIiMWJLPKUH8dWOIejbSI65EcLyvIvJ5Lprk4FUxomj+5vcRjhZJ6Xjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5ee66d-7374-4ac2-4dbd-08d809b11b06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 00:32:34.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGRBn/hT7Setcdnmku6CUEEGVS08tv1EiM9yA6sIwSoDU7kYTgaOPwwlDGlmvGul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 cotscore=-2147483648 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006060001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:16PM +0200, Vlastimil Babka wrote:
> SLUB_DEBUG creates several files under /sys/kernel/slab/<cache>/ that can be
> read to check if the respective debugging options are enabled for given cache.
> The options can be also toggled at runtime by writing into the files. Some of
> those, namely red_zone, poison, and store_user can be toggled only when no
> objects yet exist in the cache.
> 
> Vijayanand reports [1] that there is a problem with freelist randomization if
> changing the debugging option's state results in different number of objects
> per page, and the random sequence cache needs thus needs to be recomputed.
> 
> However, another problem is that the check for "no objects yet exist in the
> cache" is racy, as noted by Jann [2] and fixing that would add overhead or
> otherwise complicate the allocation/freeing paths. Thus it would be much
> simpler just to remove the runtime toggling support. The documentation
> describes it's "In case you forgot to enable debugging on the kernel command
> line", but the neccessity of having no objects limits its usefulness anyway for
> many caches.
> 
> Vijayanand describes an use case [3] where debugging is enabled for all but
> zram caches for memory overhead reasons, and using the runtime toggles was the
> only way to achieve such configuration. After the previous patch it's now
> possible to do that directly from the kernel boot option, so we can remove the
> dangerous runtime toggles by making the /sys attribute files read-only.
> 
> While updating it, also improve the documentation of the debugging /sys files.
> 
> [1] https://lkml.kernel.org/r/1580379523-32272-1-git-send-email-vjitta@codeaurora.org
> [2] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
> [3] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org
> 
> Reported-by: Vijayanand Jitta <vjitta@codeaurora.org>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  Documentation/vm/slub.rst | 28 ++++++++++++++----------
>  mm/slub.c                 | 46 +++------------------------------------
>  2 files changed, 20 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index f1154f707e06..61805e984a0d 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -100,20 +100,26 @@ except some that are deemed too performance critical and don't need to be
>  
>  	slub_debug=FZ;-,zs_handle,zspage
>  
> -In case you forgot to enable debugging on the kernel command line: It is
> -possible to enable debugging manually when the kernel is up. Look at the
> -contents of::
> +The state of each debug option for a slab can be found in the respective files
> +under::
>  
>  	/sys/kernel/slab/<slab name>/
>  
> -Look at the writable files. Writing 1 to them will enable the
> -corresponding debug option. All options can be set on a slab that does
> -not contain objects. If the slab already contains objects then sanity checks
> -and tracing may only be enabled. The other options may cause the realignment
> -of objects.
> -
> -Careful with tracing: It may spew out lots of information and never stop if
> -used on the wrong slab.
> +If the file contains 1, the option is enabled, 0 means disabled. The debug
> +options from the ``slub_debug`` parameter translate to the following files::
> +
> +	F	sanity_checks
> +	Z	red_zone
> +	P	poison
> +	U	store_user
> +	T	trace
> +	A	failslab
> +
> +The sanity_checks, trace and failslab files are writable, so writing 1 or 0
> +will enable or disable the option at runtime. The writes to trace and failslab
> +may return -EINVAL if the cache is subject to slab merging. Careful with
> +tracing: It may spew out lots of information and never stop if used on the
> +wrong slab.
>  
>  Slab merging
>  ============
> diff --git a/mm/slub.c b/mm/slub.c
> index 47430aad9a65..ac198202dbb0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5351,61 +5351,21 @@ static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
>  }
>  
> -static ssize_t red_zone_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	if (any_slab_objects(s))
> -		return -EBUSY;
> -
> -	s->flags &= ~SLAB_RED_ZONE;
> -	if (buf[0] == '1') {
> -		s->flags |= SLAB_RED_ZONE;
> -	}
> -	calculate_sizes(s, -1);
> -	return length;
> -}
> -SLAB_ATTR(red_zone);
> +SLAB_ATTR_RO(red_zone);
>  
>  static ssize_t poison_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_POISON));
>  }
>  
> -static ssize_t poison_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	if (any_slab_objects(s))
> -		return -EBUSY;
> -
> -	s->flags &= ~SLAB_POISON;
> -	if (buf[0] == '1') {
> -		s->flags |= SLAB_POISON;
> -	}
> -	calculate_sizes(s, -1);
> -	return length;
> -}
> -SLAB_ATTR(poison);
> +SLAB_ATTR_RO(poison);
>  
>  static ssize_t store_user_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
>  }
>  
> -static ssize_t store_user_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	if (any_slab_objects(s))
> -		return -EBUSY;
> -
> -	s->flags &= ~SLAB_STORE_USER;
> -	if (buf[0] == '1') {
> -		s->flags &= ~__CMPXCHG_DOUBLE;
> -		s->flags |= SLAB_STORE_USER;
> -	}
> -	calculate_sizes(s, -1);
> -	return length;
> -}
> -SLAB_ATTR(store_user);
> +SLAB_ATTR_RO(store_user);
>  
>  static ssize_t validate_show(struct kmem_cache *s, char *buf)
>  {
> -- 
> 2.26.2
> 
> 
