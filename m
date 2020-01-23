Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A078C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1807824125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cTymw1Ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWDlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 22:41:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41101 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgAWDlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 22:41:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so641534pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4IYYoWtx8mo3fAqViP2Q1A79n+DLL8YZqTFMPU46Xw=;
        b=cTymw1UtMWNuzFGH08wDbbDkE8Y6PAWC9RjhMcYoEOfBsUTsCDMhTaBALA5w4n8bFv
         uJXcIq9bPJuLu/LqcWA5HrSL7XPUH+IdilXP2Jr/eV+S865gvVLMtH/n4DK5qvY7NSnj
         sI8BXWJRGN1idQXI5Qz43Q8NyI4wFxpOitZ3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4IYYoWtx8mo3fAqViP2Q1A79n+DLL8YZqTFMPU46Xw=;
        b=YYmFFm231dQRqSeoWDvXHEWsJo/fskHLmMktS4QdhYD560rm1ZSBTcY86of/eFgHwN
         J3PNOpBQTG7q/kKCaXbpjdD9sBVS7Rw9LfsgrBAmuVDZxZnvjFcqQkMfbaBKL1amJzkH
         bkYIRVgZTc9Qp/N26WYeof8pA0oZ4woli3LbRbEyCVM02FZftVpgW2akAPbVYSQSu07Q
         Q5oR2rR8fOCfKds/QU+4+Y5hMMfEDZ+6XKbtON8xEjp+kDmKvkMi0F3CLvCyXwfQ1qg0
         yrq6zgDJoV3f9YKsNIfqJy+dqio+nHjwj55YKT1JifHh4yhEeUaCNSjlRYr2dKgZ4adp
         QwYA==
X-Gm-Message-State: APjAAAWc1SqWB7QcYgGvhHZ42LmV9kwzfIHA6SvHSMZcH/ToOhMu/bx7
        0GqmYDEeVCLUQVgaIvbRZal54A==
X-Google-Smtp-Source: APXvYqwWNh0sPEwygX7Wvo8RPiFcNXSo831PAF15ESiscG3x5fFSuE6AcHIFGug9cP/qO+n0oHym3A==
X-Received: by 2002:a63:2407:: with SMTP id k7mr1679176pgk.174.1579750882332;
        Wed, 22 Jan 2020 19:41:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id c14sm397784pfn.8.2020.01.22.19.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 19:41:21 -0800 (PST)
Date:   Thu, 23 Jan 2020 12:41:18 +0900
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
Subject: Re: [RFC][PATCH 06/15] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT in CREATE_BUFS
Message-ID: <20200123034118.GA158382@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-7-senozhatsky@chromium.org>
 <1fedab8f-e9a1-36b1-3dd0-8f1ed782ec4d@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fedab8f-e9a1-36b1-3dd0-8f1ed782ec4d@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/10 10:59), Hans Verkuil wrote:
[..]
> >  
> >  	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > index 0eabb589684f..48d123a1ac2a 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > @@ -730,6 +730,7 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
> >  	unsigned requested_sizes[VIDEO_MAX_PLANES];
> >  	struct v4l2_format *f = &create->format;
> >  	int ret = vb2_verify_memory_type(q, create->memory, f->type);
> > +	bool consistent = true;
> >  	unsigned i;
> >  
> >  	fill_buf_caps(q, &create->capabilities);
> > @@ -775,7 +776,11 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
> >  	for (i = 0; i < requested_planes; i++)
> >  		if (requested_sizes[i] == 0)
> >  			return -EINVAL;
> > -	return ret ? ret : vb2_core_create_bufs(q, create->memory,
> > +
> > +	if (create->flags & V4L2_FLAG_MEMORY_NON_CONSISTENT)
> > +		consistent = false;
> > +
> > +	return ret ? ret : vb2_core_create_bufs(q, create->memory, consistent,
> >  		&create->count, requested_planes, requested_sizes);
> 
> As mentioned before: we need a V4L2_BUF_CAP capability.

I can add V4L2_BUF_CAP for memory consistency. Isn't it just q->memory
property though? User space may request MMAP consistent memory or MMAP
inconsistent memory.

	-ss
