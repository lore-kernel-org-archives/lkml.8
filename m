Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E8C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBZMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:37:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:37:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6vwY-0006sw-TO; Wed, 26 Feb 2020 13:37:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5674E1C201B;
        Wed, 26 Feb 2020 13:37:38 +0100 (CET)
Date:   Wed, 26 Feb 2020 12:37:38 -0000
From:   "tip-bot2 for Anders Roxell" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Make CMDLINE_OVERRIDE depend on
 non-empty CMDLINE
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200124114615.11577-1-anders.roxell@linaro.org>
References: <20200124114615.11577-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Message-ID: <158272065802.28353.14643125310636078839.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     645e64662af4dba9eb4a80bbab2663dd22018312
Gitweb:        https://git.kernel.org/tip/645e64662af4dba9eb4a80bbab2663dd22018312
Author:        Anders Roxell <anders.roxell@linaro.org>
AuthorDate:    Fri, 24 Jan 2020 12:46:15 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 26 Feb 2020 13:31:46 +01:00

x86/Kconfig: Make CMDLINE_OVERRIDE depend on non-empty CMDLINE

When trying to boot an allmodconfig kernel that is built with
KCONFIG_ALLCONFIG=$(pwd)/arch/x86/configs/x86_64_defconfig, it doesn't
boot since CONFIG_CMDLINE_OVERRIDE gets enabled and that requires the
user to pass the full cmdline to CONFIG_CMDLINE.

Change so that CONFIG_CMDLINE_OVERRIDE gets set only if CONFIG_CMDLINE
is set to something except an empty string.

 [ bp: touchup. ]

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200124114615.11577-1-anders.roxell@linaro.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea770..b414192 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2418,7 +2418,7 @@ config CMDLINE
 
 config CMDLINE_OVERRIDE
 	bool "Built-in command line overrides boot loader arguments"
-	depends on CMDLINE_BOOL
+	depends on CMDLINE_BOOL && CMDLINE != ""
 	---help---
 	  Set this option to 'Y' to have the kernel ignore the boot loader
 	  command line, and use ONLY the built-in command line.
