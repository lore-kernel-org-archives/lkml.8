Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D691C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059A42078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgDTR1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbgDTR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:27:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59727C061A0C;
        Mon, 20 Apr 2020 10:27:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQaCG-00035Q-7Y; Mon, 20 Apr 2020 19:27:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BBD41C007F;
        Mon, 20 Apr 2020 19:27:03 +0200 (CEST)
Date:   Mon, 20 Apr 2020 17:27:03 -0000
From:   "tip-bot2 for Christian Brauner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso/datapage: Use correct clock mode name in comment
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
References: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Message-ID: <158740362307.28353.13711119476762756523.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ac84bac4062e7fc24f5e2c61c6a414b2a00a29ad
Gitweb:        https://git.kernel.org/tip/ac84bac4062e7fc24f5e2c61c6a414b2a00a29ad
Author:        Christian Brauner <christian.brauner@ubuntu.com>
AuthorDate:    Mon, 20 Apr 2020 12:06:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Apr 2020 19:19:52 +02:00

vdso/datapage: Use correct clock mode name in comment

While the explanation for time namespace <-> vdso interactions is very
helpful it uses the wrong name in the comment when describing the clock
mode making grepping a bit annoying.

This seems like an accidental oversight when moving from VCLOCK_TIMENS
to VDSO_CLOCKMODE_TIMENS. It seems that
660fd04f9317 ("lib/vdso: Prepare for time namespace support") misspelled
VCLOCK_TIMENS as VLOCK_TIMENS which explains why it got missed when
VCLOCK_TIMENS became VDSO_CLOCKMODE_TIMENS in
2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes").

Update the comment to use VDSO_CLOCKMODE_TIMENS.

Fixes: 660fd04f9317 ("lib/vdso: Prepare for time namespace support")
Fixes: 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200420100615.1549804-1-christian.brauner@ubuntu.com

---
 include/vdso/datapage.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5cbc9fc..7955c56 100644
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
