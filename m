Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2122468F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220283;
	bh=QcOGFUpY3hWY8zDwR2VWP52YZ7ia1a6l2UUSsYDmnYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JoFxv1mhqGMj7CsgV97Ad0ipYwDja5ZPduaos4eifeBDZ2ChprkZ5/h6W8s9J+jwZ
	 MBJ3EI64ZifmayreGfUqgvDO/vbWD/koIVQn+8JU0zpAygaEPjx1/PHj66Y+LMOYG5
	 /g7To8+dcDElYNb7md/0So5U7KQS23kEYelf15ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgA1OEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgA1OEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:04:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5851F205F4;
        Tue, 28 Jan 2020 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220274;
        bh=QcOGFUpY3hWY8zDwR2VWP52YZ7ia1a6l2UUSsYDmnYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmvr4q/1N0R8PsdATDsdRMAY1O7jXZTqNUAtnzgphrwe8tp5T/vIAWVHJYcQ4AzHI
         jDJuf4+BT0JmHFLO7VTVK5yWkEs6KG1gIQN6cGAlRHYy+vYkIUEMLHafS0FasJbfW2
         Ye+rHb5TiqsVw3voGJvUAsNffTctmY4uOUArzYvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.4 079/104] tracing: xen: Ordered comparison of function pointers
Date:   Tue, 28 Jan 2020 15:00:40 +0100
Message-Id: <20200128135828.115414354@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

commit d0695e2351102affd8efae83989056bc4b275917 upstream.

Just as commit 0566e40ce7 ("tracing: initcall: Ordered comparison of
function pointers"), this patch fixes another remaining one in xen.h
found by clang-9.

In file included from arch/x86/xen/trace.c:21:
In file included from ./include/trace/events/xen.h:475:
In file included from ./include/trace/define_trace.h:102:
In file included from ./include/trace/trace_events.h:473:
./include/trace/events/xen.h:69:7: warning: ordered comparison of function \
pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Wordered-compare-function-pointers]
                    __field(xen_mc_callback_fn_t, fn)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:421:29: note: expanded from macro '__field'
                                ^
./include/trace/trace_events.h:407:6: note: expanded from macro '__field_ext'
                                 is_signed_type(type), filter_type);    \
                                 ^
./include/linux/trace_events.h:554:44: note: expanded from macro 'is_signed_type'
                                              ^

Fixes: c796f213a6934 ("xen/trace: add multicall tracing")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/xen.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -66,7 +66,11 @@ TRACE_EVENT(xen_mc_callback,
 	    TP_PROTO(xen_mc_callback_fn_t fn, void *data),
 	    TP_ARGS(fn, data),
 	    TP_STRUCT__entry(
-		    __field(xen_mc_callback_fn_t, fn)
+		    /*
+		     * Use field_struct to avoid is_signed_type()
+		     * comparison of a function pointer.
+		     */
+		    __field_struct(xen_mc_callback_fn_t, fn)
 		    __field(void *, data)
 		    ),
 	    TP_fast_assign(


