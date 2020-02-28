Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7920C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01024690
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvYiDSKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgB1BUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:20:47 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35808 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1BUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:20:47 -0500
Received: by mail-pl1-f170.google.com with SMTP id g6so548795plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/Dq6FU7+4ucFlGTVKctoP7T0CYqXsAPYM+oMCvP2zg=;
        b=mvYiDSKWHF1Bt1SXDcgoLDC4we078lXxF1XJgOv5EyB8iSgVpV1pxozNq1Wz6yRoIX
         uxRqLLia+Ol/zUccoeVbMav/JsmPmcT3wDjNqw+zTTqOWYVeVcOl/xmQ/dJ0x4SXDDDL
         /Q/wEejWl2xRGS3ETWipMCWbtoLOYw2izvlt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/Dq6FU7+4ucFlGTVKctoP7T0CYqXsAPYM+oMCvP2zg=;
        b=tBZI1TQIHOFrelQVxQBFEjuplMvueAjFxRXXcB5vy7KA3WnscQPWHdbdc6FawwUk/w
         EXYwla65A+hwClvj71IQOoJsJf84qMGGdDky9XJgw9vAQ94g+ZW107cxnL5aMgcb8yA1
         Xk6F/jVEvLjlvwTjgPUwbOVdN7F30t5NXn7/A/EAjf+28s8NMFFXDzb45HdpHqLEun4W
         N08gaJLuKTdGILK29zejOy/iTzm1gwouE3hBrBvLYz6n5xwjmH/RRJniTtzrXv7gByuY
         GczN4PRpRlWsfXdHy7l/sxMNHekBPgmNSdMUbbpA/Hs78Cka1S37KX2GoXnjrKDS5k0S
         u5kA==
X-Gm-Message-State: APjAAAXaEVX8vAYL3u+zWDBXinbVp2EbMEmNGCy8KUIXB3LAJGLoHWfo
        XH1FmCRSe4rZV1hP4nLkd68fvQ==
X-Google-Smtp-Source: APXvYqw1ZDRAUCBUAn3M31x3ckHZ3Bx3FvatakAHQH5RAPr79cOjqm5yMPJiIf549ZE4i/BWMCXPYw==
X-Received: by 2002:a17:90a:37e7:: with SMTP id v94mr1801881pjb.37.1582852845913;
        Thu, 27 Feb 2020 17:20:45 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e189sm3255096pfa.139.2020.02.27.17.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 17:20:44 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:20:42 +0900
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
Subject: Re: [PATCHv3 02/11] videobuf2: handle V4L2 buffer cache flags
Message-ID: <20200228012042.GK122464@google.com>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-3-senozhatsky@chromium.org>
 <8f48a4ab-8b8f-576d-9493-bfce7d01224d@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f48a4ab-8b8f-576d-9493-bfce7d01224d@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 12:58), Hans Verkuil wrote:
[..]
> > There are two possible alternative approaches:
> > - The first one is to move cache sync from ->finish() to dqbuf().
> >   But this breaks some drivers, that need to fix-up buffers before
> >   dequeueing them.
> > 
> > - The second one is to move ->finish() call from ->done() to dqbuf.
> 
> It's not clear what the purpose is of describing these alternative approaches.
> I'd just drop that. It's a bit confusing.

OK.

> > +/**
> > + * vb2_queue_allows_cache_hints() - Return true if the queue allows cache
> > + * and memory consistency hints.
> > + *
> > + * @q:		pointer to &struct vb2_queue with videobuf2 queue
> > + */
> > +static inline bool vb2_queue_allows_cache_hints(struct vb2_queue *q)
> > +{
> > +	return (q->allow_cache_hints != 0) && (q->memory == VB2_MEMORY_MMAP);
> 
> Simply to:
> 
> 	return q->allow_cache_hints && q->memory == VB2_MEMORY_MMAP;
> 

OK. I saw vb2_is_busy()

static inline bool vb2_is_busy(struct vb2_queue *q)
{
	return (q->num_buffers > 0);
}

in the very same header file and concluded that maybe this is the
preferred style.

	-ss
