Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A13C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5824720716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693423;
	bh=k296qi7HxlZgUoe/DmXhlF3VYg7LH0YX2UM5pcMqG7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=12VgUigZL7LKzpA1RdtGYbTXPEC/3Dp3vLmwaUTOW51ssGOZNgbXGRefNGzYh8ARc
	 QAad+X7ZtHsuGv4ExvHIKlmu9Gm2Em8l/bDjPLaENALt6zVjrYuLj4bawj7G8q/itB
	 5ufpapObYL71+uHxzQCR6UDypHsb7KYW/8J53Lzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgHQTnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgHQPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:23:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7D823109;
        Mon, 17 Aug 2020 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677814;
        bh=k296qi7HxlZgUoe/DmXhlF3VYg7LH0YX2UM5pcMqG7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlBcqZKwBXNkgiFb4/lLqHWIMFTVZvMkKNEu1d1+WLxqogiP0FTajfceYkTNIdyjK
         pMD3Mgbtnon2eVkwcRg54zFmX4Tu9Snupu6OKu2SHblCVS/HTI5uMYH3o53lvwXzS+
         87bwFEqKtiEwnoe8gT9l/3WyV+UabYUNafXCHqz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenbo Zhang <ethercflow@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 116/464] bpf: Fix fds_example SIGSEGV error
Date:   Mon, 17 Aug 2020 17:11:09 +0200
Message-Id: <20200817143839.366852240@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenbo Zhang <ethercflow@gmail.com>

[ Upstream commit eef8a42d6ce087d1c81c960ae0d14f955b742feb ]

The `BPF_LOG_BUF_SIZE`'s value is `UINT32_MAX >> 8`, so define an array
with it on stack caused an overflow.

Signed-off-by: Wenbo Zhang <ethercflow@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200710092035.28919-1-ethercflow@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/fds_example.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
index d5992f7872328..59f45fef51109 100644
--- a/samples/bpf/fds_example.c
+++ b/samples/bpf/fds_example.c
@@ -30,6 +30,8 @@
 #define BPF_M_MAP	1
 #define BPF_M_PROG	2
 
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
 static void usage(void)
 {
 	printf("Usage: fds_example [...]\n");
@@ -57,7 +59,6 @@ static int bpf_prog_create(const char *object)
 		BPF_EXIT_INSN(),
 	};
 	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
-	char bpf_log_buf[BPF_LOG_BUF_SIZE];
 	struct bpf_object *obj;
 	int prog_fd;
 
-- 
2.25.1



