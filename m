Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15EBC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC572076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OknkHI9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCSWNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:13:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:13:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so2030581pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMv6TzKYu6SFIfaWqkANidyDsDf8BBLqM+MeHs0/52E=;
        b=OknkHI9mQD8ADRe3PXx93Kzpyb+ELDkSUgQDRM58h3yDorb4jqoTr2itJgBlfKek+s
         GPG60InKlRJOdBdQbRXSkORE1oKfx5QpKOA2ikoMDq+wPx1Vp4MfouKsNxB8ax9Sa8Kh
         GoqlGK+mRpfHPj8/y5H5V+JBhN3wHH/ObKR6c12R9QEHiQTFx/75EQ1uyo0+m4hHmgRL
         mCaWvmyBcNzi6VNpXVhJ0D1BQ5OGBprC3vwM0Q1og1mu+lInsIW4fNNfCZC+BNb5JZhP
         5gDpqQVMpvdqnczGDRKX5rYJWkSSFCqS9mpBtRj6u6hjo4oUaO1awKjC2TYh68Su8m7n
         9ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMv6TzKYu6SFIfaWqkANidyDsDf8BBLqM+MeHs0/52E=;
        b=pSUVZNw2GrqPXgg213hphi/8rhB0/fFRdwv5HftC9RDcdft3a7BZYk2F8w70Bo53m2
         9u4So96dcvkxc8Bjpa5bK+FB9PmQYC7Hghv2bgkNv0rn9Fx19do/dWdc9zWlg8vQGccY
         8yVCz37IDthofCiaXz1ZAhF/Ys9Zaf1vGBmooeE04Fv/u3DSfTVnNNb9tR+rZ55lVCNA
         WXEGDUx/HiBGplS4VwaiG0l3iL5sPP12jRGjwQevKSNzT9qmn3vBh+cyZTNGTrLQQfkh
         Rp92CHHaxBXSWxOaoQmkAicf66g41Kl12L8IvUjM6Vgbf8ceTrNfyPrtr/UI0Azhncf9
         5F/g==
X-Gm-Message-State: ANhLgQ2LM7KgBm8HzPcyu2Kdsqwu3SYUG5cRHgP+n/Td6AAEQqmQC674
        Jd/Ft6zTzQj7SwQwDQu6MGPwZ676/X3/mW9U0TboJA==
X-Google-Smtp-Source: ADFU+vvD5egTSmzMoHmdQi9kOUIOr8+dusOSqQuDB+SrijkXeLWWVcykJ42cVxTC9e1X1i9nWivq0maEcDklqSk66Ig=
X-Received: by 2002:aa7:8745:: with SMTP id g5mr5989851pfo.306.1584656010721;
 Thu, 19 Mar 2020 15:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584655448.git.andreyknvl@google.com> <6206b80b3810f95bfe1d452de45596609a07b6ea.1584456779.git.andreyknvl@google.com>
In-Reply-To: <6206b80b3810f95bfe1d452de45596609a07b6ea.1584456779.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Mar 2020 23:13:19 +0100
Message-ID: <CAAeHK+xtO_A7WGFxYiJ9P9+_6B7r2E6MCoq+EhsBe0dDj=r2WQ@mail.gmail.com>
Subject: Re: [PATCH USB] usb: raw_gadget: fix compilation warnings in uapi headers
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Mark usb_raw_io_flags_valid() and usb_raw_io_flags_zero() as inline to
> fix the following warnings:
>
> ./usr/include/linux/usb/raw_gadget.h:69:12: warning: unused function 'usb_raw_io_flags_valid' [-Wunused-function]
> ./usr/include/linux/usb/raw_gadget.h:74:12: warning: unused function 'usb_raw_io_flags_zero' [-Wunused-function]
>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/uapi/linux/usb/raw_gadget.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
> index 00cbded71061..ea375082b3ac 100644
> --- a/include/uapi/linux/usb/raw_gadget.h
> +++ b/include/uapi/linux/usb/raw_gadget.h
> @@ -66,12 +66,12 @@ struct usb_raw_event {
>  #define USB_RAW_IO_FLAGS_ZERO  0x0001
>  #define USB_RAW_IO_FLAGS_MASK  0x0001
>
> -static int usb_raw_io_flags_valid(__u16 flags)
> +static inline int usb_raw_io_flags_valid(__u16 flags)
>  {
>         return (flags & ~USB_RAW_IO_FLAGS_MASK) == 0;
>  }
>
> -static int usb_raw_io_flags_zero(__u16 flags)
> +static inline int usb_raw_io_flags_zero(__u16 flags)
>  {
>         return (flags & USB_RAW_IO_FLAGS_ZERO);
>  }
> --
> 2.25.1.481.gfbce0eb801-goog
>

(Sorry, accidental resend, please ignore.)
