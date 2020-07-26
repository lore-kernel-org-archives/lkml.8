Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E27B20658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGZQ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:57:10 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:38256 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:57:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 899589109;
        Sun, 26 Jul 2020 18:57:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3PsRqud5qPii; Sun, 26 Jul 2020 18:57:03 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3CEC890F5;
        Sun, 26 Jul 2020 18:57:03 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jzjvI-001tO0-Tn; Sun, 26 Jul 2020 18:54:52 +0200
Date:   Sun, 26 Jul 2020 18:54:52 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     speakup@braille.uwo.ca, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/speakup: Update TODO list
Message-ID: <20200726165452.qhos3wrjcm6jmcmx@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, speakup@braille.uwo.ca,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Okash's latest work, the TODO list is essentially empty, so
the way out from staging now seems open.

The status of the remaining issue mentioned in TODO is not clear, we
asked the speakup user mailing list for reproducer cases, but didn't get
a really specific scenario. One serious bug was fixed by 9d32c0cde4e2
("staging/speakup: fix get_word non-space look-ahead"), which does not
seem to really be related to the bug mentioned in TODO. Possibly the bug
mentioned in TODO has been fixed long ago and people have been thinking
that it was not because they can not distinguish the symptoms mentioned
in TODO from the symptoms of the bug fixed by 9d32c0cde4e2.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/drivers/staging/speakup/TODO b/drivers/staging/speakup/TODO
index 993410c3e531..d4ca093bf0bd 100644
--- a/drivers/staging/speakup/TODO
+++ b/drivers/staging/speakup/TODO
@@ -6,35 +6,11 @@ Speakup is a kernel based screen review package for the linux operating
 system.  It allows blind users to interact with applications on the
 linux console by means of synthetic speech.
 
-Currently, speakup has several issues we know of.
+Currently, speakup has one issue we know of.
 
-The first issue has to do with the way speakup communicates with serial
-ports.  Currently, we communicate directly with the hardware
-ports. This however conflicts with the standard serial port drivers,
-which poses various problems. This is also not working for modern hardware
-such as PCI-based serial ports.  Also, there is not a way we can
-communicate with USB devices.  The current serial port handling code is
-in serialio.c in this directory.
-
-Some places are currently using in_atomic() because speakup functions
-are called in various contexts, and a couple of things can't happen
-in these cases. Pushing work to some worker thread would probably help,
-as was already done for the serial port driving part.
-
-There is a duplication of the selection functions in selections.c. These
-functions should get exported from drivers/char/selection.c (clear_selection
-notably) and used from there instead.
-
-The kobjects may have to move to a more proper place in /sys. The
-discussion on lkml resulted to putting speech synthesizers in the
-"speech" class, and the speakup screen reader itself into
-/sys/class/vtconsole/vtcon0/speakup, the nasty path being handled by
-userland tools.
-
-Another issue seems to only happen on SMP systems.  It seems
-that text in the output buffer gets garbled because a lock is not set.
-This bug happens regularly, but no one has been able to find a situation
-which produces it consistently.
+It seems to only happen on SMP systems. It seems that text in the output buffer
+gets garbled because a lock is not set. This bug happens regularly, but no one
+has been able to find a situation which produces it consistently.
 
 Patches, suggestions, corrections, etc, are definitely welcome.
 
@@ -42,6 +18,5 @@ We prefer that you contact us on the mailing list; however, if you do
 not want to subscribe to a mailing list, send your email to all of the
 following:
 
-w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca and
-samuel.thibault@ens-lyon.org.
-
+okash.khawaja@gmail.com, w.d.hubbs@gmail.com, chris@the-brannons.com,
+kirk@reisers.ca and samuel.thibault@ens-lyon.org.
