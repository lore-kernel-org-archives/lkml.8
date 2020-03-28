Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE46206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgC1Mok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:44:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Mok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:44:40 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIApE-0005BZ-Rw; Sat, 28 Mar 2020 13:44:32 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 47A481040C1; Sat, 28 Mar 2020 13:44:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "open list\:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] locking/rtmutex: Remove Comparison to bool
In-Reply-To: <alpine.LNX.2.21.1.2003281201270.20453@ninjahost.lan>
References: <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-2-jbi.octave@gmail.com> <87y2rkwwf5.fsf@nanos.tec.linutronix.de> <alpine.LNX.2.21.1.2003281201270.20453@ninjahost.lan>
Date:   Sat, 28 Mar 2020 13:44:32 +0100
Message-ID: <87o8sgwswf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules Irenge <jbi.octave@gmail.com> writes:
> On Sat, 28 Mar 2020, Thomas Gleixner wrote:
>> 
> Thanks for the feedback I take good note. I will improve next time.

And please remove these broken From: ...@example.com lines.
