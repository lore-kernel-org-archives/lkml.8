Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B252075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgFVXq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbgFVXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:12 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8f-0005DO-25; Mon, 22 Jun 2020 23:46:09 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH 10/17] c6x: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:19 +0200
Message-Id: <20200622234326.906346-11-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the copy_thread_tls() calling convention which passes tls through a
register. This is required so we can remove the copy_thread{_tls}() split
and remove the HAVE_COPY_THREAD_TLS macro.

CC: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/c6x/Kconfig          | 1 +
 arch/c6x/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 6444ebfd06a6..9cde76a5928e 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -22,6 +22,7 @@ config C6X
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
 	select MMU_GATHER_NO_RANGE if MMU
+	select HAVE_COPY_THREAD_TLS
 
 config MMU
 	def_bool n
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index cb9c8b63cddd..afa3ea9a93aa 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -104,9 +104,9 @@ void start_thread(struct pt_regs *regs, unsigned int pc, unsigned long usp)
 /*
  * Copy a new thread context in its stack.
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long ustk_size,
-		struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long ustk_size, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct pt_regs *childregs;
 
-- 
2.27.0

