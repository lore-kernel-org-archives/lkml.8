Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0879C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D45A2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgAVKD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:03:56 -0500
Received: from foss.arm.com ([217.140.110.172]:54282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgAVKD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:03:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA221FB;
        Wed, 22 Jan 2020 02:03:53 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FD73F68E;
        Wed, 22 Jan 2020 02:03:52 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH] kconfig: Sanitize make randconfig generated .config
Date:   Wed, 22 Jan 2020 10:03:44 +0000
Message-Id: <20200122100344.50751-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make randconfig" calculates the probability of a tristate option (yes,
mod, no) based on srand()/rand() and can be fed with a seed.
At the last step of randconfig some option are chosen randomly and their
tristate set based on similar mechanism.
After this passage the resulting .config is not sanitized, hence it
might result in an inconsistent set of options being selected.

This was noticed on arm64 using KCONFIG_SEED=0x40C5E904. During
randomize_choice_values() CONFIG_BIG_ENDIAN is enabled. Since CONFIG_EFI
was enabled at a previous step, and depends on !CONFIG_BIG_ENDIAN the
resulting .config is inconsistent.

Fix the issue making sure that randconfig sanitizes the generated
.config as a last step.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 scripts/kconfig/conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 1f89bf1558ce..c0fcaa4e9762 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -654,6 +654,11 @@ int main(int ac, char **av)
 	case randconfig:
 		/* Really nothing to do in this loop */
 		while (conf_set_all_new_symbols(def_random)) ;
+		/*
+		 * .config at this point might contain
+		 * incompatible options. Sanitize it.
+		 */
+		sym_clear_all_valid();
 		break;
 	case defconfig:
 		conf_set_all_new_symbols(def_default);
-- 
2.25.0

