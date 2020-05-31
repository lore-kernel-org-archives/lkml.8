Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F146C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276EF20723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590904824;
	bh=x1ClCZahba9lle1kgBX7VDXUe0vM3TTXePWMfEUxkQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Seri102AQVZz8O4cSs7Nl4/8jxKSSVaM2LYTYTA75hvNR7tmFPm4LqckbSGHe5nBQ
	 1rPCTpvfQX3Yr30YO6k1diRg6MARb3gW+kcNw/f2kjUhx5PTFlMXULOb1Y6M8wdZ4E
	 yfdJKrTZI4GhznzA4hRkofe60QEM/9hkvFVXtexk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEaGAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 02:00:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaGAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:00:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id r15so8125947wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1ClCZahba9lle1kgBX7VDXUe0vM3TTXePWMfEUxkQk=;
        b=L2FDxp6W9ewdfYt3MgXLUdY/r0U4ANmTpOc/eRvMJvKzZ5el2wP0eSEbL015q7pu8Q
         w4eR8Sv7kwXq36kRxu7X/eXG5LhqMj+aIiHWLvZGGkKGCZU4TiZ37TfFnRgASLe0aJxt
         UwcdloD41ZKJAf18AkBmcl+H1xtzD8bq+7Hd1jU7JfLAX6ajNs3ULFCnfBum3Ta6LBx7
         0SsypS54Js9j8Z0U3Xi2pzwOcYL1SDXSmTSvp4tWKBGj7p0YMriH7iVh+f/MnY6+M3eu
         D6/g8ThzV029kVU2QWvHvN6zEmUeYuBc0NFOOLY4sV3V91RRWJXmxmztrP+x1TqjvITG
         Dj0w==
X-Gm-Message-State: AOAM530LWzHr4EhosMkLwJNG3brUlDO1WI/eRxhapvodrNi5oAw6x/LB
        m+j1tht2U1juAi+IvUzQ6Z3M58zeLLPVn/SzoQjXSQ==
X-Google-Smtp-Source: ABdhPJzVl0KVxti/dBi9FJB6ied1gYgz7zAcYVCP1Eju9ZYHxHBrHhwVuSPNPUP+q5Kg5STH4N769L5Gm4xVwrZYdYc=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr15919453wmg.70.1590904821068;
 Sat, 30 May 2020 23:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200510150628.16610-1-changbin.du@gmail.com> <20200510150628.16610-9-changbin.du@gmail.com>
 <20200520210257.GV32678@kernel.org>
In-Reply-To: <20200520210257.GV32678@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 31 May 2020 15:00:10 +0900
Message-ID: <CAM9d7cj4MHhCk=u0wD6A2HRxL0fyGKukG2hfqoc+auGznPiG4Q@mail.gmail.com>
Subject: Re: [PATCH 08/19] perf ftrace: add option -l/--long-info to show more info
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:03 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, May 10, 2020 at 11:06:17PM +0800, Changbin Du escreveu:
> > Sometimes we want ftrace display more and longer information about trace.
>
> Humm, -v? Or that would bring too much stuff from other parts of perf?
> I guess so, perhaps as an option to the function-graph tracer, one that
> combines, as you do, several options provided by that tracer?

I think -v option is to debug perf tool's behavior while this is to change
the output (or behavior).

Thanks,
Namhyung
