Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0725C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HSkFJFxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgCPPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:02:47 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:42890 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbgCPPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:02:47 -0400
Received: by mail-qv1-f43.google.com with SMTP id ca9so8990973qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9iR9aVxqFWALXbZGYM4qU/9Y4ykwQCi7s/EbS0dZA1M=;
        b=HSkFJFxaXNH4QkJ1bWKHSm6sHyY+0HbGQ/8p8+IalzkVh1rCtx3tIX1zvNqOl3viFI
         mEEtsyZTeytYkTQHEZE9cOwsNj239K2BWGgOboV1T39/MSCcg8RGD8QKDe730PSjbDsI
         0ZxfOlHd8J8eWIOLVLsM1ttLdRA5VzGg6+ogI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9iR9aVxqFWALXbZGYM4qU/9Y4ykwQCi7s/EbS0dZA1M=;
        b=VxfGjCrizs259O8pJe/KomTM1SyFsSwYwn6I/CTnwEZ5clZpgbami5a25D6NLqRlr1
         HFfgEoEiXrvYDk70dE/p1hs85d+Z+4ogtUEUDFwIN7xIstoJV/m4vjCSsJEVAOuTtjwq
         MlnlDBoy5sRi1Z4FN3G8Ofgzbmvg5ajEiuvXzeY5/nHBnLIwTBVGeUIbnEWSHTDKXVuW
         9qvI6Us54kcYreT4eXPsDlyIRv4n3vNOMOfJimDZXDL/KSw1rH31H7RV/N6J3tds5oaq
         8wBWtZETYqReZIdCak27A8FMCjNaodYBqe561izpy1gDLBNbABPJ4BG0twC0NEg/tI2C
         NJ+Q==
X-Gm-Message-State: ANhLgQ0fG0yj2t++HevFyuhbUFEh8z47l0kPRC1vp9td9EtUu96BYMth
        JFRJ5dhOUntEgBMAmr2eh8b4fA==
X-Google-Smtp-Source: ADFU+vvR77h4xXyAbp8e+YyP9x0ZBikm2Q0Hs1DtOojGpMfwXOKkTUJ2U/LnMIZXGrPC6CA5sLKvsw==
X-Received: by 2002:a0c:80a5:: with SMTP id 34mr219438qvb.184.1584370964604;
        Mon, 16 Mar 2020 08:02:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d28sm9941426qkl.99.2020.03.16.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:02:42 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:02:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200316150242.GC134626@google.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309141546.5b574908@gandalf.local.home>
 <CAEXW_YQJ=vGxn5P=OtdkJT4NwE9+P0rAPEEQFdAUtyZ9Ck=qug@mail.gmail.com>
 <20200309150709.204bd306@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309150709.204bd306@gandalf.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:07:09PM -0400, Steven Rostedt wrote:
> On Mon, 9 Mar 2020 11:42:28 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Just started a vacation here and will be back on January 12th. Will
> > take a detailed look at Thomas's email at that time.
> 
> January 12th! Wow! Enjoy your sabbatical and see you next year! ;-)

Haha, I am seriously getting picked on for that. But anyway, I am back now
because I missed you guys :-D

(Just kidding, obviously I meant March 12th).

thanks,

 - Joel

