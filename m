Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C411C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB41F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ayOAwVtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgEETAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:00:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:51972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgEETAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ED9C62A1541;
        Tue,  5 May 2020 15:00:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nv6F0bF46OsB; Tue,  5 May 2020 15:00:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A03BB2A1540;
        Tue,  5 May 2020 15:00:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A03BB2A1540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588705237;
        bh=Rjfz5xymzYaDcKUScYp/x3NNVUdXiC7q7LLU5PE9Yq4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ayOAwVtM4nE+ZDxaOO5eNAuu33/KbfNxDDp0x+j3OTv50a2by86tDlyHwyREqIsH1
         fz2BPGF2dtJOwcULCxNlkmRqM1oy4a2fW/rmecuuXmGtPW1sNy7IfWMBbGl7b3vh5s
         E500PXdbCAQWVwtm/MB55xjPtlHHyH/8Yb6F+1OhEQVCiMORxHaqCoWZPa+qC1yBkK
         S35I0iJxPUnhqaZdnUsRymi8I0xAUCZ7JNN3DmdoMwOakXX2x2vGnJqnJnR31skm0/
         dbif8G54c1HqUSYTkAJOI1dZmptNL0FDw4eM0Ie+zMpYWZ9RAGSbXXwFewI+zi7uzz
         UTGx/j2RfK6TQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mo_UgZ0kehgb; Tue,  5 May 2020 15:00:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 89D572A1819;
        Tue,  5 May 2020 15:00:37 -0400 (EDT)
Date:   Tue, 5 May 2020 15:00:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ndesaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <656098739.766.1588705237442.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com>
References: <20200501202849.647891881@infradead.org> <20200503125813.GL3762@hirez.programming.kicks-ass.net> <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk> <20200504201445.GQ3762@hirez.programming.kicks-ass.net> <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com> <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com> <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3928)
Thread-Topic: static_call: Add static_cond_call()
Thread-Index: TBBGZFVyha9Zhc3xVPg/xpFfwyTxwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 2:48 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
[...]
> 
> Your initial reaction that "you can't compile away the read and the
> test of NULL" was correct, I think.

I suspect this pattern of "if (func != NULL) func(...)" could be semantically
changed to just invoking an empty function which effectively does nothing.
This would remove the need to do a pointer check in the first place. But maybe
I'm missing something subtle about why it has not been done in this context.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
