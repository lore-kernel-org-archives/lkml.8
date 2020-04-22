Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EB02077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6QKWocK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgDVOEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVOEU (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:04:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4DC03C1A9
        for <Linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:04:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so1709597qth.2
        for <Linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bh27RuUyRhV8AIGHQuorNq+FDY+JRw2ft+WsGo9S2PI=;
        b=R6QKWocKtb9dFpncU+LKcsCKqKjCId0CGi6owM5r0hmSdrJDN6Lr6NnuWqNDlmrUZN
         vPT5wbx5z2oiEKyusKBMwC6yDOqVwBMJslApEBASlN2vc5MWb/AVv8vumtlTYwGZXQcj
         MbRSOg+A79ml+eu016Fg5qHYd7eM1/Tw+q4BUjLK+PmnAfL4UoupSz8QaZhPdiudFgzO
         sfRd4gWbVa4HNa0rZyjktMdU0in1GTBHmsat2t9mw8pS9n+SKK3tQ23qqZRX4StklBjU
         mN+afKlBwDCwT25qzemYYpa+T9QnG+btHdp+OyvTgR9VAxU/frhBdyZSdTFNE/piqGli
         nD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bh27RuUyRhV8AIGHQuorNq+FDY+JRw2ft+WsGo9S2PI=;
        b=pflf41O99oWBWydc3eY0mrwq786vrimcL5ep6BeXbTQyEiVnUL1fJLGgFmgcXjlo8r
         fTS3CmNLqVDP7Qj4+crA5lEtnRqXCDeLjfeM8RJwU4eTl1WAVIhzHcTpNW1oE0HndvlG
         2OrZakCWBBLeD6MQL6vI/+2vMkjTJSsEtcJDgZ9QYtkx/JzvQm/mcFvkwQByNOZddek1
         ExoCbr93v0JxglxUlgsUqsWRC6kul1gqUanPiZettKATvix6k/k1to24p6xkYDLVvqvq
         2D3C2g2ADpObyXqFUSBZsEURFdRfBMKKpBhy+HcraQlwsk6+z/+EHw4Y9PkwuSr7glYr
         DGTA==
X-Gm-Message-State: AGi0PuZESbkYuig0iZpWMuxmLZJr25dtmqHyTjZmQjDltTUEoqoEcJUU
        nVStaJAweDXt4vDOfpq/NrMObltRiHY=
X-Google-Smtp-Source: APiQypIT1dDrRzlZvOhQF5kZDTHoOkqENabH+LIvTQXsWoYNLOgiPqAATjNN9+1AzepKSkhbJNjecw==
X-Received: by 2002:ac8:c8e:: with SMTP id n14mr27551123qti.340.1587564258100;
        Wed, 22 Apr 2020 07:04:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g25sm3864099qkl.50.2020.04.22.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:04:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59B05409A3; Wed, 22 Apr 2020 11:04:15 -0300 (-03)
Date:   Wed, 22 Apr 2020 11:04:15 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Zero ena and run for interval mode
Message-ID: <20200422140415.GE20647@kernel.org>
References: <20200409070755.17261-1-yao.jin@linux.intel.com>
 <20200409154332.GD3309111@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409154332.GD3309111@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 09, 2020 at 05:43:32PM +0200, Jiri Olsa escreveu:
> On Thu, Apr 09, 2020 at 03:07:55PM +0800, Jin Yao wrote:
> > As the code comments in perf_stat_process_counter() say,
> > we calculate counter's data every interval, and the display
> > code shows ps->res_stats avg value. We need to zero the stats
> > for interval mode.
> > 
> > But the current code only zeros the res_stats[0], it doesn't
> > zero the res_stats[1] and res_stats[2], which are for ena
> > and run of counter.
> > 
> > This patch zeros the whole res_stats[] for interval mode.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> nice catch ;-)
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied, together with the:

51fd2df1e882 ("perf stat: Fix interval output values")

you provided under private cover.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/stat.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 5f26137b8d60..242476eb808c 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -368,8 +368,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >  	 * interval mode, otherwise overall avg running
> >  	 * averages will be shown for each interval.
> >  	 */
> > -	if (config->interval)
> > -		init_stats(ps->res_stats);
> > +	if (config->interval) {
> > +		for (i = 0; i < 3; i++)
> > +			init_stats(&ps->res_stats[i]);
> > +	}
> >  
> >  	if (counter->per_pkg)
> >  		zero_per_pkg(counter);
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
