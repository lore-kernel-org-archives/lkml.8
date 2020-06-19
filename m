Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BC521941
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579598;
	bh=fkfXndqxh4AQ+gd8Jrw7nvbRge50YW+KBgsDLiMt3sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AO86iFPN9WXMFoK9v0hQc8Eb9NqFj6VvVZLWZXsMnl6VqOA3tYqGzD+IYxVvl4FCi
	 LQpQjsXnkC2fNno4+vIvkWJsg9fB0/cYsUNUkXmADs48wDlwlXga2fQO733sg7hsQ8
	 S8ziFIwhagfogjMwaC8HJSNQwUfw+mbLqnpv32RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392216AbgFSPNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392200AbgFSPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:13:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1E221582;
        Fri, 19 Jun 2020 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579592;
        bh=fkfXndqxh4AQ+gd8Jrw7nvbRge50YW+KBgsDLiMt3sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npPu5ZzkcCCPJIguNqBFR+AqzAURbzzQO9OmBhfE+2L255SYo+vIvMmmNDBznuzv7
         AQFcnqazjNNR/ax+R5X+y1FirALZw1HFvozVE/hHYTJK6+W8kvJgc5E8YQfNlfqTzj
         vjN31yjUvuEcOEUfZ8uLNhqC515a+6sEmfzafzxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 153/261] libbpf: Fix perf_buffer__free() API for sparse allocs
Date:   Fri, 19 Jun 2020 16:32:44 +0200
Message-Id: <20200619141657.207952322@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eelco Chaudron <echaudro@redhat.com>

[ Upstream commit 601b05ca6edb0422bf6ce313fbfd55ec7bbbc0fd ]

In case the cpu_bufs are sparsely allocated they are not all
free'ed. These changes will fix this.

Fixes: fb84b8224655 ("libbpf: add perf buffer API")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/159056888305.330763.9684536967379110349.stgit@ebuild
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 281cc65276e0..2a1dbf52fc9a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5358,9 +5358,12 @@ void perf_buffer__free(struct perf_buffer *pb)
 	if (!pb)
 		return;
 	if (pb->cpu_bufs) {
-		for (i = 0; i < pb->cpu_cnt && pb->cpu_bufs[i]; i++) {
+		for (i = 0; i < pb->cpu_cnt; i++) {
 			struct perf_cpu_buf *cpu_buf = pb->cpu_bufs[i];
 
+			if (!cpu_buf)
+				continue;
+
 			bpf_map_delete_elem(pb->map_fd, &cpu_buf->map_key);
 			perf_buffer__free_cpu_buf(pb, cpu_buf);
 		}
-- 
2.25.1



