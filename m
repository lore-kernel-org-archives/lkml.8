Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF22067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="xyg7NNw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgFGUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgFGUVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:21:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003FC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 13:21:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so13149150qtv.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9LawDuy/RIabvhu0uplVQvfkvDtwIE3mp3pxEyl0OCo=;
        b=xyg7NNw/6CFp+2prS3ZmKEc7KRZ4wF4LfFYUxmwtbWO2fPGtzUPYWot2jCEfSM8GL+
         vYu5mYUFBJROpZNlw1T8eezV+kJcsuplAIPX8kf2s3JOhMlQ+eRAh8yfyvwXx2hspAID
         ajbPtT1rvA8wAcQ/mvWr9l71Jmhuo2nD76GoGPBBxcuvmNcD13LZzVZSb6p8alA5LyO/
         sRhlPURTUNMCmBFQeXy0g2dNZAAC/1WIPzwDK1+gywjOIoESQLDBDp8caH/VgrkmAiw1
         UIm+tY45PrYEVtCGI2SpoqtZ8M/CDq9U0E+07+OpUw1anRWAij1ATw+g2gTXUQYGdLgc
         LlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9LawDuy/RIabvhu0uplVQvfkvDtwIE3mp3pxEyl0OCo=;
        b=L4JI+eJPHmtRYy3CVE2K56A6VjO6ZGl1nTHDOWVbdI439u5rLFH4S+ooP3eHrhbM3w
         uyUIrI9PCjDC2uQUYOBEAotjiQdZ5VLHRzq4U3IlF6o4hrI2KYskP5S8NcmSVfXuK9AN
         eMkdW5oNKHMqqpmxUglMl4iUXxctGtQaFQbmQLmSG7lieWIlXZUDWo14fApfSFhtQs5t
         whI1qv/50M43p8qW6CK2xEU4BGQB5pWpwMD3F0utFz36WboyY0m4T+HeM1xH0C37C5H0
         bXNuff6XB3EV8sFJ6x93DS0Hcs9H9K5t2zUEIqiJ5hbV3x+CaQ1StNNXW5YxmJBHLNtz
         pzKw==
X-Gm-Message-State: AOAM530MhmUDbyUhs/dVnL/7Q4EZ9nqrnLKfmdsAOnxFjLZ0U/chR6r6
        UJmOcTzP4AJyk8+bl66726N14g==
X-Google-Smtp-Source: ABdhPJyLwaCF3KfXtIkP4NWNySYcM34mEzgKXXQ6Qtd+nViXMM87OeQnxkJT1kGrsLiQODYghGvCOQ==
X-Received: by 2002:ac8:7296:: with SMTP id v22mr20359236qto.239.1591561272023;
        Sun, 07 Jun 2020 13:21:12 -0700 (PDT)
Received: from skullcanyon (marriott-chateau-champlain-montreal.sites.intello.com. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id h77sm5633202qke.37.2020.06.07.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:21:11 -0700 (PDT)
Message-ID: <572f23d1945a685bf899e96de147454f31674ae1.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] media: uapi: cedrus: Fix decoding interlaced H264
 content
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>, devel@driverdev.osuosl.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>
Date:   Sun, 07 Jun 2020 16:21:10 -0400
In-Reply-To: <CAAEAJfDFMzMkDkN7zzNvkwsmYzgQPNGkP=dhW7neycYYRBJzHA@mail.gmail.com>
References: <20200604185745.23568-1-jernej.skrabec@siol.net>
         <CAAEAJfDFMzMkDkN7zzNvkwsmYzgQPNGkP=dhW7neycYYRBJzHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 06 juin 2020 à 09:46 -0300, Ezequiel Garcia a écrit :
> Hi Jernej,
> 
> On Thu, 4 Jun 2020 at 15:55, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > Currently H264 interlaced content it's not properly decoded on Cedrus.
> > There are two reasons for this:
> > 1. slice parameters control doesn't provide enough information
> > 2. bug in frame list construction in Cedrus driver
> > 
> > As described in commit message in patch 1, references stored in
> > reference lists should tell if reference targets top or bottom field.
> > However, this information is currently not provided. Patch 1 adds
> > it in form of flags which are set for each reference. Patch 2 then
> > uses those flags in Cedrus driver.
> > 
> > Frame list construction is fixed in patch 3.
> > 
> > This solution was extensively tested using Kodi on LibreELEC with A64,
> > H3, H5 and H6 SoCs in slightly different form (flags were transmitted
> > in MSB bits in index).
> > 
> 
> So, if I understand correctly the field needs to be passed per-reference,
> and the current per-DPB entry is not good?

For interlaced content we reference fields separately. That's the
reason there is 32 entries in l0/l1. Though, as we decode both fields
in the same buffer (interleaved), the DPB indice is not sufficient to
inform the decoder what we are referencing. Understand that a top field
can be used to decode the next bottom field. This even make sense as
they are closer on the capture timeline. This covers slice based
decoders.

The flags to indicate presence of top/bottom fields in DPB array seems
only useful to frame base decoders. This is so that decoder can avoid
using lost fields when constructing it's own l0/l1 internally.

> 
> If you could point at the userspace code for this, it would be interesting
> to take a look.
> 
> > Note: I'm not 100% sure if flags for both, top and bottom fields are
> > needed. Any input here would be welcome.
> > 
> 
> Given enum v4l2_field is already part of the uAPI, perhaps it makes
> sense to just reuse that for the field type? Maybe it's an overkill,
> but it would make sense to reuse the concepts and types that
> already exist.
> 
> We can still add a reserved field to make this new reference type
> extensive.

I think it's fine to create new flag for this, as your solution would
require extending a reference to 24bit (this patch extend to 16bits).
Though indeed, we could combine frame and TOP and reserve more bits for
future use.

> 
> Thanks,
> Ezequiel
> 
> 
> > Please take a look.
> > 
> > Best regards,
> > Jernej
> > 
> > Jernej Skrabec (3):
> >   media: uapi: h264: update reference lists
> >   media: cedrus: h264: Properly configure reference field
> >   media: cedrus: h264: Fix frame list construction
> > 
> >  .../media/v4l/ext-ctrls-codec.rst             | 40 ++++++++++++++++++-
> >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 27 +++++++------
> >  include/media/h264-ctrls.h                    | 12 +++++-
> >  3 files changed, 62 insertions(+), 17 deletions(-)
> > 
> > --
> > 2.27.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

