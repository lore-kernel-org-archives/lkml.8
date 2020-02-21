Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718E0C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EB920637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273687;
	bh=uaqtr6l3s3vDn9atw6+mtNDLwhEDUDOlpKODIU0dLpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POXDv2nqUD/cUPikE1MBcU05Tum/vvHo/jQn6aPJeIH3EPYI81GMM1pohYRbKiGFC
	 IxyOs31r17a1hgOmHSidcxt4R7Pvmey519YHPoKauA3uWw1dUglcRYy+RjXo3DCjGK
	 q74VLl59ThG3VrsZjZDB1qFXloQDtu2WQ8VjMXmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgBUI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgBUIUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:20:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D8E2469D;
        Fri, 21 Feb 2020 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273242;
        bh=uaqtr6l3s3vDn9atw6+mtNDLwhEDUDOlpKODIU0dLpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEiblTRt6QvdiQNLivGKAUlE5aLI+at24KtjP/edNWzxWZVcWjvavTf8X6APoQyfO
         qX9N4wBzFo5kfA+Y19grdVc8gaHgBGmn04UPX3/HXOhjGodjznTMx1/sVm7/oDnsUW
         W122S9dN8kNRqyB7kxe7h2bvQ70eQdFhhfvIxKbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 099/191] x86/unwind/orc: Fix !CONFIG_MODULES build warning
Date:   Fri, 21 Feb 2020 08:41:12 +0100
Message-Id: <20200221072303.000088196@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

[ Upstream commit 22a7fa8848c5e881d87ef2f7f3c2ea77b286e6f9 ]

To fix follwowing warning due to ORC sort moved to build time:

  arch/x86/kernel/unwind_orc.c:210:12: warning: ‘orc_sort_cmp’ defined but not used [-Wunused-function]
  arch/x86/kernel/unwind_orc.c:190:13: warning: ‘orc_sort_swap’ defined but not used [-Wunused-function]

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/c9c81536-2afc-c8aa-c5f8-c7618ecd4f54@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 89be1be1790c4..a3cb70fbe941a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -176,6 +176,8 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_ftrace_find(ip);
 }
 
+#ifdef CONFIG_MODULES
+
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
@@ -218,7 +220,6 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 }
 
-#ifdef CONFIG_MODULES
 void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 			void *_orc, size_t orc_size)
 {
-- 
2.20.1



