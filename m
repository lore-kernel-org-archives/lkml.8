Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6089C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C06B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JJOGiHxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgENOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgENOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:55:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FBC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:55:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n18so1420859pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9HjMnwIKxpe2uw0fQ8jjAuZF11Ao8ED5SVrgc8CsCDU=;
        b=JJOGiHxd0wdf2wJI5MuPpFjPtxQ7336AKRPSLZeicJkX+D3PP8scBGIsBz7GD3QQvY
         xiDcWzNAzUxhW5hIUcxoleTzO8oAEVfftJFQNoolwWfsMx2PiEagXOnbpeVhC6GGnS9l
         rCpsi9hHJ5auXSrHEZxRh3PXFSWNGOSSSXWNEWF9OCfE1HfQFB9QuHvo0E/SlgF2pCZX
         MZr/D/ye5y3KRfgmGbeVwwineXkE5b65/rb6DPIGi60rhr1wVF5JSJUmpqM7ec8xveV9
         nqwa8FaksRAXyjj1qSAteUzrVwMtvw6/Dk+GCTMAbo2XbFa0SvjyzQAK6HWKZAdgC+2r
         c60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9HjMnwIKxpe2uw0fQ8jjAuZF11Ao8ED5SVrgc8CsCDU=;
        b=TEfMFj1QteCAZb9dBWe3JqDAWJElw4jtpZwAgn5BLOTOzmFZIBd8Wh+fKoza8hO8ba
         ZDWfonrCGv+u4wLWJYlPiPSwbDp/OfmdYnK8KoeiUwqTJIZ1vcnnbfT24NHcExqew8lh
         gHEqUf2ctvNwEEgWO7dL/lIBBhcle+TpJZmZTYxg3qnkg+ac48dhWDykYO14VYksRuEO
         kuBsKqE9xOMeutfAJEAilNI0s3nMxi+Z6TOmXiy2UIYehXUkcennhvP6s79HHma3eZaU
         62e72EWj4oqNRNI6Hqp3Qi16uYI+iAq8OZC2BXUiqT9HvPGfgSxhuKCVG/g6bhkR5waU
         Kgtw==
X-Gm-Message-State: AOAM5321j0kwWA6jHRx0sdK4Q8JNjoy04zSJcy9EMqo678bZ5hxxKa7w
        mYFCbiSzHz+yl+5/J2QHqpwyHA==
X-Google-Smtp-Source: ABdhPJx7+2eXLTKSXrTOBJ/rU5kJS0lPi+SyNjeJFlAisPsQ3+tH/CNhEfooTQvfWFF33wo1bvaJsw==
X-Received: by 2002:a65:480c:: with SMTP id h12mr4478831pgs.106.1589468105764;
        Thu, 14 May 2020 07:55:05 -0700 (PDT)
Received: from ?IPv6:2600:1010:b044:c0a6:fc3e:abd:d4e0:e1e4? ([2600:1010:b044:c0a6:fc3e:abd:d4e0:e1e4])
        by smtp.gmail.com with ESMTPSA id nm6sm6815276pjb.34.2020.05.14.07.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 07:55:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Date:   Thu, 14 May 2020 07:55:02 -0700
Message-Id: <9DBF3103-4D31-41AA-AC02-9A6F1849AA00@amacapital.net>
References: <20200514131530.GQ2957@hirez.programming.kicks-ass.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <20200514131530.GQ2957@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 6:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Thu, May 14, 2020 at 02:51:32PM +0200, Thomas Gleixner wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>> On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
>>>>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
>>>>>>=20
>>>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>>>=20
>>>>>> Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untowar=
d
>>>>>> creeps in and ruins things.
>>>>>>=20
>>>>>> That is; this is the INT3 text poke handler, strictly limit the code
>>>>>> that runs in it, lest it inadvertenly hits yet another INT3.
>>>>>=20
>>>>>=20
>>>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>>>>=20
>>>>> Does objtool catch this error?
>>>=20
>>> It does not. I'll put it on the (endless) todo list..
>>=20
>> Well, at least it detects when that code calls out into something which
>> is not in the non-instrumentable section.
>=20
> True, but the more specific problem is that noinstr code can use
> jump_label/static_call just fine.
>=20
> So a more specific test is validating none of that happens in the INT3
> handler before poke_int3_handler(). Which is what I think Andy was
> after.

Exactly.  I admit that sleep-deprived Andy was actually thinking =E2=80=9Ctg=
lx and/or PeterZ found this by inspection, and somewhere it escaped objtool=E2=
=80=99s notice,=E2=80=9D which is sort of the same thing :)=
