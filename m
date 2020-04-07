Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C66AC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E8520768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iCcgM+kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDGQ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:57:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgDGQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:57:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037GupNd012327
        for <linux-kernel@vger.kernel.org>; Tue, 7 Apr 2020 09:57:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=q6NJGSZFT9Jwz3WXumWHGEYHmPxOZGveA/6s52p3pZo=;
 b=iCcgM+kx9fACFplk2u790/4RxU+DlHPPtskatF1zBqJ/CLLO+HHsQcAnoNUfU2sCIjPQ
 7AkdoAwadc2uEuJ0SyMQs1QeCh6slNHWynbvJsKggqvAbohf5S9LkS4V+4nNGizcRJoF
 vBqkkazthr8NfppNTqaa0tLAfjephkOo/sY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 307a8qfsrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:57:08 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 7 Apr 2020 09:57:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2178C3C9803B5; Tue,  7 Apr 2020 09:38:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 0/2] mm: using CMA for 1 GB hugepages allocation
Date:   Tue, 7 Apr 2020 09:38:38 -0700
Message-ID: <20200407163840.92263-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_07:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=2 mlxlogscore=707 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds a hugetlb_cma boot option, which allows
to reserve a cma area which can be later used for 1 GB
hugepages allocations.

v5:
1) made the hugetlb_cma work if a cma reservation fails on some nodes

v4:
1) added a patch from Aslan, which is adding a useful function to cma
2) removed the hard-coded archs list from docs
3) added a warning printing on non-supported archs
4) hugetlb_lock is temporarily dropped in update_and_free_page()

Thanks!


Aslan Bakirov (1):
  mm: cma: NUMA node interface

Roman Gushchin (1):
  mm: hugetlb: optionally allocate gigantic hugepages using cma

 .../admin-guide/kernel-parameters.txt         |   8 ++
 arch/arm64/mm/init.c                          |   6 +
 arch/x86/kernel/setup.c                       |   4 +
 include/linux/cma.h                           |  13 ++-
 include/linux/hugetlb.h                       |  12 ++
 include/linux/memblock.h                      |   3 +
 mm/cma.c                                      |  16 +--
 mm/hugetlb.c                                  | 109 ++++++++++++++++++
 mm/memblock.c                                 |   2 +-
 9 files changed, 163 insertions(+), 10 deletions(-)

--=20
2.25.1

