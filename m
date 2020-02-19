Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D82FC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671A82176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g0PgV16g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSI7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:59:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39237 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:59:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so12173750pfy.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PegpeGKngB9YUd8cnkfdqnMSaOQRzxGEny6Bhf6FmTI=;
        b=g0PgV16g1w2fq3UEjYLRBNIDmuTcArwJZEwe7WQpYhmo6vp2//2J7D7X0Rl0lKuPcp
         FBQe3HFw0wFGUVnmN6R7N9vO96IKW/Er/HWCglNp7hrJtysD2Izkytd+3Eaos4Aoxh4j
         PkuSCytqwBc17EhfGuchB2yjfuMBG6MSB0p6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PegpeGKngB9YUd8cnkfdqnMSaOQRzxGEny6Bhf6FmTI=;
        b=jXmRtMShHGft+UIooiST4MMrTdFxz2F+ITkeq+U1/PIkIn7rOAqEXySzDtBJmi7Q8r
         REEZQ/JjZya8477TMrio/8O/p02onvGp6MyQGzcMf+wTFsxK1SgS7Acqe1spsA4RKFok
         x6XyK2nz1Lrgr5+qZ+fYnKy9Y/IgJEi/v1uXzjBY5Ji/xQs699zxF6PxTck+n0ySgO4W
         bgan+aYaR/v7uxnAomevtZyHpkpc0mIH8iN3lXQ2n0IqWnsdxEk3O5ipYZQ9t3kk1Qkz
         1ab2PWOMmmVYOeRyRgqp0mlUSjrvNu/tgFzunQkk9FoomV0Xpkq8r0g6Jrp3wcTx3WeN
         57YQ==
X-Gm-Message-State: APjAAAWLLcwrpaJkmITUR0sx94GomtfIj++SPCcmmeyEYkGKN0Gh3NjB
        Rfmlix0e18ML1bgl46i3Ek2+ig==
X-Google-Smtp-Source: APXvYqwsBzAL8dzct2ZYHWyMBOSWYp/DXf/ksCxOYylOpQ193V8lZ4t9uFAeStMzQkRnvLDE9bw1xQ==
X-Received: by 2002:a63:9c12:: with SMTP id f18mr25412820pge.397.1582102788264;
        Wed, 19 Feb 2020 00:59:48 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b15sm1913686pft.58.2020.02.19.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:59:47 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:59:45 +0900
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
Subject: Re: [RFC][PATCHv2 05/12] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200219085945.GE122464@google.com>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-6-senozhatsky@chromium.org>
 <7f3310f9-8a12-1299-726d-2ca04207b32c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f3310f9-8a12-1299-726d-2ca04207b32c@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/19 09:25), Hans Verkuil wrote:
[..]
> > diff --git a/Documentation/media/uapi/v4l/vidioc-create-bufs.rst b/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > index bd08e4f77ae4..68185e94b686 100644
> > --- a/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > +++ b/Documentation/media/uapi/v4l/vidioc-create-bufs.rst
> > @@ -121,7 +121,14 @@ than the number requested.
> >  	other changes, then set ``count`` to 0, ``memory`` to
> >  	``V4L2_MEMORY_MMAP`` and ``format.type`` to the buffer type.
> >      * - __u32
> > -      - ``reserved``\ [7]
> > +      - ``flags``
> > +      - Specifies additional buffer management attributes. Valid only when
> > +	queue reports :ref:`V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS` capability.
> > +	Old drivers and applications must set it to zero.
> 
> Drop the 'Valid only' sentence. The V4L2_FLAG_MEMORY_NON_CONSISTENT depends
> on that capability, but other flags added in the future may not.

The whole sentence, right?

> Inside add a reference to the memory flags section created in patch 3.

Sorry. Inside?

[..]
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 72efc1c544cd..169a8cf345ed 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -938,7 +938,10 @@ struct v4l2_requestbuffers {
> >  	__u32			type;		/* enum v4l2_buf_type */
> >  	__u32			memory;		/* enum v4l2_memory */
> >  	__u32			capabilities;
> > -	__u32			reserved[1];
> > +	union {
> > +		__u32		flags;
> > +		__u32		reserved[1];
> > +	};
> 
> How about this:
> 
> 	__u8			flags;
> 	__u8			reserved[3];
> 
> That avoids the anonymous union and allows some space for future additions.

Hmm. This way old apps, which clear out ->reserved, e.g.
memset(&x.reserved, 0x00, sizeof(x.reserved)), won't clear
out x.flags and can accidentally submit some unintended
garbage. It's not the case with anon union.

	-ss
