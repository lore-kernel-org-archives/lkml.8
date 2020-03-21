Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6AFC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2051620776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCUOdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:33:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgCUOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBt-00047n-0f; Sat, 21 Mar 2020 15:33:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9A5241C22BC;
        Sat, 21 Mar 2020 15:33:27 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:27 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] scripts: Fix the inclusion order in modpost
Cc:     kbuild test robot <lkp@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145351.32292-17-vincenzo.frascino@arm.com>
References: <20200320145351.32292-17-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480120726.28353.6111013865150096917.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f58dd03b1157bdf3b64c36e9525f8d7f69c25df2
Gitweb:        https://git.kernel.org/tip/f58dd03b1157bdf3b64c36e9525f8d7f69c25df2
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:41 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:24:00 +01:00

scripts: Fix the inclusion order in modpost

In the process of creating the source file of a module modpost injects a
set of includes that are not required if the compilation unit is
statically built into the kernel.

The order of inclusion of the headers can cause redefinition problems
(e.g.):

   In file included from include/linux/elf.h:5:0,
                    from include/linux/module.h:18,
                    from crypto/arc4.mod.c:2:
    #define ELF_OSABI  ELFOSABI_LINUX

   In file included from include/linux/elfnote.h:62:0,
                    from include/linux/build-salt.h:4,
                    from crypto/arc4.mod.c:1:
   include/uapi/linux/elf.h:363:0: note: this is the location of
   the previous definition
    #define ELF_OSABI ELFOSABI_NONE

The issue was exposed during the development of the series [1].

[1] https://lore.kernel.org/lkml/20200306133242.26279-1-vincenzo.frascino@arm.com/

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Link: https://lkml.kernel.org/r/20200320145351.32292-17-vincenzo.frascino@arm.com

---
 scripts/mod/modpost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edfdb2..0f354b1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2251,8 +2251,12 @@ static int check_modname_len(struct module *mod)
  **/
 static void add_header(struct buffer *b, struct module *mod)
 {
-	buf_printf(b, "#include <linux/build-salt.h>\n");
 	buf_printf(b, "#include <linux/module.h>\n");
+	/*
+	 * Include build-salt.h after module.h in order to
+	 * inherit the definitions.
+	 */
+	buf_printf(b, "#include <linux/build-salt.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
