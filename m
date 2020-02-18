Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43279C34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT49w0C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRTaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:30:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37680 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:30:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id c188so20678150qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U9BxnklloKOZjCuc3cdTh1HeN/WnMWEq4zfovk73vyI=;
        b=nT49w0C1ih5oOzBuBiyvQjcGXgaymRwO9laS+OKDFfRZxupH6y7XS1KkdPScRyKr7Y
         TLq9WjVJyN6/VcyD6x32k0izI8wLRVmKM5Rsq0WbUf4/hD/YmFCTeMADkULpEBF7zGmH
         jcOvWaensQUjpPb71s4iSUMXCIjg61ptLPuZ+lpRZXVof6kXle79aTHPOhUCjSJuB2HW
         wTNHJm2VVJMDt7LszNAtbhRSEfHsDAihoUkR5Tkk9HjIYiXHpU2Cxv/GZb3geQplz7rq
         rvn8+Q9tl7llI3pMLPHrz9iy7PSnDxS/2zqirUQGyCM7hdiBIqCLI1PFHn6uPEgS0RCV
         EJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9BxnklloKOZjCuc3cdTh1HeN/WnMWEq4zfovk73vyI=;
        b=rzor2X8ijm4OlCHBN9QzzDO8C1uYOe9UXFlMgmpE+DAT3GXXGOIqS2dCWfMMm4y1wt
         NH47qd/rZ79Z+CVpal4AYrWHea/KZEHl/ShMKQm8a1AWI6a7m/vJvox7lSkNN+TXq1lr
         e5/Xlifseujvuh5QP23oyTUbQrlGzGqOasiAubESzDVs9b1J1ZCdr/yWWnTHcFouY2gz
         LBq6p4r/JtjeExKF8hEXj4ruAGhC0kd5w5n7BXsnxbnAT0GhC4uwzrL9nVx0G9QH99eC
         uD/O+chzLVyvaIP41Ac4uICd9Uokq3/kzLhj41Z6rZb+OOKSSiBo9iDOEIQxqX55ZIQg
         N1Cg==
X-Gm-Message-State: APjAAAVcYemquQUh7Qw00mzgKaZGASBFn9yD7VE/xFDVV60if4oZNCJV
        WdNMBHhjwKZjR1I2L4WQlpg=
X-Google-Smtp-Source: APXvYqzPBYX13UKcjxqTRxINgTW3YVwcmTzpGKcYlyHHhqImes3oVrqtJfJVeX1Cbl5C51KUmqQCeg==
X-Received: by 2002:a37:a488:: with SMTP id n130mr19775161qke.120.1582054221733;
        Tue, 18 Feb 2020 11:30:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.210.189])
        by smtp.gmail.com with ESMTPSA id o10sm2223215qtp.38.2020.02.18.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:30:21 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2047403AD; Tue, 18 Feb 2020 16:30:11 -0300 (-03)
Date:   Tue, 18 Feb 2020 16:30:11 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200218193011.GB5365@kernel.org>
References: <20200213094204.2568-1-leo.yan@linaro.org>
 <20200218184934.GA11448@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218184934.GA11448@xps15>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 18, 2020 at 11:49:34AM -0700, Mathieu Poirier escreveu:
> On Thu, Feb 13, 2020 at 05:41:59PM +0800, Leo Yan wrote:
> > This patch series is to address issues for synthesizing instruction
> > samples, especially when the instruction sample period is small enough,
> > the current logic cannot synthesize multiple instruction samples within
> > one instruction range packet.
> > 
> > Patch 0001 is to swap packets for instruction samples, so this allow
> > option '--itrace=iNNN' can work well.
> > 
> > Patch 0002 avoids to reset the last branches for every instruction
> > sample; if reset the last branches for every time generating sample, the
> > later samples in the same range packet cannot use the last branches
> > anymore.
> > 
> > Patch 0003 is the fixing for handling different instruction periods,
> > especially for small sample period.
> > 
> > Patch 0004 is an optimization for copying last branches; it only copies
> > last branches once if the instruction samples share the same last
> > branches.
> > 
> > Patch 0005 is a minor fix for unsigned variable comparison to zero.
> > 
> > This patch set has been rebased on the latest perf/core branch; and
> > verified on Juno board with below commands:
> > 
> >   # perf script --itrace=i2
> >   # perf script --itrace=i2il16
> >   # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
> >   # perf inject --itrace=i100il16 -i perf.data -o perf.data.new
> > 
> > Changes from v3:
> > * Refactored patch 0001 with new function cs_etm__packet_swap() (Mike);
> > * Refined instruction sample generation flow with single while loop,
> >   which completely uses Mike's suggestions (Mike);
> > * Added Mike's review tags for patch 01/02/04/05.
> > 
> > Changes from v2:
> > * Added patch 0001 which is to fix swapping packets for instruction
> >   samples;
> > * Refined minor commit logs and comments;
> > * Rebased on the latest perf/core branch.
> > 
> > Changes from v1:
> > * Rebased patch set on perf/core branch with latest commit 9fec3cd5fa4a
> >   ("perf map: Check if the map still has some refcounts on exit").
> > 
> > 
> > 
> > Leo Yan (5):
> >   perf cs-etm: Swap packets for instruction samples
> >   perf cs-etm: Continuously record last branch
> >   perf cs-etm: Correct synthesizing instruction samples
> >   perf cs-etm: Optimize copying last branches
> >   perf cs-etm: Fix unsigned variable comparison to zero
> 
> For all the patches in this set:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Unless Arnaldo says otherwise, I suggest you send a new V5 with Mike's RB for
> patch 3/5 and mine for all of them.  That way he doesn't have to edit the
> patches when applying them.

Yeah, that would make things easier for me, always appreciated.

- Arnaldo
 
> Thanks,
> Mathieu
> 
> > 
> >  tools/perf/util/cs-etm.c | 157 +++++++++++++++++++++++++++------------
> >  1 file changed, 111 insertions(+), 46 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
