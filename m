Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B924C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E38820829
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR5Zgoyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGQIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgGQIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594976126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XI4nEZZeTErLSUZryeEot9E65dRQ6gK4ETg2301d/w=;
        b=dR5ZgoyiZRXZUi4pbOTahUxLz7MhftE3BTSE8msRMUxGu9n/eCk/iC+9IFS7TZGsn0zuUX
        McYlU4GL0bS5oGxqpX1WXQ4Lm+OytnkHvZGNi2f+C5AL6esnE8RlYbOy+DIjt70TPmEQKX
        biqhID1uWH6W17z43i50HNUt0GpYMZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-vRJ-e7ixOuWSXH4EeN3mbA-1; Fri, 17 Jul 2020 04:55:23 -0400
X-MC-Unique: vRJ-e7ixOuWSXH4EeN3mbA-1
Received: by mail-wr1-f69.google.com with SMTP id b8so8320818wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XI4nEZZeTErLSUZryeEot9E65dRQ6gK4ETg2301d/w=;
        b=gHTtW3dhyMJ+EZGWF0s9SoVGt0iCTWyYBLbeqagbbrVNC4bfqe8XiDSZi+4EypBAx+
         kTshONBjgwJIHObsh4ehJEclqNefTNdE98YXlyUbJO2qAoHe25i97RJJNQWU92KSPh24
         WVMAne4zQODfwsFYrpml5pfp3zZtjj+Nya9FyZbWQ/YZe5pszUAH6EKGDrF0AyU+PyLw
         2naHM8ZkAgZeHR71/2u6mEGWkRbBdcreAhJVSGsx8Z/12S74Kk0JEL5yx+9AXtLxN6AO
         sYT/VJijBPGqTMqlrrbPY5g/PnCWwtUZk928gfuMxwarVGBzewmZrYMM6xISNevU1/RZ
         +mhg==
X-Gm-Message-State: AOAM5313ZKkR4yD94GUa+vqVXYOBEDh2rE08k0MuRdb+t9Q5heYCnEYh
        t/uCkSFFCQssqRyXJQAq6YiydG0X8y3GhSkxMCgMuv50kmI6fA+pOskZ9zr6A/KHidE7Ld4qab+
        G3WIG54XK5Di7xZlybMZQ4K68
X-Received: by 2002:a7b:c775:: with SMTP id x21mr8378221wmk.34.1594976121808;
        Fri, 17 Jul 2020 01:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlQPFtvZT51Z58AIE5vT4594yCNMsfr9Ds3LKq+kNbUdm3mAvMl22NKFAoesPZEMojsUSFeg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr8378199wmk.34.1594976121566;
        Fri, 17 Jul 2020 01:55:21 -0700 (PDT)
Received: from steredhat.lan ([5.171.231.144])
        by smtp.gmail.com with ESMTPSA id c25sm12079968wml.18.2020.07.17.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:55:20 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:55:17 +0200
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
Message-ID: <20200717085517.56jis3aw53wssf5a@steredhat.lan>
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-3-sgarzare@redhat.com>
 <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:26:51PM -0600, Jens Axboe wrote:
> On 7/16/20 6:48 AM, Stefano Garzarella wrote:
> > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> > index efc50bd0af34..0774d5382c65 100644
> > --- a/include/uapi/linux/io_uring.h
> > +++ b/include/uapi/linux/io_uring.h
> > @@ -265,6 +265,7 @@ enum {
> >  	IORING_REGISTER_PROBE,
> >  	IORING_REGISTER_PERSONALITY,
> >  	IORING_UNREGISTER_PERSONALITY,
> > +	IORING_REGISTER_RESTRICTIONS,
> >  
> >  	/* this goes last */
> >  	IORING_REGISTER_LAST
> > @@ -293,4 +294,30 @@ struct io_uring_probe {
> >  	struct io_uring_probe_op ops[0];
> >  };
> >  
> > +struct io_uring_restriction {
> > +	__u16 opcode;
> > +	union {
> > +		__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
> > +		__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
> > +	};
> > +	__u8 resv;
> > +	__u32 resv2[3];
> > +};
> > +
> > +/*
> > + * io_uring_restriction->opcode values
> > + */
> > +enum {
> > +	/* Allow an io_uring_register(2) opcode */
> > +	IORING_RESTRICTION_REGISTER_OP,
> > +
> > +	/* Allow an sqe opcode */
> > +	IORING_RESTRICTION_SQE_OP,
> > +
> > +	/* Only allow fixed files */
> > +	IORING_RESTRICTION_FIXED_FILES_ONLY,
> > +
> > +	IORING_RESTRICTION_LAST
> > +};
> > +
> 
> Not sure I totally love this API. Maybe it'd be cleaner to have separate
> ops for this, instead of muxing it like this. One for registering op
> code restrictions, and one for disallowing other parts (like fixed
> files, etc).
> 
> I think that would look a lot cleaner than the above.
> 

I'm not sure I got your point.

Do you mean two different register ops?
For example, maybe with better names... ;-):

	IORING_REGISTER_RESTRICTIONS_OPS
	IORING_REGISTER_RESTRICTIONS_OTHERS


Or a single register op like now, and a new restriction opcode adding
also a new field in the struct io_uring_restriction?
For example:

	struct io_uring_restriction {
		__u16 opcode;
		union {
			__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
			__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
			__u8 restriction; /* IORING_RESTRICTION_OP */
		};
		__u8 resv;
		__u32 resv2[3];
	};

	/*
	 * io_uring_restriction->opcode values
	 */
	enum {
		/* Allow an io_uring_register(2) opcode */
		IORING_RESTRICTION_REGISTER_OP,

		/* Allow an sqe opcode */
		IORING_RESTRICTION_SQE_OP,

		IORING_RESTRICTION_OP,

		IORING_RESTRICTION_LAST
	};

	enum {
		/* Only allow fixed files */
		IORING_RESTRICTION_OP_FIXED_FILES_ONLY,
	};


Thanks,
Stefano

