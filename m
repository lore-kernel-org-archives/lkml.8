Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D600C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEA217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mHAFG69J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBGU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:57:08 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36945 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:57:08 -0500
Received: by mail-qv1-f65.google.com with SMTP id m5so279510qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dVLwvxYnw/DhslrzZDgX9QSyZCEOsezSYOE/C4OrcU=;
        b=mHAFG69JHfiKmi6lijdzLuiwF+VS5rLnxy0GUIpw2PAJu5Q9ikrtIGYQ2Qt3opito2
         XcSPPclX9FiMMAngwHZ4wSmTDcQOQqrikh7kQi2Lt2lrBjXxujLNTYfYfe3EEz5fo5r+
         2lvTDkOR5+ncNvEPYuwqZEG25AbG0LiNj673U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dVLwvxYnw/DhslrzZDgX9QSyZCEOsezSYOE/C4OrcU=;
        b=ap1ke7b7WrXIHAAJ0JiaFDc7JiF5JCeBMfy042ZrCaOOG/WbOMm4WmrG4sQZbGyvf8
         Pbl9NDy/m/qtl31oE3jthc8s8S2rDlMgTwxEoiDCtweUldmdl5dzlkvNWT7eGAmxJJ0K
         T/8IeNtulXlDvm61Rp/nN4nBzY28spRM2sxD8qUQSTvl4fGNphv+Id7D94uVh73ZdU1b
         5nyC2RDKfLVr3EF3lmLQR6ZpgH9QLbFP6rPk2jE2jiULmLgI3exEStVd0vdkAa/C7LLp
         r22FLWfvB5nahKAM+EqGBF/JZSt5GHcUAoyxFkprp8jLAPkOLCu0TRnC4plaY2593IDs
         UwMQ==
X-Gm-Message-State: APjAAAUv/3NXhaeYiwpS9dshkCDyEc/c0KG1h/v+hlbqvUKyV2BdQUAl
        nk9PzSawjryaqqpfpGLExkn9ZLuT7Ec=
X-Google-Smtp-Source: APXvYqyMyh6YLBi79Lu69+qwx7gfRc74ZuhjiqNSWnnTAey4CDWT2VaR2PhFZ8iPVplHvwRYNTKMpQ==
X-Received: by 2002:a05:6214:10c1:: with SMTP id r1mr293428qvs.70.1581109026746;
        Fri, 07 Feb 2020 12:57:06 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 136sm1887431qkn.109.2020.02.07.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:57:06 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Date:   Fri,  7 Feb 2020 15:56:53 -0500
Message-Id: <20200207205656.61938-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
These patches remove SRCU usage from tracepoints. The reason for proposing the
reverts is because the whole point of SRCU was to avoid having to call
rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
was breaking..

Further it occurs to me that, by using SRCU for tracepoints, we forgot that RCU
is not really watching the tracepoint callbacks. This means that anyone doing
preempt_disable() in their tracepoint callback, and expecting RCU to listen to
them is in for a big surprise. When RCU is not watching, it does not care about
preempt-disable sections on CPUs as you can see in the forced-quiescent state loop.

Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
revert SRCU tracepoint code to maintain the sanity of potential
tracepoint callback registerers.

Joel Fernandes (Google) (3):
Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
it unique"
Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints"
Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"

include/linux/tracepoint.h | 40 ++++++--------------------------------
kernel/tracepoint.c        | 10 +---------
2 files changed, 7 insertions(+), 43 deletions(-)

--
2.25.0.341.g760bfbb309-goog

