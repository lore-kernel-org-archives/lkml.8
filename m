Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8208C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D9920658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594037;
	bh=jNp12BpVLlboRufCqZwC2stiu59XQ7lAaXdsZyV1Goo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5S8wzinqJEFEL8hLII9utGLgvYSzhv9bgi/tgVrnU5CDNhBWvQ4giZkgIkSyuMjT
	 HfmNzKjU6Co6jCP2JI73nwU1YwrXLc0mPi1L3EigZtqXyXdnfKECDr/udSjVkHuHNR
	 sM7gV2c7tK2SDXS2VmH70Ngn2p2BffN8a7vepmzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgIHTkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730699AbgIHPyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155C42415E;
        Tue,  8 Sep 2020 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579514;
        bh=jNp12BpVLlboRufCqZwC2stiu59XQ7lAaXdsZyV1Goo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htEINggwhnnGHKf0h8A0DjC5rO1arlOiL9CkLekTT/JPDZO6xPkF/D71ikc7CmxUu
         lCu9sDaqpguy8HY2199f3epZYvl/bIOBiwzS9qWJHgz6fcFU+nyorLfcRHRtQa2qkG
         ejSvgxuO417xwv2jBHWewGqYPXyIeIQHP0t/8oQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 080/186] selftests/bpf: Fix massive output from test_maps
Date:   Tue,  8 Sep 2020 17:23:42 +0200
Message-Id: <20200908152245.525432915@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
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
index 754cf611723ee..0d92ebcb335d1 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1274,6 +1274,8 @@ static void __run_parallel(unsigned int tasks,
 	pid_t pid[tasks];
 	int i;
 
+	fflush(stdout);
+
 	for (i = 0; i < tasks; i++) {
 		pid[i] = fork();
 		if (pid[i] == 0) {
-- 
2.25.1



