Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7565C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF422073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WAFphRNH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ABhO7WVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFKUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:04:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgFKUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:04:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05BK2OVT015786;
        Thu, 11 Jun 2020 13:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qEuCe+RY1CgEKGZcnwjXujcVZQ2UsDU4E13oxeYM4k0=;
 b=WAFphRNH3wgtuiYWcxFbhjpUdDz200/fBNieCxkCDChfd/7RN6y6SQ0MXWzNST+jrYiX
 FTj/c07pdEasQ80n1SpNgEORVt2ia/1xONd+elic8IMqlFbOIWLBW1nrx2X/1g7UEJe/
 rff75kzPFjmsMnGObjkmX5GekPKxfbXGDns= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31k8wxd1nx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Jun 2020 13:04:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 11 Jun 2020 13:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmKyb2b7aJw00gqB1g0B2Gx6yjh5L0uJuZd0ciBb2rCgNWUE7Y5cJ3NIIAcqVzrn+C20Qh3PlMC5RZMLEW2E2P/4BdVmVeRY0iV3zrd5XYDPBMHqHB8XBXvATTQga1/O3iNX0qvdS06Fm34OO+uW5LcnJ7SR8BQ3iXnufDDThr2MQOu25uITrfNIxvMexGCHKre3H39QXXbj1qrAyLY7G9/PJM+aUsL2WS27YPPGdYlkdavii+a6AASb2EPSa8H8coQ2hdoZXlzRL+8l/9kPO8fNKCekc50+Sspio9Ue3zt8azE2P5vc9pwTpRpO1AieQZCv4G3+D16TFbWokoTfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEuCe+RY1CgEKGZcnwjXujcVZQ2UsDU4E13oxeYM4k0=;
 b=X0POl92r6ubyImE6X4QULCTDjL/AdajIuRlneHKldqySqn3Scd9epSXpVxWkL91KmTzTZnpFscjA35XOkrOwBUtpocKZncDc7eRoeBxJALx5XSBA9dpO32wIiExnHfeTJNZ95xA+F8OjiWXzDCrZWerM6UyG9EUKjf9a5M2RJ2dkEGm2Z3dSQDtUE+Ibi4zX7DeVFPGdDdIYvU6Vp4TaRJZDJOrf0kcThWInxPz2FqOBOT8Wx+Yh82I3mXLo5NkHsFzeqkBGWICDyIj/85X8SHxUQvkvfwwtv3Qu2i+7QgPaY9GYdok8+oRusRDZPgb5g22NmFCKcNsjW8cCPUKBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEuCe+RY1CgEKGZcnwjXujcVZQ2UsDU4E13oxeYM4k0=;
 b=ABhO7WVdgbmOZqzF+0mR1K4/usG6RyCRaeHYrgcjSE6hjPbqpsXDxG+rLH+i5iqYlVp4cabdJJzwQHRBuHsqtwdCc9iTFlBgHHZKcx03LfKuZTcFN8wF/SJSyUimBVdJbECG0YwbY7dVQ6rniPstN9fVcOpreKKtKAZSqZNd894=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3125.namprd15.prod.outlook.com (2603:10b6:a03:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 20:04:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 20:04:17 +0000
Date:   Thu, 11 Jun 2020 13:04:14 -0700
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
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <20200611200414.GA711074@carbon.DHCP.thefacebook.com>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
 <20200610224611.GD702969@carbon.DHCP.thefacebook.com>
 <8ed46959-dcbd-041b-5c1c-172d5dce1eb0@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed46959-dcbd-041b-5c1c-172d5dce1eb0@suse.cz>
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5bc9) by BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 20:04:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:5bc9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50597888-d0d2-488a-b8f4-08d80e429f51
X-MS-TrafficTypeDiagnostic: BYAPR15MB3125:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3125F49A7045C9BA8A5A9105BE800@BYAPR15MB3125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYxU/szQXV95/uFVxEZWkxsaACM3HpOGGzqmxhMyriahtrGYY+B/MermFr8hSFf0s3AxZkktlnCil15m1D9KjAvq6tuF/lG7LaEaHW0nRWt+jkf2An16PYKkZ2vm+SL5ey/K4wuJwR7aXcReYIJv4ggusK9Qi6T9/2CaH1mG75XCkz55Ubxu3PCqjuw4OeECbz0kHBP+cjETV+xl/73NCXHKPe4OpDonWOjVNoC5iJR+pqZfJ7Z84mzWf3yxu+ShYOLh88FzugteRj9UoZz/2yYlArAxh1akHYcPHUKES2I7B+MkdITte0avEUcW0qk1kr/Tbaah3k7ofjVu81XhJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(186003)(7416002)(66946007)(66476007)(7696005)(66556008)(16526019)(52116002)(53546011)(2906002)(4326008)(6666004)(1076003)(5660300002)(54906003)(316002)(55016002)(8676002)(86362001)(6506007)(6916009)(9686003)(8936002)(478600001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KiFvuoR309llq4tUjeC27Rk9dklmVm/+mdnEbsldkY8l5Z6/8mON7etSTxatJDPCu7BIDevaikwcJqEvt0ZV59YabOjqyv3HxkkZQArRbxdmQIZzXjfb/8aVb7WBUkbFFHV8B5RulCofpQXoYVB63/rlHahE4iYsJeUgEREgR3mq88FD+w/b6jBC2C2rrqJKJs7e93y0km2yjeOCfplJ0d3B3xza+lxCjqJqTygdsXXLEHgO1/SD4sJAka/jKOpAj1qMKmrk5KspAumsT/oe/d4IaPCxFrC9U4AB05KB/xoUHvgbp78ik3O03UbXPw7rG+33wT9CIFuzO+qzK1/yzS830C564iGKlZdAT9nc0ZvPMd62ZFwW+KVQCqEh7UjyYqhcngMaViqKIvrUgsVQYi2uF+aVz6ycNCQFPd/GP/1yJ4WxzpN4QOrgD34t9V2UZb+SvRfU0LfX6mnUJMkzAK4pzqHnD/qsEwvXrSaKLQ6xuAZB/qRoUc9iIgppy487gG1L+z2tWIdFivx0rTY8xA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50597888-d0d2-488a-b8f4-08d80e429f51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 20:04:17.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e1FuivMkAPpPTXgjE1zPpEJKY4lUB2FgWSrabuUWvNO+FfwoZEIN4HexHw/57N9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3125
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_20:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 cotscore=-2147483648 suspectscore=5 priorityscore=1501 clxscore=1015
 phishscore=0 mlxlogscore=890 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110156
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:56:53AM +0200, Vlastimil Babka wrote:
> On 6/11/20 12:46 AM, Roman Gushchin wrote:
> > On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
> >> @@ -3672,6 +3672,14 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
> >>  }
> >>  EXPORT_SYMBOL(__kmalloc_track_caller);
> >>  
> >> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >> +{
> >> +	if (memcg_kmem_enabled())
> >> +		return virt_to_cache(x);
> >> +	else
> >> +		return s;
> >> +}
> > 
> > Hm, it looks like all the SLAB version doesn't perform any sanity checks anymore.
> > Is it intended?
> 
> Yes, it was the same before commit b9ce5ef49f00. The commit could have been more
> precise - kmemcg needs virt_to_cache(), but not the sanity check. The SLUB
> version also shouldn't really be doing the sanity check if only
> memcg_kmem_enabled() is true (and not the debugging/hardening), but the code
> then looks ugly and I hope this will just fix itself with your kmemcg slab rework.

