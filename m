Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7918C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6D205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CbNLuemM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgENOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:43:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:42118 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:43:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4D4B42A5B7D;
        Thu, 14 May 2020 10:43:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Waxj-7Zm_nSu; Thu, 14 May 2020 10:43:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D649D2A5B7C;
        Thu, 14 May 2020 10:43:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D649D2A5B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589467417;
        bh=6hptfcSKmRUE+zmXMAzHjHOIYDANTwRCBE8XEZLUToM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CbNLuemM5szRYd+im9stxtZ2K4ChiyVuhndUneuss2RHpFJpEt3to5BXLCfxc+6p+
         dUu4n03eppFxjqS8YygnzTD1LI9vbfLW3E8m9zPkuzGBrNbadBGDlMBbRyMRK2iu/p
         SmcI4VZGW6XAdUr4/18c3R8A+uGr1h64194DsOhYxk7UQqp50+n8tj8hMjT76hmDHG
         qwRpsvZ6Bdj6baSozUefaGnLskGdXXjZuvSTGIopxRrljhdUPOmXKFKj7UJkoD2YLI
         x8lkib4wixj45I2eQVQP7NwZAt878tTBJcfXIKroP0R0UdZntnuWC3dNLTpaWAxIGg
         TLdrQQnZMtC8g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cOCJjQ3pcUwU; Thu, 14 May 2020 10:43:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C4B632A5C4E;
        Thu, 14 May 2020 10:43:37 -0400 (EDT)
Date:   Thu, 14 May 2020 10:43:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <311451534.21045.1589467417727.JavaMail.zimbra@efficios.com>
In-Reply-To: <87eermzk1n.fsf@nanos.tec.linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de> <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com> <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com> <1225010168.20900.1589463536204.JavaMail.zimbra@efficios.com> <87eermzk1n.fsf@nanos.tec.linutronix.de>
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT
 entry stubs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (zclient/8.8.15_GA_3928)
Thread-Topic: x86/entry/32: Provide macro to emit IDT entry stubs
Thread-Index: kQKldAjQdVcOVE13Ds4o+qa9RgzKkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Thomas Gleixner <tglx@linutronix.de> wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> > ----- On May 14, 2020, at 12:31 AM, Andy Lutomirski luto@kernel.org wrote:
> >> On Wed, May 13, 2020 at 6:44 PM Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >> They're needed for all entries except SYSCALL, but they're hidden
> >> inside helpers in many cases.
> >
> > Indeed, on x86-32 the macro SAVE_ALL contains cld. That architecture
> > appears to be OK.
> >
> > What I am concerned about is the idtentry, idtentry_mce_db,
> > and idtentry_df macros introduced in entry_64.S by this series.
> > Those are supposed to be technically equivalent to the prior
> > code, which indeed has the ASM_CLAC but no "cld".
> >
> > So maybe the cld happens to be hidden elsewhere, but I'm clearly
> > missing it ? Or is it not needed for some reason ?
> 
> It's needed and it is there where it was forever in error_entry and
> paranoid_entry.

Ok I simply missed it.

> 
> It probably makes sense to stick it right after the CLAC.

Indeed.

Thanks!

Mathieu

> 
> Thanks,
> 
>         tglx
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
