Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65603C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D760207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSjdCDdl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhzC+Avw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGUSvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:51:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26777C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:51:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595357458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdipnKXv3gOGqH0ByEIYykeYoO9kup3rKdufCdBST5o=;
        b=OSjdCDdl0En8O17RWQ2kJMkhJc48ZoYrrAGhVElzkTziId74MGCnajDN+06rmSVCW1QVr7
        cM65LcmmT/xjJg76JHHyeHe9vskF8WyWPPHpRwljtRC9n3JvxYrKY2duFWsUwz7qxUm5kV
        rZNg3YM1HTY2aLwyZdk6j9JfDv1MyNuumYvFxCCZnnVaXmbDP25pahtKU/kLEtMUiucXvw
        G2tfoUBJ3IEIUbEGiw3aVwRmq/W5+kXZ+RkVot8ySNUNnfuzE7MTHHXLEK7m8ba5iAZBwi
        35HMPg1pBWa7wIdAWM/eqHS0RMcGetDeQy5tJ7mphc4srdmyEo5UHatsam7TSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595357458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdipnKXv3gOGqH0ByEIYykeYoO9kup3rKdufCdBST5o=;
        b=vhzC+AvwODodfdah/REw2j3SxBIkVwbF7H0+QNRbTVowXyai3t6WQuaoOgy3lzl9kvt/0t
        JZf8OHm/WU3Zr5AQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <87eep7nvv6.fsf@nanos.tec.linutronix.de>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200716225458.GL5523@worktop.programming.kicks-ass.net> <87tuy6q965.fsf@nanos.tec.linutronix.de> <87eep7nvv6.fsf@nanos.tec.linutronix.de>
Date:   Tue, 21 Jul 2020 20:50:57 +0200
Message-ID: <87y2nc3dny.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
>
> Bah, that creates a dependency on sched/core ...

Only when looking at the wrong tree :)
