Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69612C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0722077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qq2lxYQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCYNPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:15:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42255 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCYNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:15:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id t9so2016628qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jjYGmCdWOxDHKljO3oneNL13klBtbY9s960pcoSP18=;
        b=qq2lxYQPPNi7TJbXZxU1nygbmeLSrjEBh9cV5Knr7kWRe4Biv6O2zmw6KANaAJqLBu
         sZvIAZAjFEfUAkZLKm5oJ16jf03sv1NWaf/rQiWqESePwcNaxKKvvDx9zqtFRmwA1qjD
         Uc4KF8c2V9D2va9MTwgbFUQ7X8gmplPQGhBGTyaNdahQsmpShtkERqtwv2xws67atLoq
         iAF8DMoGC5tjtJ1J8JovAYhRaG2JrEsVgbMT2+xJNUrxBArv20z7us3kBtJkHObcZftJ
         foNfYsqQfnkUxOMFJ4vzJBhE2HrmcHTSA3VeWZtof+ErJuqQ9x5anLXy3BPScQDEkili
         1vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jjYGmCdWOxDHKljO3oneNL13klBtbY9s960pcoSP18=;
        b=qxB9Rgf8BJ+tjIYyBTn/EhL2t90Da//EAXioBMRJCq1jSnc1fulGuUTt7tSkeWyq4G
         HuZrGuG9PEcJySs6IP/Wotm9hTjS1gQ5BxT6KoaqGei1bq6HqLnqEw7D4ay1ez6GvzTX
         MSPcz/pqt59eRkIRYuSFb5yoLPSpaqVGk+l0oiZ1W7GcVNDhMEjzvg9A+HfS2I3RIE1N
         Yq2FZEAW3l5FgX/DaI6RWm8CFcq5EjgohUjc/irAhg4SM5qtlqO0hiB84poVKGWviUnH
         /dx+g8oANRnJj0+7QKuHbm1WKEMKJ3eZfsiOnTFDmNSgapJiR8i5cNMdbiY2tZqvXqbP
         Jk4A==
X-Gm-Message-State: ANhLgQ0c66r/ZF6RKO2P4/hHb9AL20cP+khKiVgaiEX/163HTKIcbsRN
        l+WqqcOeWCiaKtVynqYhj8I=
X-Google-Smtp-Source: ADFU+vubdijCEmwrjMtmsILWJUfAPGFtm9m/4iHYXKyx/919lpHT1gjmv74JhRpTgemXavZoF00hdw==
X-Received: by 2002:ac8:2f5c:: with SMTP id k28mr2877215qta.301.1585142152607;
        Wed, 25 Mar 2020 06:15:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r207sm15029180qke.136.2020.03.25.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:15:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D67F140F77; Wed, 25 Mar 2020 10:15:49 -0300 (-03)
Date:   Wed, 25 Mar 2020 10:15:49 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200325131549.GB14102@kernel.org>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325103345.GA1856035@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 11:33:45AM +0100, Jiri Olsa escreveu:
> On Tue, Mar 24, 2020 at 05:04:43PM +0200, Adrian Hunter wrote:
> > perf list expects CPU events to be parseable by name, e.g.

> >     # perf list | grep el-capacity-read
> >       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]

> > But the event parser does not recognize them that way, e.g.

> >     # perf test -v "Parse event"
> >     <SNIP>
> >     running test 54 'cycles//u'
> >     running test 55 'cycles:k'
> >     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
> >     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
> >     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
> >     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
> >     -> cpu/event=0,umask=0x11/
> >     -> cpu/event=0,umask=0x13/
> >     -> cpu/event=0x54,umask=0x1/
> >     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
> >     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
> >                            \___ parser error test child finished with 1
> >     ---- end ----
> >     Parse event definition strings: FAILED!

> > Fix by adding missing Intel CPU events to the event parser.
> > Missing events were found by using:

> >     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

So, I'm not being able to reproduce this, what an I missing?

[root@seventh ~]# grep -m1 'model name' /proc/cpuinfo
model name	: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
[root@seventh ~]#

[root@seventh ~]# perf list | grep el-capacity
  el-capacity OR cpu/el-capacity/                    [Kernel PMU event]
[root@seventh ~]# perf test -v "Parse event" |& grep el-capacity
el-capacity -> cpu/event=0x54,umask=0x2/
[root@seventh ~]# perf stat -e el-capacity:u,cpu/event=el-capacity/u
^C
 Performance counter stats for 'system wide':

                 0      el-capacity:u
                 0      cpu/event=el-capacity/u

       2.315736828 seconds time elapsed


[root@seventh ~]#

[root@seventh ~]# perf test -v "Parse event" |& grep el-capacity -B5
running test 55 'cycles:k'
running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
el-capacity -> cpu/event=0x54,umask=0x2/
[root@seventh ~]# perf test -v "Parse event" |& grep el-capacity -B5 -A5
running test 55 'cycles:k'
running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
el-capacity -> cpu/event=0x54,umask=0x2/
el-conflict -> cpu/event=0x54,umask=0x1/
el-start -> cpu/event=0xc8,umask=0x1/
tx-abort -> cpu/event=0xc9,umask=0x4/
topdown-slots-issued -> cpu/event=0xe,umask=0x1/
tx-capacity -> cpu/event=0x54,umask=0x2/
[root@seventh ~]#
