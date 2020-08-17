Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C238EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98433205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677533;
	bh=3vfQKMttlM0pOTyMoFBwaEXl9k9Q1/ngIocA8s8nfjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVisbq6JlE7CqhhS+dvgAsNoCCkLoQLiNHciXF5kJNO/ly3mmX7/Gi54jKqxT/f+n
	 HkcG+jib4rEfss3MvT2qLkiTuwAic8GlgwLNLJtY1Nd6C1HWwFodrtPX9OuIm0PLVK
	 ylvQfZQfu116IxcPK2G1zoV3oSZC68aRtWH3FvZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgHQPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbgHQPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:18:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDFF62065C;
        Mon, 17 Aug 2020 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677509;
        bh=3vfQKMttlM0pOTyMoFBwaEXl9k9Q1/ngIocA8s8nfjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYpXIQu8ybujXfde4CPcT95hQ6lh5ivUb+KDY5+FQkB724oTUXEb93B82pnQzFWvA
         n/pC+Vir2VZ1on2V4y99xkRCAe/1QNHRGbAwTrO5NNwdh+ybwUHVe27S5jZ5QLM4yx
         a9VvZs3Io2+dGwazndkHtfmmGlHosooZmd7jgXQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Simon MacMullen <simonmacm@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.8 001/464] tracepoint: Mark __tracepoint_strings __used
Date:   Mon, 17 Aug 2020 17:09:14 +0200
Message-Id: <20200817143833.807083399@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

commit f3751ad0116fb6881f2c3c957d66a9327f69cefb upstream.

__tracepoint_string's have their string data stored in .rodata, and an
address to that data stored in the "__tracepoint_str" section. Functions
that refer to those strings refer to the symbol of the address. Compiler
optimization can replace those address references with references
directly to the string data. If the address doesn't appear to have other
uses, then it appears dead to the compiler and is removed. This can
break the /tracing/printk_formats sysfs node which iterates the
addresses stored in the "__tracepoint_str" section.

Like other strings stored in custom sections in this header, mark these
__used to inform the compiler that there are other non-obvious users of
the address, so they should still be emitted.

Link: https://lkml.kernel.org/r/20200730224555.2142154-2-ndesaulniers@google.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 102c9323c35a8 ("tracing: Add __tracepoint_string() to export string pointers")
Reported-by: Tim Murray <timmurray@google.com>
Reported-by: Simon MacMullen <simonmacm@google.com>
Suggested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/tracepoint.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -361,7 +361,7 @@ static inline struct tracepoint *tracepo
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
-#define __tracepoint_string	__attribute__((section("__tracepoint_str")))
+#define __tracepoint_string	__attribute__((section("__tracepoint_str"), used))
 #else
 /*
  * tracepoint_string() is used to save the string address for userspace


