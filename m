Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBDBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB95206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369572;
	bh=CC8GE+CSYun6IUecFV4bWTtigoHsjzmK0rzxyp3p9C8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dWUtAzOCc1JPqYFypa3NxLsfzDgsjcYOqp0Qvwpw58AMc+JtG261/TOpRYIOgccQ6
	 Lu1h/VZnQKiOpwhBobsyFXf10He85YnuozHb+2ShDqGBdyXr2FkvcOkpbB1n9SQnLA
	 eFVLrRe7gQDxwhDNSjqTlf1sqZsahcinbD/015Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgF1Sja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:39:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BAC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:39:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so14434557ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qSaWVRUl2zO300rdtSbnSVLJbcBuaQneyMj8/TgXCjw=;
        b=fRVzn9mePWUQG0QOf3biD4mbJ9q23eAqskyHVpDXJsHwz8CrCEqVqTkmHNLB/TNJms
         X54fEjUeKQrAHi4g8o5gTNfruauiTRU21d7O7Mb86na8S/AMH+wQ6Kp3FVKoI+fuD7yP
         0yARVR/hZmDFc3C4osXcvBNOGBNs+Zwfx7xWFvXL9+tTUB29YVCGjy/iMADeXIKbPDxm
         oGBYKuBv2ybbXFmsph+UVg3jrzwunmBfwQM7AMqThTcjAWGosy0jp2RfglAWwQ3NcgKI
         kXhl6EwFHTK5vPByXr5j0wXki6TdRoNMVkXpE76YwajximcNzvQedDS7VbX1mmx+kDu5
         Y2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qSaWVRUl2zO300rdtSbnSVLJbcBuaQneyMj8/TgXCjw=;
        b=texUAB+wQxs+llFQEhEanolDWd6SCZdybyzWwb2ocyTb2sGFi/1a1lb4ney36tlXLs
         sgOXwj1aj3is97sdV4rKuciGANSi1Pypq99MzCq57dlQAaVpL/4xSVc7mrtgAMV1EWIs
         21Kh8nofKWrEI5Aut3RHKdBPQmoFq+wM43mWULkInGSylTcQVhgt/bdLCjd/CCpOLCsD
         ce65tC+N7HkOcyuVaFp3xb1zrLXx76P+4s2Y7fZScm96apuu45y5qZerL4nNw2r8xLUx
         Cwy4pFfkVDRIf/E7rPtZG+4+GdHsJmbbpxzIFmfgqC/HI5ld5x4dAdL2O1Nt9mfwICyE
         B4BQ==
X-Gm-Message-State: AOAM533Ynm3aTkQUXr69Fi7TVH51n+djwHhxs1xzv12h3dnMRMaJ5OyX
        T7dN5jZIPoXEpSBJT1GRwvMD31P1
X-Google-Smtp-Source: ABdhPJzI2oy/4oBpKNl6hS1DeUHpmuc4rLoHBBQcehCspc8dR4HjKmtAuP+/FzpYtPiDgCJ0oh5gig==
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr9791066ejb.8.1593369567985;
        Sun, 28 Jun 2020 11:39:27 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l33sm11529661edl.48.2020.06.28.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:39:27 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:39:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20200628183925.GA219470@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-06-28

   # HEAD: f097eb38f71391ff2cf078788bad5a00eb3bd96a timekeeping: Fix kerneldoc system_device_crosststamp & al

A single DocBook fix.

 Thanks,

	Ingo

------------------>
Kurt Kanzenbach (1):
      timekeeping: Fix kerneldoc system_device_crosststamp & al


 include/linux/timekeeping.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b27e2ffa96c1..d5471d6fa778 100644
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
