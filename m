Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF80C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF0820727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fkt++4ZN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VtWHcoVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEOUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:03:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41576 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:03:30 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FJxJsc024619;
        Fri, 15 May 2020 13:03:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PHjWCmIXEfKTOi1EcJEk7hwa1kkaBn1WQnMr1w+rHKI=;
 b=Fkt++4ZNrwQHnU3xJjQMRFDyxsN5JrAEt/NfJJ231RO4L1j9W+8OlPm+iYXyK4Ps5+qI
 lHTl33e3xls4ai7D/E02JbXRnvFfvDrQvSQafwCfvuOpuv5L3/XALAQNXQc8sgHYO11D
 MPiNCtFbVFASYXZLlm006tVi0iA4naBhCtE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3111r0t2b7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 13:03:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 13:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2ve4HFv/OCI9cWuSeJvnZzr0JXS/8CeDARmgilm5xsxURlucYI7THTypRksKBihuw1498rP1IzMxWt87iKnVhNuu2QOOejjEmD4phuYPZZuaYVeD5q6kUQQxWaLTK4CZW18RHjMTrVNAWWsRTwlflsvYybPX0n8Oc68MG2XCihSiqB9toYoTLnx+kNJDz0At95BzhlNrhWffsg09vKAC8pT9L8xl8H8OWZ0imVhJI8pJez1Za51epWLie1xUQk+MUuARzMxYv3zMtlG5lUmHle5OFCzLXANiTaROjedsJXptkla50E4aqobatk9QpBw+A8OChsKHyIzazwMGCJUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHjWCmIXEfKTOi1EcJEk7hwa1kkaBn1WQnMr1w+rHKI=;
 b=k61r6/vjx5wFE4rdGaI9ZIK8GIU8dosYUSXup+zxHmjxhIv5/+W1EygxAodbXzKjFb1VntjnloGCin+zZCpOC++B7lyoBWHm6spGUIUWmtN9sIkhYH3KCCp46fHsCgcHSskFFwpeYatqcJ1i2kFR1UrlrcxtrzIfIG/L5DocaMI2Ykd8Y4pyWVQUl1cEKSn4KqEZtA/KU03ABneEsBM4L8dv8yVo5okjsyHmsOfLFqYNg36PsMTse1yQh2IuhngekVRY9+kqFT8u3cfKKdlTcQYcVlz+WgjL0jNXO4e173YIb++0Yo+DAVirapg12H723tlTuMUcdfmQKOsmC8n79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHjWCmIXEfKTOi1EcJEk7hwa1kkaBn1WQnMr1w+rHKI=;
 b=VtWHcoVVSRgwu/j1IhgIAJTJeqpEVY010R1AKb3MjQRyJqOvoFuR1HiiRoo37i1aSd+8++EIj+2dKWAX8A+XEfdMcUeu9SxzeS4hsqYAffqhP38I8ooV0Q4mGFDlIbg47jfsFiWdB191reRIPW2idyaekCYkdRWdcy4tLmSzXGE=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3029.namprd15.prod.outlook.com (2603:10b6:a03:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 20:03:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 20:03:01 +0000
Date:   Fri, 15 May 2020 13:02:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200515200259.GA171296@carbon.dhcp.thefacebook.com>
References: <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
X-ClientProxiedBy: BYAPR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:a03:100::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b821) by BYAPR08CA0019.namprd08.prod.outlook.com (2603:10b6:a03:100::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 20:03:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:b821]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e230aa9-b394-450d-26c4-08d7f90af8d6
X-MS-TrafficTypeDiagnostic: BYAPR15MB3029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30295762EF971E664188A64ABEBD0@BYAPR15MB3029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NPHoTnB0MosHSGIPnJDHzcZvmTIdI4FOL6ByE1mOGwANJ/sB6P5WWd36WcC0dBOvIXc75cZqntdEPVE4+yzerkg7q4ijaC8OO+ENWRG6lSyTnAtGob5wcVWzuzfsUlFN69E2nHLQspS2Ts2ey+WF8+Uzk/EXe4A90Oj2IJOGAVeZ8rGipC23v7dtiQyuzHlOWRPj5WIMKavlU8jmVDxTtBx5XceXeZPfaUspEu+H7UYoXYm7U6Gk9NcBt2sOXlWoipzfzytuuSnvaYwcq+YqDyF6xvtC0k+bvG35JDQqDjd+LgVGlEQ2IST0UPtB7jYXa53RfjMLYRD5ECHmUiBgYCdq8jFl3c2SE+RyN6i+/fOabzc8y4uAtFqXWHLO7AYCd3578Zvc6CDoksNAijAMBkO6/IkbvrQou2B36go+VvDs9kGlXThrlF+5TAbs4p8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(54906003)(16526019)(55016002)(478600001)(8676002)(66556008)(316002)(5660300002)(33656002)(6916009)(66946007)(9686003)(4326008)(66476007)(1076003)(86362001)(186003)(2906002)(7696005)(8936002)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JgGsmlIpuJ8uqoTs70qSGSva4Fnxt93SF67p0yoKgniR374ijtrk+fvZrObTijrgBLGSFXVf1PADiXvgHD0Q14BCC4d6KY9M5wHisQpbDB9P8yax5uWm+FRDdLVUTnVrzGxTjeMdO65vD8dQbF/hUsMeEuOtyAyo76391Vv3Nrv8OomUtOYH5Lkv+jWUaVv7KIErdzRMU2EgfSedDeI2V9qq4rvFjT9C5Nq1P/54KVLfmhVQVstPw/Zyzd5jySDFIZ6Lynx/1vSMWXKnUDh1B1lqOoOIZzbkDXmFQKSQoBHtPKfz/uDCca2wTzO+614eppIZCQMYW8b7UAA7cm6FPV+Dr6Ev9tmQh50Y6jwj4bWPUKTW5/I7+g1XG5FCRwYQYM7rm1QSO/LQt0eLEOOXSTsCRrbSl36X4WpZ9+qq5B5pXk8PtVo3NEqtZ7gRjRSNxrOVF0OZY8uOEFUVd2nuh127/IskOins76sUij5Qk3ie4ZKLZ/lt8Uy9D+CZmEZ4yf9FBxdZJ7vnVHo8ooJUMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e230aa9-b394-450d-26c4-08d7f90af8d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 20:03:01.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACrLrWQ3asHlbvJzbKf6ADVtILgOWF9d61dHEFcGlRel3fHT9v7U5Zo4bNZYjjGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=5 cotscore=-2147483648
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150166
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:35:54PM +0000, Christoph Lameter wrote:
> On Mon, 4 May 2020, Roman Gushchin wrote:
> 
> > On Sat, May 02, 2020 at 11:54:09PM +0000, Christoph Lameter wrote:
> > > On Thu, 30 Apr 2020, Roman Gushchin wrote:
> > >
> > > > Sorry, but what exactly do you mean?
> > >
> > > I think the right approach is to add a pointer to each slab object for
> > > memcg support.
> > >
> >
> > As I understand, embedding the memcg pointer will hopefully make allocations
> > cheaper in terms of CPU, but will require more memory. And you think that
> > it's worth it. Is it a correct understanding?
> 
> It definitely makes the code less complex. The additional memory is
> minimal. In many cases you have already some space wasted at the end of
> the object that could be used for the pointer.
> 
> > Can you, please, describe a bit more detailed how it should be done
> > from your point of view?
> 
> Add it to the metadata at the end of the object. Like the debugging
> information or the pointer for RCU freeing.

