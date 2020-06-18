Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B27C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C3620890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592497179;
	bh=hQha3rys9qirYkr0uwdzG451fe2vSY0ED4QKs6G5tlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PATyLrnPcHfOe/1qXLFpCzYmG3aVOIJY1copl5fTIkOUkVEeZPwPpAgQaxCwXgp4B
	 BpkAhSg7H1ohU1oMdafgewBcRMh1a1h60LcLCWF8yfAzcOnYJuRzDnORF6vxrAiX4l
	 UXyHHHtDxT4shZiDHJs5PkQoWtDu6lsl96bWBldc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgFRQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:19:32 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:34163 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbgFRQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:19:16 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 05IGHqZB027327;
        Fri, 19 Jun 2020 01:17:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 05IGHqZB027327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592497074;
        bh=bJXBqWiLF+s040Rs2D8WdVLHL2N8PIPU8Pr23YrC5Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqL3+bnnoZ6TEYCvn48oCUoshcQ5K4K3xPCqoCTZAae9ot1kXxhXza5N2p8KFmlnV
         R4eiJk/i74w6Dpcvszwi/nYG278ddWcwr1ARSB8bQ7rDWeEcbpcXF/iItUUsciHUpL
         2WT0oZ/XofHZot0N+wOl162ulciJ6H95dU0LDCNF1E7KKfP5eIrP5yf360p5URgQN4
         gKpzHYF/lz1h3ZGrM6IhgbG9IleNdDE/NxPImeN6qgPNO8p8lTeQW1nXYLjKpNWa8F
         L2UZkmDEpHBpf6bv7wdo7nvApp+dplATrr6WiRGjdwUpqraSa9Pbx0sTneXYBERFID
         IDqYs/3r+7muA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] init: annotate init_task as __init_task_data for all arches
Date:   Fri, 19 Jun 2020 01:17:50 +0900
Message-Id: <20200618161750.178659-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618161750.178659-1-masahiroy@kernel.org>
References: <20200618161750.178659-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init_task_data is no-op when CONFIG_ARCH_TASK_STRUCT_ON_STACK=n,
so you can always annotate init_task as __init_task_data.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/init_task.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..0110b2941c4d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -61,11 +61,7 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
  * Set up the first task table, touch at your own risk!. Base=0,
  * limit=0x1fffff (=2MB)
  */
-struct task_struct init_task
-#ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
-	__init_task_data
-#endif
-= {
+struct task_struct init_task __init_task_data = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	.thread_info	= INIT_THREAD_INFO(init_task),
 	.stack_refcount	= REFCOUNT_INIT(1),
-- 
2.25.1

