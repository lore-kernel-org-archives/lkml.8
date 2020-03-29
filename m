Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8F20733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+giDJM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgC2OrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:47:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38587 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgC2OrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:47:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so13449322oic.5;
        Sun, 29 Mar 2020 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XAc+r1WXKheiyXAD+tO9YztVYErGlJXr5LD1cuVbdk=;
        b=V+giDJM9hafx0Gt/bGQh4dA3RbMgq2ZwWSGnSxdc35Rjixbay2fbmMrKwa7OvZv4oG
         lLNU0Z5V3lGhcxr2mxK7rsZNxoc3tk/Dh60BoKCbtmV8EpLz7+2JYPt4PhW66Oye7T7z
         6DPKlSvF87TvLU+YNzf0YtbKMB/ZrmcJ5N5eJjr+26leq4FrxkDmrjVvUPjwWKFH2viq
         9JipFFPnT/rASEzJcIc3BeN92mK0b8TlzG+k0VesdiJRl2q25UKfHiZzwNJR0AUQJpjW
         jpR7xYAwqaBqTZi0YMqGMxTxWPCi1b8meNyVmTNT1UHIAp4QAd1bzBjtsQnSNWqRNIHJ
         BAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XAc+r1WXKheiyXAD+tO9YztVYErGlJXr5LD1cuVbdk=;
        b=oUPjj8dLld23WWaFPya0T8MFWtApo1R0SVZgCDPNniQMOC19C7Ct4xuXZvrAYErgDc
         kl1PVhjiUtPaRX8HJoI4/UBbWi3hNeVVtY7AjiFHhWuPgPQR+BovB1OnwK+CoLMQUSLl
         vZBRZe2Au0WKH4myE7EieoieL614HeMiQd9/kxclVWm03kwYcLdeAFCHfymLRUdpqcmd
         cycPlYneQJGMPI0uLhvLH5sWHl548dTDeIi1/4IVd3kVXX5Ag6EHPyWkQoAy06dexg/I
         iFy2P9dZn+PD4XjsjXW388jh/6r0c8DYWXFlfI9UNCueNkyXTBOTabvrzX8dMxDYrC5U
         YQjA==
X-Gm-Message-State: ANhLgQ3i04PgMepxHSTf3pIrg+CROlYkK7ncVmFc8dT5/+STxHdUhc8V
        JASrs+SNQv1LcSXNlPAMJ9E=
X-Google-Smtp-Source: ADFU+vsrm8bF82HNWyt+p2He4J7b65vFnhlfXTVbvRrKA3Swz9X01pci1jsivdX3hFEhX9P4YQAyKA==
X-Received: by 2002:aca:aa55:: with SMTP id t82mr4958005oie.147.1585493225116;
        Sun, 29 Mar 2020 07:47:05 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d21sm1743653otp.39.2020.03.29.07.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:47:04 -0700 (PDT)
Date:   Sun, 29 Mar 2020 07:47:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL
 checks in bdc_req_complete
Message-ID: <20200329144703.GA9720@ubuntu-m2-xlarge-x86>
References: <87zhc0j2qi.fsf@kernel.org>
 <20200329011246.27599-1-natechancellor@gmail.com>
 <871rpb4nd1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rpb4nd1.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:43:54AM +0300, Felipe Balbi wrote:
> 
> Hi Nathan,
> 
> Nathan Chancellor <natechancellor@gmail.com> writes:
> 
> > When building with Clang + -Wtautological-pointer-compare:
> >
> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
> > address of 'req->queue' equal to a null pointer is always false
> > [-Wtautological-pointer-compare]
> >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> >                              ~~~~~^~~~~    ~~~~
> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
> > address of 'req->usb_req' equal to a null pointer is always false
> > [-Wtautological-pointer-compare]
> >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> >                                                     ~~~~~^~~~~~~    ~~~~
> > 2 warnings generated.
> >
> > As it notes, these statements will always evaluate to false so remove
> > them.
> >
> > Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/749
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> It's now in my queue for v5.8. It doesn't really look like a bug fix, so
> it's not going in during v5.7-rc
> 
> -- 
> balbi

Thank you for picking it up. It would be nice to see it in 5.7 since
we're enabling this warning and this is one of two outstanding
instances in -next and the other one's patch has been picked up plus the
patch itself is rather benign. Not to mention that I did send this patch
back in October. However, when it is merged into Linus' tree is
ultimately your call so I won't argue as long as it gets there
eventually.

Cheers,
Nathan
