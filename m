Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA3FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7EB2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585307;
	bh=qHeCeREw8luRvssVaXq9yusH73MMUoN9KoeWxWLV7R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSw3ov+SONyjtCI9pWW2wFyr5wN6Hz/BVRWHmc1HbiXev+q89owMQ8/2kMKTnyQMm
	 tKfKT/atTgoFySjntfg1b5V8SX/nBfWqgwlj43S8mmVYQzKL9eeQYwpFqLcSAM0Q+Q
	 Ez7E4KPhnL2dmPxx2z1zhNpGIfcB+NoJy6obB71U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIHRPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbgIHQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE17C2483F;
        Tue,  8 Sep 2020 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579905;
        bh=qHeCeREw8luRvssVaXq9yusH73MMUoN9KoeWxWLV7R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g02QSsOxuWV9fDNA68KenXLnMomX30M9HRI0oyyGNR4ABwPQAycrNLAXabxx9CmzX
         w7iMEMws5NeEpdZxhU9VamTEK1kiGtCU6VXXZqIMGV9ul8I7db3hwx0XrAXvGeRTHZ
         MnyzPmeHmq2BHbiohliQB50krkXMZe0aDfdnzXJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/129] selftests/bpf: Fix massive output from test_maps
Date:   Tue,  8 Sep 2020 17:24:52 +0200
Message-Id: <20200908152232.260940342@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit fa4505675e093e895b7ec49a76d44f6b5ad9602e ]

When stdout output from the selftests tool 'test_maps' gets redirected
into e.g file or pipe, then the output lines increase a lot (from 21
to 33949 lines).  This is caused by the printf that happens before the
fork() call, and there are user-space buffered printf data that seems
to be duplicated into the forked process.

To fix this fflush() stdout before the fork loop in __run_parallel().

Fixes: 1a97cf1fe503 ("selftests/bpf: speedup test_maps")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/159842985651.1050885.2154399297503372406.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index c812f0178b643..1c4219ceced2f 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1282,6 +1282,8 @@ static void __run_parallel(unsigned int tasks,
 	pid_t pid[tasks];
 	int i;
 
+	fflush(stdout);
+
 	for (i = 0; i < tasks; i++) {
 		pid[i] = fork();
 		if (pid[i] == 0) {
-- 
2.25.1



