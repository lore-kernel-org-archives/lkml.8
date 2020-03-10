Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0078BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DD72146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foQBrWTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgCJRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:30:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45335 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:30:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so7718645qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFJLzhWaardAj209J2djxfvD0M0AS7lKdB6B6SWHZls=;
        b=foQBrWThN+yCBGBNZSwfyEbyDlaCMm5DA8KSAZ9GqbXE0/DfzA4E8icMH5iYvJvsHa
         NDNsJioQ71Ts6+n4LL+sFvaZs5120wRO7CKBIljnRuRjxwLJZl3WNCI23ibbNzYVyMMF
         BUg149LJkpWq8Sy0az8HA9DO8ubTly8Ivxqb5UVWSVw9EzFBPi5y5sijIK+l7tA7VT35
         rLK3faWz2udvP0dIvOGhATNJjO/EuyeGoMEWApQ4RWiEclldpJwPpK/VVPFLzrwm8jcv
         tvLL/TAy2UkRTBaywvz3BlK21NAw9HMp3hHnnV8bZkk0c5I0d6BzE6Z6c3Ae6UG2T+fs
         U0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFJLzhWaardAj209J2djxfvD0M0AS7lKdB6B6SWHZls=;
        b=H4TT8T2A6rN3ZsFpuqZqlyGVUbMc083eclWcfM/Qztjf+lU+t9NbfQN2OJtFQIDkqA
         CBBRXa9LBQocoHSDrtaKGbJYOOC1SAhtxw9R1ZRqoUyaqm2YQZqDCl6i9/qy7SPe/4VF
         lX4vus05meM30U8pPHnQXUJ7uoTSxdj98yrTqpvEwhmo4B8fKfQDtb14pZ6+2jZOXoVU
         WE1Kwui+kIvmsp7L83bI/4jOHHAAHnBzhZ6CuZW356WpgjoLJeT2RHMhoGOK1/bxtDA9
         LnQkneeLdnkZhmCN15esd2Lr1M52gbdB1JScM89MLLbdf6lkRvs1h0iYbT/l6Po58hy8
         yVOA==
X-Gm-Message-State: ANhLgQ0lfRzBWVeHRsBnBVbjvh5/cBVQDY8Wb/1ezdfWZqG34XitAl9k
        qKZgW8kz9k2usI7kiFRU68Y=
X-Google-Smtp-Source: ADFU+vtsLhWD473LGlo6ncSc0lO+QdgbO80OJA8Bb7BImWRXU/K0WZl+HyIo3SNPsPXP11AWxbD+SA==
X-Received: by 2002:a37:a6d4:: with SMTP id p203mr15055850qke.184.1583861415306;
        Tue, 10 Mar 2020 10:30:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id v82sm24442483qka.51.2020.03.10.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:30:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0006440009; Tue, 10 Mar 2020 14:30:09 -0300 (-03)
Date:   Tue, 10 Mar 2020 14:30:09 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V2 1/9] perf pmu: Add support for PMU capabilities
Message-ID: <20200310173009.GJ15931@kernel.org>
References: <20200309174639.4594-1-kan.liang@linux.intel.com>
 <20200309174639.4594-2-kan.liang@linux.intel.com>
 <20200310130644.GC15931@kernel.org>
 <00ebb51d-0282-8181-7285-c60aec27566c@linux.intel.com>
 <20200310140421.GD15931@kernel.org>
 <fa4e32f0-1572-a9aa-e609-3cecaae7ef9e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4e32f0-1572-a9aa-e609-3cecaae7ef9e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 12:54:05PM -0400, Liang, Kan escreveu:
> 
> 
> On 3/10/2020 10:04 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 10, 2020 at 09:53:24AM -0400, Liang, Kan escreveu:
> > > On 3/10/2020 9:06 AM, Arnaldo Carvalho de Melo wrote:
> > > > Em Mon, Mar 09, 2020 at 10:46:31AM -0700, kan.liang@linux.intel.com escreveu:
> > > > > +static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
> > > > > +{
> > > > > +	struct perf_pmu_caps *caps;
> > > > > +
> > > > > +	caps = zalloc(sizeof(*caps));
> > > > > +	if (!caps)
> > > > > +		return -ENOMEM;
> > 
> > > > So here you check if zalloc fails and returns a proper error
> > 
> > > > > +	caps->name = strdup(name);
> > > > > +	caps->value = strndup(value, strlen(value) - 1);
> > 
> > > > But then you don't check strdup()?
> > > Right, I should check strdup(), otherwise the capability information may be
> > > incomplete. I will fix it in V3.
> > 
> > Thanks, overall just consider making the patches smaller if possible,
> > with prep patches paving the way for more complex changes so that
> > reviewing becomes easier, for instance:
> > 
> >    perf machine: Refine the function for LBR call stack reconstruction
> > 
> > Seems to do too many things at once. It was unfortunate, for instance,
> > that the pre-existing code had that
> > 
> > resolve_lbr_callchain_sample()
> > {
> > 	/* LBR only affects the user callchain */
> > 	if (i != chain_nr) {
> > 		body of the function, long
> > 		....
> > 		return err;
> > 	}
> > 
> > 	return 0;
> > }
> > 
> > One of the things you did in this patch was to the more sensible:
> > 
> > 	/* LBR only affects the user callchain */
> > 	if (i == chain_nr)
> > 		return 0;
> > 
> > 	body of the function
> > 	...
> > 	return err;
> > 
> > So if you had a prep patch at this point just removing that silly
> > indent, then we would see that that is just removing the indent, the
> > next patch wouldn't have that check for user callchains, would be
> > smaller, I think that would help reduce the patch sizes.

> > Then if you just moved to a separate function the (callchain_param.order
> > == ORDER_CALLEE) part, the patch would again be smaller, etc.
 
> > This helps reviewing and usually helps us later, with bisection, when
> > some bug is introduced,
 
> Sure, I will go through all patches and see what I can do to reduce the size
> of patches in V3.

Thanks a lot for considering my suggestions!

- Arnaldo