Got it.

> 
> > Also, Is it ever possible that s != virt_to_cache(x) if there are no bugs?
> 
> Well, only in the kmemcg case it should be possible.
> 
> > kmem_cache_free_bulk() in slab.c does contain the following:
> > 	if (!orig_s) /* called via kfree_bulk */
> > 		s = virt_to_cache(objp);
> > 	else
> > 		s = cache_from_obj(orig_s, objp);
> > which looks a bit strange with the version above.
> 
> Looks fine to me. If we are called with non-NULL s, and kmemcg is not enabled,
> we can just trust s. If we are called with NULL s (via kfree_bulk()) we need to
> get cache from the object, even if kmemcg is not enabled, so we do
> virt_to_cache() unconditionally.
> Once your series is fully accepted, we can remove SLAB's cache_from_obj() and
> the whole 'else' part in the hunk above. Or am I missing something?

Right. I guess there will be even more cleanups possible, let's see where we'll end up.
It looks like nothing prevents it from being queued for 5.9 after 5.8-rc1 will be out,
right?

> 
> 
> >> @@ -3175,6 +3179,23 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
> >>  }
> >>  #endif
> >>  
> >> +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >> +{
> >> +	struct kmem_cache *cachep;
> >> +
> >> +	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> >> +	    !memcg_kmem_enabled() &&
> >> +	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> >> +		return s;
> >> +
> >> +	cachep = virt_to_cache(x);
> >> +	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> >> +		  "%s: Wrong slab cache. %s but object is from %s\n",
> >> +		  __func__, s->name, cachep->name))
> >> +		print_tracking(cachep, x);
> >> +	return cachep;
> >> +}
> > 
> > Maybe we can define a trivial SLAB version of kmem_cache_debug_flags()
> > and keep a single version of cache_from_obj()?
> 
> I think the result would be more obfuscated than just making it plain that SLAB
> doesn't have those SLUB features. And I still hope SLAB's version will go away
> completely. If your series is accepted first, then this patch based in that will
> not introduce slab.c cache_from_obj() at all.

Ok, makes sense to me.

Thank you!
