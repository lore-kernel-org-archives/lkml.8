Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3420661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217956;
	bh=K4ZECZq3tAY87oe384WQVJjhJMv+1+sz5kr4mGnvw9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRJ4eN5ZNE/Q6Jb1Qp5V3Vkg1V64sZzjzMvMBKXThrKPnFW95qPTOce4vThLNoNnv
	 nVUqeNlo7EyaOnqiMDSNbciXEpiyopTNsKDRSgCUUmGQ34ydXXh93auXfgOsn/yO08
	 /vuZJVoJvgGKk9TOYZIxlfh9omTKCQpZxYfCc6l4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbgAPXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgAPX2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:28:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57EFC2072B;
        Thu, 16 Jan 2020 23:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217310;
        bh=K4ZECZq3tAY87oe384WQVJjhJMv+1+sz5kr4mGnvw9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiwK3NWOcyi7ChoOxPY2Yda47xF3E4HSVaYRRc+JdR+TL4cqf4GdYhWY5glz5LN7z
         fzXOr6OmN5/dopKgamPcnFj7KY8EwnM2U5cXR6rQLCtl50zFUoAF+iTysiElt95T8T
         /7sxWxmEStFdIt3NxMu+2IU29KrQ0V/CmBo61Fkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andi Kleen <ak@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 4.19 05/84] fs/select: avoid clang stack usage warning
Date:   Fri, 17 Jan 2020 00:17:39 +0100
Message-Id: <20200116231714.039571209@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit ad312f95d41c9de19313c51e388c4984451c010f upstream.

The select() implementation is carefully tuned to put a sensible amount
of data on the stack for holding a copy of the user space fd_set, but
not too large to risk overflowing the kernel stack.

When building a 32-bit kernel with clang, we need a little more space
than with gcc, which often triggers a warning:

  fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
  int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,

I experimentally found that for 32-bit ARM, reducing the maximum stack
usage by 64 bytes keeps us reliably under the warning limit again.

Link: http://lkml.kernel.org/r/20190307090146.1874906-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/poll.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -16,7 +16,11 @@
 extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
+#ifdef __clang__
+#define MAX_STACK_ALLOC 768
+#else
 #define MAX_STACK_ALLOC 832
+#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC


