Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F24C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551652065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GmXkwb6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgENRmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:42:03 -0400
Received: from mail.efficios.com ([167.114.26.124]:37914 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgENRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:42:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CE86B2A74A8;
        Thu, 14 May 2020 13:42:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6gRTkJaYBkVH; Thu, 14 May 2020 13:42:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 71EC92A726A;
        Thu, 14 May 2020 13:42:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 71EC92A726A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589478121;
        bh=rl5NndpsDO8QhemJHLzoUyiImPIEnoGILnWFL7l4FrA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GmXkwb6t1r1dVa06dFwR+WVq7UGqKtZYxWOstsYoLrzCLgzOvMU6QDx2u/7s1GxlG
         BixschzIw+si7AK7rtmBJofm+Csfq8P0tEixAV19Ge7lTSHWC8Zmap1YuhaMa6O8OD
         mXu2ZSdMKJiVuzKP8wZYJI6ugKfYRjDQqb2BHYoRdd9bf6oqjoMkYvaoUJ6BKclQGz
         EU3pqKuI3Isv4CAdZ+TbRvYR35e2sKUMKQcr3H0C6lxU/u/7+ZeNTvAFXeuJpJTXxw
         M7m3R+2gQMisLgDBmrG5JK0xM8sC634/8uAQsWCW2Ql1IPDn0DiBkeUSv8TslFjw7+
         /d7pjbBeM+cOw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fOKMkDNG6Odq; Thu, 14 May 2020 13:42:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5F4F52A7601;
        Thu, 14 May 2020 13:42:01 -0400 (EDT)
Date:   Thu, 14 May 2020 13:42:01 -0400 (EDT)
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
Message-ID: <1431848694.21308.1589478121367.JavaMail.zimbra@efficios.com>
In-Reply-To: <87y2puxvqa.fsf@nanos.tec.linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de> <409359846.20366.1589413337072.JavaMail.zimbra@efficios.com> <87y2puxvqa.fsf@nanos.tec.linutronix.de>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/mce: Send #MC singal from task work
Thread-Index: ImAUO0bzJcO1A9UmbRjZPE+t84RW8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2020, at 1:38 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
>>
>>> From: Peter Zijlstra <peterz@infradead.org>
>>> 
>>
>> Patch title: singal -> signal.
>>
>>> Convert #MC over to using task_work_add(); it will run the same code
>>> slightly later, on the return to user path of the same exception.
>>
>> So I suspect that switching the order between tracehook_notify_resume()
>> (which ends up calling task_work_run()) and do_signal() done by an
>> earlier patch in this series intends to ensure the information about the
>> instruction pointer causing the #MC is not overwritten by do_signal()
>> (but I'm just guessing).
> 
> No, it does not. See the ordering discussion.
> 
> Aside of that signal never transported any address information. It uses
> force_sig(SIGBUS).
> 
> Even if a different signal would be sent first then the register frame
> of the #MC is still there when the fatal signal is sent later.
> 
> But even w/o changing the ordering the taskwork check in do_signal()
> runs the pending work before delivering anything.

Yep, that was the key thing I missed,

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
