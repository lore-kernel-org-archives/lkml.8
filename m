Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F54C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1BC20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbwpAGiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCIHjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:39:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46293 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgCIHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:39:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y30so4311580pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDh2YIDb9vMSkZayjdTws9M7um4cCCRB3gf7x+Y/aVA=;
        b=HbwpAGiECfiJ5QIVoV/10COWkjpuf99URX3VmiBIs7WlpfDfrNcDSGvGrxu4C+BMvX
         ICRCaO8wT0g5mqLVYD6KM2z6mAD4grC6imeiHScgqESSeubx3qB5svp64w5UOhVveK/0
         scZqsFzHua+ATFWvHml42xQhj6gHTEAmBaM+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDh2YIDb9vMSkZayjdTws9M7um4cCCRB3gf7x+Y/aVA=;
        b=l9AhyFzgMzzic3z3uWujxT330dWg50UcKphB3TIhcTTRhjvVA9Pq74aWXIEulWp8f2
         yFLWqHhESG9okNHunnfCIwbTNG2RGivIQ+/mo57OVs9SvXHG6/zj4Hu2O1tZILUH5m5z
         /lnaWqyT5HLM32vpxG8moO73EEMUmAVfLZs5oQqsqz5zaAPJ04ADziyyJ1DKOww/Pxfp
         llJ2wIc7juGDkm7wUK6gaLddVr62Ei1ISWMpsSVQWxNS5qglWtOoTiThwOykl6SIidqi
         bZUG+RFfatXX7/82PUdQNf4cH7odiKbiVYYDxtacEb9Ss2k7I6+aH+btGzygMU2gWMuJ
         6m5w==
X-Gm-Message-State: ANhLgQ2tJyyhEJXlBd8OXqNYoLQRyLQeTl0blc8WPS5rAgyymRzeqp2F
        y9xJy3cZIjTXG7eLG4uE1b75rQ==
X-Google-Smtp-Source: ADFU+vthv985z4nPWRmO2LaLZGEbzt3++VV0/U9D9ZGX4USNRSTBj/3XlD4hcF5vxbHlhQGjgaFyIQ==
X-Received: by 2002:a63:a062:: with SMTP id u34mr15571753pgn.286.1583739552043;
        Mon, 09 Mar 2020 00:39:12 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x4sm38021917pgi.76.2020.03.09.00.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:39:11 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:39:09 +0900
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
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
Message-ID: <20200309073909.GD46830@google.com>
References: <20200302041213.27662-2-senozhatsky@chromium.org>
 <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
 <20200307094634.GB29464@google.com>
 <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
 <20200307112838.GA125961@google.com>
 <a4d85ac3-0eea-bc19-cd44-0c8f5b71f6bc@xs4all.nl>
 <20200309032707.GA9460@google.com>
 <40cd09d9-49a6-2159-3c50-825732151221@xs4all.nl>
 <20200309072526.GC46830@google.com>
 <e31197b6-5d22-0c3a-cc77-e9506136ada5@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31197b6-5d22-0c3a-cc77-e9506136ada5@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/09 08:28), Hans Verkuil wrote:
> >>> I'm looking into it. Will it work if I patch the vivid test driver to
> >>> enable/disable ->allow_cache_hints bit per-node and include the patch
> >>> into the series. So then v4l2 tests can create some nodes with
> >>> ->allow_cache_hints.  Something like this:
> >>
> >> I would add a 'cache_hints' module parameter (array of bool) to tell vivid
> >> whether cache hints should be set or not for each instance. It would be useful
> >> to have this in vivid. Don't forget to update Documentation/media/v4l-drivers/vivid.rst
> >> as well.
> > 
> > I see. Hmm, how do I do "test that V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS
> > is never set" then?
> 
> Not sure I understand your question. When requesting buffers for non-MMAP memory,
> this capability must never be returned. That has nothing to do with a cache_hints
> module option.

OK. What I thought was that not every MMAP memory node can have cache
hints enabled, so it should be verified that only MMAP nodes which were
configured to allow_cache_hints should report that CAP, the rest of MMAP
nodes (if any) should have that CAP bit clear.

	-ss
