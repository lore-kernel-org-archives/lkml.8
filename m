Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F60C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C35C2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551797;
	bh=xfxEHbO2CYxxBaJ6smtcDNMkhdPl2Aa+kTgvxGBP8Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/XGJU5v63yeQXwzNIcU8GP1Tj9cAUBxd29TKQCpOhl6n527/dHDGLQmJCPHUd5Ou
	 MTCA0PJJ5gYOBZXhqeuM9/KoQRtclIiZIYYh7Ggk+j1T9cWwNu/4/TKDpAjEzqGCe8
	 2Og0Kwmj+iQJQMJGlh5seQNcjGiBAlHN17QNloLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDVKgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbgDVKWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1DF2076B;
        Wed, 22 Apr 2020 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550973;
        bh=xfxEHbO2CYxxBaJ6smtcDNMkhdPl2Aa+kTgvxGBP8Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkw/yLb6MJ9y5VyztVB0hZY/65knENsv4cW2JVpIORwj2+dA5j/G7K/vjKV/m/IQe
         KraxsrE3Oz2NMja0ONTJC7k7gGbiyWWcE0H+W3u4n1Fav9qC3sHieUUy5C2epLrGnH
         U1MOXF6Hea+jbzZQSCEmh2owwcRKYbPM8MqVH3ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenbo Zhang <ethercflow@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 049/166] bpf: Reliably preserve btf_trace_xxx types
Date:   Wed, 22 Apr 2020 11:56:16 +0200
Message-Id: <20200422095054.334001038@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 441420a1f0b3031f228453697406c86f110e59d4 ]

btf_trace_xxx types, crucial for tp_btf BPF programs (raw tracepoint with
verifier-checked direct memory access), have to be preserved in kernel BTF to
allow verifier do its job and enforce type/memory safety. It was reported
([0]) that for kernels built with Clang current type-casting approach doesn't
preserve these types.

This patch fixes it by declaring an anonymous union for each registered
tracepoint, capturing both struct bpf_raw_event_map information, as well as
recording btf_trace_##call type reliably. Structurally, it's still the same
content as for a plain struct bpf_raw_event_map, so no other changes are
necessary.

  [0] https://github.com/iovisor/bcc/issues/2770#issuecomment-591007692

Fixes: e8c423fb31fa ("bpf: Add typecast to raw_tracepoints to help BTF generation")
Reported-by: Wenbo Zhang <ethercflow@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200301081045.3491005-2-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/bpf_probe.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index b04c292709730..1ce3be63add1f 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -75,13 +75,17 @@ static inline void bpf_test_probe_##call(void)				\
 	check_trace_callback_type_##call(__bpf_trace_##template);	\
 }									\
 typedef void (*btf_trace_##call)(void *__data, proto);			\
-static struct bpf_raw_event_map	__used					\
-	__attribute__((section("__bpf_raw_tp_map")))			\
-__bpf_trace_tp_map_##call = {						\
-	.tp		= &__tracepoint_##call,				\
-	.bpf_func	= (void *)(btf_trace_##call)__bpf_trace_##template,	\
-	.num_args	= COUNT_ARGS(args),				\
-	.writable_size	= size,						\
+static union {								\
+	struct bpf_raw_event_map event;					\
+	btf_trace_##call handler;					\
+} __bpf_trace_tp_map_##call __used					\
+__attribute__((section("__bpf_raw_tp_map"))) = {			\
+	.event = {							\
+		.tp		= &__tracepoint_##call,			\
+		.bpf_func	= __bpf_trace_##template,		\
+		.num_args	= COUNT_ARGS(args),			\
+		.writable_size	= size,					\
+	},								\
 };
 
 #define FIRST(x, ...) x
-- 
2.20.1



