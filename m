Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC2C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D12121741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgBEOMA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:12:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBEOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:12:00 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1izLPH-0002qQ-Kj; Wed, 05 Feb 2020 15:11:55 +0100
Date:   Wed, 5 Feb 2020 15:11:55 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     maddy <maddy@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] per-CPU usage in perf core-book3s
Message-ID: <20200205141155.ssmlyt72xu7sieuh@linutronix.de>
References: <20200127150620.taio2txyqreg4kn6@linutronix.de>
 <c26f6c2c-980f-c1b2-ff7c-7a5e2a5771cd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c26f6c2c-980f-c1b2-ff7c-7a5e2a5771cd@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05 07:10:59 [+0530], maddy wrote:
> Yes, currently we dont have anything that prevents the timer
> callback to interrupt pmu::event_init. Nice catch. Thanks for
> pointing this out.

You are welcome.

> Looking at the code, per-cpu variable access are made to
> check for constraints and for Branch Stack (BHRB). So could
> wrap this block of  pmu::event_init with local_irq_save/restore.
> Will send a patch to fix it.

Okay. Please keep me in the loop :)

> 
> Maddy

Sebastian
