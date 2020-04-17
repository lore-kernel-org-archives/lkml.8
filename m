Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6911F206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezd8MYoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDQVhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgDQVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:37:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DBAC061A0C;
        Fri, 17 Apr 2020 14:37:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b10so3276719qtt.9;
        Fri, 17 Apr 2020 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oo5vR4yC5MtDvMVJ8Kcq/TzZ58lxiEoKMeIC53iSq0s=;
        b=Ezd8MYoQKEF03PFVDXvEcZhHZRk4J4SaXaU490YvfqptHrPxFS5OAH7rJSRUi/ziUR
         IKthdnnIULiCyJFob0vGq2t2mgO+OQvyUdoG2NSH/vvbwb4PJdR9rbD4/BmZQ3jzXZAi
         v3FmUGbilKzK+rDAFxVZ4TCyDYWSbI3W4Qvi7u6QwM7SWIB8uEcL7SRMnTF4HHtCtKOw
         F90BXczXLDTPkEaiJ0ipSqVk0IKNpYLBUoMqv9KrUjNn80KaF/6atBIxb13MpXsrQDCN
         ZmYFNhrX2uLAO6UeUp+hiezeKf9gTYOrHLQaCiT7M4Ldro4s5pLL1Uexoa6LHewXAGnh
         peGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oo5vR4yC5MtDvMVJ8Kcq/TzZ58lxiEoKMeIC53iSq0s=;
        b=DBcjkdBfIpSZSdyj7EfcfF7fSzcSukyWK6XxW6WFiSV8RtQLy9goXp0nDFKNRIQSY9
         tszQGjLmEXEkV4ddeQvjn+hmggYG/TaYEPuXZ52wCL0prwjZy3VnUcNj53YFu7TNVEzU
         O5Y1co+roeR2y9hKKHbBHtRbxGUfDY44yKFAJ/EmRYmGfCQLT0o7sj7B83jAuTNYfiO7
         2GtKmj24C2YucYfjw5HSqlHjB0tCRXSqPxebXhc5V3xNUGyW6JGvOxjNadMGN6uupq46
         CHlqt66/oRQeTZQAB7zH1O04x+scAdijMNQygKoW2q/DjFJXCB6O1+OrZaq18sjiYhaI
         uH5g==
X-Gm-Message-State: AGi0PuYBIp2KFE0X6MWt/r3EwNaWG4A2Zf2DllylV4tia0pKQOiA9Y8F
        T59r/qPK7MjRbeR0JGBLT0U=
X-Google-Smtp-Source: APiQypLiB4CIXCAeMYTa6TZmsw814FETSiWGIk8ktp6sUlkrRJ02GLe7du3uV1SSmssOYZbhJn17nw==
X-Received: by 2002:ac8:296f:: with SMTP id z44mr5123606qtz.18.1587159427130;
        Fri, 17 Apr 2020 14:37:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x68sm18116965qka.129.2020.04.17.14.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:37:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50557409A3; Fri, 17 Apr 2020 18:37:04 -0300 (-03)
Date:   Fri, 17 Apr 2020 18:37:04 -0300
To:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
Message-ID: <20200417213704.GB21512@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
 <20200416151443.GA2650@kernel.org>
 <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 17, 2020 at 04:50:00PM +0300, Adrian Hunter escreveu:
> On 16/04/20 6:14 pm, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 01, 2020 at 01:16:08PM +0300, Adrian Hunter escreveu:
> >> Currently, callchains can be synthesized only for synthesized events.
> >> Support also synthesizing callchains for regular events.
> > 
> > This is super cool, I wonder if we shouldn't do it automatically or just
> > adding a new type of callchains, i.e.:
> > 
> > 	perf record --call-graph pt uname
> > 
> > Should take care of all the details, i.e. do the extra steps below
> > behind the scenes.
> > 
> > Possibly even find out that the workload specified was built with
> > -fomit-frame-pointers, that the hardware has Intel PT and do all behind
> > the scenes for:
> > 
> > 	perf record -g uname
> > 
> > Alternatively we could take some less seemingly far fetched approach and
> > make this configurable via:
> > 
> > 	perf config call-graph.record-mode=pt
> > 
> > What do you think?
> 
> Adding a --call-graph option sounds reasonable, and config to define default
> callgraph options.  But this was done at Andi Kleen's request, so he may
> want to comment.

Andi? My concern is that if this is the optimal solution for a good
subset of the machines out there, then we need to make it easy to use,
even transparent, if possible and safe to take that path.

- Arnaldo
