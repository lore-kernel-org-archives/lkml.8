Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC18C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76C62076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhhOE0vW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2S3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2S33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:29:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D75C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:29:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so1657239qvw.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXFt0EZMvpiF8YvWRIbxBeZ3EWG6fYd2jc4e9y7grkU=;
        b=MhhOE0vWN+/14cKGsqZSyuPvclNoNVF4GWVTix4OzoiJHzBI55540T1AnuF+BsgPFM
         UgXuUs/eTfXJGve5J8kXAfdfwup+19seib3FEZkHChojA6l41N6ycHGkkm+kqDOPTnzl
         HX5/wbnBTDppaOU6cvDOxq+GKrhMy5bzo12RXG9EsPDoJmblp17YLM07wqhmGeRaXKul
         wVG0fPT4P90gS05agLoulalj8uFQkYzrY1KAuOQBcdXjbadDcrBS9j1AKHTGBaSi6eqO
         JWD1zMKi+tg8atMNJlfX7ccdyMpZBie3mDIAPAUv6DL4CzmrwjCIKnQit+19qtoMaYg7
         /t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXFt0EZMvpiF8YvWRIbxBeZ3EWG6fYd2jc4e9y7grkU=;
        b=A6J2tTUBlLmQQvl+k1F2rHUuZIFHhHgmprm1HYacrs6d7syOrTfJWjBguvoouNHnOO
         bROgEcBZ0OELAE2ZkS0HPLieIPKhNMuAW+OikjW663ugyuic4xn/UhjZkExI7YKqSEvq
         5PMI3JVlYyFM1AjQX9UfVD+BnguB13ShVaqteWeikh/Ki/KSJ4y5QtGT2bkQ70L5Llcv
         fBZeORQ9ynN2cTDn1qlaxo95JgA9ksO0zXUnrzHn8XSXOLN7BbGeg8awgakOpAQjYEMB
         jIs7PUWq6uB4kkh9+Y9tI3MqeVfZ3tfrzfst8RX7T2naZ56a2xff6ouyvGuwRw1F4qQ2
         nssg==
X-Gm-Message-State: AGi0PuZWO6xXFNz0QMxugA6fikscVn3Q+meK3C7Pw225CgZxycHJReDF
        VPvHbnIYirp0CKfEoPUKRLuxTfz/D0YCTA==
X-Google-Smtp-Source: APiQypJAgvM6Q87vV9TL/44rlOMPxSITQ1zUd/dku9xR8KhF8JEn44/tRWCWBNbKiU7p+H2vWDPLmA==
X-Received: by 2002:a0c:e305:: with SMTP id s5mr35247944qvl.234.1588184968443;
        Wed, 29 Apr 2020 11:29:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o27sm16284659qko.71.2020.04.29.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:29:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 665FE409A3; Wed, 29 Apr 2020 15:29:25 -0300 (-03)
Date:   Wed, 29 Apr 2020 15:29:25 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] perf intel-pt: Add support for synthesizing branch
 stacks for regular events
Message-ID: <20200429182925.GH30487@kernel.org>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 06:07:42PM +0300, Adrian Hunter escreveu:
> Hi
> 
> This patchset adds Intel PT support for synthesizing branch stacks for
> regular events.  This follows on from the patchset that did the same thing
> for call chains.
> 
> The first 3 patches convert Intel PT to using thread-stack to record branch
> stacks, which allows branch stacks to be accumulated separately for each
> thread.
> 
> The next 3 patches add support for synthesizing branch stacks for regular
> events.
> 
> The final 2 patches update some documentation.

Thanks, applied.

- Arnaldo
 
> 
> Adrian Hunter (9):
>       perf thread-stack: Add branch stack support
>       perf intel-pt: Consolidate thread-stack use condition
>       perf intel-pt: Change branch stack support to use thread-stacks
>       perf auxtrace: Add option to synthesize branch stack for regular events
>       perf evsel: Add support for synthesized branch stack sample type
>       perf thread-stack: Add thread_stack__br_sample_late()
>       perf intel-pt: Add support for synthesizing branch stacks for regular events
>       perf intel-pt: Update documentation about itrace G and L options
>       perf intel-pt: Update documentation about using /proc/kcore
> 
>  tools/perf/Documentation/itrace.txt        |   5 +
>  tools/perf/Documentation/perf-intel-pt.txt |  53 +++++--
>  tools/perf/builtin-inject.c                |   3 +-
>  tools/perf/builtin-report.c                |   5 +-
>  tools/perf/util/auxtrace.c                 |   6 +-
>  tools/perf/util/auxtrace.h                 |   2 +
>  tools/perf/util/evsel.h                    |  10 ++
>  tools/perf/util/intel-bts.c                |   2 +-
>  tools/perf/util/intel-pt.c                 | 210 ++++++++++++++--------------
>  tools/perf/util/s390-cpumsf.c              |   3 +-
>  tools/perf/util/session.c                  |   2 +-
>  tools/perf/util/thread-stack.c             | 217 +++++++++++++++++++++++++++--
>  tools/perf/util/thread-stack.h             |   8 +-
>  13 files changed, 393 insertions(+), 133 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
