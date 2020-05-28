Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DC3215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667128;
	bh=oneoTHrWpzNqI69GqpPe4DfpOYXgyNGWsMPEeL0cg/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YivHkHv3plmzNMJSiOeB3tHpyD757iKAbxWsWCiLK+dsWq4FYp2fFsur7HE/vcxa5
	 pQiJDJwovIJymz82Q9EjN/0qHTn0swSM7/wDRGYYsjoDSFQFKNG1Or0L+52A2vzwlj
	 CJku21jfzJgoDrljen2TEpm9H4L3KI0zZODT75oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgE1L6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389106AbgE1L5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF91216C4;
        Thu, 28 May 2020 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667071;
        bh=oneoTHrWpzNqI69GqpPe4DfpOYXgyNGWsMPEeL0cg/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Snrz18/cRX/t7sqJaUujcmfQqip7qgFkmvV9LU8LaXq7bHRwLu06zxfwItAKr5SPm
         JuKKHqJWAc8fzA1xb4zKZXsI3Yn4CWEgdPXKoAq66eI9rFVkQbY5U0sFEsgdicRtZI
         bCUnSi4KMyXsnFJWXZO2DYfQolFbk4FLrUR/q2PQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/13] x86/mmiotrace: Use cpumask_available() for cpumask_var_t variables
Date:   Thu, 28 May 2020 07:57:36 -0400
Message-Id: <20200528115744.1406533-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115744.1406533-1-sashal@kernel.org>
References: <20200528115744.1406533-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4d434ddb75db..f140b2d39319 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -385,7 +385,7 @@ static void enter_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL &&
+	if (!cpumask_available(downed_cpus) &&
 	    !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
 		pr_notice("Failed to allocate mask\n");
 		goto out;
@@ -415,7 +415,7 @@ static void leave_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
+	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {
-- 
2.25.1

