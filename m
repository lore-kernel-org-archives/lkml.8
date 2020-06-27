Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2A20724
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dh4JYSM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgF0QLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:10:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D44C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:10:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q90so5443025pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmqzFZ1buIwT4xrRi2FIHyllUAjbkOAd/H/8HxkAW6U=;
        b=dh4JYSM4NRBR8w2L+qg0N6eb1ocUwJuefZCDJ8ZAsegTTsNUdCHDIcY2KsJTT14RgX
         lmeulxGNpq4ng/Fmwb1zgiNrDYW0uFB4egI29Rc7jTu1T59KcyRuyhT/Zn9yPJpRPuSQ
         E5NYbzcoNWjOrKIiJt1IMVILm4RHgsJF72yjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmqzFZ1buIwT4xrRi2FIHyllUAjbkOAd/H/8HxkAW6U=;
        b=b57QZdSS8LKnl9XMKEww5bW66mRJRx8duSZN6zNAXTVKHd3MGjaoeFuxTaHDn9HCuj
         93K911rJnyxo0R813XXyO3e9xdy/TLpUGmi/P0iUb5X6qj5OSrgdQOUXPBivdjAqpLdp
         KYA81rTBorJo/6CQV0cVMUi958ZUmxGgzejKgjCAN4+rq/bJJhR8LHFRTJD6wvJeVBng
         GoZeHjaXTohVvJIWmmyEJ0RewYf/lVEAuft5KOshc+Jk/VJgEULk63Wux1WCVJNIvOQG
         hn37e5fsyb5IzF3yTcprhRAvbykK52234FWCIj9ZfsgU7eWnEEGm/v9R9qcD0ngzwreE
         ZuKA==
X-Gm-Message-State: AOAM530z1omcN0kdNmF1RownAVSymNgpKaN00tBcaFJasivcHTLcbcIC
        OU6o+aYdxcKnerratcK1tIHZxg==
X-Google-Smtp-Source: ABdhPJxvFEkA27nw2gBUVjy1fli8GztX/RD0yA8MQhKOnpjbbyyo6aVteBGz+IF4Z8iHZdIMOvTrXg==
X-Received: by 2002:a17:90a:35c:: with SMTP id 28mr1653573pjf.63.1593274258994;
        Sat, 27 Jun 2020 09:10:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13sm7074448pjy.40.2020.06.27.09.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 09:10:58 -0700 (PDT)
Date:   Sat, 27 Jun 2020 09:10:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Message-ID: <202006270853.C40CA89806@keescook>
References: <20200627125417.18887-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627125417.18887-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 02:54:17PM +0200, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, remove all the function callback
> casts.
> 
> To do this modify the function prototypes accordingly.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>

Oh yes, the tasklets! I'd love to see this fixed correctly. (Which is to
say, modernize the API.) Romain hasn't had time to continue the work:
https://lore.kernel.org/kernel-hardening/20190929163028.9665-1-romain.perier@gmail.com/

Is this something you'd want to tackle?

> ---
>  drivers/s390/char/tty3270.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 98d7fc152e32..aec996de44d9 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -556,8 +556,9 @@ tty3270_scroll_backward(struct kbd_data *kbd)
>   * Pass input line to tty.
>   */
>  static void
> -tty3270_read_tasklet(struct raw3270_request *rrq)
> +tty3270_read_tasklet(unsigned long data)
>  {
> +	struct raw3270_request *rrq = (struct raw3270_request *)data;

Regardless, this is correct as far as fixing the prototype.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
