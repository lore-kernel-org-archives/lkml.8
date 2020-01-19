Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BDC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C732467A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgASKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:40:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgASKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:40:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1it80d-0001fg-0W; Sun, 19 Jan 2020 11:40:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9C9101C1A1B;
        Sun, 19 Jan 2020 11:40:46 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:40:46 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] efi/capsule-loader: Explicitly include linux/io.h
 for page_to_phys()
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126165417.22423-7-sean.j.christopherson@intel.com>
References: <20191126165417.22423-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157943044646.396.15130430056668189892.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     c6625a314cb81149718390c6be01a9294a016966
Gitweb:        https://git.kernel.org/tip/c6625a314cb81149718390c6be01a9294a016966
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 26 Nov 2019 08:54:11 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:15:48 +01:00

efi/capsule-loader: Explicitly include linux/io.h for page_to_phys()

Through a labyrinthian sequence of includes, usage of page_to_phys() is
dependent on the include of asm/io.h in x86's asm/realmode.h, which is
included in x86's asm/acpi.h and thus by linux/acpi.h.  Explicitly
include linux/io.h to break the dependency on realmode.h so that a
future patch can remove the realmode.h include from acpi.h without
breaking the build.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/r/20191126165417.22423-7-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index b139513..d3067cb 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/efi.h>
