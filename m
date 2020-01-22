Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9798A2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEUygi0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAVCxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:53:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgAVCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:53:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2553752pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 18:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUSpbzQrCD6o0BFV4rM7kWGpbJmN9Rieqc/eqMah9Sg=;
        b=NEUygi0trrMIxzEg4+2az/7rHQV4S0dVmlHSwNM1y0GmWtjFADOr5iEHfXye6UdYEe
         tSjBExRVY6mqUqMY6BcUfoP40Jw72DC4SydacLuo8BxA6eTAGdNV7YazwcSeQhHzfD5W
         gzLP2ORGNO3kMw0E2sk1soxhO/dQJtWAGMAoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUSpbzQrCD6o0BFV4rM7kWGpbJmN9Rieqc/eqMah9Sg=;
        b=sxldFbFCundvNOB0PKdekVEyf+uoCVKNm6TFU0yW+IMDjnD2kqGrTjRP0M07YaHgn/
         wpSFMDnAK7w6iQZ78xjCmErHNqAh/XUCBU1KSFRyJcDtQDgngv/cKKk9UNIxbx4xj9W4
         Gn5CRisWtOmHHWfCPV+gjC/Iz1mFrzV+5woRdR6kCs2kG+psnXRNkwAY0BpgfY3YJCYR
         Rt9gdOjbXk+y1V1ogx2pbmxUDf3s7ROotYwGgBLkbfVnPM+EAIzMcOtj6B5Nnf9yFThf
         ZbH1DC84dYKeTc/w4ZcDKFH2zMkL+Tf8+0Tkjn8cNHqBquMNDnazrXti/53NZfpdIMuP
         Rbug==
X-Gm-Message-State: APjAAAUDV3VIWMH9Jd0O1xeriqGFcuVVjPDGmoDCYo9PK7kBkBbuZMcF
        EVJBFfYfXIoF3jhDHQYRra+dzw==
X-Google-Smtp-Source: APXvYqzEmmFJ3m7Mydjc2bCP6L1VchsuolUsAp9Z16hGJdFhBLBlaXvqe3rvrbPKKaHjh3JLzuO7qg==
X-Received: by 2002:a65:56c9:: with SMTP id w9mr8443639pgs.296.1579661633974;
        Tue, 21 Jan 2020 18:53:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l2sm44861054pff.59.2020.01.21.18.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 18:53:53 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:53:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC][PATCH 02/15] videobuf2: handle V4L2 buffer cache flags
Message-ID: <20200122025351.GF149602@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-3-senozhatsky@chromium.org>
 <ada2381c-2c1c-17c3-c190-48439ae1657a@xs4all.nl>
 <20200122013937.GC149602@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122013937.GC149602@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/22 10:39), Sergey Senozhatsky wrote:
> [..]
> > >  }
> > >  
> > > +static void set_buffer_cache_hints(struct vb2_queue *q,
> > > +				   struct vb2_buffer *vb,
> > > +				   struct v4l2_buffer *b)
> > > +{
> > > +	vb->need_cache_sync_on_prepare = 1;
> > > +
> > > +	if (q->dma_dir != DMA_TO_DEVICE)
> > 
> > What should be done when dma_dir == DMA_BIDIRECTIONAL?
> 

[..]

> We probably cannot enforce any other behavior here. Am I missing
> something?

Never mind. I got your point.

	-ss
