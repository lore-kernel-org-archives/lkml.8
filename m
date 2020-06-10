Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB45A2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o0BVr1Br";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eN/AYdI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFJWGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:06:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbgFJWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:06:43 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AM4hft002378;
        Wed, 10 Jun 2020 15:06:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xUhjTJ9DKIOAhoUeR2lQwjDAqZZGyoXLZetXIomrC5w=;
 b=o0BVr1BrIlUbZX2VX8ohaIAtQjRArd2Zn4tCuaEFMuJSOrF6WrDIKqBJDO8pVVi/3Me9
 DGNoeCV24AKVpoHsE+CDpO6Z4Dmsyp4jeMicqIdYdQ90LWMz3w8z+47ygbzMfhuMAjzy
 ljwVJyPDNQ7ow9JCypNW903jvBJAji2BjIg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31k33jhnq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jun 2020 15:06:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Jun 2020 15:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHqTS6OcJMr8mnsMC7FXYmsoGKj8iucZnsGMQlKpiaR7aO7RvHsPKsAQrp9FNOppWROowEABD81J4HCjccEjhyrGP9/8n5LDpa/QWN4JliF5SrbEd//gjMrWX1mmpKCtAaAmKwmU8CQPc/9Jy7tKCjaQgjms4qVdOXm2HZiIaugDs4fSLw0yfCj7R+8vZY0huhQJKgMG7KyG7A1DDD62r9/bG3wzt3el+qW7MqEQoUZEiLuQGJEWzbZd+eTUNE/YO50XkWTYBJ4jfI/U9QxZqiY260wjlZOCXdwpVvm2Iz+9rIpSq43bugsI9PTN0yCVnglEtTdbHnzsT8tx6ZHRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhjTJ9DKIOAhoUeR2lQwjDAqZZGyoXLZetXIomrC5w=;
 b=NTJanyp+mTJq7WA/32rhFW6/JRuwa9hsvP8nX5qF6fUYDrJJsuSHtpYGu20/5n3KXjXoy51D/aFEgaV32RkM5dRTAD7rfMJCdlag+xNEt9hskuwgZIPiQI7UdsDM1rWFUrKWlCPHvYI1gOTGV4XDZNVO0yYTkBvF4jAFXKg82hNMoKYrC5L+Z9l5N93+PyY3OUMqTd5M0jGZ49WDkes39KsP8uNvq5TJcTITTC2SfzcJpWLnuNquvEnC2SOyMxZFYur3JZ4TDzT/fwLqN5HLV2S+mS+B+DA6vatHCydbKmQdU/IWb2HmrrsmyMUaxxoO+qR3lhT2hMJz0NfbV3plYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhjTJ9DKIOAhoUeR2lQwjDAqZZGyoXLZetXIomrC5w=;
 b=eN/AYdI//+F/nFxLzu/E/6zvT0Bfz4xJumCg836PVRNKwNrTPXTv4z88MyuVBxiBXQj2ub/8kEbu0x+qcJTVSthOia1qVL7uDbKW1Zou+rzAnfMlmp9GmdQxPt6qpJ0t31gEe/uHv19vFULoc7qIcFDMa8/iWe0plvJioJaMP/Y=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3464.namprd15.prod.outlook.com (2603:10b6:a03:10a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 22:06:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 22:06:21 +0000
