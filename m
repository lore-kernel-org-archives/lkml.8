Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A1FC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C4206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n57b7Oiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEDPip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:38:45 -0400
Received: from mail.efficios.com ([167.114.26.124]:33790 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEDPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:38:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 54387293108;
        Mon,  4 May 2020 11:38:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wBtw50ZU26bZ; Mon,  4 May 2020 11:38:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F0C1E29301F;
        Mon,  4 May 2020 11:38:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F0C1E29301F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588606724;
        bh=Gy6vkWMHf66R561OSG3T3GNqfTM+kJgguKmehJQJ/5o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n57b7OiyMvzg+fGdys5pLsCdbsWmGFmPG5b7sYdxruVIWplZprUodMkBtVzFndgkK
         rM6EfdDOCBZiBzN522zv+/KZn+2Zzh//AgSWLqrY13ic3etZZOABK3fiwRDw1klprS
         2RDuKzFpcpG1YwkFTEj+Gp+iKnyg+Azg4+T9EYr4cxXQqyBQ+Lplu0bIYbgh6VkHxq
         h8bATzoFXLpymQVdOXVLNSvblaMh0CSyVR0vGw46Ph/o0A7miLXiOFoy5nQtJocRjv
         VOIPsY+TXEuhtXJZ4/Aa4umjW5WpWXEai/qjeScbIA+gfxnQP61euoIE2asj1XaZR1
         HB+51BGLcDzLw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sexFtVLxPHTS; Mon,  4 May 2020 11:38:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DC07229301D;
        Mon,  4 May 2020 11:38:43 -0400 (EDT)
Date:   Mon, 4 May 2020 11:38:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     rostedt <rostedt@goodmis.org>,
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
Message-ID: <1533922227.82188.1588606723786.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200504153135.GJ8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home> <20200430191434.GC8135@suse.de> <20200430211308.74a994dc@oasis.local.home> <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com> <20200430223919.50861011@gandalf.local.home> <20200504151236.GI8135@suse.de> <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com> <20200504153135.GJ8135@suse.de>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: percpu: Sync vmalloc mappings in pcpu_alloc() and free_percpu()
Thread-Index: koijJ/z6mXCPro7wCDn7K0mtIqgv5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 4, 2020, at 11:31 AM, Joerg Roedel jroedel@suse.de wrote:

> On Mon, May 04, 2020 at 11:28:46AM -0400, Mathieu Desnoyers wrote:
>> ----- On May 4, 2020, at 11:12 AM, Joerg Roedel jroedel@suse.de wrote:
>> Placing this here is inefficient. It syncs mappings for each percpu allocation.
>> I would recommend moving it right after __vmalloc() is called to allocate the
>> underlying memory chunk instead:
>> 
>> static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
>> {
> 
> Tried this before, actually I put it into the caller of
> pcpu_mem_zalloc(), but that didn't fix the problem for me. Stevens
> test-case still hangs the machine.

That's unexpected.

Did you confirm that those hangs were also caused by percpu allocations ?

Maybe adding the vmalloc_sync_mappings() at each percpu allocation happens
to luckily sync mappings after some other vmalloc.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
