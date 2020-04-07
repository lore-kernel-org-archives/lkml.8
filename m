Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8797C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7920719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DhYnqllR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDGBEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:04:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22754 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgDGBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:04:40 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03710MYd016709
        for <linux-kernel@vger.kernel.org>; Mon, 6 Apr 2020 18:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=S0ioYLMHpN25Y2gPp3J+lnRWbfqozyUe1QBToHd3GdQ=;
 b=DhYnqllRM1//uwS1elmA0PKQezZDLDlE1EkXBpazHjZ4e5Afp3fXSafcMxANiCOkZ8sM
 TAEUj83avJ7uosOxkGchQZqp8aBZWbD1gzrgc2k/OZ+qiwmRU1jNNaO+zVyhGqVopjCr
 w05Q3+CHOSNGFVhEAM9R1ydDkDVS4HziY7E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 307ff7w4fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:04:39 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 18:04:38 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2BCC33C9170A7; Mon,  6 Apr 2020 18:04:37 -0700 (PDT)
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
Subject: [PATCH v4 0/2] mm: using CMA for 1 GB hugepages allocation
Date:   Mon, 6 Apr 2020 18:04:29 -0700
Message-ID: <20200407010431.1286488-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_14:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 suspectscore=2 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=728 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070007
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds a hugetlb_cma boot option, which allows
to reserve a cma area which can be later used for 1 GB
hugepages allocations.

This is v4 of the patch(set). It contains a patch from Aslan,
which adds a useful function of the cma side, and the previous
version of the hugetlb_cma patch (v3) with all following cleanups
and fixes squashed, plus the following changes:
1) removed the hard-coded archs list from docs
2) added a warning printing on non-supported archs
3) hugetlb_lock is temporarily dropped in update_and_free_page()

I've retained Michal's and Mike's acks, because changes are
not significant. Please, let me know if there is something
wrong.

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

