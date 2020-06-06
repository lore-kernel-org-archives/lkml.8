Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF58AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A41D2076D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EloAZFWH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VU63ely5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgFFAeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:34:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgFFAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:34:00 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0560V9e4011079;
        Fri, 5 Jun 2020 17:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=s6jEXqJ+XQKvrW8RMaptCgkbnobEiItV+pZ/BJDO5E0=;
 b=EloAZFWHG/DRMCPsxpTeixmHpn5NkJowJR5KzeurGyD5EDsdtWdwCOK9joMEm1gh0Ktn
 X59OphJTY4pRnQGWz5eBam2dWZoUm3fMH5y8DIvZoV+ri/VOwaSLfX6vfYK4y/XZZ8l9
 WjHJaCVS9OvWJH4Xik5vYxeCA44yytmT4/o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31f90tp5jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 17:33:46 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 17:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLmmxgfWAfWttvOmQtpHVWKFXQnvqMm4vKKzeBYL7uUM61BuNzdaSZFYwLt4bL6rGPxJR8kkxMAg77yF6Q2/rLoOh8R5EWtjpkoG2VBHvfLESIsjMVbtFzRhmyMKEEz6U8j0zZgpJvV7oG8iNn+PXpCY462teHPagQ6qsnA/32aPG4PBZ5d4+8yOQeiy4TGwXF2G2R3zDd0BNPG6elgBOFQnq1/5tUJRlU8L6jj3szsYuROl/aIWmniaXFmXdBJZuG5e8EbURG32JHKHyktFdNXVN7Qe5sbzwwXYLT/M0q1nFAiIcZwy4hWOG0Uzl2aYV+eCMP+Po7PBAo0faFGH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6jEXqJ+XQKvrW8RMaptCgkbnobEiItV+pZ/BJDO5E0=;
 b=YqUwp2KA9DaFDnQH/d33NsL0snOjQaJ1W+eIE1Q8CoagTzGbjDENubs9p6En+3QOyOPIP+yx38JGafHq1LTUTsSFxehonvyfXy0OCBnn6561mbOwlZmsiL3Grq2g9iAJm7om2P047sJZrJITeZDOZTCQ10CQMMmZWthLzi/Sl0N4IgUxE38A2bXoFMMfaFekzsOOqcwiMSOY+gHVDi6TTCslwdjhBY4Y4QgO9CRbHTGVxZy9T/Ndf4tZioFPOvboybcGhngmH9aPMWzF1abcDHptyoFBuZYyiVnHmCTtmQ8qVXekNL5RDt332xQ2VdjVaSjPNBaDQUvQZsIVZ2VL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6jEXqJ+XQKvrW8RMaptCgkbnobEiItV+pZ/BJDO5E0=;
 b=VU63ely5/NmdD8nU2/fro3D8Dw9pgNOZEiG/gUu4jkYFZUNkz52PNhRX8ORscUiRyEOxJIO342UXwTJOuBdVgU8EKJqT+rjk1nnWqXPtwdsgVnHDoXS5PLM+v6mQU8tOzo4FHd6sGuNVao/ilW6k0WgyJ+Bdlj4Tm42ugATD8Lo=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Sat, 6 Jun
 2020 00:33:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Sat, 6 Jun 2020
 00:33:44 +0000
Date:   Fri, 5 Jun 2020 17:33:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        <vinmenon@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 4/5] mm, slub: make remaining slub_debug related
 attributes read-only
