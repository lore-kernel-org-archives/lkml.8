Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5F2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDTWMwqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCYMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:17:47 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46287 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:17:47 -0400
Received: by mail-qv1-f66.google.com with SMTP id m2so859032qvu.13;
        Wed, 25 Mar 2020 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCHqbfOcz9l1jIgI5+QSL8qEVN5vTHKN+GHmYTlp45w=;
        b=QDTWMwqnimXH9BgJrZzF+2LHILQZrdax1XSud9DKh10Y67tjuwD7eyWW7E0u6Z/zdd
         TKMrknL3wikSdgYxlZBDa07yj6UMtG5/7lqzY32J09CuDe44OxEM+ywXfKXvy1cdrSFK
         g8nM/4qw0bjJ3HPlKI/QUbtvNCYyH3ZEBSoMwzeL+1ejiCo8Pepx3zRArKXaNFjowZef
         8OlzdHPkMgberpSaJqMx6xbaH10pPqq5TwtLl6qd3NHQLHQ427IdoMzJm2exPPB1BS2V
         Q6J96R4NMUJ/ge/uCxRwcUjXh990F2Y8COCYIS4MqEZaLMRVa/W/EaHLLyZG3H7KNcfe
         3i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCHqbfOcz9l1jIgI5+QSL8qEVN5vTHKN+GHmYTlp45w=;
        b=KeVnn6vo7LNVK2kEPOtC2wIWBEsECef26i5FBuDFswUBnp6oFj35mlR/ZXiIXnxbNh
         vmQuhh8NpLB1HZ304zOCrBte2uT8QPE8xN/xl1pbP7NVF1R6CHDFVAEHVIyNUqFh2NCb
         Yl31r9ksFxXzS5lTdin9VSC5M5Qfi/jtJSIx+3lTURQMTolDFRtEHTP7t78PgX8I/xBZ
         DdslmRhPYkt/y67l6pkJuyBqIaQWiFFDb4xxENHac2YYfgXPGuTP7vUJVqR5jPY2Bv87
         WXkhOYgikxPJbahfwS/YVvwgACBNanczBGblWbRReL7RIlNZN5MDfS+of/yxJAi9iqf6
         eCrw==
X-Gm-Message-State: ANhLgQ0fAG/D9jLA8v69zUohh6ndERZLTBELbTCNi5b4XB7z5KQS9Bmf
        RAIjV4SSNqa1U4FGcLfpb9s=
X-Google-Smtp-Source: ADFU+vu0ZXFGriF908POiSFosFKaQnLnOfMY/fECiEMBSS9Kd0l6vVikqWXqq8m4s+0cPi3rzpUoDA==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr2675365qvv.192.1585138665891;
        Wed, 25 Mar 2020 05:17:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c14sm4021332qtv.32.2020.03.25.05.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:17:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9725740F77; Wed, 25 Mar 2020 09:17:42 -0300 (-03)
Date:   Wed, 25 Mar 2020 09:17:42 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Message-ID: <20200325121742.GI9917@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
 <20200324163444.GA162390@mtj.duckdns.org>
 <20200324201522.GP2452@worktop.programming.kicks-ass.net>
 <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
 <CAM9d7chu0xowWK19fBQdSueVmAacpE6qO4x4NPjOY9Tcm8_AqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chu0xowWK19fBQdSueVmAacpE6qO4x4NPjOY9Tcm8_AqA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 07:24:37PM +0900, Namhyung Kim escreveu:
> On Wed, Mar 25, 2020 at 6:25 AM Arnaldo Melo <arnaldo.melo@gmail.com> wrote:
> > On March 24, 2020 5:15:22 PM GMT-03:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > >On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
> > >> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> > >> > Hello Peter, Tejun and folks.
> > >> >
> > >> > Do you have any other comments on the kernel side?
> > >> > If not, can I get your Ack?
> > >>
> > >> Everything looks good from cgroup side. I think I acked all cgroup
> > >parts already
> > >> but if not please feel free to add
> > >>
> > >>  Acked-by: Tejun Heo <tj@kernel.org>
> > >
> > >Yeah, looks good to me too. Since it's mostly userspace patches, will
> > >you route it Arnaldo?
> > >
> > >Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Thanks for the acks, I'll process it tomorrow, so tests passing it'll go Ingo's way for 5.7 tomorrow.
> 
> Thanks all for the acks,
> 
> Arnaldo, as it's floating around on the list about a month already
> I guess it needs a rebase.  Also I need to check TUI as Jiri reported.
> Will post a next version soon.

Thanks, I'll wait then.

- Arnaldo
