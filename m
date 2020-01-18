Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E015C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E8A2468C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgARKpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 05:45:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgARKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 05:45:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1islb6-0006sd-CF; Sat, 18 Jan 2020 11:44:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC0011C0325;
        Sat, 18 Jan 2020 11:44:55 +0100 (CET)
Date:   Sat, 18 Jan 2020 10:44:55 -0000
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/documentation] MAINTAINERS: Mark simple firmware interface
 (SFI) obsolete
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200118082545.23464-1-lukas.bulwahn@gmail.com>
References: <20200118082545.23464-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <157934429574.396.10093505590671688891.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/documentation branch of tip:

Commit-ID:     b2aa09178d1132bc6731af609a079dde83feddc1
Gitweb:        https://git.kernel.org/tip/b2aa09178d1132bc6731af609a079dde83feddc1
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Sat, 18 Jan 2020 09:25:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 18 Jan 2020 11:38:37 +01:00

MAINTAINERS: Mark simple firmware interface (SFI) obsolete

Len Brown has not been active in this part since around 2010 and
confirmed that he is not maintaining this part of the kernel sources
anymore and the git log suggests that nobody is actively maintaining it.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200118082545.23464-1-lukas.bulwahn@gmail.com
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4017e6b..fe82a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15044,11 +15044,8 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