Message-ID: <20200606003341.GG561977@carbon.DHCP.thefacebook.com>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-5-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-5-vbabka@suse.cz>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9cf1) by BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 00:33:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:9cf1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2968c5a2-7f04-4dde-6d2e-08d809b144b5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2214F5C6ED2895DCD25CEA2ABE870@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJQ330pvTOydXZASYTixkIznwcxyXnNPUQrxyyXHGPE1ZpyhsrKgV4RTD8czcR1+SGPgGqnqR0dqjZgp/yBiOIoHsVH5Q8IsAdrCpFJGZfC5s8k4EDBy3J3ruq7SX5pO/eT8IcSQoJnab8OHm2pCqPuoNLgjnQad5JgiJBut5OmTxhcjwrJ5klIlmUCp6e564NpaNTmkIRjAqsAPCSghQmKLtfQOmGcXQIopmPUOFMxH1iZKpi462tL2hovktsjBmU99etfjzCBd+tIJZlTLxez9u63uKZs/ck3lJhvGwZBs2WW1oztxJ27IuX1r48LLYUukQZj8lqJiDX183qoWGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(52116002)(7696005)(54906003)(2906002)(33656002)(6506007)(83380400001)(9686003)(6916009)(1076003)(16526019)(5660300002)(186003)(478600001)(4326008)(55016002)(66476007)(66556008)(8936002)(7416002)(66946007)(86362001)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cAJaCriMK4rGqwq3myNZagI7VbTFURoWVIL+ztq4EVzZ3MDmhkdjXmlE/6te+RWitbL8H/J4xN0h30GAIKH6FOI+3/STeOH0DkpUNN/inqcMOGZyKpfqH6lx3QXGQ0syUH1s2p/x7k/j3U8ecp/x1cgZD9PSrFPKATVEGnra2+GtSLdepTwunNeyhau1jBI9CMIqVCyZnaqUg6YhmLBLWBSw2gK7xbj3duAyHaxP1HetBvLvIb34TVuoa+sUejKPLeIEoSegQlMbt6pdLFvH9ORqkWLu4RKZ7TvxzIxxCvkWwrLh0yVtkztpiXCSRvPLsEvZ5t07/wo83gdeHWm/DnkqeJN0PI5mfUe5qoZXJbPnISARstIg/UcpQpGvyXzdopP64YYC6j+GAZG6yc79EArwBfeEICv/AAXla8JcggX++QtjB8+TVUgyqpC/TFckDZVpnJtlSFXyn0HP31zrWzF2x5SSU3HBtbQNRZJeDsACy73foPAWVgYOLk6dLN2m98ivkUVPCOCAQOabRnkFcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2968c5a2-7f04-4dde-6d2e-08d809b144b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 00:33:44.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKU1+Lgr+vuvd8mjp2kgnz/jtWbgDbXY+xIk6jgGYXUWVStkZkIcKxre0GnV21kQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 adultscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006060001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:18PM +0200, Vlastimil Babka wrote:
> SLUB_DEBUG creates several files under /sys/kernel/slab/<cache>/ that can be
> read to check if the respective debugging options are enabled for given cache.
> Some options, namely sanity_checks, trace, and failslab can be also enabled and
> disabled at runtime by writing into the files.
> 
> The runtime toggling is racy. Some options disable __CMPXCHG_DOUBLE when
> enabled, which means that in case of concurrent allocations, some can still use
> __CMPXCHG_DOUBLE and some not, leading to potential corruption. The s->flags
> field is also not updated or checked atomically. The simplest solution is to
> remove the runtime toggling. The extended slub_debug boot parameter syntax
> introduced by earlier patch should allow to fine-tune the debugging
> configuration during boot with same granularity.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  Documentation/vm/slub.rst |  7 ++---
>  mm/slub.c                 | 62 ++-------------------------------------
>  2 files changed, 5 insertions(+), 64 deletions(-)
> 
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index 61805e984a0d..f240292589bd 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -115,11 +115,8 @@ If the file contains 1, the option is enabled, 0 means disabled. The debug
>  	T	trace
>  	A	failslab
>  
> -The sanity_checks, trace and failslab files are writable, so writing 1 or 0
> -will enable or disable the option at runtime. The writes to trace and failslab
> -may return -EINVAL if the cache is subject to slab merging. Careful with
> -tracing: It may spew out lots of information and never stop if used on the
> -wrong slab.
> +Careful with tracing: It may spew out lots of information and never stop if
> +used on the wrong slab.
>  
>  Slab merging
>  ============
> diff --git a/mm/slub.c b/mm/slub.c
> index 58c1e9e7b3b3..38dd6f3ebb04 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5056,20 +5056,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  	return x + sprintf(buf + x, "\n");
>  }
>  
> -#ifdef CONFIG_SLUB_DEBUG
> -static int any_slab_objects(struct kmem_cache *s)
> -{
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	for_each_kmem_cache_node(s, node, n)
> -		if (atomic_long_read(&n->total_objects))
> -			return 1;
> -
> -	return 0;
> -}
> -#endif
> -
>  #define to_slab_attr(n) container_of(n, struct slab_attribute, attr)
>  #define to_slab(n) container_of(n, struct kmem_cache, kobj)
>  
> @@ -5291,43 +5277,13 @@ static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
>  }
> -
> -static ssize_t sanity_checks_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	s->flags &= ~SLAB_CONSISTENCY_CHECKS;
> -	if (buf[0] == '1') {
> -		s->flags &= ~__CMPXCHG_DOUBLE;
> -		s->flags |= SLAB_CONSISTENCY_CHECKS;
> -	}
> -	return length;
> -}
> -SLAB_ATTR(sanity_checks);
> +SLAB_ATTR_RO(sanity_checks);
>  
>  static ssize_t trace_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TRACE));
>  }
> -
> -static ssize_t trace_store(struct kmem_cache *s, const char *buf,
> -							size_t length)
> -{
> -	/*
> -	 * Tracing a merged cache is going to give confusing results
> -	 * as well as cause other issues like converting a mergeable
> -	 * cache into an umergeable one.
> -	 */
> -	if (s->refcount > 1)
> -		return -EINVAL;
> -
> -	s->flags &= ~SLAB_TRACE;
> -	if (buf[0] == '1') {
> -		s->flags &= ~__CMPXCHG_DOUBLE;
> -		s->flags |= SLAB_TRACE;
> -	}
> -	return length;
> -}
> -SLAB_ATTR(trace);
> +SLAB_ATTR_RO(trace);
>  
>  static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
>  {
> @@ -5391,19 +5347,7 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
>  }
> -
> -static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
> -							size_t length)
> -{
> -	if (s->refcount > 1)
> -		return -EINVAL;
> -
> -	s->flags &= ~SLAB_FAILSLAB;
> -	if (buf[0] == '1')
> -		s->flags |= SLAB_FAILSLAB;
> -	return length;
> -}
> -SLAB_ATTR(failslab);
> +SLAB_ATTR_RO(failslab);
>  #endif
>  
>  static ssize_t shrink_show(struct kmem_cache *s, char *buf)
> -- 
> 2.26.2
> 
> 