I've tried to make a prototype, but realized that I don't know how to do
it in a right way with SLUB (without disabling caches merging, etc)
and ended up debugging various memory corruptions.

memcg/kmem changes required to switch between different ways of storing
the memcg pointer are pretty minimal (diff below).

There are two functions which SLAB/SLUB should provide:

void set_obj_cgroup(struct kmem_cache *s, void *ptr, struct obj_cgroup *objcg);
struct obj_cgroup *obtain_obj_cgroup(struct kmem_cache *s, void *ptr);

Ideally, obtain_obj_cgroup should work with an arbitrary kernel pointer, e.g.
a pointer to some field in the structure allocated using kmem_cache_alloc().

Christopher, will you be able to help with the SLUB implementation?
It will be highly appreciated.

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4af95739ccb6..398a714874d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2815,15 +2815,11 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 
 	/*
 	 * Slab objects are accounted individually, not per-page.
-	 * Memcg membership data for each individual object is saved in
-	 * the page->obj_cgroups.
 	 */
-	if (page_has_obj_cgroups(page)) {
+	if (PageSlab(page)) {
 		struct obj_cgroup *objcg;
-		unsigned int off;
 
-		off = obj_to_index(page->slab_cache, page, p);
-		objcg = page_obj_cgroups(page)[off];
+		objcg = obtain_obj_cgroup(page->slab_cache, p);
 		if (objcg)
 			return obj_cgroup_memcg(objcg);
 
diff --git a/mm/slab.h b/mm/slab.h
index 13fadf33be5c..617ce017bc68 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -210,40 +210,15 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+static inline void set_obj_cgroup(struct kmem_cache *s, void *ptr,
+				  struct obj_cgroup *objcg)
 {
-	/*
-	 * page->mem_cgroup and page->obj_cgroups are sharing the same
-	 * space. To distinguish between them in case we don't know for sure
-	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
-	 * always set the lowest bit of obj_cgroups.
-	 */
-	return (struct obj_cgroup **)
-		((unsigned long)page->obj_cgroups & ~0x1UL);
-}
-
-static inline bool page_has_obj_cgroups(struct page *page)
-{
-	return ((unsigned long)page->obj_cgroups & 0x1UL);
-}
-
-static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t gfp,
-					       unsigned int objects)
-{
-	void *vec;
-
-	vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
-	if (!vec)
-		return -ENOMEM;
-
-	page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
-	return 0;
+	// TODO
 }
-
-static inline void memcg_free_page_obj_cgroups(struct page *page)
+static inline struct obj_cgroup *obtain_obj_cgroup(struct kmem_cache *s, void *ptr)
 {
-	kfree(page_obj_cgroups(page));
-	page->obj_cgroups = NULL;
+	// TODO
+	return NULL;
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -296,7 +271,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      void **p)
 {
 	struct page *page;
-	unsigned long off;
 	size_t i;
 
 	if (!objcg)
@@ -306,17 +280,8 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
 			page = virt_to_head_page(p[i]);
-
-			if (!page_has_obj_cgroups(page) &&
-			    memcg_alloc_page_obj_cgroups(page, flags,
-							 objs_per_slab(s))) {
-				obj_cgroup_uncharge(objcg, obj_full_size(s));
-				continue;
-			}
-
-			off = obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
-			page_obj_cgroups(page)[off] = objcg;
+			set_obj_cgroup(s, p[i], objcg);
 			mod_objcg_state(objcg, page_pgdat(page),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
@@ -330,21 +295,17 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 					void *p)
 {
 	struct obj_cgroup *objcg;
-	unsigned int off;
 
 	if (!memcg_kmem_enabled())
 		return;
 
-	if (!page_has_obj_cgroups(page))
-		return;
-
-	off = obj_to_index(s, page, p);
-	objcg = page_obj_cgroups(page)[off];
-	page_obj_cgroups(page)[off] = NULL;
+	objcg = obtain_obj_cgroup(s, p);
 
 	if (!objcg)
 		return;
 
+	set_obj_cgroup(s, p, NULL);
+
 	obj_cgroup_uncharge(objcg, obj_full_size(s));
 	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
 			-obj_full_size(s));
@@ -363,16 +324,6 @@ static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 	return NULL;
 }
 
-static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t gfp,
-					       unsigned int objects)
-{
-	return 0;
-}
-
-static inline void memcg_free_page_obj_cgroups(struct page *page)
-{
-}
-
 static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 							   size_t objects,
 							   gfp_t flags)
@@ -415,8 +366,6 @@ static __always_inline void charge_slab_page(struct page *page,
 static __always_inline void uncharge_slab_page(struct page *page, int order,
 					       struct kmem_cache *s)
 {
-	memcg_free_page_obj_cgroups(page);
-
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
 }
