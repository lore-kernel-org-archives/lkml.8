Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6638A246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uo712UO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB1LjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:39:16 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:33151 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgB1LjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:39:16 -0500
Received: by mail-pj1-f52.google.com with SMTP id m7so4303693pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ziAc3Mla8xF8RThiT9RDbHiUPBgQNQRjNzhxmEJKPBI=;
        b=Uo712UO7G9rKVyqN2AewidkdDnhXrqXFF6S81IEiC/JHl5NAllVgieR/51erXXMTjB
         4rXaAySUQwHwlxNU5LOyfqHrJpV6qhtlTGtDex7QrcfZID9nXOtF5GfmdKs5P23xbHXM
         jrNkNZL4k7to01dgJaHLmCnV3qp/NG0YWeaKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ziAc3Mla8xF8RThiT9RDbHiUPBgQNQRjNzhxmEJKPBI=;
        b=JBtNPVMd7INxNli8DJKrPo0MNmP5N3gkyD4i9QeZEDypuQonLUk3g+xDYlPM057nTy
         QtOs6K43ynPoc2CUINf5Lp9Ohlf5OC6Jga7sLDjLVYeo2TuKA3VOxPJEN+U1yFVTQKd0
         kWMJGn1EQa32uyZLShNGuX8lNmZzT3VRTtPqiTYDfYrqhf4WJK+cMKdqGopnfzboyZJ0
         l1g0CnwqqVcIdMnzhvK/8Nt3yiCG+g7I9nJ5W0LH2/m0FPvqC5pGNpvHN51M6eSdMC9j
         TjsJsP2ea4lJLmFLF3gxxxgVKs1mlBSvTzNH4YOkmmO3J++36kGEc/Daec9tbnl8E+vX
         71GA==
X-Gm-Message-State: APjAAAWof1gLrzJSfN5Q8ikOmozMc9s1g5Rxof1lHM1fOA4mcIK/vV6O
        DnZKlKFKlQYztOP1yZrwwO2I7g==
X-Google-Smtp-Source: APXvYqx1o0UUcIcmWEAYPT5Lm+FW8M2YK9NHnQGVnRLMf6dcWL3dFJ0hUPE6fzphU1UogSBVs1Ko8g==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr3428561plo.98.1582889954918;
        Fri, 28 Feb 2020 03:39:14 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id y5sm10715100pfr.169.2020.02.28.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:39:13 -0800 (PST)
Date:   Fri, 28 Feb 2020 20:39:11 +0900
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
Subject: Re: [PATCHv3 05/11] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200228113911.GA121952@google.com>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-6-senozhatsky@chromium.org>
 <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
 <20200228035759.GP122464@google.com>
 <7c936a58-7ad9-60a5-1f4a-e86ee358752a@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c936a58-7ad9-60a5-1f4a-e86ee358752a@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/28 09:50), Hans Verkuil wrote:
> On 2/28/20 4:57 AM, Sergey Senozhatsky wrote:
> > On (20/02/27 13:36), Hans Verkuil wrote:
> > [..]
[..]
> >>> +    * - __u32
> >>> +      - ``reserved``\ [6]
> >>>        - A place holder for future extensions. Drivers and applications
> >>>  	must set the array to zero.
> >>
> >> Old drivers and applications still think reserved is [7] and will zero this.
> > 
> > Just to make sure, does this mean that you also want me to drop the
> > "Drivers and applications must set the array to zero" sentence?
> 
> Not for the reserved field, only for the flags field.

Got it.

So V4 is ready. Do you think it'll make sense to send it
out now or next week?

	-ss
