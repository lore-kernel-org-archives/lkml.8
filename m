Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33DC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC3520714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xemFkJ5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBKCc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:32:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43179 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgBKCc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:32:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so3772981qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 18:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=jFdYdBwbUoJOc2urJNoWgPRmJ7mEems1T1irxxfxUiM=;
        b=xemFkJ5X6RbDRyfmT8JZdzKl0EEoSr6Gw8uh17y1jzx7dcaexlKuvkENnty8X+NKCn
         Rjas425dIvznfVDr787MLIYMULsExvXTFPIfLU+ap0j/mjKIwDDrpgl4PmRGGEHi8TIe
         jO3mQA2lgB+NUtGZ2iF0kHie5jGj+wJ1umgWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=jFdYdBwbUoJOc2urJNoWgPRmJ7mEems1T1irxxfxUiM=;
        b=lg7/kpGDvB3Vob8NLEfTySgDvBZsQaIi0ZWvYUaJndO9BEAwTN8RjkMO/SO/SSFvOu
         WzNhdncjU2PVzaHUpAbGeGJBa4Enrceoi1sPbIOuQ9+3hxN4Dh3NzyaE5XztGbrsGeLR
         xT0lTAI9kcxgq6uFateQSewRNqKsJ5/pwBBYkS1r1Q2UOeSlTeUT/onLle1qSlhZnHLU
         rtTGKhcZkb9NXOuA+M04WNlI/iOT4Xdyk/rxkNYk+Xfpk3xVpbfowf2Hp2Kq+o0kRpnZ
         FX+TWxJNu7OyhLngFMpNQW67lBQFRu8R1GfVAINGih+L/0GRfn19g/vWPLNIlUv+VeUx
         cZuw==
X-Gm-Message-State: APjAAAWW9Zs8OLK2UouHqvtwzXwmhiDQs9jrZpX6+rb6vT2cmPryPV/Y
        UJQScj0leV9molUuTeJxToDdBw==
X-Google-Smtp-Source: APXvYqxnMdAhWxpGj8+tA3gVz/8WLMRSoNFUGniIBCd3iWybUkh23PkUICWg91o39UxMxp10NJTdDg==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr4264117qka.208.1581388346504;
        Mon, 10 Feb 2020 18:32:26 -0800 (PST)
Received: from ?IPv6:2600:1003:b86c:4985:a114:330:d564:a397? ([2600:1003:b86c:4985:a114:330:d564:a397])
        by smtp.gmail.com with ESMTPSA id b19sm1161356qkj.99.2020.02.10.18.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 18:32:26 -0800 (PST)
Date:   Mon, 10 Feb 2020 21:32:23 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20200210212222.59a8c519@rorschach.local.home>
References: <20200210170643.3544795d@gandalf.local.home> <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com> <20200210212222.59a8c519@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
From:   joel@joelfernandes.org
Message-ID: <522406EB-8788-47F1-B616-0A6338A03304@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 10, 2020 9:22:22 PM EST, Steven Rostedt <rostedt@goodmis=2Eorg=
> wrote:
>
>> Which brings a question about handling of NMIs: in the proposed
>patch, if
>> a NMI nests over rcuidle context, AFAIU it will be in a state
>> !rcu_is_watching() && in_nmi(), which is handled by this patch with a
>simple
>> "return", meaning important NMIs doing hardware event sampling can be
>> completely lost=2E
>>=20
>> Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI
>context,
>> is it at all valid to use rcu_read_lock/unlock() as perf does from
>NMI handlers,
>> considering that those can be nested on top of rcuidle context ?
>>=20
>
>Note, in the __DO_TRACE macro, we've had this for a long time:
>
>		/* srcu can't be used from NMI */			\
>		WARN_ON_ONCE(rcuidle && in_nmi());			\
>
>With nothing triggering=2E

I did not understand Mathieu's question, afaik perf event sampling code in=
 NMI handler does not invoke trace_=2E=2E=2E_rcuidle functions anywhere=2E =
That afair is independently dealt within perf and does not involve tracepoi=
nt code=2E And if NMI has interrupted any code currently running in __DO_TR=
ACE, that's ok because NMI is higher priority and will run to completion be=
fore resuming the interrupted code=2E Did I miss something? I am not surpri=
sed the warning doesn't ever trigger=2E

Thanks,
Joel=2E


>
>-- Steve

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
