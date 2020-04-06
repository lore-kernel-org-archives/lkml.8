Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A124B206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWVreJ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDFM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:59:20 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34236 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:59:20 -0400
Received: by mail-qv1-f65.google.com with SMTP id s18so7426577qvn.1;
        Mon, 06 Apr 2020 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxGwinml6L63Dd0SxlcAA+Fpb67gjBgQcqRZqE51pfI=;
        b=vWVreJ6xUG3g48AYI+1xkZhxI/cr4OThryjnox6hAOz0Gwa7e5OeSnPjEk2zPY1xta
         ClGQtU8mVpnp3VMZixHhB3aCVavqUQDSXuCsK6f7ieziSrMqOrZ36Hw0pxlN1TLZ19Cc
         porg0WqRFoBoYLSLqzuYfrxBInc4l9oyDX75VotUP28H0b1SdTRU2jSr3fIAAh3QDVL3
         IkGNhFrWdjheWt4YGyEvzefnfj7i87jQ/4YZOcq+fHK4WpzjCMHUDzt4bWjXF0ClOo+M
         l8qsiG70B+xhjWYSXhAv8efk8kYtO9nGkb0nvYF8mNW5u98/yuCEhOEuFV1jadSkCv4A
         aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxGwinml6L63Dd0SxlcAA+Fpb67gjBgQcqRZqE51pfI=;
        b=sQBwaf1rKSPboV+QH2pjVQnX41jRjRKUhunYk5QC2v/GJ+ysW/xL0giy55xbqVi/x6
         iPOHEekxiWx0gmMBfX1zZ8+zfY2sas6CPUXt7CObt4LFYmpDSAHqNOVrng2fqJzt8m6Q
         EUFvyPNFdC3Q07td6K8Ti6JWXktUY5bNeQONvoSZrTYW1tYu10jzYcOOI/tXEsiDPM7/
         l+sOgpIQQ+xZoSfGwcRFumijJhbxNTTdxYwWgdzQeF+PYt7OsE7Nlb2jX+rV+BXPKD/m
         U8fpst3oXXHUuUbDwUks4hnO6hXsSKnk1RFjGjrZe9OMxcESg7bSDToxYZkkm0BwlxZQ
         h0HA==
X-Gm-Message-State: AGi0Pua4w3ikm93kVRn78rYk4JHRG4JQhe6f1SaFe2Ru+/Voc/Y72w4r
        51n/Fg/zQ1QSZSkBF8xnpD4=
X-Google-Smtp-Source: APiQypKdfXQycH3iEQEMh24zdyT04thHwTjkvMXimi+fx7j80MTOVpNSbBz+vGHS/+FdhJMHRbHmcw==
X-Received: by 2002:a0c:e902:: with SMTP id a2mr20982750qvo.103.1586177959061;
        Mon, 06 Apr 2020 05:59:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c40sm15506777qtk.18.2020.04.06.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 05:59:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B304409A3; Mon,  6 Apr 2020 09:59:16 -0300 (-03)
Date:   Mon, 6 Apr 2020 09:59:15 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Message-ID: <20200406125915.GQ9917@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
 <20200403124028.GA18559@kernel.org>
 <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
 <0a942366-c8dd-4767-ee84-fdc0024b035f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a942366-c8dd-4767-ee84-fdc0024b035f@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 06, 2020 at 11:30:23AM +0200, Andreas Gerstmayr escreveu:
> On 03.04.20 15:16, Andreas Gerstmayr wrote:
> > On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
> > > > On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
> > > > > When running perf script report with a Python script and a callgraph in
> > > > > DWARF mode, intr_regs->regs can be 0 and therefore crashing
> > > > > the regs_map
> > > > > function.

> > > > > Added a check for this condition (same check as in
> > > > > builtin-script.c:595).

> > > > > Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>

> > > > Tested-by: Kim Phillips <kim.phillips@amd.com>

> > > Thanks, added this to that patch.

> > Great, thanks!
 
> Ah, I thought you were referring to my initial flamegraph.py perf script.
> Is there anything I can do to get it merged?

I'll test it today, were there any Tested-by: or Reviewed-by: to that
flamegraph.py?

That is not yet a strict requirement for having patches accepted, but
help me a lot in dedicating time to test things that passed thru some
testing by other people,

Thanks,

- Arnaldo
