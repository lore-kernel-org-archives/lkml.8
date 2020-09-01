Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FCC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10948208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975049;
	bh=4YAmf4dSSuVzZiazHPkKQCjkpbtJsu85PXPDdQOTguM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qlFuVpNk72euD3i/JMZ9wSR/EDSXV+CgQ90Dpkcwkn35Zdf9k69BaXHOrDmOkh57
	 DWaKNaZWmf8AjIYGGdjRhzfc3K9oEVPZ9j3QIzC1VflRLS7IpGC1nEupRDQFA1LrBE
	 lOwb75OLVw7mgiz4xvJ2Wd18/1PRZPitdZOVNP8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgIAPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbgIAPlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:41:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF15B206EF;
        Tue,  1 Sep 2020 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974896;
        bh=4YAmf4dSSuVzZiazHPkKQCjkpbtJsu85PXPDdQOTguM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqE52FrLDolxgcj08vAKUo5EL40l4DYe+gpHGn3aRsnyLkR6bkc4rR9hABKA3G9rD
         4IVd/sk8oLzD9tRB4KYHzcJ0vSfCgMz5/FT43OMAR42fcnIEFT4NLLPRt/CDhHleAM
         sMAWDqltoNsJ1YYX6IB8XvBhqRv7/lXNrb3G/EDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 132/255] selftests/bpf: Fix btf_dump test cases on 32-bit arches
Date:   Tue,  1 Sep 2020 17:09:48 +0200
Message-Id: <20200901151007.041112548@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit eed7818adf03e874994b966aa33bc00204dd275a ]

Fix btf_dump test cases by hard-coding BPF's pointer size of 8 bytes for cases
where it's impossible to deterimne the pointer size (no long type in BTF). In
cases where it's known, validate libbpf correctly determines it as 8.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200813204945.1020225-6-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index cb33a7ee4e04f..39fb81d9daeb5 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -12,15 +12,16 @@ void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 static struct btf_dump_test_case {
 	const char *name;
 	const char *file;
+	bool known_ptr_sz;
 	struct btf_dump_opts opts;
 } btf_dump_test_cases[] = {
-	{"btf_dump: syntax", "btf_dump_test_case_syntax", {}},
-	{"btf_dump: ordering", "btf_dump_test_case_ordering", {}},
-	{"btf_dump: padding", "btf_dump_test_case_padding", {}},
-	{"btf_dump: packing", "btf_dump_test_case_packing", {}},
-	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", {}},
-	{"btf_dump: multidim", "btf_dump_test_case_multidim", {}},
-	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", {}},
+	{"btf_dump: syntax", "btf_dump_test_case_syntax", true, {}},
+	{"btf_dump: ordering", "btf_dump_test_case_ordering", false, {}},
+	{"btf_dump: padding", "btf_dump_test_case_padding", true, {}},
+	{"btf_dump: packing", "btf_dump_test_case_packing", true, {}},
+	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true, {}},
+	{"btf_dump: multidim", "btf_dump_test_case_multidim", false, {}},
+	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false, {}},
 };
 
 static int btf_dump_all_types(const struct btf *btf,
@@ -62,6 +63,18 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 
+	/* tests with t->known_ptr_sz have no "long" or "unsigned long" type,
+	 * so it's impossible to determine correct pointer size; but if they
+	 * do, it should be 8 regardless of host architecture, becaues BPF
+	 * target is always 64-bit
+	 */
+	if (!t->known_ptr_sz) {
+		btf__set_pointer_size(btf, 8);
+	} else {
+		CHECK(btf__pointer_size(btf) != 8, "ptr_sz", "exp %d, got %zu\n",
+		      8, btf__pointer_size(btf));
+	}
+
 	snprintf(out_file, sizeof(out_file), "/tmp/%s.output.XXXXXX", t->file);
 	fd = mkstemp(out_file);
 	if (CHECK(fd < 0, "create_tmp", "failed to create file: %d\n", fd)) {
-- 
2.25.1



