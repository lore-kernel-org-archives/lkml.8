Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFACC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B277E206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgC1L2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:28:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1L2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:28:43 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jI9df-0004CF-9R; Sat, 28 Mar 2020 12:28:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E51DE1040C1; Sat, 28 Mar 2020 12:28:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "open list\:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] locking/rtmutex: Remove Comparison to bool
In-Reply-To: <20200327212358.5752-2-jbi.octave@gmail.com>
References: <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-2-jbi.octave@gmail.com>
Date:   Sat, 28 Mar 2020 12:28:30 +0100
Message-ID: <87y2rkwwf5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules Irenge <jbi.octave@gmail.com> writes:

> From: Jules Irenge <jbi.octave@example.com>
>
> Coccinelle reports a warning inside rt_mutex_slowunlock()
>
> WARNING: Comparison to bool
>
> To fix this, the comparison to bool is removed
> This not only fixes the issue but also removes the unnecessary comparison.
>
> Remove comparison to bool

So you explain 3 times in different ways that the comparison to bool is
removed. What's the point?

Thanks,

        tglx


