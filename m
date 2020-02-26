Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DEC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DD320838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582711937;
	bh=7BzpNwQ1a5JrXGbiNy55HvIpNqq+r0KUKA8v0I80ooU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akYhg0VcHaZeRxNsSub38CKZdTkXYldnCq3j2LkjiK87oooyzbFBuTS2R9dd2CPCt
	 KgBeChrgUMxgvdl84kCguAulxXx/Lqk1iWyMps78hBbLWPPiuZ8VgVo7XcivJSa/SK
	 P/ITxy+FiB0o+SeE67e5el88YnlQoM43xfhT+wWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBZKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:12:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42634 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:12:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so2386289ljl.9;
        Wed, 26 Feb 2020 02:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgtf/Yh5fw23zpaM+oJehFHDgy9iRIzBJZORq8BS8yI=;
        b=PLRgKZUV/08PUhQyG4rmFZIssdWccwYnZ668dHkt1UQesKfWojVohKUN7vlMeyGHDF
         VB4jx27JvV6fvheOUOXgq4fq1B9jA8dGj4sfpqciAVe6+0Ikx5ZrS8kFT5wb2Opq1cbD
         6Bh/Wge5k6Rb2EIQEXBg5wrw/Nmx8cXW1Jojkt91iCu8Y8nsS0nTp/Hp8HBLMfO24cb/
         68Pf/VRYu7iy4k7fcrhnNm429obDygBR/xrJAMYgNafQVetPEp+bVBpG2L2g5AYEKsNA
         y/psiR4L6t4pPyRdUhF0zGlTKsr83PWEP8TQn2hqXmqUkXhA1H0Ry2xg0zBs6Gc4RWxw
         8KXQ==
X-Gm-Message-State: APjAAAXIhuTHc0PQXgsbXSj4w/LGB+pd9tmOKkOBZjc8x3AOVSCt3Bb7
        EtbaZWemcK28RvLhzXNNjLOVRauL
X-Google-Smtp-Source: APXvYqwI2EXm7w460uhNh1RP7Gen+GVUesLpFxmO5pbpK3KyTAxQW9Xcok2OwdQ9D4n0ksEEL2GhRg==
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr2568866ljc.246.1582711934119;
        Wed, 26 Feb 2020 02:12:14 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id k1sm797019lfg.20.2020.02.26.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:12:13 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6tfo-00050N-Tv; Wed, 26 Feb 2020 11:12:12 +0100
Date:   Wed, 26 Feb 2020 11:12:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/2] USB: core: Fix potential memory leak in
 usb_get_configuration()
Message-ID: <20200226101212.GX32540@localhost>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
 <1582697723-7274-2-git-send-email-yangtiezhu@loongson.cn>
 <20200226080906.GV32540@localhost>
 <c7dfaa07-dd34-600d-2a69-95a65f966dfc@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7dfaa07-dd34-600d-2a69-95a65f966dfc@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:42:55PM +0800, Tiezhu Yang wrote:
> On 02/26/2020 04:09 PM, Johan Hovold wrote:
> > On Wed, Feb 26, 2020 at 02:15:23PM +0800, Tiezhu Yang wrote:
> >> Make sure to free all the allocated memory before exiting from the function
> >> usb_get_configuration() when an error is encountered.
> > There's no leak in this function as far as I can tell. Any allocated
> > memory is released in usb_destroy_configuration() when the last
> > reference to the struct usb_device is dropped.
> 
> Yes, you are right, the allocated memory in usb_get_configuration()
> will be released in usb_destroy_configuration().
> 
> By the way, is it better to release the allocated memory as early as 
> possible
> in usb_get_configuration()? Just like this:
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index bb63ee0..dd4ebeb 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -885,12 +885,17 @@ int usb_get_configuration(struct usb_device *dev)
> 
>          length = ncfg * sizeof(char *);
>          dev->rawdescriptors = kzalloc(length, GFP_KERNEL);
> -       if (!dev->rawdescriptors)
> +       if (!dev->rawdescriptors) {
> +               kfree(dev->config);
>                  return -ENOMEM;
> +       }

No, there's no point in that. And just like your original proposal, this
would also introduce a double free.

Johan
