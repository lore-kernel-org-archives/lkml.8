Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C05C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BF92070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRcjzBNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCGJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:46:38 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:51528 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCGJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:46:38 -0500
Received: by mail-pj1-f48.google.com with SMTP id l8so2131285pjy.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RrUVYR+Ncmf3+5c5RCoXaObVour9qF7+lbeQrqlz+7c=;
        b=MRcjzBNzTh5m3HSl5QjeZjeXKY2VA6NvugpKkaY9BkbYggMALXdwJmatwbyzt4HVaN
         FNVwzPydWl9DfNHfnZpihcslmKiTLENkCGlOZ1pnwEXwB5KfPBF87uI20I4WeQLruafb
         k51o3Yw1Kue72BUfoIjgvPAQ90aUwsFtPxcMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RrUVYR+Ncmf3+5c5RCoXaObVour9qF7+lbeQrqlz+7c=;
        b=G11lXpOpaL1opHf8j36+b+NSbQvDbeg9VxJqdH8lOCfzLxjDtJc07qD9MOdxhlLnyO
         FAuF7U7ByHDumDew9TYfm9Jg3GCCdyHtGW7HWnCOGh0OgLLf6SyKIusPxuIwsxcRQjFC
         CIZ2GwRwnK+LUAU1jb9aV+dS0eozL+PeNttwr6Tr8eBMxziMQlCuORXe3/Zi+1B45TCZ
         r7dk4e8aNFqJ9gysFRMZuaqJ7p9sg9Wn3171/0eZ1LtPLpdPq7M0DIqPSqJ/B6Yu5Cjr
         HqXxMvhvJqROAexn5Nvw7dSn+zCdBPCl7vYg4J7pnu6SsHVhT597OGIOYXUiXxIg426G
         XtzQ==
X-Gm-Message-State: ANhLgQ1csBggT1k3m/xvCpJgJm4SkQeC6DFFr3bVYYwSOSKZ6ZRiR2qV
        wxDQPuF132KhZVPNMtmUZqfN1g==
X-Google-Smtp-Source: ADFU+vu/3aSIwqudH328r7Q6d2ReouzpmLb4lMtmayKrIiBYtfhZmjNz5NkivGbIl4PV33pL8GnFfQ==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr6987040plr.81.1583574397292;
        Sat, 07 Mar 2020 01:46:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b10sm11855226pjo.32.2020.03.07.01.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 01:46:36 -0800 (PST)
Date:   Sat, 7 Mar 2020 18:46:34 +0900
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
Message-ID: <20200307094634.GB29464@google.com>
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
> >   * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
> >   *		driver can set this to a mutex to let the v4l2 core serialize
> >   *		the queuing ioctls. If the driver wants to handle locking
> > @@ -564,6 +573,7 @@ struct vb2_queue {
> >  	unsigned			requires_requests:1;
> >  	unsigned			uses_qbuf:1;
> >  	unsigned			uses_requests:1;
> > +	unsigned			allow_cache_hints:1;

Shall I use "unsigned int" here instead of "unsigned"?

	-ss
