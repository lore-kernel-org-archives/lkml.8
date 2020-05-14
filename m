Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE345C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBEA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fc6xdFKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgENBoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:44:37 -0400
Received: from mail.efficios.com ([167.114.26.124]:46034 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:44:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9E67A2A1317;
        Wed, 13 May 2020 21:44:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id diXTWMAjP-sG; Wed, 13 May 2020 21:44:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 240A62A1229;
        Wed, 13 May 2020 21:44:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 240A62A1229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589420675;
        bh=6FThw3NNByQCnxLcP7jjvyChrbYfW3ckvc93LQYwYE8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fc6xdFKAcrDet33aSmzu9EWoVN7G2SwLUoqyCqvG7ztumDlWhOO5IcIn2G1iwIkdk
         xRFJCEV0bL3b7p0tH/KQ7NhjPmM2uKijxXvSb3RrfiLjUpcwCQlUPe6D937DAL/J//
         MMbYImZsY3prXz7ga1scJ0xyfWmBW/LKs/yoMJjfEWkVI5yB7/lPO8nlyo+DZidHOo
         oRCp2WnELPcfzM9l1bKsZBam2mCZvA3yWQcL6834Fu4bpbMgDwomS2fhwkJPqk1uhT
         7wvfCIWvNgt3/8xl7FnCosgbvEJvrkWNCIt5VF3xer4uh1+2z3W3CwbMrzVyQRf8zq
         WobvLBQ/amT8g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IUqaYDzi7Za5; Wed, 13 May 2020 21:44:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 103912A112F;
        Wed, 13 May 2020 21:44:35 -0400 (EDT)
Date:   Wed, 13 May 2020 21:44:34 -0400 (EDT)
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
        Will Deacon <will@kernel.org>
Message-ID: <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134904.166735365@linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de>
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT
 entry stubs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry/32: Provide macro to emit IDT entry stubs
Thread-Index: bKEXdwZ/BOfNVJVq+EaT2heUgapaxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:44 AM, Thomas Gleixner tglx@linutronix.de wrote:

[...]

> +.macro idtentry vector asmsym cfunc has_error_code:req sane=0
> +SYM_CODE_START(\asmsym)
> +	ASM_CLAC
> +	cld

Looking at the various interrupt and trap entry points for 32 and 64-bit
x86, I notice a lack of consistency in use of the following instruction
sequence at the asm entry point:

- ASM_CLAC,
- cld (clear direction flag).

Are they always needed, or only for interrupt handlers ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
