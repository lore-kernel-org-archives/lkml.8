Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC66C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D775E2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n06LmP07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgEFOBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:01:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:54228 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgEFOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:01:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9251D2A8F88;
        Wed,  6 May 2020 10:01:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eG7yUYehepJm; Wed,  6 May 2020 10:01:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 534CC2A8F87;
        Wed,  6 May 2020 10:01:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 534CC2A8F87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588773672;
        bh=EQM02SNu2SWhvvdUmRvLNrhRarRYmDp/3bLLVv2cp1A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n06LmP07BKwmqLKk3yRXPML91xGwDztOH/oCmNFc3ikhd1O9fuKzGoHW8mRIkw8ma
         xXbY1uPzXddQYlZmgIFOCBtewic5/fUnf/XB9raWWQR+GVzGwKAtRP3dkUupuvccJV
         B+/dr22ZynmpYhbIWX/WwD3Bksq0DX09YiTFyVfmqN2riGRBiNj8Ilj6/5VgjGQVuk
         27A9bzUyQH+27vkwnmUPE23IGsrCRacR6IBTSAcmb03AQX5goAtvwiLr7F0ArbNA54
         fdn4CM/AV2fN50EL7O5Ls4Ht6UIIv/4yQwAQ47cNFDfrfHHV4Ub9rX71dGCp2pBAAO
         WJKC2g8YJIg1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DcBuXVV67e_q; Wed,  6 May 2020 10:01:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3CB602A87FC;
        Wed,  6 May 2020 10:01:12 -0400 (EDT)
Date:   Wed, 6 May 2020 10:01:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     ndesaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <482526608.2543.1588773672085.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200506135502.GS3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com> <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com> <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com> <656098739.766.1588705237442.JavaMail.zimbra@efficios.com> <CAKwvOdnLze0e3Vwmb1Xdqwcwe9h6gnAwGnt3ksiNX7ENb_3Y9w@mail.gmail.com> <470458191.1021.1588710464160.JavaMail.zimbra@efficios.com> <20200506135502.GS3762@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: static_call: Add static_cond_call()
Thread-Index: /XazMzaob2R7RnrpgfiHRnqwczHCZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 6, 2020, at 9:55 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, May 05, 2020 at 04:27:44PM -0400, Mathieu Desnoyers wrote:
>> Actually, if the goal is to do code patching of the call, I wonder
>> what makes it OK to "guess" all the call patterns generated by the compiler ?
> 
> We're not guessing, have have objtool read the compiler output and
> record the location for us. The compiler can generate whatever it likes.

So is the plan to adapt objtool if future compilers change the generated
instruction patterns ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
