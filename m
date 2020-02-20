Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4763E20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sI2eZY5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgBTKWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:22:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgBTKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:22:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KAJ0Ye095952;
        Thu, 20 Feb 2020 10:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5UKDu7l3UNxspcPIx9HSKdFAH6sgOkJpPpiv9ECBSfg=;
 b=sI2eZY5rGOBRoS15GFUXiIhyaDvJm40S+ZOt8fdaWYrChDMJ8+nTePMoUpi1e7oZ/kKT
 ttbnBuBc2Mon7XwE1p03VlOOLvBbuoqiYueM23vfdwnBJ4jFbIxZemcv0sCqXZpntDJi
 9CISvBHII29w+asX5+JRzkXdVbYh/2lrt/LlYl/BvBNrnxCURlPIz84LTsrseO3iRLcT
 D8nBhOjucPao8h2H5Jx2C+e+XaCTIhXIM5GElbYI2gmR/lZvpfR6wWZL2IPlr+JnYuNA
 oUCjhHWaGLKaYcMd2ZdTvl4oJc6Nfz5a/KHckF9atFE7Ap9omGPzPjjNyhLziS5YwJHE /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y8udd8tjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 10:22:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KAK8kS014174;
        Thu, 20 Feb 2020 10:22:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y8ud3dr5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 10:22:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KAMXqd025211;
        Thu, 20 Feb 2020 10:22:33 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 02:22:33 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.19\))
Subject: Re: [PATCH] mm: Fix possible PMD dirty bit lost in
 set_pmd_migration_entry()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200220075220.2327056-1-ying.huang@intel.com>
Date:   Thu, 20 Feb 2020 03:22:29 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCA5401A-6EB6-49D9-B673-86A89808FA15@oracle.com>
References: <20200220075220.2327056-1-ying.huang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
X-Mailer: Apple Mail (2.3608.80.19)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 20, 2020, at 12:52 AM, Huang, Ying <ying.huang@intel.com> =
wrote:
>=20
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Looks good to me.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> mm/huge_memory.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 580098e115bd..b1e069e68189 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3060,8 +3060,7 @@ void set_pmd_migration_entry(struct =
page_vma_mapped_walk *pvmw,
> 		return;
>=20
> 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
> -	pmdval =3D *pvmw->pmd;
> -	pmdp_invalidate(vma, address, pvmw->pmd);
> +	pmdval =3D pmdp_invalidate(vma, address, pvmw->pmd);
> 	if (pmd_dirty(pmdval))
> 		set_page_dirty(page);
> 	entry =3D make_migration_entry(page, pmd_write(pmdval));
> --=20
> 2.25.0
>=20
>=20

