Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17382C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EFE20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDTKGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:06:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35163 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:06:25 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQTJi-00044w-Ou; Mon, 20 Apr 2020 10:06:18 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH] vdso/datapage: use correct clock mode name in comment
Date:   Mon, 20 Apr 2020 12:06:15 +0200
Message-Id: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the explanation for time namespace <-> vdso interactions is very
helpful it uses the wrong name in the comment when describing the clock
mode making grepping a bit annoying.

This seems like an accidental oversight when moving from VCLOCK_TIMENS
to VDSO_CLOCKMODE_TIMENS. It seems that
660fd04f9317 ("lib/vdso: Prepare for time namespace support") misspelled
VCLOCK_TIMENS as VLOCK_TIMENS which explains why it got missed when
VCLOCK_TIMENS became VDSO_CLOCKMODE_TIMENS in
2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes").

Update the commit to use VDSO_CLOCKMODE_TIMENS.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrei Vagin <avagin@gmail.com>
Fixes: 660fd04f9317 ("lib/vdso: Prepare for time namespace support")
Fixes: 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/vdso/datapage.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5cbc9fcbfd45..7955c56d6b3c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -73,8 +73,8 @@ struct vdso_timestamp {
  *
  * @offset is used by the special time namespace VVAR pages which are
  * installed instead of the real VVAR page. These namespace pages must set
- * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
- * time namespace slow path. The namespace aware functions retrieve the
+ * @seq to 1 and @clock_mode to VDSO_CLOCKMODE_TIMENS to force the code into
+ * the time namespace slow path. The namespace aware functions retrieve the
  * real system wide VVAR page, read host time and add the per clock offset.
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.1

