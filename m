Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE09C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0449F2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YE7VuCje";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VgWaQpT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgFESRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:17:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgFESRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:17:15 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 055IFd13018282;
        Fri, 5 Jun 2020 11:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=f0jzzFVVNt+7C0ldI/qs4IyZKRiSKSyZ2HOlER8zkIU=;
 b=YE7VuCjehijd4JDghquua6uOuAk4I1E8pY8T+7m6onbWXY0fkQXn9Dpxr+htntwO/HPv
 DcBnkwo/wVpDeHLwBXm+2tPXkBJLNGjouJG/uv9pI2dkd6pMxDkJm3szP2VT1POpOMQ7
 ohnbNz7H3s5utBlCF+o3GNYsCiUlhGDZkFw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31f913mpdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 11:17:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 11:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARYSCDdG2OfdImx2UL+phm5wpw97tTbTwQwD68zwdV4/0lI8z83aQEyAYmwvxT6Z3p/jMMdr1cVbegsN4IAWJtAo9gQqAntShT53f5sVWZU18XRty1on7ivpNZQhOLnCtwK8YztTunO0FT9o29l+6e4oK51T8TLkqtD+tGmqlAAOp+r9ymIbvyUoiAGP9+O66fMudCfls78w3f5IysFRhl/OSAWFeKV0Js6pXNx20v3PTPPblI4FtpfBdnr8eIpDGwxEB11DB/gEoFeKCoQRFkSBSUsUJ1/Lh2bfj1CdTnX0cjQlVepFiK0s117jm9AmWFAcmpRkgphsaFqbG3Cocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0jzzFVVNt+7C0ldI/qs4IyZKRiSKSyZ2HOlER8zkIU=;
 b=VCZbpRkKqdBewSH/DxIRIxBfaa8KKITwZU9kB3YADoE3wA3HiyAxm6B1YqSDZRhF/Xu7n4B+dO/Ko77uzw3ZDMtCgVdvFof6Srqy9KV7N5k1qPOmajHBHztuX4grCjvgwtK8pqreRyYkLVfI4lyW6gFQFmRnClYzspccMwfvcyGQhoHf5Pv/Gf3bULr6weleAhspHyk+nnoVuSyW3tYn7Oj98zaKiMIq7R04c5GCbufuzDmNRLdqPm6HmZU/bS+2GZ6oPCFUZYsKR8J8aoBhC3RfflxK6uC+Jhib1zsqasFjKa2H1xVrfQNqvMyQ6s8wnDA95U22S19mAiFU3WxVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0jzzFVVNt+7C0ldI/qs4IyZKRiSKSyZ2HOlER8zkIU=;
 b=VgWaQpT6h/9WWuyfSCYm7J7yMPt+P34LE9WdrrlOAsS7d3aEA3T1s5C+gXICd2KLUolkxohal2NhtQFXH6gJ9XS+VV1LiAv1LvNvLY7HLvMj89a1eRNE8pe0yd5a0bTEcJXGaJ0zW0f2xY48Da5O0iE3j26yHLeAUSh1MLM7700=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3109.namprd15.prod.outlook.com (2603:10b6:a03:ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Fri, 5 Jun
 2020 18:17:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 18:17:03 +0000
Date:   Fri, 5 Jun 2020 11:17:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200605181700.GB561977@carbon.DHCP.thefacebook.com>
References: <20200527223404.1008856-1-guro@fb.com>
 <20200527223404.1008856-18-guro@fb.com>
 <d7cdecbc-db24-8ced-1a86-6f4534613763@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cdecbc-db24-8ced-1a86-6f4534613763@suse.cz>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:66af) by BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 18:17:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:66af]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94933642-abcf-473e-d39a-08d8097ca581
