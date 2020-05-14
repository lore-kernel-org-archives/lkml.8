Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14415C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB02065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nna48kqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbgENAMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:12:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:59312 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732871AbgENAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:12:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D33082A01DD;
        Wed, 13 May 2020 20:12:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x1rj64-fNMHO; Wed, 13 May 2020 20:12:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 50A252A02E7;
        Wed, 13 May 2020 20:12:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 50A252A02E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589415156;
        bh=yKNNRZvL8dMTn7sIxUntqrp463iCqOUIAOlejog8k00=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nna48kqPw9r2kqVBLYpY0skDMpDt3z/vv8AoHxlscGafJf3ZppQGzpJ9Xa2tmA8+F
         fQXqrIytqTkIefiKQqb24KgZAAylc4L5mWrTXfSnq60nmxGBtnvLVk/B8b5VbuNRMx
         RYnnvCfXktg7Q57+vVW4WWp3MKgsBzK1tvuXBa+N+pgluYEI+m8JRRcPNHpeoxE0j+
         tYYP6KS2HTVSx2fmzROFpuovoKPeINT82pm/7XQkrRRwuZTL7Tmqyc2r7Pylz2D4D7
         eR5MO4Vko4zUrvX/EpkzYlxRAnj09Cn+W4sIk0j2ExR3Sw3Uqrg8l9zObr9A9lZGnM
         eLK1EYGRoip/Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8AmOsT5E59SX; Wed, 13 May 2020 20:12:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3E9BB2A0356;
        Wed, 13 May 2020 20:12:36 -0400 (EDT)
Date:   Wed, 13 May 2020 20:12:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1443118821.20546.1589415156226.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134101.525508608@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134101.525508608@linutronix.de>
Subject: Re: [patch V4 part 1 35/36] x86: Replace ist_enter() with
 nmi_enter()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86: Replace ist_enter() with nmi_enter()
Thread-Index: 04pvHkpOjJdrPm9nbOo2wMfV0w97sQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> A few exceptions (like #DB and #BP) can happen at any location in the code,
> this then means that tracers should treat events from these exceptions as
> NMI-like. The interrupted context could be holding locks with interrupts
> disabled for instance.
> 
> Similarly, #MC is an actual NMI-like exception.
> 
> All of them use ist_enter() which only concerns itself with RCU, but does
> not do any of the other setup that NMIs need. This means things like:
> 
>	printk()
>	  raw_spin_lock_irq(&logbuf_lock);
>	  <#DB/#BP/#MC>
>	     printk()
>	       raw_spin_lock_irq(&logbuf_lock);
> 
> are entirely possible (well, not really since printk tries hard to
> play nice, but the concept stands).
> 
> So replace ist_enter() with nmi_enter(). Also observe that any nmi_enter()
> caller must be both notrace and NOKPROBE, or in the noinstr text section.

Are there similar issues with non-x86 architectures, or is this
exception-behaves-like-an-interrupt issue specific to x86 ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
