Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761E4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3C206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhcvqaTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHITBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgHITBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:01:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43926C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 12:01:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so3696566pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCQmffw/i58ICs4V65P0Gmx0jlfMHsHEylHgWzK3pBQ=;
        b=fhcvqaTmn2sVgbdLQ8Q30+/nra5OheM++NBD41UQhMjeydwWokLZcZWkFU2vqd8lhd
         7z/r0bbwCRJFT1+SjKEfbF9/4pVo6toRdfx+D4Wds03ZIpZwwukif2ngVWtJpZWLFnuM
         zT1qKc8xQ2QpIc352ypogFc2e6VOU1kBZd5fjbfrg8M8p5+xdvNl/j9xY9PM48Exg1M1
         HZTgSpJd7asX5fx1T4fLbZrPWrwBerGIlq7stIsnW5fuXEfz6V5AeA37LVzJBXmtYKq7
         M8OOXTKrjmCMjA1/sXDXRbCP+mSf7iZUf/2gYUQ4UhPmyFbWqkLrDNcOhfnpg7BzAA+8
         PZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCQmffw/i58ICs4V65P0Gmx0jlfMHsHEylHgWzK3pBQ=;
        b=pHW5iRTDusnK4ZdmNl0HCsOjsx7D1cu5nDNjM67YiVyae+24l6pu1IteivzlhPYqX4
         zmIaMNoB9o5gvSTzixCBORFkDUAi/fHw10kLq8NxEpxImezoyYNAcyhK3cWC9LeszrOI
         IfQ7wQ85i6sWZ90FT6l85ejWgV6If6LFZFWluFn0Ysh0sNsVnGweWOXpdjlls+XbYVe3
         GI0IsnOXhjtaEqQ5EZ2doRvhWCFA9rEiTDzLF9jMcF2esmhfd3vUol0mINQWhBHpZr8f
         VphA44m+uUry7371q5f4KI8am5qBNO7+6K+jJx+AnUdNXGYBHCUb8jcdlybN4Dd36OpD
         k0lQ==
X-Gm-Message-State: AOAM530+W6oqxs8zSiPcsEIoTup71oahzhFh8CdrA1kZruKAyBnCCP6r
        4EDBTqycOzDDw3bgEhCq6eI=
X-Google-Smtp-Source: ABdhPJwlLXY+ljlvzCGdp+QZRJzeQ/vj/qHJBv+EBWhmfNMBhXm9UCzuLTPrGe0KTx6Uo3BLidy1uQ==
X-Received: by 2002:a63:e747:: with SMTP id j7mr1085881pgk.107.1596999700635;
        Sun, 09 Aug 2020 12:01:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13sm18409857pjl.7.2020.08.09.12.01.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 12:01:40 -0700 (PDT)
Date:   Sun, 9 Aug 2020 12:01:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] macintosh/via-macii: Access autopoll_devs when
 inside lock
Message-ID: <20200809190138.GA133890@roeck-us.net>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
 <5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> The interrupt handler should be excluded when accessing the autopoll_devs
> variable.
> 

I am quite baffled by this patch. Other than adding an unnecessary lock /
unlock sequence, accessing a variable (which is derived from another
variable) from inside or outside a lock does not make a difference.
If autopoll_devs = devs & 0xfffe is 0 inside the lock, it will just
as much be 0 outside the lock, and vice versa.

Can you explain this in some more detail ? Not that is matters much since
the change already made it into mainline, but I would like to understand
what if anything I am missing here.

Thanks,
Guenter

> Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/macintosh/via-macii.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
> index ac824d7b2dcfc..6aa903529570d 100644
> --- a/drivers/macintosh/via-macii.c
> +++ b/drivers/macintosh/via-macii.c
> @@ -270,15 +270,12 @@ static int macii_autopoll(int devs)
>  	unsigned long flags;
>  	int err = 0;
>  
> +	local_irq_save(flags);
> +
>  	/* bit 1 == device 1, and so on. */
>  	autopoll_devs = devs & 0xFFFE;
>  
> -	if (!autopoll_devs)
> -		return 0;
> -
> -	local_irq_save(flags);
> -
> -	if (current_req == NULL) {
> +	if (autopoll_devs && !current_req) {
>  		/* Send a Talk Reg 0. The controller will repeatedly transmit
>  		 * this as long as it is idle.
>  		 */
