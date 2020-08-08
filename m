Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762D92087C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsbJCfT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHHCWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgHHCWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:22:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B76C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:22:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so2782767qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ecrnqYOvc4eCeauMfs2J6ltj0dBor5l9FCOKfk/i2NE=;
        b=IsbJCfT9oVZ5agxDiVijRJYQ9e6JAKIQZC1Wx5njAoRkdcMK1YNS/yaBEJVw9hyJ+1
         O41sdyPfGqA1ihXW3L4Z92E57qUtjHb0azYl+jTGL/0b+r80ycB32zdcHepRTJZ6Zv+c
         NJNYv6+FTcpAMqRrh2XRp3nGn9i9Z2B76FI9zCscozBtGfOcGEVyx3WsoL6/krziaQju
         sYfDUEI1a7DWTDkAPQRASLvRVwHo0tSWFdl/SiNBpS/UpddzIJhghPGTARUxVz3X/KjY
         MtqtGg3CXuuB1IGA6i/A3mgJigRTBO7hl3cKduviJ4YCJ0q7ZcA7k+2DFzyLL2+kU17U
         V3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ecrnqYOvc4eCeauMfs2J6ltj0dBor5l9FCOKfk/i2NE=;
        b=qxYqYtXfLnkSu6msvCkKj0xp9os9y28l+W2MglsB2tsdVnbafiwG/o4ugYcdtOHFEB
         xucuasdegbRXdeGljt+fPcZb1xqi9uis+8etPL6W9ELJ0xG74QAEfxpPaX35Fs49kq8h
         9TXXVfi8WWVVUP794zPg3yLjLop77RqCmpYTqnhyU2caHZ8ei78Ej4I83TlkMnfb8rHO
         1Yj9Fq52pEUCPoISz7rCiT7zx4GsBJPXpSpaif8rK8bgzA4xY0v1AqbM52rML/zy6gET
         GFk9thzxwqwWWFKBl8LRcxl5eyYVa8wI3sOJZcVbjX+oQkxX6+HWwpGHLnYiQqyYVF3a
         CHVg==
X-Gm-Message-State: AOAM533qPPQTrkmDz1TBvYLs7Igc0F06hPgxYsoPqRtfZe2rZBcFF0l9
        xU8mgWWAYGK+58JBM8KWmr4=
X-Google-Smtp-Source: ABdhPJxM5y4L5rKuVDondHa1v4nK0PZ4ONWX1OVrNFgG4YC4bDVvflESho0SwrLV22yC7pbRhQlDnw==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr17652215qtv.381.1596853337361;
        Fri, 07 Aug 2020 19:22:17 -0700 (PDT)
Received: from mail.google.com ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id e4sm9412771qts.57.2020.08.07.19.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:22:16 -0700 (PDT)
Date:   Sat, 8 Aug 2020 10:22:03 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/18] perf ftrace: select function/function_graph
 tracer automatically
Message-ID: <20200808022203.yqadm2verquocjrg@mail.google.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
 <20200718064826.9865-2-changbin.du@gmail.com>
 <20200804125115.GF3440834@kernel.org>
 <20200806001448.ln2u7qyc4fnuk5lh@mail.google.com>
 <E69D6A9B-D2F7-43EA-AD6F-3164F199A6E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E69D6A9B-D2F7-43EA-AD6F-3164F199A6E4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:05:03PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On August 5, 2020 9:14:48 PM GMT-03:00, Changbin Du <changbin.du@gmail.com> wrote:
> >On Tue, Aug 04, 2020 at 09:51:15AM -0300, Arnaldo Carvalho de Melo
> >wrote:
> >> Em Sat, Jul 18, 2020 at 02:48:09PM +0800, Changbin Du escreveu:
> >> > The '-g/-G' options have already implied function_graph tracer
> >should be
> >> > used instead of function tracer. So the extra option '--tracer' can
> >be
> >> > killed.
> >> > 
> >> > This patch changes the behavior as below:
> >> >   - By default, function tracer is used.
> >> >   - If '-g' or '-G' option is on, then function_graph tracer is
> >used.
> >> >   - The perf configuration item 'ftrace.tracer' is marked as
> >deprecated.
> >> >   - The option '--tracer' is marked as deprecated.
> >> 
> >> You should try to be more granular, for instance, I think the
> >decision
> >> to change the default is questionable, but could be acceptable.
> >> 
> >> But why deprecate the perf configuration for the default tracer?
> >> 
> >> Say people who already use 'perf ftrace ls' go and use with this
> >patch
> >> and see that it changed the default from the function_graph tracer to
> >> the function tracer and disagree with you, they want the default to
> >be
> >> the function graph tracer, know that there is (or there was) a
> >> ftrace.tracer in ~/.prefconfig, and then try that, only to find out
> >that
> >> it is not possible, frustrating :-\
> >> 
> >> So can we please remove this deprecation of ftrace.tracer so that
> >people
> >> used to how it was can get that behaviour back?
> >> 
> >Agreed. If no -F or -G is given, we can use the ftrace.tracer as
> >default tracer.
> >Let me update it. Thanks.
> 
> Thanks, I'm general try to be as granular as possible, doing one thing per patch, this way the reviewer can do some preliminary cherry picking and we also improve git bisectability.
>
Arnaldo, I changed the policy as below:
      - Preserve the default tracerr which is function_graph.
      - If '-g' or '-G' option is on, then function_graph tracer is used.
      - If '-T' or '-N' option is on, then function tracer is used.
      - The option '--tracer' or configuration ftrace.tracer only takes
	effect if neither -g/-G nor -T/-N is specified.
      - The function_graph has priority over function tracer if both -G/-g
	and -T/-N are given.

Please check updatae in v8. Thanks.
> - Arnaldo
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
Cheers,
Changbin Du
