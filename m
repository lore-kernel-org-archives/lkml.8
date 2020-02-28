Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C50C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922124697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EOajRbNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgB1BiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:38:24 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33585 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgB1BiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:38:24 -0500
Received: by mail-pf1-f173.google.com with SMTP id n7so831878pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pHnMRxICH0I+GNHaEVFkFwGJH/h6/yM2II2ROvzzI8=;
        b=EOajRbNVoiH98mpn/puq3GP602oTXM/n+qI7v2aZMg33dJwatjgg8M2FozZbzZO03I
         qCzFIkRPCj8vq5P8iQhkInyz+wKfmxq9uj2mQUlK16c7qnibDTygMmttqR9kMsmpvixd
         l1xRz9Dbxrf0jnrxDu1EAlU72ogvkxNQio8Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pHnMRxICH0I+GNHaEVFkFwGJH/h6/yM2II2ROvzzI8=;
        b=Fma4JEma66pHZgp+wsClnqPo2vGUnZO2RNpPpBjenXw5pZ9hgvwYbvkoJdTao9FIZC
         ZL1Ss3WQYNIXfDrDEAykTJTG6oiry838seZff5pYntAk5uicZAzboJZCWsm9RfO1G8RH
         q90b8m+8V9nvdvFg1UAI0zUpoqNxXuSKdWfgG9CMgCpj+GFmOnUaKvc8dY7GIrBBqLHp
         IntHBnk7dmeLJVAmjPj4qm4551wCwEhdjjJbOJE4dP/qTD3gRbrSsioZeezfef9OYPCM
         LFkA+Ut3epb1CVTJkys48t7R6ahiWhyiNgmvYWlWw8bWwvRujxUM92bd1dWQ7RUNlGT2
         h37A==
X-Gm-Message-State: APjAAAV4cn/4h48vbIWQcL9oILt1AhQTAnVa9+aUQzP0/cTnypsU2WNu
        XkF2jYDynctNtsoNsAx2kAOS8A==
X-Google-Smtp-Source: APXvYqySYvDTN8wZnZhWGxlt+WqKA9GVb7XwPKqRcwE4YXZQfqvQMGgIpAqljVgaOogA16TcZlUzQA==
X-Received: by 2002:aa7:96c7:: with SMTP id h7mr1822919pfq.211.1582853902968;
        Thu, 27 Feb 2020 17:38:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id p17sm8462775pfn.31.2020.02.27.17.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 17:38:22 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:38:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 05/11] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200228013820.GM122464@google.com>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-6-senozhatsky@chromium.org>
 <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 13:36), Hans Verkuil wrote:
> > diff --git a/Documentation/media/uapi/v4l/vidioc-create-bufs.rst b/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > index bd08e4f77ae4..6a8a4d5de2f1 100644
> > --- a/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > +++ b/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > @@ -121,7 +121,13 @@ than the number requested.
> >  	other changes, then set ``count`` to 0, ``memory`` to
> >  	``V4L2_MEMORY_MMAP`` and ``format.type`` to the buffer type.
> >      * - __u32
> > -      - ``reserved``\ [7]
> > +      - ``flags``
> > +      - Specifies additional buffer management attributes.
> > +	See :ref:`memory-flags`. Old drivers and applications must set it to
> > +	zero.
> 
> Drop the last sentence, it's not relevant.

OK.

> > +
> > +    * - __u32
> > +      - ``reserved``\ [6]
> >        - A place holder for future extensions. Drivers and applications
> >  	must set the array to zero.
> 
> Old drivers and applications still think reserved is [7] and will zero this.

OK.

Hmm... If those apps use hard-coded size then we might have a problem.
If they use sizeof(reserved) then everything is OK. Shall we also have
a union here?

> > diff --git a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
> > index 917df6fb6486..e52cc4401fba 100644
> > --- a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
> > +++ b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
> > @@ -112,10 +112,19 @@ aborting or finishing any DMA in progress, an implicit
> >  	``V4L2_MEMORY_MMAP`` and ``type`` set to the buffer type. This will
> >  	free any previously allocated buffers, so this is typically something
> >  	that will be done at the start of the application.
> > -    * - __u32
> > +    * - union
> > +      - (anonymous)
> 
> Anonymous unions are formatted a bit differently (I made a very recent patch
> that unified the union formatting in the v4l docs). See e.g.
> Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst.

OK, will take a look.

	-ss
