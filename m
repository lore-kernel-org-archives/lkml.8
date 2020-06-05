Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2AD20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366968;
	bh=ASIx1f7M2i1M5BhfB5V08l+8rsFnCdCEoy/P7rov25k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iC/UDa84y0dUmUI9EZA6rKHyBMlHqgTTLY0v0onLO5VauUJZrEHQ5ZjMighW/PWQ9
	 6GTpkBrDWW+3YOJQ4QajA75ZuVp3nl3cHk035ZHLlREmddPpQlZxiCGA2zZvWuKzDl
	 Y1gKBYpov04vV0NApS5ldo08bDP3OiZpK/h7DH5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgFEOWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgFEOSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722C3208A7;
        Fri,  5 Jun 2020 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366730;
        bh=ASIx1f7M2i1M5BhfB5V08l+8rsFnCdCEoy/P7rov25k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxGETOPVHW5w1jmoJjGRaeeHRwJ3iiqPd1CcjxU9Lv3P9pmBb54DvcIu4EwF/jBox
         OQHZG8vb6m1rL85aWcmdOJQU7OXzhYL5ar5TKaLtABqHeNm+b8EjmryvbD7MnsBveB
         sndokBBIbazHOTBIPHwBROwTFkP1rqziHAhOJv9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 30/38] x86/mmiotrace: Use cpumask_available() for cpumask_var_t variables
Date:   Fri,  5 Jun 2020 16:15:13 +0200
Message-Id: <20200605140254.433457105@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit d7110a26e5905ec2fe3fc88bc6a538901accb72b ]

When building with Clang + -Wtautological-compare and
CONFIG_CPUMASK_OFFSTACK unset:

  arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
  equal to a null pointer is always false [-Wtautological-pointer-compare]
          if (downed_cpus == NULL &&
              ^~~~~~~~~~~    ~~~~
  arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
  equal to a null pointer is always false [-Wtautological-pointer-compare]
          if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
              ^~~~~~~~~~~    ~~~~
  2 warnings generated.

Commit

  f7e30f01a9e2 ("cpumask: Add helper cpumask_available()")

added cpumask_available() to fix warnings of this nature. Use that here
so that clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's
value.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/982
Link: https://lkml.kernel.org/r/20200408205323.44490-1-natechancellor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/mmio-mod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index b8ef8557d4b3..2a36902d418c 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL &&
+	if (!cpumask_available(downed_cpus) &&
 	    !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
 		pr_notice("Failed to allocate mask\n");
 		goto out;
@@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
+	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {
-- 
2.25.1



