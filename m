Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CCC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CAA20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcv8iiyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCRTAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:00:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33781 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCRTAy (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:00:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6so1846358qkm.0
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCPvdLN8939vZPMxozowr4/88mIqH8EmpduD2QRUtkM=;
        b=Qcv8iiyjAj4cRMxa+L5QuL2pFGxOPSawEy9XDsHtt6KzJ2jC1TP6z5Gv3x0jFuYlsd
         /sNt+DmgzbI72z1SsiXXBkkQJr2FmLm/P+29V3Gyck4B9QiQnUwFYEUkNvvNjMaPvGZ1
         o1keQMZXjMwt1NivMUTEc3F3LvDexShjTtlc7Xd0u5PB6a2REGJ7FhVEDK+FpVJJOxWv
         00FxAmOSRar0rv/n56mLwD6F/ljjrdUVgr1sqXeRkSIa+/CZZKladK7Ds4JKczF7wEk5
         k4HK605Ai2hOqbxaT9nEAydN5Uu22xbw0bnwVrPX7mr4lazLfHLsv+5AvG3R43dLAQRV
         rlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCPvdLN8939vZPMxozowr4/88mIqH8EmpduD2QRUtkM=;
        b=k9Y5kJkRTcvkpb3z2O82XqrhPJFaG3XrZrg2X5r+TptBp5qDrMukJkkmzoEDnvRm+n
         +NTRlfWnMZd9ALMjyAAUmOy00flWGX20unZw3HEUlW8wsgDRKEvWf3vhOmBCQKWA10Qt
         iQC4MsoU+oO5trlVCPdTxNPjeZA7TxC/DFrfmlgUF3Jl4CPjsVR5J7sTNROi5xPsxlj3
         70OzCCkayeCwmmKYbRpQqcV+4Kl/t7b7oLWMW4rnzfSz3kSG1k92daAzELAaF+Z37jMQ
         SZN5EvD76QfcT43YsynG3K81n8If+LxKI3vSg7PRdA871i0a5RTsbSIVkYnpfdAAnZjB
         sUeA==
X-Gm-Message-State: ANhLgQ0H85lpEmIchoypM2/FufapydPTpboZpxk3auXS3+EU28ovFaXS
        hn5i01WQLeVs++jeW0wri1s=
X-Google-Smtp-Source: ADFU+vtp8+WNV/mfAETLwj+rtiCgqdcqlCYxVXIyYK4cr0BZdAEHvcslZpJqrTNCj96rAt7mf0xZQw==
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr5508309qke.314.1584558052415;
        Wed, 18 Mar 2020 12:00:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v187sm4431033qkc.29.2020.03.18.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:00:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46296404E4; Wed, 18 Mar 2020 16:00:49 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:00:49 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align the output for interval aggregation mode
Message-ID: <20200318190049.GM11531@kernel.org>
References: <20200218071614.25736-1-yao.jin@linux.intel.com>
 <20200220105355.GA553812@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220105355.GA553812@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 20, 2020 at 11:53:55AM +0100, Jiri Olsa escreveu:
> On Tue, Feb 18, 2020 at 03:16:14PM +0800, Jin Yao wrote:
> > There is a slight misalignment in -A -I output.
> > 
> > For example,
> > 
> >  perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
> > 
> >  #           time CPU                    counts unit events
> >       1.000440863 CPU0               1,068,388      cpu/event=cpu-cycles/
> >       1.000440863 CPU1                 875,954      cpu/event=cpu-cycles/
> >       1.000440863 CPU2               3,072,538      cpu/event=cpu-cycles/
> >       1.000440863 CPU3               4,026,870      cpu/event=cpu-cycles/
> >       1.000440863 CPU4               5,919,630      cpu/event=cpu-cycles/
> >       1.000440863 CPU5               2,714,260      cpu/event=cpu-cycles/
> >       1.000440863 CPU6               2,219,240      cpu/event=cpu-cycles/
> >       1.000440863 CPU7               1,299,232      cpu/event=cpu-cycles/
> > 
> > The value of counts is not aligned with the column "counts" and
> > the event name is not aligned with the column "events".
> > 
> > With this patch, the output is,
> > 
> >  perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
> > 
> >  #           time CPU                    counts unit events
> >       1.000423009 CPU0                  997,421      cpu/event=cpu-cycles/
> >       1.000423009 CPU1                1,422,042      cpu/event=cpu-cycles/
> >       1.000423009 CPU2                  484,651      cpu/event=cpu-cycles/
> >       1.000423009 CPU3                  525,791      cpu/event=cpu-cycles/
> >       1.000423009 CPU4                1,370,100      cpu/event=cpu-cycles/
> >       1.000423009 CPU5                  442,072      cpu/event=cpu-cycles/
> >       1.000423009 CPU6                  205,643      cpu/event=cpu-cycles/
> >       1.000423009 CPU7                1,302,250      cpu/event=cpu-cycles/
> > 
> > Now output is aligned.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks, tested and applied.

- Arnaldo
