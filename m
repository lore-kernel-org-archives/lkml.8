Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F0C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A75E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ovhxWUTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3PUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:20:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:51162 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgD3PUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:20:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F36F528F2D9;
        Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qNbj4V80Mxgb; Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9BC7B28F4C5;
        Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9BC7B28F4C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588260015;
        bh=Lu6W5976+YDF4QPySU4/Jni56pOvaynH+19pRZWdrr4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ovhxWUTIpdBc84kPQiTlr4mY6vQEJfAFOBmlZUryLQE5eHcIvkgxBr+w9HLGOFzME
         Z3VVGGBEfLbjPsD9K2dZZclCcWhlC8ubVv2QdQKomNJGeaOfeFcbCYCbeSfCdK3RdF
         rzURGDL2K8k7LC28VIUQMqFMdQick6ZLsVwFGcMRTpe0LopXyW2FayLpsH4B1MlA5M
         lwca2NYHsFqnHSlQ5VUjFBGm/cSPJlHy7zMLgFbWi38N5m7h+ygfOE5C3iXaj0mnF9
         /2ZzJJfDWMlvHpAG5A7FQZJrBKT5K0F27dq5xoERRb7H/LOOSDAgM+OJ5epo3KFDZQ
         j8GMSrKQZ9G6g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rKevt2I_vHs9; Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 83C8E28F5B1;
        Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
Date:   Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joerg Roedel <jroedel@suse.de>, rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <2026887875.77814.1588260015439.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430145057.GB8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430145057.GB8135@suse.de>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: S3gTR+3031U2pkjEqLvIr5kkofeFSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 10:50 AM, Joerg Roedel jroedel@suse.de wrote:

> On Thu, Apr 30, 2020 at 04:11:20PM +0200, Joerg Roedel wrote:
>> The page-fault handler calls a tracing function which again ends up in
>> trace_event_ignore_this_pid(), where it faults again. From here on the CPU is in
>> a page-fault loop, which continues until the stack overflows (with
>> CONFIG_VMAP_STACK).
> 
> Did some more testing to find out what this issue has to do with
> 
>	763802b53a42 x86/mm: split vmalloc_sync_all()
> 
> Above commit removes a call to vmalloc_sync_all() from the vmalloc
> unmapping path, because that call caused severe performance regressions
> on some workloads and was not needed on x86-64 anyway.
> 
> But that call caused vmalloc_sync_all() to be called regularily on
> x86-64 machines, so that all page-tables were more likely to be in sync.
> 
> The call was introduced by commit
> 
>	3f8fd02b1bf1 mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()
> 
> to fix a correctness issue on x86-32 PAE systems, which also need
> unmappings of large pages in the vmalloc area to be synchronized.
> 
> This additional call to vmalloc_sync_all() did hide the problem. I
> verified it by reverting both of the above commits on v5.7-rc3 and
> testing on that kernel. The problem is reproducible there too, the box
> hangs hard.
> 
> So the underlying problem is that a vmalloc()'ed tracing buffer is used
> to trace the page-fault handler, so that it has no chance of faulting in
> the buffer address to poking_mm and maybe other PGDs.
> 
> The right fix is to call vmalloc_sync_mappings() right after allocating
> tracing or perf buffers via v[zm]alloc().

Either right after allocation, or right before making the vmalloc'd data
structure visible to the instrumentation. In the case of the pid filter,
that would be the rcu_assign_pointer() which publishes the new pid filter
table.

As long as vmalloc_sync_mappings() is performed somewhere *between* allocation
and publishing the pointer for instrumentation, it's fine.

I'll let Steven decide on which approach works best for him.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
