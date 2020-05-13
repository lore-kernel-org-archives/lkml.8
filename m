Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0978F205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpoJ+r5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbgEMR6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732611AbgEMR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:58:09 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F682C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:58:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r3so180401qve.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jsw3CZQW8TNAau5K+70bI5NImUGorTi2FKZJN5WB16Q=;
        b=qpoJ+r5L7H9PVtgA7ACG/3cdaUYNUUvhr+U+qjvbsf3ceSYOhGfrBYuaElY6Sk8jWm
         GdBMw4Be8y+A92ExwXu2ND96knZYgzUdqevDhGDCAvQ7FxT211q/6XWG5muBEIPHp1Rp
         eUYL/w6tk1kNzqSvLYLL5kqZkH2XqmagPlyG87XirtcHZq3bq4NgF22D2oP2wn/CY5XK
         LeHhxSBHp9QiG50zN6PvVPqoQnUhLDM55OMXfLz1IKwOIjizyaSl5gNua+bkvELgGfG7
         yBbRs7iy6bahnlYhrzEYlbz5nqSfOAIUUzXJUi2obR+xPS88cF/VMUjSHVNKUKJMTq6v
         oBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jsw3CZQW8TNAau5K+70bI5NImUGorTi2FKZJN5WB16Q=;
        b=KQyw558PYZCVrbBFA3KknasE9fw+Dw7naCS0JTW1khfPIpp71irhK9G5+96vHpALEI
         HJck5+q8NIByzjQf5JJdYGtwWwk8sTBLIN+2GHyggW33qqhHKMVElYgIWh6Ctd6oJzf2
         JyMlNNwI1oe74jsDsH9PeYQSZ83HCXY8MxgQfYEOiBqmsuZlpzBxXW2zIEjH2DCODUux
         tFJvBENt9HuXdjSz/SOVO43s24hYOWShKJKFnC5a5Gto/UAbIcZ89bghG11pz+p+TFI+
         DPLCl1yq045Kds9YaxyG5riTOxnTgd3czGKwT+jhX4WCp+5TAeL5K84FqBRvrrjDNRnK
         jFUA==
X-Gm-Message-State: AOAM532/JikFSpQtsA2FcUCqPRIbzLjxhXZ2o2Sosp4sCUpP1l8aruF7
        +Y6cuuqSJIlWATvvUREDtyUWaeKZGrM=
X-Google-Smtp-Source: ABdhPJx1fqLhtAxFk6BXXvKqbxOsYO6B/IxsL0G7N2hV9fHRt7Ax6bhxrVNjbv5qy9QDCDfgZZ6ibg==
X-Received: by 2002:a05:6214:18f1:: with SMTP id ep17mr888714qvb.64.1589392688290;
        Wed, 13 May 2020 10:58:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x24sm295632qth.57.2020.05.13.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 10:58:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A3FC640AFD; Wed, 13 May 2020 14:58:05 -0300 (-03)
Date:   Wed, 13 May 2020 14:58:05 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf expr: Fix memory leaks in metric bison
Message-ID: <20200513175805.GK5583@kernel.org>
References: <20200513000318.15166-1-irogers@google.com>
 <20200513175253.GB3343750@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513175253.GB3343750@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 07:52:53PM +0200, Jiri Olsa escreveu:
> On Tue, May 12, 2020 at 05:03:18PM -0700, Ian Rogers wrote:
> > Add a destructor for strings to reclaim memory in the event of errors.
> > Free the ID given for a lookup, it was previously strdup-ed in the lex
> > code.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
