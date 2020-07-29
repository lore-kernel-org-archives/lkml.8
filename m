Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834BDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EA62075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WnCObVLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2T3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG2T3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:29:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:29:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so2619297pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aZ7p8EHZoo9qycQIMdaotqoaYgynEROIC8oqOG/GaZw=;
        b=WnCObVLfySyy64FqXSDnFEPTLWePeLYaV3rMTrGP8oNEtPK8uVOFrqq+JZZr6vFcCj
         J0QfWpvXvSxxSqnBFTV2kwnIWZMMP/KOs67z18Rg0Cl4VOC2599SlvC4ge1v6lSfRyM8
         JfEK0x4VAMrf3fdLv8kO7hey4mAP0OrjR/h4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZ7p8EHZoo9qycQIMdaotqoaYgynEROIC8oqOG/GaZw=;
        b=gq78noNlivQqeBA54z3FRGIEtLpeT17Qft4LE2lBCVvDwWalXOOx6WbMkOl5/30QXn
         lkVxtflnIRge6Dq2ziUqvT0RYi6yAbRGUnFXmU/e7Y0HtEIDIE0YreSVwAL0ExgUHjmy
         +AMF9GTUKF1fhyPB8XmEAqzEZI8dW3vqWJk0SdOSFGvy6qZmDFpJ9XI93uFPJl/L8pip
         GdPISFLDSzzDLXhxlTgBNxdOR5aJXrw+ABK/1RUfrmOLVqPCYvgPptgdD8v/ZNJ7oUsO
         Co7/uMbOktrca+GCe2BgSW3MZKcx3+Tc8tMBOrGveU8lRoOLBpEbmEHNSrSFckoaNKlw
         FhXw==
X-Gm-Message-State: AOAM531ANvJrmJI60jI4BoS3NlEscTpf7DbxwJXBTNjr61GsQhi8ev3X
        wozCXKps2NG591dQQZC4Jqx/aA==
X-Google-Smtp-Source: ABdhPJzMm2ohUDy3567nRC6m9AWAnaFLKW9xzNh1RJB/hsAX7IuSLOHL/1u0Hu1YWe6v9RMCQABQEA==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr21221pjn.87.1596050956268;
        Wed, 29 Jul 2020 12:29:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm3178918pfn.77.2020.07.29.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:29:15 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:29:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     peterz@infradead.org
Cc:     David Howells <dhowells@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain
 the old value
Message-ID: <202007291228.5DFF9315@keescook>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
 <20200729111120.GA2638@hirez.programming.kicks-ass.net>
 <20200729113731.GA2678@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729113731.GA2678@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:37:31PM +0200, peterz@infradead.org wrote:
> On Wed, Jul 29, 2020 at 01:11:20PM +0200, peterz@infradead.org wrote:
> 
> > Subject: locking/refcount: Provide __refcount API to obtain the old value
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed Jul 29 13:00:57 CEST 2020
> > 
> > David requested means to obtain the old/previous value from the
> > refcount API for tracing purposes.
> > 
> > Duplicate (most of) the API as __refcount*() with an additional
> > 'int *' argument into which, if !NULL, the old value will be stored.
> > 
> > Requested-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/refcount.h |   65 +++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 57 insertions(+), 8 deletions(-)
> > 
> > --- a/include/linux/refcount.h
> > +++ b/include/linux/refcount.h
> > @@ -165,7 +165,7 @@ static inline unsigned int refcount_read
> >   *
> >   * Return: false if the passed refcount is 0, true otherwise
> >   */
> > -static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> > +static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
> >  {
> >  	int old = refcount_read(r);
> >  
> > @@ -174,12 +174,20 @@ static inline __must_check bool refcount
> >  			break;
> >  	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
> >  
> > +	if (oldp)
> > +		*oldp = old;
> > +
> >  	if (unlikely(old < 0 || old + i < 0))
> >  		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
> >  
> >  	return old;
> >  }
> >  
> > +static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> > +{
> > +	return __refcount_add_not_zero(i, r, NULL);
> > +}
> 
> so, I could also emulate C++'s
> 
> bool refcount_add_not_zero(int i, refcount_t *r, int *oldp = NULL)
> 
> style by going to town on this with a bunch of CPP magic, but I don't
> think that'll actually make things clearer.

Erg. No, I like the __-version better -- it looks more like other kernel
APIs.

-- 
Kees Cook
