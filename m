Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C7BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBB9206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Mypb7zOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405281AbgFYNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:53:18 -0400
Received: from mail.efficios.com ([167.114.26.124]:56322 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:53:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A03D82CABE6;
        Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V8WUMZaIQi3E; Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 577E22CABE5;
        Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 577E22CABE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593093195;
        bh=I3csx80zJEF9mbERaYzL+rw3FEGRe/CCSKR5RSaWPvU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Mypb7zOS4tq0xtacEXQ9O367JX+/6XBDUYYZ/gjzmRfUu6PqTzaHqX/ADrJ+excrz
         oPQbEV0dzVKOvVk7z/XdXkfk+jOfg+byLaG4KDgYKUDdG362n7ji4gTnazUlql/2Y7
         R4vEBnb2RPvhUUhysms6N3ql7Agt67TmlZx1UWWNiKJKBSSbzxkDbzBbuz0fqO0P3y
         VbX1r5jin/tyciD4AUIfIwD5Tc6aRDk5mOHrZ/8Bs8SDWK/EOKxpxmTJgkX8Y2KIZV
         FSV/6GLiMWLRYNbjq2vN2KXXtGimw9Dgv1wAupfGE1kITBQ/6oBl/sSIqZs4Z3vTg7
         uPfLcZq0iys5A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jo-yAEqJQ8BW; Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 42DBD2CABE4;
        Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
Date:   Thu, 25 Jun 2020 09:53:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Message-ID: <126813531.12266.1593093195147.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200625094454.732790f7@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: pGMPEKLnUQhW+hZT70UEO/ST3lTbpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 9:44 AM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> [ SEVEN YEAR PROBLEM SOLVED! ]
> 
> Up until now, if an event is interrupted while it is recorded by an
> interrupt, and that interrupt records events, the time of those events will
> all be the same. This is because events only record the delta of the time
> since the previous event (or beginning of a page), and to handle updating
> the time keeping for that of nested events is extremely racy. After years of
> thinking about this and several failed attempts, I finally have a solution
> to solve this puzzle.

Out of curiosity, considering that LTTng has solved this problem 10+ years ago
with a simpler concurrency-friendly time-stamping model, why not simply use it
rather than add complexity to the current ftrace timestamp scheme ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
