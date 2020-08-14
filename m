Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33B5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C//CjU4u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3m6G5N79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHNL4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgHNL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:56:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D2C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:56:23 -0700 (PDT)
Message-Id: <20200814101933.574326079@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597406181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=Vg1F9ZHbEUn2ExotEwu5Pprj3knGPkgwMJo72vYiC8I=;
        b=C//CjU4u8e306CDxSW4FHbTNzCzvPhW911AcAgwm4b3gbqEjBtYyL+O3OtpnP5U8GKtFc7
        9yOMmhQVIwtnxDO0jX4Rgfp8hKcHAsunjdPyD+Mms+06kYVmjJkqA+OCIb4ncYaMElVTOI
        LRNwO8PJApnM9iXnEDJ4Wq6rmI9XOf0iwZVkDTsFjV9/QnGJ17TrW/sbaCY44bSm1Tclpl
        myCcvNEXKJFxZckr19FQLdnPxn2plzklPSY2cSpoOcW0h47cnmIQhgIFHTENN7oDAA1iVM
        SieujuS0VMCaCDQv23F1TVivkEttQIMqXrIkupnPRgabQI06l7PYJFXfUG6XOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597406181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=Vg1F9ZHbEUn2ExotEwu5Pprj3knGPkgwMJo72vYiC8I=;
        b=3m6G5N79xheu48zAQO6/Z31zK1LYc16wuFqLmkkpd/OGwmp5h3Jur0gD1OSBnKTqdPAhu9
        NyZ2M2JboDbZc4Dw==
Date:   Fri, 14 Aug 2020 12:19:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk intends to store various timestamps (MONOTONIC, REALTIME, BOOTTIME)
to make correlation of dmesg accross different machines easier.

The NMI safe timekeeper allows to retrieve these timestamps from any
context, but it lacks a few things:

  1) The nmi safe accessors are not providing time stamps until timekeeping
     is initialized during early boot.

     This can be mitigated by using sched clock up to the point where time-
     keeping becomes available. This has no side effects because clock
     monotonic takes sched clock into account at initialization time
     anyway. So no random time jumps are possible.

     If early sched clock is not available then there is no difference
     either, obviously. Both return 0.

  2) It requires a new accessor which allows to retrieve all three clock
     timestamps in one go.

     Trivial excercise. But there are a few twists:

     A) Access to boot time can be racy if the sleep time offset on resume
     	is injected after timekeeping resume. That's the case when the RTC
     	or whatever is used to calculate sleep time is not availble when
	the timekeeping core is resumed.

     B) Timestamps are frozen accross the very inner low level
     	suspend/resume path. Not a big problem, but might affect the
     	developer debug printks.

     A detailed description of these two points is in the changelog of
     patch 2.

Thanks,

	tglx
