Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C64C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B424680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996704;
	bh=rd1SIbmXxYvtm9wWt8urLuw3HKsMhen7Kfo3TD0jJA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lc0MhTMWQXXjjjGdKPouGaNK9xqK95eBvIQ+4U32LAUh77Q9PuYRNEaoxVhOVkgUP
	 iMlKLEbQEqm4tJW9nBni8lFBWzEwVkyrywsy16pANIPskII6VeHcyAkcXlqxvdYFYP
	 1rl8A+7aFzvAzUtHJospxQE654sCIDWIcPxII/8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgANKLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbgANKLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7493207FF;
        Tue, 14 Jan 2020 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996699;
        bh=rd1SIbmXxYvtm9wWt8urLuw3HKsMhen7Kfo3TD0jJA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsUJx0xZasCYVU40EzxiHjctm8zYr41L2NbXeGjEa48aiWxCYdLh6Ob3CcF7DYPZ9
         K/vBsoZ5oU92KOS6Zbzfofm7W+Tij9NKzWpn1bNn8Kru0lsMTIQVJ3INdMgsXJ0+GB
         bTpOUODQbFDtj57fKQP9KtaDn1LYJRCnvBN5eyuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 07/31] tracing: Have stack tracer compile when MCOUNT_INSN_SIZE is not defined
Date:   Tue, 14 Jan 2020 11:01:59 +0100
Message-Id: <20200114094341.048111684@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit b8299d362d0837ae39e87e9019ebe6b736e0f035 upstream.

On some archs with some configurations, MCOUNT_INSN_SIZE is not defined, and
this makes the stack tracer fail to compile. Just define it to zero in this
case.

Link: https://lore.kernel.org/r/202001020219.zvE3vsty%lkp@intel.com

Cc: stable@vger.kernel.org
Fixes: 4df297129f622 ("tracing: Remove most or all of stack tracer stack size from stack_max_size")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_stack.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -201,6 +201,11 @@ check_stack(unsigned long ip, unsigned l
 	local_irq_restore(flags);
 }
 
+/* Some archs may not define MCOUNT_INSN_SIZE */
+#ifndef MCOUNT_INSN_SIZE
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 static void
 stack_trace_call(unsigned long ip, unsigned long parent_ip,
 		 struct ftrace_ops *op, struct pt_regs *pt_regs)


