Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754C5C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477F9246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mU4IwRfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgB0WHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:07:10 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42270 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgB0WHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:07:09 -0500
Received: by mail-vs1-f67.google.com with SMTP id w142so694382vsw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqKNDeiMvIdCSL5g1lAtM6a4Ex9LPGPv076qA0QF9lE=;
        b=mU4IwRfVv40ylj1KZhG7HSK0P8maoUVYPcDj7UGjf35I2u77f06PVOHTWkifNWYTUD
         Ys+1AHL6jXPpn+s3M5wfh69RonHgCQ9LuKBfHHginkUEE7V2pgNuUblYdLrPXS7xmS8R
         6intotQ33g5TdMYt7fNsAve6mpUz21gBgX0Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqKNDeiMvIdCSL5g1lAtM6a4Ex9LPGPv076qA0QF9lE=;
        b=s9O4t2/MA6X58DLwmuUR/ySWTXVQ2+xxv1oYGBwK8KXI7bK4u1dLAIWl1Puyah6otQ
         j+XWsW8PLDh9NfS5fFthfSVCTInVpG9SxLJq+nGQ47eYfpVJFXW58JxUCi7utCiJ6Rax
         n3NvS7I+95qSS8GgNNXj+R/ZepYniUHXxSruqUA7NwDdeq3rVnlXMEnOx/VUe+xk5Fbj
         WNUInx/Fu9XJL2YhEqavS8XTAUh229zv3ArfTjrNIb1dsVvQMp6suPCHJQ3v3GsMPmt4
         1YsBj+YjNS0PPThHbjl6xKv1CIEZNO/vjUgsqiu29Pc/fAQu/40GbRlXvsH0iGcS01uf
         TatQ==
X-Gm-Message-State: ANhLgQ11042GPQsH9w6STqVkndkRVOTWBxCDOjm4d2mupp9OkI4jFpAB
        FXC2P0xQNj4WuXBOXWX+leHqa/COBLM=
X-Google-Smtp-Source: ADFU+vuYNY6TKrjhuIz7L/TJ0d6ckzSRrU6uo6vA7T2WbdVSORruRGFOinCmaK3bUIAUPp3WqtOmAQ==
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr877155vsh.179.1582841227731;
        Thu, 27 Feb 2020 14:07:07 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id w1sm290369vso.22.2020.02.27.14.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:07:07 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id t20so250952uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:07:07 -0800 (PST)
X-Received: by 2002:ab0:2006:: with SMTP id v6mr499526uak.22.1582841226616;
 Thu, 27 Feb 2020 14:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-4-linux@roeck-us.net>
In-Reply-To: <20200226210414.28133-4-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Feb 2020 14:06:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UMB8=qxAH=9VCZk-g6iFqPpM2RnrekmTXuqcOrHkVuLw@mail.gmail.com>
Message-ID: <CAD=FV=UMB8=qxAH=9VCZk-g6iFqPpM2RnrekmTXuqcOrHkVuLw@mail.gmail.com>
Subject: Re: [RFT PATCH 3/4] usb: dwc2: Abort transaction after errors with
 unknown reason
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> In some situations, the following error messages are reported.
>
> dwc2 ff540000.usb: dwc2_hc_chhltd_intr_dma: Channel 1 - ChHltd set, but reason is unknown
> dwc2 ff540000.usb: hcint 0x00000002, intsts 0x04000021
>
> This is sometimes followed by:
>
> dwc2 ff540000.usb: dwc2_update_urb_state_abn(): trimming xfer length
>
> and then:
>
> WARNING: CPU: 0 PID: 0 at kernel/v4.19/drivers/usb/dwc2/hcd.c:2913
>                         dwc2_assign_and_init_hc+0x98c/0x990
>
> The warning suggests that an odd buffer address is to be used for DMA.
>
> After an error is observed, the receive buffer may be full
> (urb->actual_length >= urb->length). However, the urb is still left in
> the queue unless three errors were observed in a row. When it is queued
> again, the dwc2 hcd code translates this into a 1-block transfer.
> If urb->actual_length (ie the total expected receive length) is not
> DMA-aligned, the buffer pointer programmed into the chip will be
> unaligned. This results in the observed warning.
>
> To solve the problem, abort input transactions after an error with
> unknown cause if the entire packet was already received. This may be
> a bit drastic, but we don't really know why the transfer was aborted
> even though the entire packet was received. Aborting the transfer in
> this situation is less risky than accepting a potentially corrupted
> packet.
>
> With this patch in place, the 'ChHltd set' and 'trimming xfer length'
> messages are still observed, but there are no more transfer attempts
> with odd buffer addresses.
>
> Cc: Boris ARZUR <boris@konbu.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/dwc2/hcd_intr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Seems sane to me.  Also suggest a "Fixes" or "Cc: stable" tag.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
