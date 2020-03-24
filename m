Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CCEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EFB20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxhaqVRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCXQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:56:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41541 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCXQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:56:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id z23so2132760lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFIGNUpDtx5h3b6b+QEOb2QoBDkARJdMv8Frt7I6mcA=;
        b=QxhaqVRqxE0tPjxrjiFFHwiVs8u2p615mXSrju0U3UuWgoLLYUWEQU+OKjgjF53E9c
         q5jtVRTHsvMjYvRETJyKjbrLGxHHYT278X1y0HsDX/H+j7Tq8y25cJmSkPVjbnclwjOH
         Y6XGY+xWWe229Z8UWWIo1D/YiQ9kPJC5idX6IFKK/1MZtnKtL2TXRieh3d08F2EI2PWT
         AfWmBbNVlKl0O+Gy7tLu+op1tpAXWzcSVj53v2/JJjS3GKfGybabnAsy9OaQ6/5bP/QQ
         CpGjLqa9p84STUG0co/tM5DY38XvrfrMhoE3ofKqSBC2JtAuuDkr1DXqPTEFYJNqNK/U
         CtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFIGNUpDtx5h3b6b+QEOb2QoBDkARJdMv8Frt7I6mcA=;
        b=YdMqO30cSfQldLHFHf5FZ21fFusHb/Slhmqnz/P5cxApOx/t1yzmhXFsPrtFCrJC1J
         MXtd7uQ4xqKUXpodlkwmNiAYVd45jv0cpdlYzUh/OiZLpSR/zhe/+JLZNcqZNb8lPriR
         tWGBwd9/5RhwqRhie+79aBx1VWNwb13AgIe1BPHtHj4WtC+VqG1g2xnVIx7h/15xaePL
         bwAg4UzT9465Rzf63V/3I8z9cwaTVfzYclFHCee3sIA3/wyT0XPrSMcm+01LHLa38z8m
         Nf5iTH5QZi8kPEoIugc8JOSxjWf0Ytctnd5t6jghZ60eLY4Dw6Pj5K3yaPwd7RHQSFAt
         uxGA==
X-Gm-Message-State: ANhLgQ1p+lTcsZ3DaEdAaCnYMqaL5TVVaKzb5VQ1eo6N3mSoiCq9frri
        Ebvx2qvGIvnbF8KQKEP5W5o5SowupGeA5k85r/nzeQ==
X-Google-Smtp-Source: ADFU+vv3k8ZkJQxHJmVmXT2nkkdi7lVh9FsmwbzVxxYv13+3VtTq5l/toW1odvSLvnTLqAuk7oiHpfiw6M+O+7TBNRI=
X-Received: by 2002:a19:ad43:: with SMTP id s3mr10218645lfd.63.1585069002228;
 Tue, 24 Mar 2020 09:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153643.15527-1-will@kernel.org> <20200324153643.15527-4-will@kernel.org>
 <20200324165128.GS20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200324165128.GS20696@hirez.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Mar 2020 17:56:15 +0100
Message-ID: <CAG48ez2WJo5+wqWi1nxstR=WWyseVfZPMnpdDBsZKW5G+Tt3KQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with data_race()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 5:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 24, 2020 at 03:36:25PM +0000, Will Deacon wrote:
> > diff --git a/include/linux/list.h b/include/linux/list.h
> > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > --- a/include/linux/list.h
> > +++ b/include/linux/list.h
> > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> >   */
> >  static inline int list_empty(const struct list_head *head)
> >  {
> > -     return READ_ONCE(head->next) == head;
> > +     return data_race(READ_ONCE(head->next) == head);
> >  }
>
> list_empty() isn't lockless safe, that's what we have
> list_empty_careful() for.

That thing looks like it could also use some READ_ONCE() sprinkled in...