Date:   Wed, 10 Jun 2020 15:06:12 -0700
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
Message-ID: <20200610220612.GB702969@carbon.DHCP.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-8-vbabka@suse.cz>
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9e4e) by BYAPR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:e0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.13 via Frontend Transport; Wed, 10 Jun 2020 22:06:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:9e4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbde43e-6874-4bf0-69a9-08d80d8a8208
X-MS-TrafficTypeDiagnostic: BYAPR15MB3464:
X-Microsoft-Antispam-PRVS: <BYAPR15MB346455AFEB4B7165BF1D8575BE830@BYAPR15MB3464.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+iCvRxc3r4K5oqzig+0T9SouAYh7DGnUq5+/WqHPv6Vc/krT5IzO21Dm5OfUtfPVTWAg24zRnbTeAy+b1pDEMTUnV4Clg0mO4MiWudfaByofSeQ9dNq7N4M2hUjZpG7zdDKX1e5r7KotzufQ4dgTihUWy9eDmo/y1m9lT4+x/aoxqIjYDZOYf6PWDkuGXscHcMbGI54SrWkLNdvMfrFb2H3W8VvX+IcGq2ai/FtMK6esAypFmiVip+90r4khxSV17mh7ZagVLfaD/ARMqhiji2EIWJ/z5xSyNwj2gh2LWDwNAX53miKQMlEZ3Qnxdtj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(136003)(366004)(39860400002)(478600001)(33656002)(52116002)(54906003)(316002)(6506007)(8936002)(6916009)(9686003)(8676002)(7696005)(55016002)(66946007)(83380400001)(2906002)(7416002)(1076003)(66476007)(6666004)(86362001)(66556008)(186003)(5660300002)(16526019)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EBKmq+sqfujvQ3cN2Nvlmhc8AnsS1t3fqiDdtTJMeqB0PV56mnHa1TDMLokSLdJA2QFh2w2k0PuIEbu1qpuKr6PIKdr5Ku4t8ZpXF8G6RTojP6R5UdC2eo1wSwXfhIJ7HQe/unuYA1VHpfDXEZBUmf4IX+hA8NxbppPYwKYiFYFz1LaaMLt96vE0t/DXqeWbA1//lVUQLq8qrrC7bBGzIw2fh7z9Muewfl2SgjGBCi4HPrTDMq8eFZw539AynUW0bRRaaa0+xOTF43uajQGnjGJ6iKDlkPbG6besjw9SkEK5uw8Sn+IM6c3huzEy5qQtkZmclreMh5MrUBbJFfA6XVen3yS325NtDdietd+3rNXP5KvfafuwEKNDNpeyUh3o1T+uIRARbWzpnIQSzP8I+LrDo2hakrkidPYXgR/Q+tCNXMUQx9FsSnaQYsY1SSIZkcrY8Eh1F0BD/hPf1ppXpWF1NQ/9i74+eKYhwHJpa756aOROCVC90mdWH9flxvCWXKrIutyZQ88z7GSY7kpWGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbde43e-6874-4bf0-69a9-08d80d8a8208
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 22:06:21.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sws8+FmLaycrCq05JblyiTqf5llEVtMVD18uiCXOcYqs4ZUpAIXKi3OUMUJMvEx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:33PM +0200, Vlastimil Babka wrote:
> There are few places that call kmem_cache_debug(s) (which tests if any of debug
> flags are enabled for a cache) immediatelly followed by a test for a specific
> flag. The compiler can probably eliminate the extra check, but we can make the
> code nicer by introducing kmem_cache_debug_flags() that works like
> kmem_cache_debug() (including the static key check) but tests for specifig
> flag(s). The next patches will add more users.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Acked-by: Roman Gushchin <guro@fb.com>

One small nit below.

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 24d3e5f832aa..c8e8b4ae2451 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -122,18 +122,28 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif
>  
> -static inline int kmem_cache_debug(struct kmem_cache *s)
> +/*
> + * Returns true if any of the specified slub_debug flags is enabled for the
> + * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> + * the static key.

Maybe adding VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS)) to make sure the flags
argument is valid?

> + */
> +static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
>  {
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (static_branch_unlikely(&slub_debug_enabled))
> -		return s->flags & SLAB_DEBUG_FLAGS;
> +		return s->flags & flags;
>  #endif
>  	return 0;
>  }
>  
> +static inline int kmem_cache_debug(struct kmem_cache *s)
> +{
> +	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> +}
> +
>  void *fixup_red_left(struct kmem_cache *s, void *p)
>  {
> -	if (kmem_cache_debug(s) && s->flags & SLAB_RED_ZONE)
> +	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
>  		p += s->red_left_pad;
>  
>  	return p;
> @@ -4076,7 +4086,7 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>  	offset = (ptr - page_address(page)) % s->size;
>  
>  	/* Adjust for redzone and reject if within the redzone. */
> -	if (kmem_cache_debug(s) && s->flags & SLAB_RED_ZONE) {
> +	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
>  		if (offset < s->red_left_pad)
>  			usercopy_abort("SLUB object in left red zone",
>  				       s->name, to_user, offset, n);
> -- 
> 2.26.2
> 
