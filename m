Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A074CC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734B720717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4JrsQqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TJos7CsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgGQXhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:37:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:37:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595029070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qhBCp5oifLUN19We7Kb5IeTk7cj/ecbete5sSwz5VUs=;
        b=k4JrsQqUWJpSxIsq5XesfpB5sTIc3ogCGGn2Wha9vRngRdl29bapWaYJevS+XojBS8rcve
        vr/CvkEhBh/aFeW/o3pEVjD5I50v3l/vcY90xuMpiQpCUv9WiAI1Y8rvnL4+nMr30VIltX
        juVhJjUfB8tu2FCcH/TDvmKMdQ2gP9teqx7ihqhA86AVwSO92BqZArcO8CtqlU8EppwFev
        yR49SmBHFxfNsTXdV6d7evVc1ZxYa51kaeKRa6KnOrun1RzUPctSF3XlMCTGFkPj69vVHr
        scH1W4bAfZhIc+hkCzEyOG3QxGJQuh0WYzjHj5YVx0gC7WY5SHTWpfB4uvtXUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595029070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qhBCp5oifLUN19We7Kb5IeTk7cj/ecbete5sSwz5VUs=;
        b=TJos7CsRZijD2Iwi2ej/8iISuuowFHmWTVTXGJPlQ3VwsO8FqV5x1ZS8DHNkj3GdyxA9DR
        DlO+A7bXhhXa9WAQ==
To:     "Li\, Aubrey" <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of IRQ and softirq
In-Reply-To: <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
References: <cover.1593530334.git.vpillai@digitalocean.com> <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com> <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
Date:   Sat, 18 Jul 2020 01:37:50 +0200
Message-ID: <87y2nhpvap.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Li, Aubrey" <aubrey.li@linux.intel.com> writes:
> On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
>
> We saw a lot of soft lockups on the screen when we tested v6.
>
> [  186.527883] watchdog: BUG: soft lockup - CPU#86 stuck for 22s! [uperf:5551]
> [  186.535884] watchdog: BUG: soft lockup - CPU#87 stuck for 22s! [uperf:5444]
> [  186.555883] watchdog: BUG: soft lockup - CPU#89 stuck for 22s! [uperf:5547]
> [  187.547884] rcu: INFO: rcu_sched self-detected stall on CPU
> [  187.553760] rcu: 	40-....: (14997 ticks this GP) idle=49a/1/0x4000000000000002 softirq=1711/1711 fqs=7279 
> [  187.564685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 14
> [  187.564723] NMI watchdog: Watchdog detected hard LOCKUP on cpu 38
>
> The problem is gone when we reverted this patch. We are running multiple
> uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> This is 100% reproducible on our side.

ROTFL. I just predicted that from staring at the patch ....
