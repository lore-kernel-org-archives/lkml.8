Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732FD2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YqOjZ4HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGOF3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:29:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbgGOF3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:29:04 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06F5R3gH031306
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jBPZIxmT9Tkpkif76heASl4sVSO1vN4U8creO7C5kTw=;
 b=YqOjZ4HO45MXyBDGi3PDQusGNeZmVI9uOeefacBEFlS6w6nB3LC9BQDI92djT5OrwI2F
 OpIUgUh6KNSYN+m6lE+/P99StWAKnjR3G4MalttSSfegRqoTYke0pIf1Cm+W/DoH1L79
 ZCvF6+QVNa9I4rdErCBu1GRHu/WBNjZgwaM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32793m9fuf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:29:03 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 22:29:02 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 72EA162E52DD; Tue, 14 Jul 2020 22:26:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/2] bpf: fix stackmap on perf_events with PEBS
Date:   Tue, 14 Jul 2020 22:25:59 -0700
Message-ID: <20200715052601.2404533-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_02:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxlogscore=978 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150046
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling get_perf_callchain() on perf_events from PEBS entries may cause
unwinder errors. To fix this issue, perf subsystem fetches callchain earl=
y,
and marks perf_events are marked with __PERF_SAMPLE_CALLCHAIN_EARLY.
Similar issue exists when BPF program calls get_perf_callchain() via
helper functions. For more information about this issue, please refer to
discussions in [1].

This set fixes this issue with helper proto bpf_get_stackid_pe and
bpf_get_stack_pe.

[1] https://lore.kernel.org/lkml/ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.=
com/

Changes v1 =3D> v2:
1. Simplify the design and avoid introducing new helper function. (Andrii=
)

Song Liu (2):
  bpf: separate bpf_get_[stack|stackid] for perf events BPF
  selftests/bpf: add callchain_stackid

 include/linux/bpf.h                           |   2 +
 kernel/bpf/stackmap.c                         | 204 ++++++++++++++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 .../bpf/prog_tests/perf_event_stackmap.c      | 120 +++++++++++
 .../selftests/bpf/progs/perf_event_stackmap.c |  64 ++++++
 5 files changed, 374 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_event_sta=
ckmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/perf_event_stackmap=
.c

--
2.24.1
