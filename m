Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1096F208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoT934nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCYOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:22:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44378 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgCYOWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:22:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id x16so2222945qts.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceSqSuAmwe5F0+PN0pPM82PCWq207HfzffKDVDP+Rio=;
        b=NoT934nNmmMbrUs6I2yybbvCgNxL0ShfK9CCqSoB5EU/inCFd9Gxl2RaccAOwyzZEC
         Xvbdk3lRzox8L9R2zwZrjVbsH7YG1sk6w3IcAGop7OiVjL98RccjBqT22HeT0MSUcjHH
         j1xGy/RGV6DJ9bOvO965kwaZ7cOrgJwVAXwjmRpLmsR23xK+qsknrSMXNr9CSTKAlds1
         25ujJZH4u+WJ2Wal5nKodazNciNzm4DzKmgZtL9zZaRc2FfLBn+L+Hiv6f8ZVbF/xaTg
         49sHNx0DgtTL8E7QbTQjOn3A87Ac9KaKge+ELnDLHVjA622QQv9gsJvqGb6wTT0is9Ek
         Brsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceSqSuAmwe5F0+PN0pPM82PCWq207HfzffKDVDP+Rio=;
        b=EC3OCxGQaF3CCQeMfhh88byC7OhBcQwAibS2anH8UbUGgQji1Qe4HwaU5Z5bgFqGps
         FEPhsOzHnitZppIrlr2ywDNQ3booyBU5w+j2/nOD/VGzpJp+jyKpsuHhz25V3QxrH8si
         ueZR/AsNidCcgCo0vem6uU52aiT+zye6hYjke3a2jpln9AxzpD0vuhxd337a0u3FN+eL
         hinMkYTIJrBNBWgmq5BwUanGPhNE7TYX46dJmpcCCOMtFfvQMWyksYxHC4RQtQDJoyiI
         OOYx0v8e2srqiv9qweho8bfHCVEvuux+EkkfM3Tv0ek8a3xiJfVSUBIClqk+0VHef4D2
         MAEw==
X-Gm-Message-State: ANhLgQ1pKsYHYsfRAbBfyv+lt2xUoKg0vCW6sbdASm1ezrwYZbi0HlYi
        pysEWpBGIN6g7IDSGSemCDgzp9t7
X-Google-Smtp-Source: ADFU+vsEV6iDLw4ZICY8HYix3G6oKUwgXR9kX9ZEqoMBO8cchgHfWgbJawEvDNY4OD7BhtJFu4/sdw==
X-Received: by 2002:ac8:6d19:: with SMTP id o25mr3184596qtt.303.1585146137211;
        Wed, 25 Mar 2020 07:22:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l188sm15215023qkc.106.2020.03.25.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:22:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8DC5340F77; Wed, 25 Mar 2020 11:22:14 -0300 (-03)
Date:   Wed, 25 Mar 2020 11:22:14 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200325142214.GD14102@kernel.org>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325135350.GA1888042@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 02:53:50PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 25, 2020 at 10:15:49AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 25, 2020 at 11:33:45AM +0100, Jiri Olsa escreveu:
> > > On Tue, Mar 24, 2020 at 05:04:43PM +0200, Adrian Hunter wrote:
> > > > perf list expects CPU events to be parseable by name, e.g.
> > 
> > > >     # perf list | grep el-capacity-read
> > > >       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]
> > 
> > > > But the event parser does not recognize them that way, e.g.
> > 
> > > >     # perf test -v "Parse event"
> > > >     <SNIP>
> > > >     running test 54 'cycles//u'
> > > >     running test 55 'cycles:k'
> > > >     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
> > > >     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
> > > >     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
> > > >     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
> > > >     -> cpu/event=0,umask=0x11/
> > > >     -> cpu/event=0,umask=0x13/
> > > >     -> cpu/event=0x54,umask=0x1/
> > > >     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
> > > >     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
> > > >                            \___ parser error test child finished with 1
> > > >     ---- end ----
> > > >     Parse event definition strings: FAILED!
> > 
> > > > Fix by adding missing Intel CPU events to the event parser.
> > > > Missing events were found by using:
> > 
> > > >     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
> > > > 
> > > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > So, I'm not being able to reproduce this, what an I missing?
> 
> I think you need to be on some really recent intel
> which defines events which we did not covered yet
> like el-capacity-write in icelake

That is why I tried with el-capacity, which is moved to the parser as
well, I've replaced el-capacity-read, which I don't have in this Kaby
Lake machine, with el-capacity, that is present:

[root@seventh ~]# perf list | grep el-capacity
  el-capacity OR cpu/el-capacity/                    [Kernel PMU event]
[root@seventh ~]#

- Arnaldo
