Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB9C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7637D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="a0h2NHQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgD3QS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:28 -0400
Received: from mail.efficios.com ([167.114.26.124]:38972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgD3QSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1493A28FB39;
        Thu, 30 Apr 2020 12:18:23 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bzyRC6oWE99D; Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BC0A028F877;
        Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC0A028F877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588263502;
        bh=L55kMAHWHtClXwT3AsAHrTu4aKopstWuDvA/OyUEXfw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a0h2NHQD3T8P5WMYNRq/esttBzqmJ5x00gb7J/F1X1p6JpLeAsgsEjUh20DCv5pma
         muv6+Y+WUACsdkjNSDLiDjqG5hvb6yHS6wC/GWDD2Qv4uXPq+X5GuKGUOeU8DYAU79
         FeizHDpFWpLt7Eica3HjqwfMiPaqwuy5tDBXdfo2sYvAahVQ0yPLnPRiotbk6OgQQn
         wCK0OGubt84svS5QivphLQZZnRkPTBLj4ZQfyFadgrMxG12mZ+idp88uglnv7LPBqK
         nOBKkfqgqri7WE8fQALZX4/KWthxgXjAOK0+5vvtENlNMbcdJp3o5vXKaeSwSLEw5u
         qnbLNdK4sCABA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z-dubMsoJYa8; Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AAA3428F79F;
        Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
Date:   Thu, 30 Apr 2020 12:18:22 -0400 (EDT)
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
Message-ID: <947455570.77870.1588263502669.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200430121627.682061e2@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200430141120.GA8135@suse.de> <20200430145057.GB8135@suse.de> <2026887875.77814.1588260015439.JavaMail.zimbra@efficios.com> <20200430121627.682061e2@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: rw6BtFhk9xaOWvTrQYsbm6qr+yaRNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 30, 2020, at 12:16 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 30 Apr 2020 11:20:15 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > The right fix is to call vmalloc_sync_mappings() right after allocating
>> > tracing or perf buffers via v[zm]alloc().
>> 
>> Either right after allocation, or right before making the vmalloc'd data
>> structure visible to the instrumentation. In the case of the pid filter,
>> that would be the rcu_assign_pointer() which publishes the new pid filter
>> table.
>> 
>> As long as vmalloc_sync_mappings() is performed somewhere *between* allocation
>> and publishing the pointer for instrumentation, it's fine.
>> 
>> I'll let Steven decide on which approach works best for him.
> 
> As stated in the other email, I don't see it having anything to do with
> vmalloc, but with the per_cpu() allocation. I'll test this theory out by
> not even allocating the pid masks and touching the per cpu data at every
> event to see if it crashes.

As pointed out in my other email, per-cpu allocation uses vmalloc when
size > PAGE_SIZE.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
