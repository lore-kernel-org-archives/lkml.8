Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D6920738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691147;
	bh=k296qi7HxlZgUoe/DmXhlF3VYg7LH0YX2UM5pcMqG7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sks9FpqxHAysKWxz9MJw6Dms+qGIR4nu0h+3muSd65GBUzdstaHNLBwHxOeZMj43B
	 Ej5K1+tAlvzHDUl1oNg3MouIsAEBDnQ6tT3EAlNM03RSjc7CTH/ednb8mP25nNviin
	 h9YdUn1RTDxmtn1mcLJutTpp4c5aGwRq32MMZxhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgHQTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgHQPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:45:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F0B22CF8;
        Mon, 17 Aug 2020 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679104;
        bh=k296qi7HxlZgUoe/DmXhlF3VYg7LH0YX2UM5pcMqG7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwOO60x/ejIwvaJnn8urqH+OHhw9szTW/qORl7+kiYqFhDwx8ko3YfRTwsiZdZm5k
         kB4nG6+NleRN/EU18Yh3/pD6nzw6ubBOt02hEigGdAoON2wGneDXdYe92rGlr56NEI
         mq+Miij6jem/qI4qyztfTR1RJidHMS67ZLs+qJfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenbo Zhang <ethercflow@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 098/393] bpf: Fix fds_example SIGSEGV error
Date:   Mon, 17 Aug 2020 17:12:28 +0200
Message-Id: <20200817143824.370500193@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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



