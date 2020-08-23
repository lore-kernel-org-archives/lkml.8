Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376F20723
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yzaIXnlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHWEFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:05:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x1guQtS5y3PGv/arR1A5XeEiC/cJH8DGLr91UoqDDfA=; b=yzaIXnlqQQsOp3H4I+5VpizLNj
        YTPVumRbYYRihUwrCO1IJXLrt15MLAB/V27s5MwAe0Xn8/ZGp4k2ysipOjBVeybXuKDjGLjTlnuuY
        86uX1uONbDU55QJV5O4P7BL7XCt6NTFR1DlmIAlyHmqWFZI4yUA8qQb08mmNBdY8/wcRaU7xBLgxZ
        ++cMJs1G7sjR9Fega/r3HYnnNS31vhLxfmp+WEGZKFK73a8ZhI2V/78IfhR7KEWyDXCOfbmgC97FE
        u7OwnNlhXWykfdXr+NBxSbXPBYgYqHbKNDFBV1Zjcr4T9RfjdATpDC3J3JhnSFZYndSGURZloDXN8
        6rqEBDMQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFu-0004sO-7P; Sun, 23 Aug 2020 04:05:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] lib: syscall: delete duplicated words
Date:   Sat, 22 Aug 2020 21:05:14 -0700
Message-Id: <20200823040514.26136-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 lib/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/syscall.c
+++ linux-next-20200730/lib/syscall.c
@@ -44,7 +44,7 @@ static int collect_syscall(struct task_s
  *			 .data.instruction_pointer - filled with user PC
  *
  * If @target is blocked in a system call, returns zero with @info.data.nr
- * set to the the call's number and @info.data.args filled in with its
+ * set to the call's number and @info.data.args filled in with its
  * arguments. Registers not used for system call arguments may not be available
  * and it is not kosher to use &struct user_regset calls while the system
  * call is still in progress.  Note we may get this result if @target
