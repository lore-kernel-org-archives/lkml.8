Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D77C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD97222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4fnLH50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBSIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41638 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgBSIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:42:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so12144327pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEfRYK8X2QQnG43sHHHHoR8YIwfIEm7XxLTlJ/H+Qso=;
        b=D4fnLH50SoBcu24sBK+TREJyUfMHxXPaZKVeoLfvA5KFxaZ7c68RJNszw2tBFA9Qcp
         ba+eAmlzeBfOiXE8FiyX0VS/UsLgVA9SF+n+DR06ziu8bljGWCHxbU/czk9XIaQ7Imvj
         bhlROB8OvWew6mZ/ZxOVoOWi7afsncAZvIcNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEfRYK8X2QQnG43sHHHHoR8YIwfIEm7XxLTlJ/H+Qso=;
        b=Ka1VMnl84MrQcyowH4IRghsU4uTDgV2H28YNon33vJPSPoGX3OonbcFfVs6tedEWsy
         m76+wt1BIMLMrDvk+DxxqwOv8kyt6WLiavnFMCA5xbJsimQ8oQ36Ak7KIOc+rzXUWM8D
         kvWYEcYyKy28s8Ukceur+mDolriDI90UTt98UaRLFhpesLcav4xYi9k8mBkYWMFUWJl2
         9YZQzFsQmZun7EXiILsSPk87S1AP4mh2dViFC5urBDdTh4OivAo3qLi5NyQCzUfePxAF
         evDigYW92yEc9VQr21zbEzzVOt6A2Cu/TZwswMprHykYanTFiKp27Uji+O9ZjTOOOWkW
         IGrQ==
X-Gm-Message-State: APjAAAVj43kMMArV0bHlBrW7DuZB10rSNTVn9lv4iK609uLdHEwFjTob
        xUtV4tgRoUEz2p+Gcb29wPz1ZA==
X-Google-Smtp-Source: APXvYqzjnuZExpo94NDDjP+oXQOEJXX7Rv7xGZvYk6wB2CYz2vbMD1KopE9TEkAVUNxHi4plCGVSsw==
X-Received: by 2002:aa7:9796:: with SMTP id o22mr25408908pfp.101.1582101748508;
        Wed, 19 Feb 2020 00:42:28 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id v25sm1829913pfe.147.2020.02.19.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:42:27 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:42:26 +0900
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
Subject: Re: [RFC][PATCHv2 11/12] videobuf2: add begin/end cpu_access
 callbacks to dma-sg
Message-ID: <20200219084226.GC122464@google.com>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-12-senozhatsky@chromium.org>
 <06d654ec-9d05-4ef5-c27e-ff78c96a3457@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d654ec-9d05-4ef5-c27e-ff78c96a3457@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/19 09:35), Hans Verkuil wrote:
> On 2/4/20 3:56 AM, Sergey Senozhatsky wrote:
> > Provide begin_cpu_access() and end_cpu_access() dma_buf_ops
> > callbacks for cache synchronisation on exported buffers.
> > 
> > V4L2_FLAG_MEMORY_NON_CONSISTENT has no effect on dma-sg buffers.
> > dma-sg allocates memory using the page allocator directly, so
> > there is no memory consistency guarantee.
> 
> This should also be a comment in the code.

OK.

	-ss
