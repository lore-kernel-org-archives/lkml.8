Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D8206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfcENy/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgF2XiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgF2XiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:38:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCCC061755;
        Mon, 29 Jun 2020 16:38:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so8391754pje.4;
        Mon, 29 Jun 2020 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDmndeuf6+uwXZ1m8jycymUjCeI0m9qm4ZAV+tpUoqg=;
        b=hfcENy/nu+8E+qPHtGgHggPo6FrtxlNt1g3/qmAgrr2o/GeOEqJpOKezxPVlV2RrRh
         0KzMSRt54d77uU3CRpOsadNGCSfoFK6qKedJodEwFFHR0W/ZF5AQzl06oNG3A3o+KFEn
         MzKOf00Bp6rabpwXlPL5ygB6sxRt8CRt9wZM3XAODkEaa56JTdG16bmehUOHrMm/ZX89
         s7hvtrUVekSR3hNK4AVPO83dr5GpeL6ncNfFHhKSgoXQ+frCdgB3GxuQ0GwG1mmNoWZL
         F5yTQyy1amwtjAv9UtHUwiQpqAWx/D64f6YQW+qYlYLJn5apqAZIQMWwX2+/etDOzU8X
         X0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDmndeuf6+uwXZ1m8jycymUjCeI0m9qm4ZAV+tpUoqg=;
        b=SRTIaQDAt2G8c/jLDMjy4gJxDjI9HqjtHDlfZ+TpfsYhYIkvjls5R5e17Uz72cSQbC
         bJL84BVDAoDZOoi2LiokUXvbeEw1On0hZS9aZa2IsI3I4ESqIeHEUAH+of8qn7B1/WyG
         HT0NzhOmoxXfKF/hPS/ZwPOr2G5cKYGBVqGJ85xsJQo0MZ4SW+JsK7vxvZ+9KYbGB5OV
         CRTKvElr+6iy1QBgjpjW89tTmC2Z0uXDWVtXuouL6v/2qwVb/N6vYmi3uFqH+DQAbTbp
         HvARRTxAi2ktXneKA9svoA3EPYlCylJJnDJ6y9LqZst2wNR/Tx113pBgawfuUcsCJQyu
         rBjg==
X-Gm-Message-State: AOAM530lsp0t0DB13jWjgVHMdgNI6rFCXD073tMGXzaaQtO0t0r9IZOO
        abDSEyJ8kMj/lJtbHGBedQ8=
X-Google-Smtp-Source: ABdhPJw6Bo4vFRwwv/fuSCRqDQFKj4SZC42yqkHiNSoyybyL4QJ4pKH13OihOF5unIFYUS8sr+jhfg==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr20182148pjo.85.1593473884458;
        Mon, 29 Jun 2020 16:38:04 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x69sm637205pfc.144.2020.06.29.16.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 16:38:03 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:37:57 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: gadget: fix langid kernel-doc warning in usbstring.c
Message-ID: <20200629233756.GA25245@taoren-ubuntu-R90MNF91>
References: <b49b7e07-8986-f185-3a99-a088419a532b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49b7e07-8986-f185-3a99-a088419a532b@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 08:08:03PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix spelling of the 'langid' function argument in the kernel-doc
> notation to quieten a kernel-doc warning.
> 
> ../drivers/usb/gadget/usbstring.c:77: warning: Function parameter or member 'langid' not described in 'usb_validate_langid'
> ../drivers/usb/gadget/usbstring.c:77: warning: Excess function parameter 'lang' description in 'usb_validate_langid'
> 
> Fixes: 17309a6a4356 ("usb: gadget: add "usb_validate_langid" function")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tao Ren <rentao.bupt@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>

Thanks for the fix, Randy!

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>

> ---
>  drivers/usb/gadget/usbstring.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200626.orig/drivers/usb/gadget/usbstring.c
> +++ linux-next-20200626/drivers/usb/gadget/usbstring.c
> @@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_get_string)
>  
>  /**
>   * usb_validate_langid - validate usb language identifiers
> - * @lang: usb language identifier
> + * @langid: usb language identifier
>   *
>   * Returns true for valid language identifier, otherwise false.
>   */
> 
