Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE181C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C74208C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bet13KnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgH0W67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:58:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgH0W66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:58:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07RMthkG009734
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:58:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=V8v2HLqpeDEkeOjhNDExne03SMsDKgR7x+rbMJ0UfKs=;
 b=bet13KnQt2EbwUynF4RDEYw4BFJx08ACDPoj0FlK4+bMFKgUu9oabhXsr6WHvffr2qqB
 sj1hLxuwKcKOc3e285es7edEYNaxAFg81/hNdDdJ/uA84N3P3IPKdYICpLZ5CdQ6YHPs
 ODJJEt0L64OIaK1fF2sPvrhPgfuQ0u7WPiU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 335up700wk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:58:56 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 15:58:55 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 62A18393DEDD; Thu, 27 Aug 2020 15:58:44 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH v1 0/4] mm: kmem: kernel memory accounting in an interrupt context
Date:   Thu, 27 Aug 2020 15:58:39 -0700
Message-ID: <20200827225843.1270629-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=600 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270173
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements memcg-based memory accounting of
allocations made from an interrupt context.

Historically, such allocations were passed unaccounted mostly
because charging the memory cgroup of the current process wasn't
an option. Also performance reasons were likely a reason too.

The remote charging API allows to temporarily overwrite the
currently active memory cgroup, so that all memory allocations
are accounted towards some specified memory cgroup instead
of the memory cgroup of the current process.

This patchset extends the remote charging API so that it can be
used from an interrupt context. Then it removes the fence that
prevented the accounting of allocations made from an interrupt
context. It also contains a couple of optimizations/code
refactorings.

This patchset doesn't directly enable accounting for any specific
allocations, but prepares the code base for it. The bpf memory
accounting will likely be the first user of it: a typical
example is a bpf program parsing an incoming network packet,
which allocates an entry in hashmap map to store some information.

v1:
  - fixed a typo, by Shakeel

rfc:
  https://lkml.org/lkml/2020/8/27/1155


Roman Gushchin (4):
  mm: kmem: move memcg_kmem_bypass() calls to
    get_mem/obj_cgroup_from_current()
  mm: kmem: remove redundant checks from get_obj_cgroup_from_current()
  mm: kmem: prepare remote memcg charging infra for interrupt contexts
  mm: kmem: enable kernel memcg accounting from interrupt contexts

 include/linux/memcontrol.h | 12 -------
 include/linux/sched/mm.h   | 13 +++++--
 mm/memcontrol.c            | 69 ++++++++++++++++++++++++++++----------
 mm/percpu.c                |  3 +-
 mm/slab.h                  |  3 --
 5 files changed, 63 insertions(+), 37 deletions(-)

--=20
2.26.2

