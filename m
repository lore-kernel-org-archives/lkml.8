Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13EEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D652070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgCSSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:03:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgCSSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:03:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEzVo-0006wd-Nw; Thu, 19 Mar 2020 19:03:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C943C1C22B5;
        Thu, 19 Mar 2020 19:03:19 +0100 (CET)
Date:   Thu, 19 Mar 2020 18:03:19 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/configs: Slightly reduce defconfigs
Cc:     Randy Dunlap <rdunlap@infradead.org>, Borislav Petkov <bp@suse.de>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <433f203e-4e00-f317-2e6b-81518b72843c@infradead.org>
References: <433f203e-4e00-f317-2e6b-81518b72843c@infradead.org>
MIME-Version: 1.0
Message-ID: <158464099943.28353.10943155317127048693.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e2bdafc1070f5db0bc1bc40116955f54188771cb
Gitweb:        https://git.kernel.org/tip/e2bdafc1070f5db0bc1bc40116955f54188771cb
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 25 Feb 2020 21:14:05 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Mar 2020 18:48:52 +01:00

x86/configs: Slightly reduce defconfigs

Eliminate 2 config symbols from both x86 defconfig files:
HAMRADIO and FDDI.

The FDDI Kconfig file even says (for the FDDI config symbol):
  Most people will say N.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org> # CONFIG_FDDI
Link: https://lkml.kernel.org/r/433f203e-4e00-f317-2e6b-81518b72843c@infradead.org
---
 arch/x86/configs/i386_defconfig   | 2 --
 arch/x86/configs/x86_64_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 59ce9ed..5b602be 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -125,7 +125,6 @@ CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
-CONFIG_HAMRADIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
@@ -171,7 +170,6 @@ CONFIG_FORCEDETH=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_R8169=y
-CONFIG_FDDI=y
 CONFIG_INPUT_POLLDEV=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0b9654c..f3d1f36 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -123,7 +123,6 @@ CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
-CONFIG_HAMRADIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
@@ -164,7 +163,6 @@ CONFIG_SKY2=y
 CONFIG_FORCEDETH=y
 CONFIG_8139TOO=y
 CONFIG_R8169=y
-CONFIG_FDDI=y
 CONFIG_INPUT_POLLDEV=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
