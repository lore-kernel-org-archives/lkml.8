Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A11C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6D220656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ooka7yuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHUPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:06:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgHUPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:06:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LF4M2s012554
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:06:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vNrR4zSzmcgBz+DK2EJwB/LPCbtsGJ9/WTDRVxCAlTk=;
 b=Ooka7yuPU9b8tDuL+hra78HFmpQeMZ2wYkPY4DK2YrbHQemwFySzL7XEGhI7h724apCb
 VR0lwpIl/JNO9R3J/IonMzSmcRR8vGJJqrsDBn5JvGUrhIpKWhrWMCH7zPZsCL7fdnW3
 /gDZLkOAj6/TiH93p7GAzZdiP4gvP4aLlNw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 332ehfrpjx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:06:45 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:06:43 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 78BFF3441067; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v4 16/30] bpf: eliminate rlimit-based memory accounting for cpumap maps
Date:   Fri, 21 Aug 2020 08:01:20 -0700
Message-ID: <20200821150134.2581465-17-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=38 mlxlogscore=924
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use rlimit-based memory accounting for cpumap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cpumap.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 74ae9fcbe82e..50f3444a3301 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -86,8 +86,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	u32 value_size =3D attr->value_size;
 	struct bpf_cpu_map *cmap;
 	int err =3D -ENOMEM;
-	u64 cost;
-	int ret;
=20
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
@@ -111,26 +109,14 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr=
 *attr)
 		goto free_cmap;
 	}
=20
-	/* make sure page count doesn't overflow */
-	cost =3D (u64) cmap->map.max_entries * sizeof(struct bpf_cpu_map_entry =
*);
-
-	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	ret =3D bpf_map_charge_init(&cmap->map.memory, cost);
-	if (ret) {
-		err =3D ret;
-		goto free_cmap;
-	}
-
 	/* Alloc array for possible remote "destination" CPUs */
 	cmap->cpu_map =3D bpf_map_area_alloc(cmap->map.max_entries *
 					   sizeof(struct bpf_cpu_map_entry *),
 					   cmap->map.numa_node);
 	if (!cmap->cpu_map)
-		goto free_charge;
+		goto free_cmap;
=20
 	return &cmap->map;
-free_charge:
-	bpf_map_charge_finish(&cmap->map.memory);
 free_cmap:
 	kfree(cmap);
 	return ERR_PTR(err);
--=20
2.26.2

