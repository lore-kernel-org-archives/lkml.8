Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCFC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C320783
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0WeEkyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRTDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:03:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33482 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTDa (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:03:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id p6so1862756qkm.0
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qOkhE330vtZ1e69iIjVyr/Ge6ASbGdm5Spx+kHks238=;
        b=O0WeEkyfPOxGtBLwVh4hKvrSGmbQCPXprY/DvgQlOThx/LSPfzg1rntvKlORo+QPtu
         PqTKG1LOj0HUbpIIm9dLSockzbHvp/pqbhexb3vCvo2xwuzht5/Ykccr9Vj5n+F54765
         rRBWRPHoycQrjkB6NfI/O6Dp/vwQADmW2Zk3612gHSpn+SZH4WG8OKRRRAWf7VQhIxxG
         g3BUOPZb6ib1FmV0i82w3duJbxEIsLenmL8EaRlc01YnBQ1R2WCEWghXCSEu1Vx8JVSW
         R/71NTF6YNIREygT3+Nv/3pMkow1HLtDccbFnTgsDczLJWMngxdo6N785QBDn7MxAYLC
         XM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOkhE330vtZ1e69iIjVyr/Ge6ASbGdm5Spx+kHks238=;
        b=d7Ft2f0Ihg3azy/CbKTez0hREIMGS1/Vy5ANJ39TpwgpG5UntYeHcSaWmR/0JJnEkq
         R2EMGhOXXxBsUlwxP0M7t0JYx3TgSOk3hnGYMu+aVDEnV92HvUKPcEFjVTmzTbVRsvo/
         Sqd/H13S2Rq2SydyPattd1msLcm8dbeuvOorSzqZxTgGzOTmjHms8Xz322GMYMkvh7dc
         yQuFx1y5p4eJJhppKU4dVUvLC1MrPzPrFMUiJWbJ3O6SzUixzAKl4N4HLAsm1XoyoEDq
         9wRIlNB8SZevVZUxUncgPeZhYY0HwXQCwedFSxj7aSocucImDvuSlA6RYjEturZ2RSpb
         XLKw==
X-Gm-Message-State: ANhLgQ2P+a4U5PXDLI+YLRqsuxzFx7xxjjELC3xYMLS1EpFqHSU8YoxU
        TP83LZU9ElIfcmdDo+iTW7c=
X-Google-Smtp-Source: ADFU+vsZeLgurK+E3emu21GqR1m+596NrqeASgWZ0y2527cKcca9MSEAd2Mzmhs0YodrjtreGPBX8w==
X-Received: by 2002:a37:490:: with SMTP id 138mr5805842qke.378.1584558207764;
        Wed, 18 Mar 2020 12:03:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 18sm4706998qkk.84.2020.03.18.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:03:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58472404E4; Wed, 18 Mar 2020 16:03:25 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:03:25 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 0/3] perf report: Support sorting by a given event in
 group
Message-ID: <20200318190325.GO11531@kernel.org>
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200318190116.GN11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318190116.GN11531@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 04:01:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 20, 2020 at 09:36:13AM +0800, Jin Yao escreveu:
> > When performing "perf report --group", it shows the event group information
> > together. By default, the output is sorted by the first event in group.
> > It would be nice for user to select any event for sorting.
> > 
> > The patch 1/3 introduces a new option "--group-sort-idx" to sort the
> > output by the event at the index n in event group.
> > 
> > The patch 2/3 creates a new key K_RELOAD to reload the browser.
> > 
> > The patch 3/3 supports hotkeys in browser to select a event to
> > sort.
> 
> Thanks, applied.

Doesn't work with 'perf top', should, investigating,

- Arnaldo
 
> - Arnaldo
>  
> >  v7:
> >  ---
> >  v6 was posted two months ago and all comments were fixed.
> > 
> >  v7 just rebases to perf/core, no other change.
> > 
> > Jin Yao (3):
> >   perf report: Change sort order by a specified event in group
> >   perf report: Support a new key to reload the browser
> >   perf report: support hotkey to let user select any event for sorting
> > 
> >  tools/perf/Documentation/perf-report.txt |   5 ++
> >  tools/perf/builtin-report.c              |  16 +++-
> >  tools/perf/ui/browsers/hists.c           |  29 ++++++-
> >  tools/perf/ui/hist.c                     | 104 +++++++++++++++++++----
> >  tools/perf/ui/keysyms.h                  |   1 +
> >  tools/perf/util/hist.h                   |   1 +
> >  tools/perf/util/symbol_conf.h            |   1 +
> >  7 files changed, 138 insertions(+), 19 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
