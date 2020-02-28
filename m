Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C231C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEAC2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLoUb8YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgB1D6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:58:06 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33727 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbgB1D6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:58:05 -0500
Received: by mail-pl1-f172.google.com with SMTP id ay11so704229plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xTrl5tDJ3LgMjVjznAF2IZeLLj4bLTa5BFypN0t3zI=;
        b=FLoUb8YWIBuLFoC4a674VnvdxctknREYD8PsnvPRqrRhKsCe12ZRSw+75eaa+Dlup8
         MCLEWHv+XMbgSPaH9rDmqjz2BP7UVMNjqglwAa/87DKW6m47xejUIaAVeWnkBb1w8558
         sW0TsJVbQTh+l68RVz8wB7l1Tgmy7ImR47CWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xTrl5tDJ3LgMjVjznAF2IZeLLj4bLTa5BFypN0t3zI=;
        b=gwZ87WlTYWaeIiL/2hBRczi4aMdtHXkp29XXri6yDrvZrKkn9Y5dZSMs7Cf0LWa23R
         0P7IlKK1V4LHFUyzl0R8XVEaH+8LhARTQVgNjDs/lYAFT8mrQ0dTn2AmUGnAT1OqQ2kl
         qBMB0XHfh6BRcIuz0YA6HApOEozJ0DZxV1wW5v+c0t+OG0ykRgCNkfcnfLgvpn1YckhH
         olr6Rlzz7Lv6UwHdszWRR8lr7R0Kp5vLp/yXrdzLS2ie7aq9Q5PdvRHjOCnas2kfHiqh
         1v77PXOAEEnj+iKNCX6Qu0QftzUPGz9wpPxbuPw36veLfN4oAT3N6WU8vElAmh+TK8Ba
         M9pA==
X-Gm-Message-State: APjAAAVeeQY7xy43dQKmlmw7C774xLFp3NUOTcJpMWeT7d/GuK7Ddo3o
        qU7ra5KAG19OQtysMh0166kUVQ==
X-Google-Smtp-Source: APXvYqyvxjKuYMmtpPhK74Cp/7Nhm3vufNA08w1WY2arWJ6e2j4fSSY/TtpCAkQC5CTdLTtF/shCvQ==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr2512123pja.27.1582862283222;
        Thu, 27 Feb 2020 19:58:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id c68sm9251950pfc.156.2020.02.27.19.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:58:02 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:57:59 +0900
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
Message-ID: <20200228035759.GP122464@google.com>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-6-senozhatsky@chromium.org>
 <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea79a02-8346-2b1d-c2d8-3a3b36480320@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 13:36), Hans Verkuil wrote:
[..]
> >  	other changes, then set ``count`` to 0, ``memory`` to
> >  	``V4L2_MEMORY_MMAP`` and ``format.type`` to the buffer type.
> >      * - __u32
> > -      - ``reserved``\ [7]
> > +      - ``flags``
> > +      - Specifies additional buffer management attributes.
> > +	See :ref:`memory-flags`. Old drivers and applications must set it to
> > +	zero.
> 
> Drop the last sentence, it's not relevant.
> 
> > +
> > +    * - __u32
> > +      - ``reserved``\ [6]
> >        - A place holder for future extensions. Drivers and applications
> >  	must set the array to zero.
> 
> Old drivers and applications still think reserved is [7] and will zero this.

Just to make sure, does this mean that you also want me to drop the
"Drivers and applications must set the array to zero" sentence?

	-ss
