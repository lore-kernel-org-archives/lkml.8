Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3EDC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726472077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585131892;
	bh=MBtguq08zTRxGsCd6FDs0iyXmJJN7TCawEHThED587U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ObYrte3CHobNvfvVyI2ghQPHpblMvs0F6kmW+tcs0QUjg1mq5nMQCz6GwXnA9xlVV
	 2WbsOLNVOWbBq+0QWA6biYfHeKyM5ah9AmEs2OBvFnMwuKX7CLUeCP+IYS5nM9QR5p
	 4cqJLnRTPm2tmxE847v29+Uz43m0teiNAtDYNyWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCYKYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:24:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53877 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCYKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:24:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so1746317wmj.3;
        Wed, 25 Mar 2020 03:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JudwYayiOIszuwAtyoXWUCq8w6IbQTZxNsPBYDBfHE=;
        b=Cc2DfsP+1ey+EsfFZQRH+PZDYSWrv/brBADwv4OF7F//loSUo/uaCbyJc2ZCPmkD8y
         mEG3x20oNuU/2b8q3iMlqli7KR5xOQq38UNHkHMEnz9GloUqci0o0jydpewb7u7ApS2I
         5DfuasuRuEzyWYDn4bhyX44khCdybA6txtjGNw9q5ZN/o9AATf9IQVn86cJk5nBrSjKs
         EeVqIGs9p+lOFURp2Cpk0daENWu+XqiU6ULt0zS/4AvLqk7EwMjL9Kcr4mGeRS4C/GIw
         AB54x/OlM6AveXWHOo6EyNh/hIu9l51Hq7Uo0nF9nR6gbCn0NQQ/ZrBXOO3NZ8Bb9VGQ
         9ybg==
X-Gm-Message-State: ANhLgQ3Pk7E2JFQC4aUyscZecs/fzpPjpU7pEqAJlza/JP2+MeenJ7rN
        d6SCG3k+RvcxrzMqneGLQpqMsCrwp5i14fzTQDLL9Q==
X-Google-Smtp-Source: ADFU+vuANgBK+LMwpbXf/GsjW0A2D8NyP74khoa1vGG+lCoGfP+Zdr2Avx+oCyzWXXlcnN6lS70etc6A3C14nSUmDwE=
X-Received: by 2002:a7b:c388:: with SMTP id s8mr2712915wmj.168.1585131889102;
 Wed, 25 Mar 2020 03:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200224043749.69466-1-namhyung@kernel.org> <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
 <20200324163444.GA162390@mtj.duckdns.org> <20200324201522.GP2452@worktop.programming.kicks-ass.net>
 <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
In-Reply-To: <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Mar 2020 19:24:37 +0900
Message-ID: <CAM9d7chu0xowWK19fBQdSueVmAacpE6qO4x4NPjOY9Tcm8_AqA@mail.gmail.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
To:     Arnaldo Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 6:25 AM Arnaldo Melo <arnaldo.melo@gmail.com> wrote:
> On March 24, 2020 5:15:22 PM GMT-03:00, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
> >> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> >> > Hello Peter, Tejun and folks.
> >> >
> >> > Do you have any other comments on the kernel side?
> >> > If not, can I get your Ack?
> >>
> >> Everything looks good from cgroup side. I think I acked all cgroup
> >parts already
> >> but if not please feel free to add
> >>
> >>  Acked-by: Tejun Heo <tj@kernel.org>
> >
> >Yeah, looks good to me too. Since it's mostly userspace patches, will
> >you route it Arnaldo?
> >
> >Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Thanks for the acks, I'll process it tomorrow, so tests passing it'll go Ingo's way for 5.7 tomorrow.

Thanks all for the acks,

Arnaldo, as it's floating around on the list about a month already
I guess it needs a rebase.  Also I need to check TUI as Jiri reported.
Will post a next version soon.

Thanks
Namhyung
