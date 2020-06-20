Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEE9233CF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhgV1qId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgFTDiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732778AbgFTDiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:38:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133DC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:38:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so5012111pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HcObWc1pAc0CzEIfy/Ab93l3HI5nWLBSYzw/kBHBfwY=;
        b=lhgV1qIdumIkMjp9zAF4dHdPgrXIFVHFt+Cc38pwGU4wKuxuWy7t3Nre+sHpGriVla
         ia0lFohFVhdGIpkN3vOb4zlR5TDKv+GgLGNyWVIraSzsTiVYCrf+I1Xp4tWF1zgw8Lkz
         RTFP0UGHV9zsWoyNkG8p1MZaPmeCP93Lm3IC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HcObWc1pAc0CzEIfy/Ab93l3HI5nWLBSYzw/kBHBfwY=;
        b=ZfB4hGCfDrQYrB1Owxhe2QtD7YkWldW0AXO/YurO9aIOhPa0l/uLCllqavV7nMjRgR
         JRZEQh+bYUww5HAx8SXvL0tgr7Tp5iKc+20hTTcfCyFXD6HGqBtVCWjmwj889/oANMJB
         KZOOWaoJrMPG9Lb7ifsgsmJiuEh6R7lSObLrf16yj82uxIG9cmVZ7+sDdEO9wr8CBU8L
         66bdFUee/eC/gYZr+MeV3lB7m1aQEECczYmRpiXxJXRC1l3Ec5zq6PnIe+sfvPvAWhhF
         Fc5g7So/TGrELitRxuBew3Ymk4j0Y+3falmI4r5PcAtmUUasy09bo0IXOyRTXlmgL59/
         WnyQ==
X-Gm-Message-State: AOAM5326AUvCJbK7I1Nq6yWWENX9oGgDwocAheQ5ecCjDNYDa2FU8dny
        yZpN9eNIUmqiOe+0/1m5Qoa8Ig==
X-Google-Smtp-Source: ABdhPJy6m7gEuO0EEGifM2oVB4op2VgxIdj0c/pwvE0F4pJDMkyR74gSJh0ct/N06naCetuf7Ub2Eg==
X-Received: by 2002:a17:902:a587:: with SMTP id az7mr11015643plb.278.1592624300090;
        Fri, 19 Jun 2020 20:38:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8sm6323027pjr.41.2020.06.19.20.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:38:19 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:38:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Charles <18oliveira.charles@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
Message-ID: <202006192035.81C1F7E2C4@keescook>
References: <20190613180824.6ajwjelzr5fmjnie@debie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613180824.6ajwjelzr5fmjnie@debie>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:08:24PM -0300, Charles wrote:
> Avoid following compiler warning on uninitialized variable
> 
> In file included from ./include/linux/rwsem.h:16:0,
>                  from ./include/linux/notifier.h:15,
>                  from ./include/linux/clk.h:17,
>                  from drivers/tty/serial/sh-sci.c:24:
> drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
> 
> Signed-off-by: Charles Oliveira <18oliveira.charles@gmail.com>
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index abc705716aa0..a6af73eaec11 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1350,7 +1350,7 @@ static int sci_dma_rx_submit(struct sci_port *s, bool port_lock_held)
>  {
>  	struct dma_chan *chan = s->chan_rx;
>  	struct uart_port *port = &s->port;
> -	unsigned long flags;
> +	unsigned long uninitialized_var(flags);

akpm made this same change in -mm, and it's not the right
solution[1]. Please just initialize it to 0 if the compiler can't figure
it out. :)

-Kees

[1] https://lore.kernel.org/lkml/20200620033007.1444705-2-keescook@chromium.org/

>  	int i;
>  
>  	for (i = 0; i < 2; i++) {
> -- 
> 2.11.0
> 

-- 
Kees Cook
