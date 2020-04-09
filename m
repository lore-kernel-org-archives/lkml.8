Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E116C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B462072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G3sO7tSR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G5qZuHtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIBSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:18:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDIBSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:18:22 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03917O4H027720;
        Wed, 8 Apr 2020 18:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=w6LNSOW5XnoghXdhA0vAvrcALxKcvmdJ2KgJUvLSSvA=;
 b=G3sO7tSR83BUExrMonarLnpR6cl95hgGNabzG9jckiqbhbTchw9HCm8GeYQidmRnY8fp
 wUVVFUSn2gk/8J3lW7SfA7CSe/5H1n7kk3P02fDN2m6t/yUdeOkT3f4yGrUl6Z4JmEYS
 Vq7ZRPL5qB9cAn8QWTcFnCczYtGyxejfTYc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 309sad054x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Apr 2020 18:16:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 8 Apr 2020 18:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iakbs0hemc/PSDN1PInYwhdxSg6fNuMokyd5QfTrg/JGKIIPOyZwd6itCgbx2BpA/U2u8KHa1qAGES5YbrgLlDIHcSmDpl+3ld0pJWaJQu3BJ/f3YBw6i3vtGKhUE/9mmi/ZLG5RsBuPKI9/ARYfkAAbMABCHywiOp2Lfe/Q1cvl9AU9iOAC8Y23WoQNZddjbNNUSbMX0I3rSnO47gRXzwaxn3IWdN/lH5MXWVwx4tlpIlr5Blia5O7yBaK8Tvdt4MZ6hBOnCKPj+VFSTDN0pPybsI6Mwj1IYAEbzUuBs46+QDvgH0mex/hjzqHDNal30pQTz4Ys9prIiVV6gg4EJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6LNSOW5XnoghXdhA0vAvrcALxKcvmdJ2KgJUvLSSvA=;
 b=dg5Z1OPhERkVvC0KJadKZDv0hKPqNWC/2GPhbPwVvMAYllvUDX2c/cujV/DH1ubLfE86yJqZ2Jm0/Aa6c0MsC1QcJq5vKbxBOmn+cAujp7xA3pw99/DEiZD90xUpmBadSVodqoYkO3UMnQPSozPVvuVpq9MPnLZxVB3Gjd6QATkSCSyouRCjxWWMyspqa0Gdp8j1HxcfDdMy/Nr80eHRlrS8gU/MM1pHYWfI3W6wizmFCjzTYkgYDsHh8VrQtHteiq5XNunN5bE0232F8MYb2Lq1V+u0kq2HzOSK+onZzai5pND23f0zZ45xY2NIKboO3Zij7wSMg6W8nP+losxBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6LNSOW5XnoghXdhA0vAvrcALxKcvmdJ2KgJUvLSSvA=;
 b=G5qZuHtzeF+z5v0skvc0duL+CVlPNxJ2MVqOxd7nNnG2+ApgcOKZS/5oosQMpfr2Q1K8k907VdY+2GceYYD8rW51tU9cuZ1HpLFXhhuEJMn6pCdhuRVQmmtGDZxKsLdvZJeLGBpDd0oNL460hvKppAeLAkpb6tCRl5XOWy8PLbI=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 01:15:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 01:15:55 +0000
Date:   Wed, 8 Apr 2020 18:15:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5 1/2] mm: cma: NUMA node interface
Message-ID: <20200409011551.GA120817@carbon.DHCP.thefacebook.com>
References: <20200407163840.92263-1-guro@fb.com>
 <20200407163840.92263-2-guro@fb.com>
 <20200408175312.14a055276b676edaefe636e2@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408175312.14a055276b676edaefe636e2@linux-foundation.org>
