Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615B20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Fdu19Bux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgEUXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730716AbgEUXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:16:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:16:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so6925692qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUoZcotUHvHkDynbBdg2kum8KhHAvdqpz3vVIU74srU=;
        b=Fdu19Bux/T9zm5qDECsrqrKsavHJgzr0BrjJeEkoqgM9U/vqgFdBSQXH4noPwGen8f
         Q+Gw98IBbkNh619BiVZpXHsN0/WHEPtpiRUPYGdWCFrYWRYz1HHOQwFaztsVqsb5rnaJ
         wj227OUGoChm2DCYa8nBV+whh4EJaMHlCZ7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUoZcotUHvHkDynbBdg2kum8KhHAvdqpz3vVIU74srU=;
        b=XHytW3kCs4aCknjCF1R0zGJUTPIlLJ4Ceh6VPfBTaUbshAfGdaLba3JPYtS6VgUicg
         eD1DSWen/Pq4yc+eFd6dRp7MGChML/1voaXoCfojYDKKuTtQlar2Ei1xr6XJRxRKiUoi
         8YYBF7FR2fcCEtmxS9JqXQELF9LSqFvx7JpbnBV18lAld/1KxttBay1GR3lOzIzACkeF
         KNHTRm2SfQ78r2KacJocAidYph09hNvc2ES/Bw2SeRbTU78nlcKh3qYucEGXjNc3KJYJ
         y8Hugy9P+DBsSSf7y8/rldyrLtDbahtkdTF6ARjmEt5PL6+GCleDFso1ab2ZOzbiyQXU
         3CgA==
X-Gm-Message-State: AOAM531+GrJ+MYbJY3t2ge5/DjWDV6r+SpRRQ1gWpaUxLucXUbrksBo6
        SE/xL22PXt9Yq1f95EQo8kB5nA==
X-Google-Smtp-Source: ABdhPJzUSnir1qv6SQFJsgNt1l7Z5aj4xbIs+83yHT7ZC+9w1PCdkvgd/8GD23L46b9y4ABJK2rEWg==
X-Received: by 2002:ac8:3032:: with SMTP id f47mr13381740qte.386.1590102992154;
        Thu, 21 May 2020 16:16:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 88sm6436462qth.9.2020.05.21.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 16:16:31 -0700 (PDT)
Date:   Thu, 21 May 2020 19:16:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200521231631.GB246288@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200521231426.GA246288@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521231426.GA246288@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 07:14:26PM -0400, Joel Fernandes wrote:
> On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
[snip]
> > +	/*
> > +	 * If class_pick is idle or matches cookie, return early.
> > +	 */
> > +	if (cookie_equals(class_pick, cookie))
> > +		return class_pick;
> > +
> > +	cookie_pick = sched_core_find(rq, cookie);
> > +
> > +	/*
> > +	 * If class > max && class > cookie, it is the highest priority task on
> > +	 * the core (so far) and it must be selected, otherwise we must go with
> > +	 * the cookie pick in order to satisfy the constraint.
> > +	 */
> > +	if (prio_less(cookie_pick, class_pick) &&
> > +	    (!max || prio_less(max, class_pick)))
> > +		return class_pick;
> > +
> > +	return cookie_pick;
> > +}
> 
> I've been hating on this pick_task() routine for a while now :-). If we add
> the task to the tag tree as Peter suggested at OSPM for that other issue
> Vineeth found, it seems it could be simpler.

Sorry, I meant adding of a 0-tagged (no cookie) task to the tag tree.

thanks,

 - Joel

