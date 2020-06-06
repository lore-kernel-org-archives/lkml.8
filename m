Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99080C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF3D206FA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rD8H32Yc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VTiU+yxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgFFAdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:33:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgFFAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:33:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0560VjEA017841;
        Fri, 5 Jun 2020 17:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=j71NAYaZc3wazEdYmWXXOxZSbxyEwEB46vojGRMx7d8=;
 b=rD8H32YcmpvD7tUaKI39Xgp9UMXuZC+QjplJvzCTYLqz/58QXppzm1rrnGpGp7SNHMFr
 rEVFKI8qzjgwjph8ky5RLDNbWgn8R0oFH8jw9svmo6Jro8KJmDtaCbNhbWanuQprBx3z
 yHUTKKv4XJLwqDWEENEJoP3mwKn+aMsS8m0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31f90ue5wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 17:33:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 17:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do1PLJsPAWYvWAyx6EnmM6eDJvnS6qdkOoXSHhxV/ny+EFy8R7kAOjvIomjXdoPGWoePa0qZr1zoFb2iI9ogf9aTvVXUAzu25sTf8sN33VkJfYL6HVZ0ik6/54Rz1KT6+S+Z8+8uEoG23PQnybfaAdhsIziYdPBur81f0dxkH1bFo0PylVd9bLMOrQslEeWJMoDhU5HxgwkAciLgJ5dVYzZ3xHNWTEljwF1AK3cBzUGstwBRBFuQMIU7CJO7+a3ziAyapgb0EOSXKNWRMLdWs8Xcmj+/T47lnL8f64as4kAeHeAbKTARE9QMxsZ3MY3hpYyAVF9v04Kqdg2eUFb8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j71NAYaZc3wazEdYmWXXOxZSbxyEwEB46vojGRMx7d8=;
 b=KaLT6TTDDq1E01dPVy51eKoc35OSrb+b65l9yHBuYCv76oMf3xmORYMC41IOV9GDEVF9fO/HWUWTuvE0eAbBTc5HqC7FTnVtaMs6ZArKdIGsAKR6ZjI9o0DQvUlEyoai/K928jsCtadPJ3HbL8hY+Yj2XsBYaQjL0GFqfCi5iJBtm5L7GPlnpZCMaMaDNwgw1qeyYffmdX2dAta0A5NskOPOa1LavIPLC9nqKDKmNJ9g1MCwVc8W12yj3E9gZ1603NKljZkFnpWV2o9zf0ElApRyAiwSq76gjVwtAaWJQs8OtQwbX+tOsKOwOnPNGHjRccGTk0zaJDBbaGj13XeuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j71NAYaZc3wazEdYmWXXOxZSbxyEwEB46vojGRMx7d8=;
 b=VTiU+yxWbU3ZBmmJuvEoSB8thWcuWIdF/J/z1HNwqkjg4Bi+jJPWisKCFm0WD47egoBQpbJMFUOS+kEsbL9VxkYZ6Gq3lvuhkMVkvfrh4A615ppjZINx4147kVXFJqCsxLfU44iuQvYWLe4gkI4V2oIBwO+tnq2P1PDDjm2dne8=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3333.namprd15.prod.outlook.com (2603:10b6:a03:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Sat, 6 Jun
 2020 00:33:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Sat, 6 Jun 2020
 00:33:02 +0000
Date:   Fri, 5 Jun 2020 17:32:59 -0700
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
Subject: Re: [RFC PATCH 3/5] mm, slub: remove runtime allocation order changes
Message-ID: <20200606003259.GF561977@carbon.DHCP.thefacebook.com>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-4-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-4-vbabka@suse.cz>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9cf1) by BY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:a03:1b8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 00:33:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:9cf1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2db9a01-2689-4f74-7a08-08d809b12bc0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3333:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3333B8F7F96ECBBB8F9EDE15BE870@BYAPR15MB3333.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgH8KoLD5RuNRLFhiBuyg5SFrpeOSZscE1yq78F2p+vCDAdcSSI17YosYeVPkKBgp56sMtS7iqCuiAwscUSGTYWdg9YdrTNRQibsuyJQYfcroSrjQe8KK+4JJK6JLAERwuCEi/JYUDR6QmjIpYofYSuiMSdsTr/qYr02q4gnfE7cOKDzmsF/YfIyD2SLQZ6P36AKzTOozBqfxWnXu4f84pqrjJrIJqkEM5zbIj13b+D9H3XHPP22eS/ut9HynG/M3DgQZJN82ON/MBjGYSo5F9RtGUazywK/za95FFbrjbWfQ/o29jeav/l+5MlTHIuI5nSfSv27R94h27IJAaEsmXMF7JwyTmWcHWY/D1fgpxHnhawRvKkwtegIOLBRfdGguolKk3y1JxLtm/PPsyrjWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(2906002)(54906003)(186003)(1076003)(966005)(16526019)(86362001)(66946007)(316002)(7696005)(9686003)(33656002)(8676002)(478600001)(66476007)(66556008)(6506007)(5660300002)(6916009)(83380400001)(55016002)(4326008)(8936002)(52116002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: a6CktL0IdxtFE0dTX8qLyxtfeh8fCc9choTVkY7aNIMeGgQZiT+t6iME6Nulem3RAVZ0Dy0N3wtsSERgTKQ1m+P1IEWs2rPf5aU1G2gBonD87YLKliLRp0nf4lyw7akp9ArNTiXWLnoGJclrFO01t92tiBeCYQ42kIvq2RBolwkevZpQ6zq7j25azdzXTdgVTyZPswAT2damMySGAMcxhCny1f9/PAEXIJueClx804AHhOjZJp5j26TGm9fPB+oQbGvzyZxVLXNHDPQA9HfQvrqLe6WvaZFOt+VVkqcYY9wkuNbJwzj3w2Jo+lepq6AECihRZOuo+zjcUVHoL8rk2/LOdh1GEqVgUtJRAHHZRDNu8IcqyHy7xUo9mDmQ11irprrkzG5bxsTz470EtmojCt7/Fro+o/5+wPOJ2NMUjILjmXvMg1RdhirVWdlYELkSkLKaSpSmD2WyyctDe+RSv4NHXyZoViAqZ1RF8hfiicIONtZ5nNjFpc9kUtV481jdVa3DpbDroyhm38CaJ0th5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db9a01-2689-4f74-7a08-08d809b12bc0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 00:33:02.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXyykexrol2HvrrEE4KsTJ2GWIfSrhxK/gD51ZRzC8ipx4e865MWJUBvFxOOTTPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3333
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 lowpriorityscore=0 cotscore=-2147483648 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006060001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:17PM +0200, Vlastimil Babka wrote:
> SLUB allows runtime changing of page allocation order by writing into the
> /sys/kernel/slab/<cache>/order file. Jann has reported [1] that this interface
> allows the order to be set too small, leading to crashes.
> 
> While it's possible to fix the immediate issue, closer inspection reveals
> potential races. Storing the new order calls calculate_sizes() which
> non-atomically updates a lot of kmem_cache fields while the cache is still in
> use. Unexpected behavior might occur even if the fields are set to the same
> value as they were.
> 
> This could be fixed by splitting out the part of calculate_sizes() that depends
> on forced_order, so that we only update kmem_cache.oo field. This could still
> race with init_cache_random_seq(), shuffle_freelist(), allocate_slab(). Perhaps
> it's possible to audit and e.g. add some READ_ONCE/WRITE_ONCE accesses, it
> might be easier just to remove the runtime order changes, which is what this
> patch does. If there are valid usecases for per-cache order setting, we could
> e.g. extend the boot parameters to do that.
> 
> [1] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slub.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ac198202dbb0..58c1e9e7b3b3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5111,28 +5111,11 @@ static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
>  }
>  SLAB_ATTR_RO(objs_per_slab);
>  
> -static ssize_t order_store(struct kmem_cache *s,
> -				const char *buf, size_t length)
> -{
> -	unsigned int order;
> -	int err;
> -
> -	err = kstrtouint(buf, 10, &order);
> -	if (err)
> -		return err;
> -
> -	if (order > slub_max_order || order < slub_min_order)
> -		return -EINVAL;
> -
> -	calculate_sizes(s, order);
> -	return length;
> -}
> -
>  static ssize_t order_show(struct kmem_cache *s, char *buf)
>  {
>  	return sprintf(buf, "%u\n", oo_order(s->oo));
>  }
> -SLAB_ATTR(order);
> +SLAB_ATTR_RO(order);
>  
>  static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
>  {
> -- 
> 2.26.2
> 
> 
