Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F56C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9357F2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaED7IQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgAVDs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:48:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46139 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAVDs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:48:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so2678461pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 19:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KadZgXrBtO4mVuKeTcVoWP21ln+Btq+vvbOWpeDpln8=;
        b=CaED7IQMeGfxusCT6+3cakdWwWTFDcVNFi3XT3OopLYBw7YlrGgkiI2fRxqWZ9o8LK
         oylPl9WM1Bu5ILGNSdvQT+TjpwAbOkqnpJr6wm1SqC+f2TD+vL7Pt5mOx2yAXFP49lGE
         VsjEDmSCrcoh0CYc/b7527lvoL07bTexhdh50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KadZgXrBtO4mVuKeTcVoWP21ln+Btq+vvbOWpeDpln8=;
        b=P552QShk4duhW76xZtJbHAKEBz8j2ThBf8q7elMYxbD5yeS2xLHlwGcRvkCYPXiaIP
         pU8n5u5eg3Mmcr1qbmRuu9Xtx1cbalKh2QTxB4NS2zZSutQ2KtWUh3LCznkAKrN6DH6+
         ya8LsPTXo/g7VzNZM/QjwR3DbDLBUhkTbnrUKNzjmXk6+MUbutWlnN6YhmD+dZTdMQI3
         A7IM6w5KY/+fxiASaa8bjjSVAPP2CKtObHpdKfP3+UP1/wPvQZrraSBmZW4r43smffPq
         EDxXDO8hu7bSB6FC8Ro5IIZWN4l2Eq8Z2LkUnnYsomBqrdUJAPIqMNSfSalRXoPRvIrT
         w9Fw==
X-Gm-Message-State: APjAAAVo1Ty/w7datQPlKtcLmMTOEjJtzPHDwWcT86dODsmkBBsie7Uv
        AiGuAW6nwnsJhsj85kJlEkvfwg==
X-Google-Smtp-Source: APXvYqx00s1zj1f3z6a3QsGHpNeUuQypaOEQyTDGgMiU+6RS6ErEU6Tp/bmkEtJkcyZebk41iuOn8Q==
X-Received: by 2002:a65:488f:: with SMTP id n15mr9491436pgs.61.1579664908564;
        Tue, 21 Jan 2020 19:48:28 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b21sm47755963pfp.0.2020.01.21.19.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 19:48:27 -0800 (PST)
Date:   Wed, 22 Jan 2020 12:48:26 +0900
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
Subject: Re: [RFC][PATCH 05/15] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT in REQBUFS
Message-ID: <20200122034826.GA49953@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-6-senozhatsky@chromium.org>
 <8d0c95c3-64a2-ec14-0ac2-204b0430b2b4@xs4all.nl>
 <20200122021805.GE149602@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122021805.GE149602@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/22 11:18), Sergey Senozhatsky wrote:
[..]
> > > +    * -
> > > +      - __u32
> > >        - ``reserved``\ [1]
> > >        - A place holder for future extensions. Drivers and applications
> > > -	must set the array to zero.
> > > +	must set the array to zero, unless application wants to specify
> > > +        buffer management ``flags``.
> > 
> > I think support for this flag should be signaled as a V4L2_BUF_CAP capability.
> > If the capability is not set, then vb2 should set 'flags' to 0 to preserve the
> > old 'Drivers and applications must set the array to zero' behavior.
> 
> The patch set adds V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS towards the end of the
> series, I guess I can shuffle the patches and change the wording here.

Or I can add separate queue flag and V4L2_BUF_CAP:

struct vb2_queue {
...
	allow_cache_hints:1
+	allow_consistency_hints:1
...
}

and then have CAP_SUPPORTS_CACHE_HINTS/CAP_SUPPORTS_CONSISTENCY_HINTS.

	-ss
