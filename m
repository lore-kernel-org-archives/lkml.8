Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90DC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00A42073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YU+6u86+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgEEOFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgEEOFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:05:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1351C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:05:35 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t12so1953210edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQhPVNzCwxODV9jjVycfNahbwJl6DrUIjQ9AnoCrWCs=;
        b=YU+6u86++6VWtYwNPHyc1ME4CNkzeonYAyS/jdldZueht1JjMExBXKZ2fwCZZnMaZI
         ZhkNfG4Iq7Wa8TgqlSCI9rUl8C2Q7X0XofiEN2if0Co5+gwFJU/5PxOH4YrwKBPJ5sGz
         zyiacbV9r11JC/U44S4xnE/s0Ymar0Oax5aJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQhPVNzCwxODV9jjVycfNahbwJl6DrUIjQ9AnoCrWCs=;
        b=l2kpgnuaxdUih4SKRNq637HdzUpSZKJ4NtYz6wQQxe1eAJ7av+jbeY82WArRPzABX3
         Yh+PFvujqB2fHoLWMZ+hh8fmXLdbtpEQt1yLfPt6yHducQs3ysMwFhXEO4MlMZT0ysGU
         K9lUyYfE5QOc/DSbJ1ZvcFdlbGOL8Cj9QImJsJUrjFlWOrWguiSvSa+rjsbIC9Lb5BsL
         Dma+5iMIahy9Z5ad54pDGEFloOpAf7dXAceDQFwsk9NFHGn1YCpo4cR59IPYkmh4fAKn
         sxPztQVQjT6yTvMgFa6HDCCoAelJhIplJu+v/VjBwkwBYRj3Ml64SNrLO06u//7m9S1P
         TkxA==
X-Gm-Message-State: AGi0PuYC8Kj5WQynKh8mv6T6Ag2SAMfokkyLqfMpW2WUDjkLDj/NzEO+
        owFqi2FojaXhXJ0Bxo1f/88pDpMDRK3q/g==
X-Google-Smtp-Source: APiQypJvAdJ5T9ubYe6ooTQjRkaVi9jVob+Ai8aRYPfxkoAB72ZN9Pbp52HoNAJ3M6IZ4PRE/sFlWQ==
X-Received: by 2002:a05:6402:22cd:: with SMTP id dm13mr2890372edb.56.1588687534319;
        Tue, 05 May 2020 07:05:34 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id k24sm326357ejv.15.2020.05.05.07.05.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 07:05:33 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id f13so2866221wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:05:33 -0700 (PDT)
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr3926804wrs.415.1588687532834;
 Tue, 05 May 2020 07:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134110.3435-1-ezequiel@collabora.com> <20200505134110.3435-2-ezequiel@collabora.com>
 <CAAFQd5AWZFoPk2YTp2k8M7LvJshxw46-z+wK2VoM9EzB2CqiFA@mail.gmail.com> <c29fcc922a4917ac695043e605973ba9649f9c9b.camel@collabora.com>
In-Reply-To: <c29fcc922a4917ac695043e605973ba9649f9c9b.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 5 May 2020 16:05:19 +0200
X-Gmail-Original-Message-ID: <CAAFQd5A458E8iqwakKTDEyTHC+NYY-M1SaTS3m0MARwPaRyOuw@mail.gmail.com>
Message-ID: <CAAFQd5A458E8iqwakKTDEyTHC+NYY-M1SaTS3m0MARwPaRyOuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: rkvdec: Fix .buf_prepare
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 3:59 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Tue, 2020-05-05 at 15:56 +0200, Tomasz Figa wrote:
> > Hi Ezequiel,
> >
> > On Tue, May 5, 2020 at 3:41 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > The driver should only set the payload on .buf_prepare
> > > if the buffer is CAPTURE type, or if an OUTPUT buffer
> > > has a zeroed payload.
> >
> > Thanks for the patch. Just one question below.
> >
> > Where does the requirement to set OUTPUT buffer bytesused to sizeimage
> > if the original bytesused is 0 come from?
> >
>
> If I'm reading english correctly, it's here:
>
> https://www.kernel.org/doc/html/latest/media/uapi/v4l/buffer.html
>
> """
> The number of bytes occupied by the data in the buffer. It depends on the negotiated data format and may change with each buffer for compressed
> variable size data like JPEG images. Drivers must set this field when type refers to a capture stream, applications when it refers to an output
> stream. If the application sets this to 0 for an output stream, then bytesused will be set to the size of the buffer (see the length field of this
> struct) by the driver. For multiplanar formats this field is ignored and the planes pointer is used instead.
> """

Okay, thanks. I wonder if this shouldn't be handled by the core,
though. Especially given that the document refers to the length field
specifically and not the sizeimage set in the format.

Best regards,
Tomasz