X-ClientProxiedBy: MWHPR1601CA0004.namprd16.prod.outlook.com
 (2603:10b6:300:da::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:8ca0) by MWHPR1601CA0004.namprd16.prod.outlook.com (2603:10b6:300:da::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 01:15:54 +0000
X-Originating-IP: [2620:10d:c090:400::5:8ca0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e43751-7b00-4336-97d7-08d7dc238db7
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208D4DE42453D09D5D91ED5BEC10@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(8936002)(33656002)(6916009)(1076003)(81156014)(2906002)(478600001)(53546011)(16526019)(54906003)(8676002)(5660300002)(6666004)(6506007)(7696005)(86362001)(52116002)(66476007)(66556008)(55016002)(81166007)(316002)(66946007)(4326008)(186003)(9686003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ii8fRlJZgcpyo4vIJpSidP3KiO2MlUco5ENyhdIAEH9Sg5YrxF3bKkPGFYbOoyZxZ09a02ENlJnF7TfOJ7bSjSqKd8teVJwG2esADK4AGFcf84RJs3dTtE+oHU0ZG6zUlCwsnpcrewydqssGHpTmz9GO+xlQJzSEuoqQq8/wt9Il2ZKaYKP52/q+pM7MBzo0ynS+ey1HoGNJsfkGIHqdf2gyWnvKLJyt60hlL2Hjd4VD7Zh2XvCLqAehnK2JlIn6BwLD/TKb287V6sgOUgdSqPf0CAcj4fW2BFVbmtXM4LpWUyZhM+YEKqN3gIJOmV3TV+MMk3I2J1iAHldKUeu80DAdpAxA3TmWrriN8b2cj504TJsCyphszEdKraIDSMqH0ilDnk6ogNK58e426ZnqP0rjnVrdCUg4bk7nGYagUMd2VBrGpQeT1YbVklh4cIu
X-MS-Exchange-AntiSpam-MessageData: 7bd5ZW5agrdhBI5V0bwGKA+9fdpD8OvJmnYr0DpuCCNMfo/AaSJNxcjnnjIqE7eSaehIZbj5PlONyJ19EtxFZc63EthnmujsvHhLhntE/VNab5elWKfnSkmNItiawGcCTrCivby2WGdfoh15ELX7v9ZjpHEF35z9cthoy/nNVu1eiAiHUgMnpQpyX9xmmj3W
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e43751-7b00-4336-97d7-08d7dc238db7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 01:15:55.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGXNUyvFRCPQ5GNw8/0K6jAYTpo5BWKtxMBKTgx6vvqjvbD4inyU+9avOWNc2nJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-08_09:2020-04-07,2020-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 suspectscore=1 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004090006
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:53:12PM -0700, Andrew Morton wrote:
> On Tue, 7 Apr 2020 09:38:39 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > From: Aslan Bakirov <aslan@fb.com>
> > 
> > I've noticed that there is no interfaces exposed by CMA which would let me
> > to declare contigous memory on particular NUMA node.
> > 
> > This patchset adds the ability to try to allocate contiguous memory on
> > specific node. It will fallback to other nodes if the specified one
> > doesn't work.
> > 
> > Implement a new method for declaring contigous memory on particular node
> > and keep cma_declare_contiguous() as a wrapper.
> > 
> > Signed-off-by: Aslan Bakirov <aslan@fb.com>
> > Acked-by: Michal Hocko <mhocko@kernel.org>
> 
> This should have had your signed-off-by, as you were on the patch
> delivery path.  Please send it along?
> 

Will this work?

Signed-off-by: Roman Gushchin <guro@fb.com>

If not, below if the whole patch signed.

Thanks!

--

From 63ddb2d792b548ee480d85a42c94a9e6b4722f4f Mon Sep 17 00:00:00 2001
From: Aslan Bakirov <aslan@fb.com>
Date: Mon, 6 Apr 2020 11:02:59 -0700
Subject: [PATCH 1/2] mm: cma: NUMA node interface

I've noticed that there is no interfaces exposed by CMA which would let me
to declare contigous memory on particular NUMA node.

This patchset adds the ability to try to allocate contiguous memory on
specific node. It will fallback to other nodes if the specified one
doesn't work.

Implement a new method for declaring contigous memory on particular node
and keep cma_declare_contiguous() as a wrapper.

Signed-off-by: Aslan Bakirov <aslan@fb.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/cma.h      | 13 +++++++++++--
 include/linux/memblock.h |  3 +++
 mm/cma.c                 | 16 +++++++++-------
 mm/memblock.c            |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 190184b5ff32..eae834c2162f 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -24,10 +24,19 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
 extern unsigned long cma_get_size(const struct cma *cma);
 extern const char *cma_get_name(const struct cma *cma);
 
-extern int __init cma_declare_contiguous(phys_addr_t base,
+extern int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma);
+			bool fixed, const char *name, struct cma **res_cma,
+			int nid);
+static inline int __init cma_declare_contiguous(phys_addr_t base,
+			phys_addr_t size, phys_addr_t limit,
+			phys_addr_t alignment, unsigned int order_per_bit,
+			bool fixed, const char *name, struct cma **res_cma)
+{
+	return cma_declare_contiguous_nid(base, size, limit, alignment,
+			order_per_bit, fixed, name, res_cma, NUMA_NO_NODE);
+}
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 079d17d96410..6bc37a731d27 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -348,6 +348,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 
 phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 				      phys_addr_t start, phys_addr_t end);
+phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
+				      phys_addr_t align, phys_addr_t start,
+				      phys_addr_t end, int nid, bool exact_nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
 static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
diff --git a/mm/cma.c b/mm/cma.c
index be55d1988c67..0463ad2ce06b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -220,7 +220,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 }
 
 /**
- * cma_declare_contiguous() - reserve custom contiguous area
+ * cma_declare_contiguous_nid() - reserve custom contiguous area
  * @base: Base address of the reserved area optional, use 0 for any
  * @size: Size of the reserved area (in bytes),
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -229,6 +229,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * @fixed: hint about where to place the reserved area
  * @name: The name of the area. See function cma_init_reserved_mem()
  * @res_cma: Pointer to store the created cma region.
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
  * This function reserves memory from early allocator. It should be
  * called by arch specific code once the early allocator (memblock or bootmem)
@@ -238,10 +239,11 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * If @fixed is true, reserve contiguous area at exactly @base.  If false,
  * reserve in range from @base to @limit.
  */
-int __init cma_declare_contiguous(phys_addr_t base,
+int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma)
+			bool fixed, const char *name, struct cma **res_cma,
+			int nid)
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t highmem_start;
@@ -336,14 +338,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
 		 * memory in case of failure.
 		 */
 		if (base < highmem_start && limit > highmem_start) {
-			addr = memblock_phys_alloc_range(size, alignment,
-							 highmem_start, limit);
+			addr = memblock_alloc_range_nid(size, alignment,
+					highmem_start, limit, nid, false);
 			limit = highmem_start;
 		}
 
 		if (!addr) {
-			addr = memblock_phys_alloc_range(size, alignment, base,
-							 limit);
+			addr = memblock_alloc_range_nid(size, alignment, base,
+					limit, nid, false);
 			if (!addr) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/mm/memblock.c b/mm/memblock.c
index 4d06bbaded0f..c79ba6f9920c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1349,7 +1349,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * Return:
  * Physical address of allocated memory block on success, %0 on failure.
  */
-static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
 					bool exact_nid)
-- 
2.25.1


