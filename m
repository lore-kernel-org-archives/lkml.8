Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B98C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0F321835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOXqe+cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgAVFFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:05:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45721 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgAVFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:05:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so2718129pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 21:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W3QtAa0GpCqU3ZzHtwssyYyBXTxGEn8WOK20xfN/i70=;
        b=KOXqe+cgyOzv6v1zYpW2D5il/19yMEKhdDjOyKMcgPAp1jl4dG6xkhxbUj5vF4qAJk
         z2ylcP+/AduEA7qzIiP1BXwbM8M3Qf2O0iw+nWjNXFNzD+BSitSCCwO4ThGVoaUd4OuX
         IjqBOYsTwCTVvbmsnjbEug21kTgCMsHD00/kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3QtAa0GpCqU3ZzHtwssyYyBXTxGEn8WOK20xfN/i70=;
        b=QaQCTQkrfmmNVKidT1NQvEi48hmxl94ZxOsJXn0N1twMxVOC+UEKpLOnfAJpKrBNn1
         yJ/wKPJacDAtxYKRSR+jVqe86ilKf/X0izaOsoywafQqRWUlT246Jo3ONCxrVxG/Lm77
         Y4J36HY+W8cabjXAFIkZ7hAWEVESayVCz6CElKeAQYdKKNpDAd5LNErS3fnzB0I1oE+J
         1cD7mWx21BBneoriY9f0SXHgsXYBJxTqo/oGchCmizEBo/i3v0Jlbh2dc9v5x6HibYZp
         KQAiU5HV+jRPgx+bajziTyLWezrneF81fELvN3rHjtW9QK0Jx47zoDgbmG6bVjZKVjf9
         0fog==
X-Gm-Message-State: APjAAAV6Z5cGYaH+CFaYnc9wJfx5FoZgOb0BZtXosdK3AcXZrS7lCoqF
        oEJJDOVWUorP+/14UKBFKf1hNA==
X-Google-Smtp-Source: APXvYqzOVQxEB0Cb/qKyvWuxJK3JMG8vX+8qT1VGOd5nWnqFVGxB6D/FCdWny7gTuCLkbkB9+N2Jxw==
X-Received: by 2002:a63:6f8a:: with SMTP id k132mr9489382pgc.70.1579669517546;
        Tue, 21 Jan 2020 21:05:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x65sm47362058pfb.171.2020.01.21.21.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 21:05:16 -0800 (PST)
Date:   Wed, 22 Jan 2020 14:05:15 +0900
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
Subject: Re: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF
 queues
Message-ID: <20200122050515.GB49953@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-14-senozhatsky@chromium.org>
 <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/10 11:30), Hans Verkuil wrote:
[..]
> > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > index 1762849288ae..2b9d3318e6fb 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > @@ -341,8 +341,22 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
> >  				   struct vb2_buffer *vb,
> >  				   struct v4l2_buffer *b)
> >  {
> > -	vb->need_cache_sync_on_prepare = 1;
> > +	/*
> > +	 * DMA exporter should take care of cache syncs, so we can avoid
> > +	 * explicit ->prepare()/->finish() syncs.
> > +	 */
> > +	if (q->memory == VB2_MEMORY_DMABUF) {
> > +		vb->need_cache_sync_on_finish = 0;
> > +		vb->need_cache_sync_on_prepare = 0;
> > +		return;
> > +	}
> >  
> > +	/*
> > +	 * For other ->memory types we always need ->prepare() cache
> > +	 * sync. ->finish() cache sync, however, can be avoided when queue
> > +	 * direction is TO_DEVICE.
> > +	 */
> > +	vb->need_cache_sync_on_prepare = 1;
> 
> I'm trying to remember: what needs to be done in prepare()
> for a capture buffer? I thought that for capture you only
> needed to invalidate the cache in finish(), but nothing needs
> to be done in the prepare().

Hmm. Not sure. A precaution in case if user-space wrote to that buffer?

+	if (q->dma_dir == DMA_FROM_DEVICE)
+		q->need_cache_sync_on_prepare = 0;

?

	-ss
