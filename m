Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF51C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 05:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A84206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 05:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLupZ17+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCGFXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 00:23:03 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35462 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgCGFXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 00:23:02 -0500
Received: by mail-pg1-f180.google.com with SMTP id 7so2076075pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 21:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZnej70fqtnmhJkhSgvZFCaeIT417LMoCLynROy5i68=;
        b=jLupZ17+y1Pcsuu3u6ZBfn6OjqgbFG2N+msvqVCMibTY7WH6duQ4F7CrB/4ID6e2im
         YZEMtj9ia1NETFijCqJ5dzcwXztBwPsFtPj5VqyPBAOKrdilPTF/MZNMYLWoJBvXn/Bb
         yuVyvmlcVgZOoMIiUKGiLzzdMXlc/ILEQwmzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZnej70fqtnmhJkhSgvZFCaeIT417LMoCLynROy5i68=;
        b=cmcySHreI5itfntod7yuMtZajFhNdsatr2T8QxdMhJaHMXAaBQHkdD+dzWpXatukrg
         D91bT4p+FWA+DOtESf3BEaQON40mj16ragZXvXC4dAIRtUdrKrxhpJXKd7vI85rpwzsl
         ZGzYZGomX6mHkPceFcy2+v30bgfqF0h5e+auNS/lwcK8mgB2jpMr9RYghASYogfSuzoc
         h3vDJdcFgwDOhUL2D6XTf3XWWqk66IhGtXUdcihOp2g7KeYEpZEeBUvK0wtKc4RwAFuM
         sEg7mpU7duAcb+ZIwKxDTEoUB+PAzhpAb7czc0JTUQJaQWIfdKKAvejdfIP8cbEXbRcn
         UpxA==
X-Gm-Message-State: ANhLgQ1MO0jzMWnyaQooshPggAFsyJMkLSA+RpjXZvF5sAjmaM0akz2b
        wytGyxaZmoPEUKAGFniL7t5i9Q==
X-Google-Smtp-Source: ADFU+vs3kLDTiF4fIdAdEhIDT71WCUm0OIYuNytmoIRGkxyL5cwr8q//1mSe7/JhC0o9M7vi4Gsi6g==
X-Received: by 2002:a62:1889:: with SMTP id 131mr7033784pfy.250.1583558581255;
        Fri, 06 Mar 2020 21:23:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 193sm15387966pfu.181.2020.03.06.21.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 21:23:00 -0800 (PST)
Date:   Sat, 7 Mar 2020 14:22:58 +0900
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
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
Message-ID: <20200307052258.GA176460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-2-senozhatsky@chromium.org>
 <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/06 14:57), Hans Verkuil wrote:
[..]
> > @@ -491,6 +497,9 @@ struct vb2_buf_ops {
> >   * @uses_requests: requests are used for this queue. Set to 1 the first time
> >   *		a request is queued. Set to 0 when the queue is canceled.
> >   *		If this is 1, then you cannot queue buffers directly.
> > + * @allow_cache_hints: when set user-space can pass cache management hints in
> > + * 		order to skip cache flush/invalidation on ->prepare() or/and
> > + * 		->finish().
> 
> checkpatch complains about a space before a tab in the two lines above.

I see them. Sorry. Fixed now.

	-ss
