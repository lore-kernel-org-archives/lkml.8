Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B175A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e72tivqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBMOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:25:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34313 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:25:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id c20so5828825qkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc0b7TzZN/NSWX0NFmEbYxGFh6qjkw/pK6nZDwFtVfU=;
        b=e72tivqYvQ7hzD1hDEOyR4fyZzUUauEuzvGQ1N6vlP9FlkxL9ARfbqgtUfkupK82HE
         QkWjAEhiFncYm+atr/0aEnCDVDNTgaMxj0/Pwg9HQmhiF5/yPOhPnh0lTZhCD+DUthjp
         efugfVtBDen1rlDtGrdP9N7pjEOdNHRqT8Rhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc0b7TzZN/NSWX0NFmEbYxGFh6qjkw/pK6nZDwFtVfU=;
        b=qheH6KyOYuyMGi1APKRR1kdrmbpqrMciz1nteN94OXwyv03MdalQ/swccBHuzAwcQx
         wvoL2lCfTWrtjVwGLzRpixf3tBAgzPRzFnbnjSpHAoZEeyrirYHVmnCZTKQw78IWDm85
         1IKAEE/900LJa85trTXxVI/46U+bdVm2ViLPit1fSR+LG1Vlb+Xwo5qldkE68iIF3xv+
         U3BlcV+PuIkLIRXTY4amOd+KSpNLFmi++LccglZn+95FlmrUaTMelUSx8don/3Nn08KF
         4+zo/7gQ286U5dqE0WrMecck9kfg+/NwrWaAruBvzGWbCpYbqfNhe5PvCjyM2CK0KbX0
         +QOA==
X-Gm-Message-State: APjAAAWiEdCD218gTczaKHgrqPh7sGJYMOo2LjBrmFTH85DB2k/UeEZv
        hHU4sUYXenkt6tX4Ma0rwxMGZ7iGdOaypuyzBsNqEw==
X-Google-Smtp-Source: APXvYqyqVlaAznCrTjgFnMS/rbNzkVZ+JXaavI7b9i3sKA5vbbQy2odANJfyMh8Z8Llpqed5LUZncN0z3LiE3my3DaQ=
X-Received: by 2002:a37:6d47:: with SMTP id i68mr16018376qkc.228.1581603919781;
 Thu, 13 Feb 2020 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20200212210139.382424693@infradead.org> <20200212210749.915180520@infradead.org>
 <20200212223818.GA115917@google.com> <20200212204128.20f5e8ba@oasis.local.home>
In-Reply-To: <20200212204128.20f5e8ba@oasis.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Feb 2020 09:25:08 -0500
Message-ID: <CAEXW_YSddXU++o7xpi-0kzg9GA6UkM5FsnoXjLQ=gAFBjPf=RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 8:41 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 12 Feb 2020 17:38:18 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I think there are ways to turn off function inlining, such as gcc's:
> > -fkeep-inline-functions
> >
> > And just to be sure weird compilers (clang *cough*) don't screw this up,
> > could we make it static inline notrace?
>
> inline is defined as notrace, so not needed.
>
> I did that because of surprises when functions marked as inline
> suddenly became non inlined and traced, which caused issues with
> function tracing (before I finally got recursion protection working).
> But even then, I figured, if something is inlined and gcc actually
> inlines it, it wont be traced. For consistency, if something is marked
> inline, it should not be traced.

Ah I see it, thanks for the clarification Steve! That looks like a
good idea. I withdraw my previous comment.

- Joel
