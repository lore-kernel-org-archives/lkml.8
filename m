Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC1C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDD920754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjMOKn0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCRTBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:01:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38841 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCRTBU (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:01:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so40707331qke.5
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gyDDAGnN0+LBWB49fPGmPM7AMhPMQQGHLODtCBzOA+Y=;
        b=GjMOKn0iB8JmAMIN2zEsnNpTiTSxtTgIaYSlZMRcLS07PLeLhXyaCbchtsSfvX/R9V
         5aNL8T2c0nPiiEiYhsP++wIQrzTGQB0/BaUsbwh/vz9ozsIEnD8VXdnog+pQsGc+SFZK
         GcLC860zu1BXYVhah1KYq20vmkewBxFDo7zktOEyR7LydoAV4nPNxHDVu2ibaj+Sbyou
         Bsj87/QJtk5gMi7uxMWWIVJfG5Yo/z/+suenjvjiDWQ8ZU5Eux+br7ntY7yfxZIYUEHB
         z8EwVcYHiXzNwuurDxgKx7cRbx4+54nKCUjo1AKhILan7Z59/ZlnGkZkaIz0xBMnJ8IA
         mdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gyDDAGnN0+LBWB49fPGmPM7AMhPMQQGHLODtCBzOA+Y=;
        b=lrhm/CSiRO9fNIQR32G9N+l1jwOYOjVSIFhBnhBbcnlwWYbKm2eG+J1rQpgzkirSff
         ckiVerLO5TPJXuKVqqTokb8JqKkx/5CdMAaxuMu4/suSp6HgrnVp42oWqADivUQIf7Nn
         v3STo4GDjghlMWNEa/ZrYbBP1uTo/gSwcP+bhasHQEz9g9hqD9i/g6zJ1P4PVq6+0pNH
         wi41NvNBcCxDNLZicaqNGFTYkB9nqntjWJ8lH5+2A6HmVeAEW/iY92lVIvTKRunxCW0O
         wQQZ3k1NiZ3tEd2kT5Ms5ypo85N0q3WYfvUUzxPVKNfWDMr5ciWx3USR7ewEMDOOGl3H
         q08Q==
X-Gm-Message-State: ANhLgQ1WytRIo5anepKWa1hk1uP4c2QpGMPaKlmj/1wrdHgvHmUDCJnJ
        famL/Dx7zS7lLFbcX6xvOPM=
X-Google-Smtp-Source: ADFU+vvZ51LoHbcmj/PTq8HQaFaXZRKm5dhASQxjInu3ufJJaPChck1GVv2khtFarjBfUYuut98VOw==
X-Received: by 2002:a05:620a:1518:: with SMTP id i24mr5593089qkk.409.1584558079471;
        Wed, 18 Mar 2020 12:01:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k4sm4723353qkc.18.2020.03.18.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:01:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF6A5404E4; Wed, 18 Mar 2020 16:01:16 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:01:16 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 0/3] perf report: Support sorting by a given event in
 group
Message-ID: <20200318190116.GN11531@kernel.org>
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220013616.19916-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 20, 2020 at 09:36:13AM +0800, Jin Yao escreveu:
> When performing "perf report --group", it shows the event group information
> together. By default, the output is sorted by the first event in group.
> It would be nice for user to select any event for sorting.
> 
> The patch 1/3 introduces a new option "--group-sort-idx" to sort the
> output by the event at the index n in event group.
> 
> The patch 2/3 creates a new key K_RELOAD to reload the browser.
> 
> The patch 3/3 supports hotkeys in browser to select a event to
> sort.

Thanks, applied.

- Arnaldo
 
>  v7:
>  ---
>  v6 was posted two months ago and all comments were fixed.
> 
>  v7 just rebases to perf/core, no other change.
> 
> Jin Yao (3):
>   perf report: Change sort order by a specified event in group
>   perf report: Support a new key to reload the browser
>   perf report: support hotkey to let user select any event for sorting
> 
>  tools/perf/Documentation/perf-report.txt |   5 ++
>  tools/perf/builtin-report.c              |  16 +++-
>  tools/perf/ui/browsers/hists.c           |  29 ++++++-
>  tools/perf/ui/hist.c                     | 104 +++++++++++++++++++----
>  tools/perf/ui/keysyms.h                  |   1 +
>  tools/perf/util/hist.h                   |   1 +
>  tools/perf/util/symbol_conf.h            |   1 +
>  7 files changed, 138 insertions(+), 19 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