X-MS-TrafficTypeDiagnostic: BYAPR15MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3109BA95B47863CF5205276CBE860@BYAPR15MB3109.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usXHQARLGPnbcofGJ/uiqimxiAyG2E/TnisX7j+kITGyEeFYLV5vt13e9FDUgYwqCaM/Vlj8COpeD9ZTi7SeF4k45ZMY4uay4DFcB9AiUNFdiWZO5Xy9fOL51IQcIC1TKCj0jiPqPBQpFjKL3SNQIARyKQEvpVUTW2nKhbOoENXLbwEEgG5GjrRZXp86WE9KoP5IwYhCZnvmbhWl4kj+YI5i7ohNTj35zqwAdrPAOENyG1LRBc07e3/ifZTwxm1Se3YFfx2IvO27TAqW6ak8SoO8caeIJCsdFnSRwMY/uSb/dVtccqi7zDMkxR+DKB6t+SpmfRZae7wpV05CEfZtbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(86362001)(66476007)(66946007)(66556008)(16526019)(53546011)(316002)(54906003)(478600001)(55016002)(9686003)(6916009)(5660300002)(6506007)(4326008)(2906002)(186003)(8936002)(52116002)(33656002)(7696005)(8676002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +z8RbeTxATXOj7EEt1ldjSjdtIXaEmVpi0i6X9cSbt4nslTxNV3PfFTVqFuIqwPdk6Gak91JgMOSqbekcUGAWJ9BOCWg4uvZHRdsQtHDKj+pQmrdruIeKg33Tz4njfBoDtek1LNevnSAsyKKFjs6sjLKecxgneQ30eh9eglMW5jCDc0vJblnZ3p9otAFwGU0p8HKB5LowVVvvDdfM4UbSTp60BdzEyIDCmL4eQkWvax/gNk1/mZ/TBvpbCAbX/RK0Rc6UXynICKB/bY586NMZWr+D+fcykP2znBeAsZWB/4quxvR39bPOWNyvHhiL12GC1r4WSr2hkkRgqVT4nNiCifF3P0jpEx2lDeJJFIYSI7P1jcAI7ycWkmzHWMMgQ3RMVrvHrYNo0i5iZAag0ecBiGtQk6ZSkkPaQnJHcWFwE1RZaP8r4zec93iduYBmsQjp46EoIw+//zcl4YKjFD0D32s+Pg22l6yXBnpDY+N93pCFO3B9zi3TFwAuAdTPHZbEuWbX1icm6Wx7ZaSQg2zfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94933642-abcf-473e-d39a-08d8097ca581
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 18:17:03.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZFuaPHge4uNbICoYKwz7X4RfXIL5M6VrAz5q9e8Rq+A2DEYkxMAHaozE+D+gFbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3109
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_05:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=1
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050136
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:24:33PM +0200, Vlastimil Babka wrote:
> On 5/28/20 12:34 AM, Roman Gushchin wrote:
> > diff --git a/mm/slab.h b/mm/slab.h
> > index c49a863adb63..57b425d623e5 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> ...
> > @@ -526,8 +430,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >  	 * When kmemcg is not being used, both assignments should return the
> >  	 * same value. but we don't want to pay the assignment price in that
> >  	 * case. If it is not compiled in, the compiler should be smart enough
> > -	 * to not do even the assignment. In that case, slab_equal_or_root
> > -	 * will also be a constant.
> > +	 * to not do even the assignment.
> >  	 */
> >  	if (!memcg_kmem_enabled() &&
> 
> Just realized that this test can go away - we don't have to call virt_to_cache()
> due to kmemcg if there is just a single cache.

Good point, will remove it in v6.

Thanks!

> 
> >  	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> > @@ -535,7 +438,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >  		return s;
> >  
> >  	cachep = virt_to_cache(x);
> > -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> > +	WARN_ONCE(cachep && cachep != s,
> >  		  "%s: Wrong slab cache. %s but object is from %s\n",
> >  		  __func__, s->name, cachep->name);
> >  	return cachep;
> 
