Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F5C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6320771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBbjj5pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgGVO3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728837AbgGVO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595428181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpvRfWeKDVYWowGCZPg9akb4cGt+hw0uA1Pjk8EfaPA=;
        b=cBbjj5prCb13Mh/vcMDcU/DTIfLqYIa77QPFSSl1TRrkEUq5cQ3Lr2h3ya+4n8oc6dspCR
        i9hw0hDUMFxpyzFeB/HI3MiXzEcDx1sbSQ8ATX9H/MQctw9KPtLsDLT86o3TFoEwjveVZ5
        WoAZA/kk1DF+V0vj8y1wnyA1AO6L0kA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-S5tyCdSGMfmYjynj13tL3A-1; Wed, 22 Jul 2020 10:29:40 -0400
X-MC-Unique: S5tyCdSGMfmYjynj13tL3A-1
Received: by mail-wm1-f72.google.com with SMTP id b13so1138323wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HpvRfWeKDVYWowGCZPg9akb4cGt+hw0uA1Pjk8EfaPA=;
        b=mnZZOEDM9vX7A3q1/mIRWGyhCD0meOQxuJmhjMsL0XCS+D2p7R2uiGeXwXN0hfI414
         pfvRVTt/BprB9CnF/cjeEeqC3R4ggj78/9ybctiujPHjbiJ5qmbcNV7WGxOYgg8e8YN+
         YXk1SEDhUtIbcBbnR4Fb+4WWGn965cAiygfsRtAFFWo3PIkpvgCH4TVOBt4vNv1+kQfS
         pfcJpncbIM65+NCJCOefiK1hwS3Y/IDyAHkRggL2LAIlGsZRgdv80qKxkeo9LFewGunx
         3lfoQdc51wCYnYQ4J+LDoEVz5RQcrLNz2CVizBu0PS/lkytJ3D6a2gokhc9jP/nsPZtD
         qgyw==
X-Gm-Message-State: AOAM531W/X9Tgeg4CdXWe8IIJfCUM2H7XpLvTn72i37z1XyD5MABtChm
        rQkqgwUyYz+pXg0eQ+J6VP88vqdSphh8pB3KnbBk79EO3AyQnnP2EPGxGCVhZ3IsoztqcymtWG5
        4F8Vi55sjB2duOoHJ8Zf3j9zk
X-Received: by 2002:adf:8024:: with SMTP id 33mr33689230wrk.117.1595428178920;
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG8Z8DO7euidMpeOf2ZLbbpnrBtYwH+3mx/ul+4ozsKYbSDmGaA4HHY0n0WQCn79ezmV8nig==
X-Received: by 2002:adf:8024:: with SMTP id 33mr33689200wrk.117.1595428178650;
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id e5sm146181wrc.37.2020.07.22.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 07:29:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 16:29:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
Message-ID: <20200722142933.rmskkqjputefjace@steredhat>
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-3-sgarzare@redhat.com>
 <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
 <20200721104009.lg626hmls5y6ihdr@steredhat>
 <15f7fcf5-c5bb-7752-fa9a-376c4c7fc147@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f7fcf5-c5bb-7752-fa9a-376c4c7fc147@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:11:17AM -0600, Jens Axboe wrote:
> On 7/21/20 4:40 AM, Stefano Garzarella wrote:
> > On Thu, Jul 16, 2020 at 03:26:51PM -0600, Jens Axboe wrote:
> >> On 7/16/20 6:48 AM, Stefano Garzarella wrote:
> >>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >>> index efc50bd0af34..0774d5382c65 100644
> >>> --- a/include/uapi/linux/io_uring.h
> >>> +++ b/include/uapi/linux/io_uring.h
> >>> @@ -265,6 +265,7 @@ enum {
> >>>  	IORING_REGISTER_PROBE,
> >>>  	IORING_REGISTER_PERSONALITY,
> >>>  	IORING_UNREGISTER_PERSONALITY,
> >>> +	IORING_REGISTER_RESTRICTIONS,
> >>>  
> >>>  	/* this goes last */
> >>>  	IORING_REGISTER_LAST
> >>> @@ -293,4 +294,30 @@ struct io_uring_probe {
> >>>  	struct io_uring_probe_op ops[0];
> >>>  };
> >>>  
> >>> +struct io_uring_restriction {
> >>> +	__u16 opcode;
> >>> +	union {
> >>> +		__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
> >>> +		__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
> >>> +	};
> >>> +	__u8 resv;
> >>> +	__u32 resv2[3];
> >>> +};
> >>> +
> >>> +/*
> >>> + * io_uring_restriction->opcode values
> >>> + */
> >>> +enum {
> >>> +	/* Allow an io_uring_register(2) opcode */
> >>> +	IORING_RESTRICTION_REGISTER_OP,
> >>> +
> >>> +	/* Allow an sqe opcode */
> >>> +	IORING_RESTRICTION_SQE_OP,
> >>> +
> >>> +	/* Only allow fixed files */
> >>> +	IORING_RESTRICTION_FIXED_FILES_ONLY,
> >>> +
> >>> +	IORING_RESTRICTION_LAST
> >>> +};
> >>> +
> >>
> >> Not sure I totally love this API. Maybe it'd be cleaner to have separate
> >> ops for this, instead of muxing it like this. One for registering op
> >> code restrictions, and one for disallowing other parts (like fixed
> >> files, etc).
> >>
> >> I think that would look a lot cleaner than the above.
> >>
> > 
> > Talking with Stefan, an alternative, maybe more near to your suggestion,
> > would be to remove the 'struct io_uring_restriction' and add the
> > following register ops:
> > 
> >     /* Allow an sqe opcode */
> >     IORING_REGISTER_RESTRICTION_SQE_OP
> > 
> >     /* Allow an io_uring_register(2) opcode */
> >     IORING_REGISTER_RESTRICTION_REG_OP
> > 
> >     /* Register IORING_RESTRICTION_*  */
> >     IORING_REGISTER_RESTRICTION_OP
> > 
> > 
> >     enum {
> >         /* Only allow fixed files */
> >         IORING_RESTRICTION_FIXED_FILES_ONLY,
> > 
> >         IORING_RESTRICTION_LAST
> >     })
> > 
> > 
> > We can also enable restriction only when the rings started, to avoid to
> > register IORING_REGISTER_ENABLE_RINGS opcode. Once rings are started,
> > the restrictions cannot be changed or disabled.
> 
> My concerns are largely:
> 
> 1) An API that's straight forward to use
> 2) Something that'll work with future changes
> 
> The "allow these opcodes" is straightforward, and ditto for the register
> opcodes. The fixed file I guess is the odd one out. So if we need to
> disallow things in the future, we'll need to add a new restriction
> sub-op. Should this perhaps be "these flags must be set", and that could
> easily be augmented with "these flags must not be set"?

Okay, now I get it, and I think that's a good point. I'm going to change that
to restrict SQE flags.

About the registration of restrictions, what do you think is the best solution
among them?
1. a single register op (e.g. IORING_REGISTER_RESTRICTIONS) which has an array
   of restrictions as a parameter.
2. a register op for each restriction (sqe ops, register ops, sqe flags, etc.),
   that requires multiple io_uring_register() calls to register all the
   restrictions.

I'd go for the first one (basically as it's implemented in this RFC) because
it seems more extensible and manageable to me, but I'd like to have your
opinion.

Thanks for your suggestions,
Stefano

