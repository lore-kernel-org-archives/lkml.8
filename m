Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FBF20720
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgFRJkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgFRJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:40:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC3C06174E;
        Thu, 18 Jun 2020 02:40:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlr26-00057f-LJ; Thu, 18 Jun 2020 11:40:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E30C1C0087;
        Thu, 18 Jun 2020 11:40:28 +0200 (CEST)
Date:   Thu, 18 Jun 2020 09:40:28 -0000
From:   "tip-bot2 for Kurt Kanzenbach" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix kerneldoc
 system_device_crosststamp & al
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200609081726.5657-1-kurt@linutronix.de>
References: <20200609081726.5657-1-kurt@linutronix.de>
MIME-Version: 1.0
Message-ID: <159247322824.16989.7576904284562875293.tip-bot2@tip-bot2>
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

Commit-ID:     f097eb38f71391ff2cf078788bad5a00eb3bd96a
Gitweb:        https://git.kernel.org/tip/f097eb38f71391ff2cf078788bad5a00eb3bd96a
Author:        Kurt Kanzenbach <kurt@linutronix.de>
AuthorDate:    Tue, 09 Jun 2020 10:17:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 11:37:03 +02:00

timekeeping: Fix kerneldoc system_device_crosststamp & al

Make kernel doc comments actually work and fix the syncronized typo.

[ tglx: Added the missing /** and fixed up formatting ]

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200609081726.5657-1-kurt@linutronix.de

---
 include/linux/timekeeping.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b27e2ff..d5471d6 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,9 +222,9 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
-/*
+/**
  * struct system_time_snapshot - simultaneous raw/real time capture with
- *	counter value
+ *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
  * @raw:	Monotonic raw system time
@@ -239,9 +239,9 @@ struct system_time_snapshot {
 	u8		cs_was_changed_seq;
 };
 
-/*
+/**
  * struct system_device_crosststamp - system/device cross-timestamp
- *	(syncronized capture)
+ *				      (synchronized capture)
  * @device:		Device time
  * @sys_realtime:	Realtime simultaneous with device time
  * @sys_monoraw:	Monotonic raw simultaneous with device time
@@ -252,12 +252,12 @@ struct system_device_crosststamp {
 	ktime_t sys_monoraw;
 };
 
-/*
+/**
  * struct system_counterval_t - system counter value with the pointer to the
- *	corresponding clocksource
+ *				corresponding clocksource
  * @cycles:	System counter value
  * @cs:		Clocksource corresponding to system counter value. Used by
- *	timekeeping code to verify comparibility of two cycle values
+ *		timekeeping code to verify comparibility of two cycle values
  */
 struct system_counterval_t {
 	u64			cycles;
