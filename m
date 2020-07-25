Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B6C43457
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929182070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Uto0v55F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGYAFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:05:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbgGYAEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:04:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ONkkuV031620
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:04:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oEnmyUCkDbp6GsiBTaBZObGYGFPu+HplQnEkNgp2CuY=;
 b=Uto0v55FZzOqaYlQG+DX1vJCW+Gc1rj90AVujKQMzsrV7W1ErsHz9Khx704IiAWQn3EK
 M3+nwwbV3jfEU0jz5lQyxOX1+f+MxMmajJKH5AELOzWEgs/7MzMY9aiT59lbcz97mDRp
 Ql14qUHNgNNr99HAH4Sj93MU7P0BZd//mxM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32etmwm9f4-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:04:50 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 17:04:43 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 436091B35AA6; Fri, 24 Jul 2020 17:04:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next 29/35] bpf: libbpf: cleanup RLIMIT_MEMLOCK usage
Date:   Fri, 24 Jul 2020 17:04:04 -0700
Message-ID: <20200725000410.3566700-30-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200725000410.3566700-1-guro@fb.com>
References: <20200725000410.3566700-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240164
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As bpf is not using memlock rlimit for memory accounting anymore,
let's remove the related code from libbpf.

Bpf operations can't fail because of exceeding the limit anymore.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/lib/bpf/libbpf.c | 31 +------------------------------
 tools/lib/bpf/libbpf.h |  5 -----
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e51479d60285..841060f5cee3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -112,32 +112,6 @@ void libbpf_print(enum libbpf_print_level level, con=
st char *format, ...)
 	va_end(args);
 }
=20
-static void pr_perm_msg(int err)
-{
-	struct rlimit limit;
-	char buf[100];
-
-	if (err !=3D -EPERM || geteuid() !=3D 0)
-		return;
-
-	err =3D getrlimit(RLIMIT_MEMLOCK, &limit);
-	if (err)
-		return;
-
-	if (limit.rlim_cur =3D=3D RLIM_INFINITY)
-		return;
-
-	if (limit.rlim_cur < 1024)
-		snprintf(buf, sizeof(buf), "%zu bytes", (size_t)limit.rlim_cur);
-	else if (limit.rlim_cur < 1024*1024)
-		snprintf(buf, sizeof(buf), "%.1f KiB", (double)limit.rlim_cur / 1024);
-	else
-		snprintf(buf, sizeof(buf), "%.1f MiB", (double)limit.rlim_cur / (1024*=
1024));
-
-	pr_warn("permission error while running as root; try raising 'ulimit -l=
'? current value: %s\n",
-		buf);
-}
-
 #define STRERR_BUFSIZE  128
=20
 /* Copied from tools/perf/util/util.h */
@@ -3420,8 +3394,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
 		pr_warn("Error in %s():%s(%d). Couldn't load trivial BPF "
 			"program. Make sure your kernel supports BPF "
-			"(CONFIG_BPF_SYSCALL=3Dy) and/or that RLIMIT_MEMLOCK is "
-			"set to big enough value.\n", __func__, cp, ret);
+			"(CONFIG_BPF_SYSCALL=3Dy)", __func__, cp, ret);
 		return -ret;
 	}
 	close(ret);
@@ -3918,7 +3891,6 @@ bpf_object__create_maps(struct bpf_object *obj)
 err_out:
 	cp =3D libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 	pr_warn("map '%s': failed to create: %s(%d)\n", map->name, cp, err);
-	pr_perm_msg(err);
 	for (j =3D 0; j < i; j++)
 		zclose(obj->maps[j].fd);
 	return err;
@@ -5419,7 +5391,6 @@ load_program(struct bpf_program *prog, struct bpf_i=
nsn *insns, int insns_cnt,
 	ret =3D -errno;
 	cp =3D libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
-	pr_perm_msg(ret);
=20
 	if (log_buf && log_buf[0] !=3D '\0') {
 		ret =3D -LIBBPF_ERRNO__VERIFY;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c6813791fa7e..8d2f1194cb02 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -610,11 +610,6 @@ bpf_prog_linfo__lfind(const struct bpf_prog_linfo *p=
rog_linfo,
=20
 /*
  * Probe for supported system features
- *
- * Note that running many of these probes in a short amount of time can =
cause
- * the kernel to reach the maximal size of lockable memory allowed for t=
he
- * user, causing subsequent probes to fail. In this case, the caller may=
 want
- * to adjust that limit with setrlimit().
  */
 LIBBPF_API bool bpf_probe_prog_type(enum bpf_prog_type prog_type,
 				    __u32 ifindex);
--=20
2.26.2

