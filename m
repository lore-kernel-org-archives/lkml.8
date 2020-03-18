Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02A920674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF5nPYvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCRPwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:52:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36044 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:52:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so21097216qtb.3;
        Wed, 18 Mar 2020 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kKClyPxe61yC2pSY7DVn7DUBywyGrSRR9PZghnJHCp8=;
        b=pF5nPYvtu06Y+vIIoyhpG1apNFjdoOXXCloF8a0nDmhZJhuDERDKeVEF8G+4ih/mq3
         Hb0L+zfeVyjLV82K3a4OzspcGiiuqwGHnYaVkFO6JyBVkWfxMBASuxmVrUxhYhuo0kuZ
         RJo/JPUZ2Ydwg/Qlt/qHN5grOCU1nWho+OaKvhRQIq06s2fIvWCGOqCr9HNNrJR1isjs
         2y4lhCorZrIoEv8Jx9KdjlX0/wjsGYfMxe4dHMmW0OrUUtoP27Hx9jh4GpMJFVHkqM8O
         2SzlH2X4bg1cx2Xf+lX7vQ04YMklUVE0xugiR7hCan4TVLdNx+LrQ7szAXp+HqkVGFLp
         hN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKClyPxe61yC2pSY7DVn7DUBywyGrSRR9PZghnJHCp8=;
        b=Kis5kDId9wsUx6mG9jSgCzCdSC5ScwHGfpYCVQvAy9XeCqpFUB8nWTSRGf7BGsHKzO
         uMdZXzbL/oaZPU1amOI5iUFBhuQUJ5hjqAUbs0Fj7OzYtWRHPVIeVheTeOXBMRn4qahh
         s7A4/ykySYE5Ruf/xosXe7mKDp75/7NrnRBeLswSZ/r3J9CkLZaFn8PSBdy+k5nq74vt
         iE1FyJtAcMzG08i5L7o3G4BxOhLdDCOAiIym3o0P4Hg6Lsr01wXYmiB9btNEPsMadRSK
         7CYAXD1U1gwprDOc6rCPgq4U5dS6QkxPCEexNhKnHRxeKTODEHwuWz55XC/Y/6nLHPb3
         lELg==
X-Gm-Message-State: ANhLgQ223ddpJzvVrfRdAuKQPtpyEcndyuUD8B4OLq8cNp2VdReCTGuo
        qDAs/XoqtUQsuKZJ8wRNIAA=
X-Google-Smtp-Source: ADFU+vtsBc5r85hjh8u7XsGM+ikgAuN7oiKhzH86B9C5xGYODun3o31DItY373xb3DJ4afhm+/ohAA==
X-Received: by 2002:ac8:678c:: with SMTP id b12mr5255018qtp.196.1584546768248;
        Wed, 18 Mar 2020 08:52:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s8sm4805024qti.0.2020.03.18.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:52:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82797404E4; Wed, 18 Mar 2020 12:52:45 -0300 (-03)
Date:   Wed, 18 Mar 2020 12:52:45 -0300
To:     Vijay Thakkar <vijaythakkar@me.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200318155245.GJ11531@kernel.org>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-3-vijaythakkar@me.com>
 <20200318142057.GD11531@kernel.org>
 <20200318152112.GA231037@shwetrath.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318152112.GA231037@shwetrath.localdomain>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 11:21:12AM -0400, Vijay Thakkar escreveu:
> >   floating point:
> >     fpu_pipe_assignment.total
> >          [Total number of fp uOps]
> >   
> >   
> >   Metric Groups:
> >  
> 
> I just realized that I did not add back the counters for per pipe total
> assignment as I said in the commit message. Patch 3/3 adds the total
> uOp assignments per pipe for Zen1 based processors. Although the PPR for
> Matisse does not list these counters, I can still sample them on my
> Ryzen 3900X system and they seem to report correct numbers. For example,
> here is the result of running:
> 
> $> perf stat -e r100,r200,r400,r800,rf00 ls
> 
> $> Performance counter stats for 'ls':
> 
>             5,047      r100:u
>             5,236      r200:u
>             31,300     r400:u
>             2,040      r800:u
>             43,623     fpu_pipe_assignment.total:u
> 
> Note that the per pipe total counters add up the overall total, which
> makes me think I should submit a v6 of this patch adding the per pipe
> totals for zen2 as well, especially since it is mentioned in the commit
> message.

Ok, so I'll remove these patches, please redo that sequence I did in the
commit log, ok?

- Arnaldo
