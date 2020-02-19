Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A8C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47461222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVTHzOlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSINo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:13:44 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43847 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:13:43 -0500
Received: by mail-pg1-f175.google.com with SMTP id u12so11971200pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gLBIj+fuH4bNJ6zllKwalYU+iG961kfhyRRqPAduohs=;
        b=cVTHzOlfDltrvNuUVa8kzzACQJWj0n5H39jmoyykMIcLCjAOEcF+AE3MR0swAyYLs/
         Duv5AnjAlKFUiGZK038MzN1WkgdcCBfuMXFO4Qns27SqZcbXvVIOVUv1r4FFd+BpstgP
         44vxbNzl/meJyidKYLrxdrRXANxFpFKMQvFno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gLBIj+fuH4bNJ6zllKwalYU+iG961kfhyRRqPAduohs=;
        b=tAY09V/VjtoLawMzaWlRY90In6TC+TyKhrYIA3r6EqwVZAiYw9w3fAzioTc7ikNs8S
         WzFFKEaO1Fuio0Z/uXeBZyFu37O+efPblvESGbCt9IAJVAOFPH02c3ToCcN9MNdUgnXO
         /VHoZ50nPHuxHipf16GdVzycKcvFMC1RiHXvScFToED5g4wKzxEUJRMKBxjXLjWoTVY8
         mIle9294mHP5GOeQ9WSS2VG2zTPFLARJbpou3gg7405/C2KWWEQY+08ZWv423GgdbiDc
         WfVks7ogJ9W2brcovKypiqEgsywcd4hxw36XwG5bY3J8YUt75skYyoeQg5rAzUs55O3K
         kNRg==
X-Gm-Message-State: APjAAAWwXq09y/08Ubuv+horwhZnQDMXBJjGD3vXX6fEWa3GTwQvxSKM
        XwpQ/ew89vi2TdGFJDQ51lftzQ==
X-Google-Smtp-Source: APXvYqzXnV7KNkCPQQhGW/2mDRfwqG7/QN4jHrX+n2YGug9t9XMLzrvbSVJzeZqLbwaLQ2qWG5JwQg==
X-Received: by 2002:a65:5ccc:: with SMTP id b12mr26622426pgt.124.1582100023146;
        Wed, 19 Feb 2020 00:13:43 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id z64sm1776228pfz.23.2020.02.19.00.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:13:42 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:13:40 +0900
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
Subject: Re: [RFC][PATCHv2 02/12] videobuf2: handle V4L2 buffer cache flags
Message-ID: <20200219081340.GA122464@google.com>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-3-senozhatsky@chromium.org>
 <be430540-4b8e-6b44-1eee-9d7291a365be@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be430540-4b8e-6b44-1eee-9d7291a365be@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/19 09:07), Hans Verkuil wrote:
[..]
> > +static void set_buffer_cache_hints(struct vb2_queue *q,
> > +				   struct vb2_buffer *vb,
> > +				   struct v4l2_buffer *b)
> > +{
> > +	/*
> > +	 * DMA exporter should take care of cache syncs, so we can avoid
> > +	 * explicit ->prepare()/->finish() syncs. For other ->memory types
> > +	 * we always need ->prepare() or/and ->finish() cache sync.
> > +	 */
> > +	if (q->memory == VB2_MEMORY_DMABUF) {
> > +		vb->need_cache_sync_on_finish = 0;
> > +		vb->need_cache_sync_on_prepare = 0;
> > +		return;
> > +	}
> > +
> > +	if (!q->allow_cache_hints)
> > +		return;
> > +
> > +	vb->need_cache_sync_on_prepare = 1;
> 
> This needs a comment explaining why prepare is set to 1 by default. I remember
> we discussed this earlier, and the conclusion of that discussion needs to be
> documented here in a comment.

Please ignore this patch. There is a follow up which sets _both_
flags by default. The purpose is to preserve the existing behaviour,
we can do all sorts of incremental changes (clear flags in more cases,
etc.) later on. Do you want me to document this in the code?

	-ss
