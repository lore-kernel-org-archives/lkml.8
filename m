Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDEA20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663502;
	bh=NxAJsTGELpCsWIQyrpwGz1O0iqdSozOGgaX3qe3alLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+yZqHAb6FgKcad6Vn7XZtMxAEyjyTrcddraEpv19+oCTiYOcNFqOtQGdRiBce90S
	 aXBkrKSe64kRYUIc3nf4/gu6Lu9deyp+UnUlJH1kVPMMrC9ZOAYW9lSGX6ws+f4AwT
	 RVKiOwwDzhzb/XSXz3Z71zjKamo2Cqb/+4VCJsg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbgFIApB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbgFHXLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EE820C56;
        Mon,  8 Jun 2020 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657914;
        bh=NxAJsTGELpCsWIQyrpwGz1O0iqdSozOGgaX3qe3alLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy1vcd0Eo6Lc4swo5/oWRIvdhu98ZjZbANPilov7WG8NEyRhL4u1YtWTe8BsnhkvQ
         1fgNx9jdTNfJwLygc0CgQCL2nyhCSL56PhNqynmsAiO8mIvdWyuRZDOzq0haWociCx
         a3eBn/I6zOzV6hhm5u+sqksuM2PE92VK3pMo/Lfw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 265/274] libbpf: Fix perf_buffer__free() API for sparse allocs
Date:   Mon,  8 Jun 2020 19:05:58 -0400
Message-Id: <20200608230607.3361041-265-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cd53204d33f0..0c5b4fb553fb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7809,9 +7809,12 @@ void perf_buffer__free(struct perf_buffer *pb)
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

