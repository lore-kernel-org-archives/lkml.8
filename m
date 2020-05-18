Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566D020715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825321;
	bh=5RVUNeeq1bOhBax5PxSgXQk4pY6uDomCG0Yjuq6vgiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JTUdx2NzLzNf7giMGU3B9DnfJg4akk4CkfbW9O/EDJH7aSrAsSkeKBDfsEvaz0Gk7
	 f8PBSwlH0/YQNlxNxyDGWZTjSR07cEhZvfysuz6B0mRCZPBiNqedk0zWpvqD66ehFB
	 hHJulsdaoBn0iMG68dMi47EmcV/MMPE6lmhSs7mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgERSIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387433AbgERSHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2BB20715;
        Mon, 18 May 2020 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825259;
        bh=5RVUNeeq1bOhBax5PxSgXQk4pY6uDomCG0Yjuq6vgiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgaNQk0UGcUYtLBqrbVvvlF9L7VFZiGe5hJxlxp/igFwItS6GEiJAO+kz9f0sM+CI
         woHEFo6axsx1wxpkKKsPf9AMJjkvBI4v2wxZybAxz7m58+OV8uIUdaJPdlpsJE4+8R
         1Jatnp0xLxWX8/Y8Y26wHFH1O9GLl1WlxpCOmuik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5.6 192/194] selftests/bpf: Enforce returning 0 for fentry/fexit programs
Date:   Mon, 18 May 2020 19:38:02 +0200
Message-Id: <20200518173547.378254492@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

commit 6d74f64b922b8394dccc52576659cb0dc0a1da7b upstream.

There are a few fentry/fexit programs returning non-0.
The tests with these programs will break with the previous
patch which enfoced return-0 rules. Fix them properly.

Fixes: ac065870d928 ("selftests/bpf: Add BPF_PROG, BPF_KPROBE, and BPF_KRETPROBE macros")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200514053207.1298479-1-yhs@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/progs/test_overhead.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -33,13 +33,13 @@ int prog3(struct bpf_raw_tracepoint_args
 SEC("fentry/__set_task_comm")
 int BPF_PROG(prog4, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
 
 SEC("fexit/__set_task_comm")
 int BPF_PROG(prog5, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
 
 char _license[] SEC("license") = "GPL";


