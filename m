Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BD42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRtFKgLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgG0ODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0ODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:03:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA62C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:03:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so14972754wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WCEKn5HIi3V8G0rZbufJIlt299Gd3FsBGNnqE5NUYlM=;
        b=GRtFKgLTNf5V163dHCAuyVNJp3fkYfiToHPg5XpQwDb3xpSF9j9hRzf5H5xvjmyb7Z
         ZJW4AMQyj9iKpH2AGJP7caGraDn1nCap13ZHQyUd2HeSjWiVchiJxnetatMVjEbiKNfj
         nu/wXJm7iHFGfvfC6I3ZRT9J0HtU6j2hh0iRvO1rGEok7eMtMbMmw7S4TlUPR1PDcoYB
         Df4WC8Z4wxpuccr/BDGu0Db2NfYtPFrIhsWQogYrVUB17mcISCO64bm0+qBVUCM7Xt0L
         apewBUHPKBWqWG2FcN4lgr3uYwbl0uURGqdsaym27oRp6Su4GFVDn9v9Ufh2cIxNRyfc
         S+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WCEKn5HIi3V8G0rZbufJIlt299Gd3FsBGNnqE5NUYlM=;
        b=cx9qrQEbarTIdcXiSt0kTUjlXBPtNIMZ/NgucVVUmksYmmLXQHE8TNRUHuOgyljBrA
         j4YIjHSUOWDMiDBw1XdsQTjFXQXhfpBfuVh/4pOrqSXOMJXwdA28Wsbw8hNiS0u+xk73
         8daMU8v++DZbMUxYkiWGxocb4UG0IV4ewDF7AzuhUrHZJEsyGmtzyJrWlR0HAl2Vidbl
         hUgMg4gNq++ygbvW+h6a5K4mHl6fv99WXTBR1A+jmEz7wivSfSYq/he3IgDQQWF8oX6A
         VgsZfRuyTx92QGoq7MCY/iQYlRAU/VlSGyQ5AKTCXEMsubO7Dzjy15TM0DEowQG+oy4h
         tENw==
X-Gm-Message-State: AOAM530MgJG83bUPcgE3FBT7mJ+oMnKJSb0dGnLKPwrSh/mSFJds1wN5
        iI3riIQZorRrbyDMakGq6c9wspzliGvIog==
X-Google-Smtp-Source: ABdhPJzxLpXkhwE1OMKy+4MjjkzkiKp+YP0RqS6jZMLOZL4pIgyCAWp98SRFYS5R4F+T2ltxBxl6Aw==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr19669192wrl.176.1595858584978;
        Mon, 27 Jul 2020 07:03:04 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id q2sm8815749wro.8.2020.07.27.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:03:04 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:03:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: dln2: Run event handler loop under spinlock
Message-ID: <20200727140302.GU1850026@dell>
References: <20200723130246.21190-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723130246.21190-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Andy Shevchenko wrote:

> The event handler loop must be run with interrupts disabled.
> Otherwise we will have a warning:
> 
> [ 1970.785649] irq 31 handler lineevent_irq_handler+0x0/0x20 enabled interrupts
> [ 1970.792739] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:159 __handle_irq_event_percpu+0x162/0x170
> [ 1970.860732] RIP: 0010:__handle_irq_event_percpu+0x162/0x170
> ...
> [ 1970.946994] Call Trace:
> [ 1970.949446]  <IRQ>
> [ 1970.951471]  handle_irq_event_percpu+0x2c/0x80
> [ 1970.955921]  handle_irq_event+0x23/0x43
> [ 1970.959766]  handle_simple_irq+0x57/0x70
> [ 1970.963695]  generic_handle_irq+0x42/0x50
> [ 1970.967717]  dln2_rx+0xc1/0x210 [dln2]
> [ 1970.971479]  ? usb_hcd_unmap_urb_for_dma+0xa6/0x1c0
> [ 1970.976362]  __usb_hcd_giveback_urb+0x77/0xe0
> [ 1970.980727]  usb_giveback_urb_bh+0x8e/0xe0
> [ 1970.984837]  tasklet_action_common.isra.0+0x4a/0xe0
> ...
> 
> Recently xHCI driver switched to tasklets in the commit 36dc01657b49
> ("usb: host: xhci: Support running urb giveback in tasklet context").
> 
> The handle_irq_event_* functions are expected to be called with interrupts
> disabled and they rightfully complain here because we run in tasklet context
> with interrupts enabled.
> 
> Use a event spinlock to protect event handler from being interrupted.
> 
> Note, that there are only two users of this GPIO and ADC drivers and both of
> them are using generic_handle_irq() which makes above happen.
> 
> Fixes: 338a12814297 ("mfd: Add support for Diolan DLN-2 devices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/dln2.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
