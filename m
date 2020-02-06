Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3840C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01CD21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7+oO+0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFHnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:43:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35005 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:43:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so2338408pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 23:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IU1zrteb9q+Qt87k2K0GIgQjA5wXyPQA9EPoT65IZsE=;
        b=F7+oO+0rmHQnZXx5qo4M6gUPD90ZCwVtW6dOyJM5XSuOIog9Bu3zsjHkBe0w6DXcCO
         82uqeIqlTLCbllWjGTACIBCr/U9DFnUng1yRc4i+lSB2FRn6uO+ewSeVDETOlwqVif4Z
         2nX8DlroOtLjXfrASsa51BBcKatHOiKx1HOxYECYm24QNGxx/5cm6cP+ntnxiu3klTqR
         U3uzVuBOqHl5b3SJpDzibDEhoURymeOgJ/SDb3taVMEY1Iq1oNMBGFvpeJYgxZK03v/P
         XuDVcA0kx4dxSGqrkIYVG56Tqk6GLSXVP2+Wt98SMKFSkzvhboxolaISLYLH5SjTbext
         WG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IU1zrteb9q+Qt87k2K0GIgQjA5wXyPQA9EPoT65IZsE=;
        b=T1v8UHfPxx7ClzKeuWCvvG5IGINSSPgmRcyDwZeMPKvhaCNYuRKp7psvppog3qAo6Y
         YisWTSkmuxLhbg8jERJIzdjeJ3V81CbFeCw3ZyrrIIs2rsTAuY0aGCnn3racVItfgDO8
         u7c7UpuiF7vRnl2Z97BGyoZrjN4NGgg0KkJ3solG0bBxp9pCTUyDm08iw99zp9OiNTsC
         Hc6M7y0+od6/aFYbyYtJ0Jq5QtLQ4YIFAP5Rus9fOhvOMnq2Ad5oTZUTRRT2Btx7B8AH
         fSHIKWcxPW9Znj65txvOsm8YXLAkS8hP/o706C4yFE+3zdTthpoyB+e6JOpOzFJC7fLN
         yRGg==
X-Gm-Message-State: APjAAAVexXLez/VsXGIp9brYpkw1ch6UnGNFe7ukiaCLIEG54D6VhOpR
        ajP95wpJf4CIglCeFPMlazTIM2e+Onctng==
X-Google-Smtp-Source: APXvYqyggvyitnBhwNK0z3DaPYbBaIbTbJQVIpI0bKqkZe37c5XbYnm7i2P+U4r0TGh5mc/iAuXcYQ==
X-Received: by 2002:a63:d0c:: with SMTP id c12mr2222616pgl.173.1580975022391;
        Wed, 05 Feb 2020 23:43:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id z64sm2090028pfz.23.2020.02.05.23.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 23:43:41 -0800 (PST)
Date:   Thu, 6 Feb 2020 15:43:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v3 1/5] perf cs-etm: Swap packets for instruction samples
Message-ID: <20200206074328.GA3807@leoy-ThinkPad-X240s>
References: <20200203015203.27882-1-leo.yan@linaro.org>
 <20200203015203.27882-2-leo.yan@linaro.org>
 <CAJ9a7VgFL24gWGGJ-Wn2YycsW1DzKgu29_HaHtE=OJ0Fz3oNcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgFL24gWGGJ-Wn2YycsW1DzKgu29_HaHtE=OJ0Fz3oNcA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Feb 05, 2020 at 03:59:40PM +0000, Mike Leach wrote:
> Hi Leo
> 
> On Mon, 3 Feb 2020 at 01:52, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > If use option '--itrace=iNNN' with Arm CoreSight trace data, perf tool
> > fails inject instruction samples; the root cause is the packets are
> > only switched for branch samples and last branches but not for
> > instruction samples, so the new coming packets cannot be properly
> > handled for only synthesizing instruction samples.
> >
> > To fix this issue, this patch switches packets for instruction samples.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 5471045ebf5c..3dd5ba34a2c2 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1404,7 +1404,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >                 }
> >         }
> >
> > -       if (etm->sample_branches || etm->synth_opts.last_branch) {
> > +       if (etm->sample_branches || etm->synth_opts.last_branch ||
> > +           etm->sample_instructions) {
> >                 /*
> >                  * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
> >                  * the next incoming packet.
> > @@ -1476,7 +1477,8 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> >         }
> >
> >  swap_packet:
> > -       if (etm->sample_branches || etm->synth_opts.last_branch) {
> > +       if (etm->sample_branches || etm->synth_opts.last_branch ||
> > +           etm->sample_instructions) {
> >                 /*
> >                  * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
> >                  * the next incoming packet.
> > --
> > 2.17.1
> >
> if is worth putting the 'if <options> { swap packet }' into a separate
> function as it appears twice in identical form? Might help if more
> options for swap packet are needed later.

Makes sense.  Will factor out a new function for this.

Thanks for reviewing!
Leo

> Either way
> 
> Reviewed by: Mike Leach <mike.leach@linaro.org>
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
