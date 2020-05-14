Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8057F20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YTJIbZvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgENNjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:39:02 -0400
Received: from mail.efficios.com ([167.114.26.124]:52080 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgENNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:39:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 087FE2A56D1;
        Thu, 14 May 2020 09:39:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qAJ5jDgUJAr5; Thu, 14 May 2020 09:38:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 636A22A5735;
        Thu, 14 May 2020 09:38:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 636A22A5735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589463536;
        bh=mCTyC/3FhHIgU4kWEPnEQdk5ldkQb2e0Sc3YlDV8jt4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YTJIbZvSqAbuPs8UXiKXBIdRP4Ue3Vf/cnqNkW600ebBtTSwwo8zoB8kaE+HkQU2q
         xj/tK1afxYE1zsQHIcR9YzYZIoNmrbPAjBsU/SPSEpmJFdFsOzpnHswdXiTxG485mX
         l5l9tJLaZuY9x477+NPxvW01CvUY8jR4J/rdkpkgpmIqW5gggoXJ4Uq1NZCizVSlwT
         Cxobf1USx12KkgoiHCupPKdDlu+nNP3IYt75+iNC7kVTPmq/3mhXKZJavsyNhehklq
         6ROHITLJjMeQfsiENe75QSGCjPqzM+EIEtxJBHEK9AtZCBYOgNpiIThEJRDULee/Mg
         cIxnDBlmtmeMg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 72nZUP86IZyD; Thu, 14 May 2020 09:38:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4F3C12A53E3;
        Thu, 14 May 2020 09:38:56 -0400 (EDT)
Date:   Thu, 14 May 2020 09:38:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
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
Message-ID: <1225010168.20900.1589463536204.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de> <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com> <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com>
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT
 entry stubs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry/32: Provide macro to emit IDT entry stubs
Thread-Index: ujvuBQzPbkwjiKyGfihGIT/NWuHiZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2020, at 12:31 AM, Andy Lutomirski luto@kernel.org wrote:

> On Wed, May 13, 2020 at 6:44 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On May 5, 2020, at 9:44 AM, Thomas Gleixner tglx@linutronix.de wrote:
>>
>> [...]
>>
>> > +.macro idtentry vector asmsym cfunc has_error_code:req sane=0
>> > +SYM_CODE_START(\asmsym)
>> > +     ASM_CLAC
>> > +     cld
>>
>> Looking at the various interrupt and trap entry points for 32 and 64-bit
>> x86, I notice a lack of consistency in use of the following instruction
>> sequence at the asm entry point:
>>
>> - ASM_CLAC,
>> - cld (clear direction flag).
>>
>> Are they always needed, or only for interrupt handlers ?
> 
> They're needed for all entries except SYSCALL, but they're hidden
> inside helpers in many cases.

Indeed, on x86-32 the macro SAVE_ALL contains cld. That architecture
appears to be OK.

What I am concerned about is the idtentry, idtentry_mce_db,
and idtentry_df macros introduced in entry_64.S by this series.
Those are supposed to be technically equivalent to the prior
code, which indeed has the ASM_CLAC but no "cld".

So maybe the cld happens to be hidden elsewhere, but I'm clearly
missing it ? Or is it not needed for some reason ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
