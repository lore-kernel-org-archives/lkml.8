Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE45C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF92177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLU/EdII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgH0OUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:20:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728029AbgH0OI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598537287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvdhiPhYSGUOeaIN0B943JFU94tDWV4/UOsJxiz1v3Q=;
        b=VLU/EdIIUF3TolhlPrwmiZP747TI/B2Ku9ggaDjMmAhFnO8LdifPtgVdu30bAKi6+7tZsj
        kQmU+kHq8lBRzoCurGQQ3vrjmfTEvsG3iaW3aNgsDEc9K8r5vmnxUpkJtE0dFZsRvkJPnb
        6ciVJMnw5i7lM9y8xfXXDz9RYv/iWxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-LevPGzZBNViChtpIXAFixg-1; Thu, 27 Aug 2020 10:08:05 -0400
X-MC-Unique: LevPGzZBNViChtpIXAFixg-1
Received: by mail-wm1-f69.google.com with SMTP id p23so2186340wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CvdhiPhYSGUOeaIN0B943JFU94tDWV4/UOsJxiz1v3Q=;
        b=Q8A9moGVwK0A2hu9/QWpEmnSEZz7jhtHxsnAXXwmIa4/OXA4kohRo0q8KGeQ40jYoB
         bw9m+R+a5dHBrzDyer262iwhvvr5ShSlkXjKTfgL88vkmBYmh4QwW4Jsrh6hzY53x/Lo
         rKoehAi/pAx1jJFogg5+SoBB2aNS2FGeihiqeXGY859uOYzfWV0RbHYG6rn4ejE+MhS+
         G0OPNowaxwdhbrFpKozxuPozrUH7ZsVtWCO661fsvCtVv938mkbZNfv5zBE/gkst6IaX
         T/EuUCX0yvsp0VZwNjPc+dnvMC2ASTURfLY6ENsTQ7m4isehHDqQewO45qTJ85IQ9XWm
         yh4Q==
X-Gm-Message-State: AOAM532VrXbLPI3lQDS+zmUwExZPYKTxz0bNIUm0tIakm8dhvPSa2d4h
        PE61bSqM75spkcHdI2sF+odlotqxKdyKI3Ow5eyvbjCVfueLz4Jr//IsCps++APt8dC/LoIK1aB
        2o1G9C1RmSpVFq+LCe6gJW73z
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr19971165wrw.8.1598537283952;
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWw4gY+gfT3ioYFr28ZoapW9vPXQZrcRf4b8LhwoAGjeKf6Sd713KoEGCbzoU3U0KCeejqiw==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr19971132wrw.8.1598537283631;
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
Received: from steredhat.lan ([5.171.209.212])
        by smtp.gmail.com with ESMTPSA id t14sm7282780wrg.38.2020.08.27.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:08:03 -0700 (PDT)
Date:   Thu, 27 Aug 2020 16:07:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20200827140758.mboc7z2us2yqp356@steredhat.lan>
References: <20200827134044.82821-1-sgarzare@redhat.com>
 <20200827134044.82821-3-sgarzare@redhat.com>
 <206a32b6-ba20-fc91-1906-e6bf377798ae@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206a32b6-ba20-fc91-1906-e6bf377798ae@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:49:45AM -0600, Jens Axboe wrote:
> On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> > @@ -6414,6 +6425,19 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
> >  	if (unlikely(sqe_flags & ~SQE_VALID_FLAGS))
> >  		return -EINVAL;
> >  
> > +	if (unlikely(ctx->restricted)) {
> > +		if (!test_bit(req->opcode, ctx->restrictions.sqe_op))
> > +			return -EACCES;
> > +
> > +		if ((sqe_flags & ctx->restrictions.sqe_flags_required) !=
> > +		    ctx->restrictions.sqe_flags_required)
> > +			return -EACCES;
> > +
> > +		if (sqe_flags & ~(ctx->restrictions.sqe_flags_allowed |
> > +				  ctx->restrictions.sqe_flags_required))
> > +			return -EACCES;
> > +	}
> > +
> 
> This should be a separate function, ala:
> 
> if (unlikely(ctx->restricted)) {
> 	ret = io_check_restriction(ctx, req);
> 	if (ret)
> 		return ret;
> }
> 
> to move it totally out of the (very) hot path.

I'll fix.

> 
> >  	if ((sqe_flags & IOSQE_BUFFER_SELECT) &&
> >  	    !io_op_defs[req->opcode].buffer_select)
> >  		return -EOPNOTSUPP;
> > @@ -8714,6 +8738,71 @@ static int io_unregister_personality(struct io_ring_ctx *ctx, unsigned id)
> >  	return -EINVAL;
> >  }
> >  
> > +static int io_register_restrictions(struct io_ring_ctx *ctx, void __user *arg,
> > +				    unsigned int nr_args)
> > +{
> > +	struct io_uring_restriction *res;
> > +	size_t size;
> > +	int i, ret;
> > +
> > +	/* We allow only a single restrictions registration */
> > +	if (ctx->restricted)
> > +		return -EBUSY;
> > +
> > +	if (!arg || nr_args > IORING_MAX_RESTRICTIONS)
> > +		return -EINVAL;
> > +
> > +	size = array_size(nr_args, sizeof(*res));
> > +	if (size == SIZE_MAX)
> > +		return -EOVERFLOW;
> > +
> > +	res = memdup_user(arg, size);
> > +	if (IS_ERR(res))
> > +		return PTR_ERR(res);
> > +
> > +	for (i = 0; i < nr_args; i++) {
> > +		switch (res[i].opcode) {
> > +		case IORING_RESTRICTION_REGISTER_OP:
> > +			if (res[i].register_op >= IORING_REGISTER_LAST) {
> > +				ret = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			__set_bit(res[i].register_op,
> > +				  ctx->restrictions.register_op);
> > +			break;
> > +		case IORING_RESTRICTION_SQE_OP:
> > +			if (res[i].sqe_op >= IORING_OP_LAST) {
> > +				ret = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			__set_bit(res[i].sqe_op, ctx->restrictions.sqe_op);
> > +			break;
> > +		case IORING_RESTRICTION_SQE_FLAGS_ALLOWED:
> > +			ctx->restrictions.sqe_flags_allowed = res[i].sqe_flags;
> > +			break;
> > +		case IORING_RESTRICTION_SQE_FLAGS_REQUIRED:
> > +			ctx->restrictions.sqe_flags_required = res[i].sqe_flags;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	ctx->restricted = 1;
> > +
> > +	ret = 0;
> 
> I'd set ret = 0 above the switch, that's the usual idiom - start at
> zero, have someone set it to -ERROR if something fails.

Yes, it is better. I'll fix it.

Thanks,
Stefano

