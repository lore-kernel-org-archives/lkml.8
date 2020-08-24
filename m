Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B60C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FFE206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262839;
	bh=XE6fwogygd3BtBfbN9VKJdPsGRATYwsuEUX0wNk/Ebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tF9n2pLkCZJaFcYvYEMljMkTd+jLTPzY5I1XZh7RAT4WHJQnjxe3Q7Le6SgqqzLUA
	 S0DzjKm7NG4qYtGTTqsMG862OgDl2QpCCVAppG7R5mVBkB/YbvxzfGAPpAQfpBZSrv
	 MiMKn7wbFkG1CxJa7YZ6pNg1K4mqAjW84lVUO+sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHXIhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgHXIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB5D207DF;
        Mon, 24 Aug 2020 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258268;
        bh=XE6fwogygd3BtBfbN9VKJdPsGRATYwsuEUX0wNk/Ebk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlDprk3NlZ0gZFRHFkcpovq8hw+HN8IvH1V4vuL4MGmJC3aRnZPBzVPEcLrh+l2lp
         gYHRkL/6aMXsmM6IuNONQElWTZNBYGUe9lITgX0V3kgBMx4w8JxZinaJXp/1b5LoPW
         jVF7/evL2VmXgnSNKr0eTIbfcGtf2cz1XnROvePo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 136/148] selftests/bpf: Remove test_align leftovers
Date:   Mon, 24 Aug 2020 10:30:34 +0200
Message-Id: <20200824082420.533918870@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veronika Kabatova <vkabatov@redhat.com>

[ Upstream commit 5597432dde62befd3ab92e6ef9e073564e277ea8 ]

Calling generic selftests "make install" fails as rsync expects all
files from TEST_GEN_PROGS to be present. The binary is not generated
anymore (commit 3b09d27cc93d) so we can safely remove it from there
and also from gitignore.

Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Link: https://lore.kernel.org/bpf/20200819160710.1345956-1-vkabatov@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore | 1 -
 tools/testing/selftests/bpf/Makefile   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1bb204cee853f..9a0946ddb705a 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -6,7 +6,6 @@ test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
 fixdep
-test_align
 test_dev_cgroup
 /test_progs*
 test_tcpbpf_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4f322d5388757..50965cc7bf098 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -32,7 +32,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
+	test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
-- 
2.25.1



