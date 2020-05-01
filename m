Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E1C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0C720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O70ZwJse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEAC05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:26:57 -0400
Received: from mail.efficios.com ([167.114.26.124]:43244 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgEAC05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:26:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2F08029426E;
        Thu, 30 Apr 2020 22:26:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sqt2ALfu7xgs; Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CC180294022;
        Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CC180294022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588300015;
        bh=ZF3kaW85r3lYEjroSS8PIY6B5jzb4TIQMkaij/jZUlg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O70ZwJseNiVOWxRXsVh9uQ0MnsRF2OCSriMm4aV+c08qg5dcCG8Z6auJNKmHaapNN
         kwQexk93+gbCgsYeCiDTlIjWckc5+dNaNierSVF5LwG9Mtuby9OrN4yBxVlbPQ5+91
         wyEnWeuXyt7VePkIn2JG3NXs1+ihc5BeIRLLJeMny3PdI0J88sYZ7Je0wZS0f/OrnY
         1IctGUvp8w5lgqDM5L6dzodGGb6l4jhy6ssSBRLW7R2b8nEGBB/gNjuYCR75mDci/C
         Lf6Y2vDFGhn6Ln55ck3k3HpF0tZi8k02m3BxFBfHrwN5WBI5IaimaINlD4ENhGcU1X
         Ak7EULrfPJb0w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ulcWaEYJbfqh; Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B8A8929401F;
        Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
Date:   Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Message-ID: <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430211308.74a994dc@oasis.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430121136.6d7aeb22@gandalf.local.home> <20200430191434.GC8135@suse.de> <20200430211308.74a994dc@oasis.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: kBddBN1oVQ4F/2TWc3Q4S/2/epDTaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 9:13 PM, rostedt rostedt@goodmis.org wrote:

> [ Joerg, sending again this time not just to you. (hit reply to sender
>  and not reply to all). Feel free to resend what you wrote before to this ]
> 
> On Thu, 30 Apr 2020 21:14:34 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
>> And alloc_percpu() calls down into pcpu_alloc(), which allocates new
>> percpu chunks using vmalloc() on x86. And there we are again in the
>> vmalloc area.
> 
> So after a vmalloc() is made, should the page tables be synced?

Why should it ? Usually, the page fault handler is able to resolve the
resulting minor page faults lazily.

> 
> This is a rather subtle bug, and I don't think it should be the caller of
> percpu_alloc() that needs to call vmalloc_sync_mappings().

Who said tracing was easy ? ;-)

> What's your suggestion for a fix?

I know the question is not addressed to me, but here are my 2 cents:

It's subtle because ftrace is tracing the page fault handler through
tracepoints. It would not make sense to slow down all vmalloc or
percpu_alloc() just because tracing recurses when tracing page faults.

I think the right approach to solve this is to call vmalloc_sync_mappings()
before any vmalloc'd memory ends up being observable by instrumentation.
This can be achieved by adding a vmalloc_sync_mappings call on tracepoint
registration like I proposed in my patchset a few week ago:

https://lore.kernel.org/r/20200409193543.18115-2-mathieu.desnoyers@efficios.com

The tracers just have to make sure they perform their vmalloc'd memory
allocation before registering the tracepoint which can touch it, else they
need to issue vmalloc_sync_mappings() on their own before making the
newly allocated memory observable by instrumentation.

This approach is not new: register_die_notifier() does exactly that today.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
