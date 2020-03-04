Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE86C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905C62073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxsZeNI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgCDBhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:37:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52973 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgCDBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:37:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id lt1so157998pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpYmXvRb3X1IttU7A8yHjd4RhEypbmbgRIYWPYo+DqM=;
        b=VxsZeNI3Syj7iboIQxJxZI9ybRfCz86rYEwBbH1AsDXtFfX6/zyIGMedLNsnkEEtEi
         ApEJBn+OvT/x4NTMeMvxGPUjhyJg+AOswN3Vd0Ghej2tDGLiNgnHbkvqumwGTZ2CvBBM
         fcurnqvi1KQOouFysKBEbtE0qTmVqJfS9acQQ6pllC2CPSL4RhQQWM29zyn+zGvSTqXO
         /KJbEXinbuwavgh+yjvFodofL+vUNOsMdZfuugssjtWHOAHNbojkQPRpWH9XlexLR72h
         W7uKDGA0A3njS3lXpEFDnZYWU8UZa6oKsGhEzwOMJVjT5+Uqj77mV2nrt03EvaRf+Ptl
         YsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpYmXvRb3X1IttU7A8yHjd4RhEypbmbgRIYWPYo+DqM=;
        b=GLZlgyDEt0WWkuKYP8nP6soMdwYbW0PVsLs/o36g5InqX23SywzmPt3PKKUfkAJV+f
         ubxDBlpl2noughmPaL8lT3sAGBZUVBfwn0zG8TRVGc8/DsTMgp8q9Z2EnWkdOqrpgW5G
         bE/QH2Q9SFkFi/9zwz6jjAq08kohwsmL3U0euNyJs4Wi1liAti+gQk+klVt/9UHFDZfd
         v4T4FjTZeAmIeWJOSFaZwIYaSc6M0ZfRbLJyT+wlU75Many1gFq+uWBwX/qtFaAeLdi3
         +ZKA8EEHHhSiC2KSoLCmZKmLj3EVFNzrbG3DbEvhJ3mS8Ic49tAd1xM2/JJOeGjgKhXG
         Q26Q==
X-Gm-Message-State: ANhLgQ1dPHhRVU+KWGormzHcDbchKfJe0oOOeVVGfNzxjPPxv7/mIVFv
        s4gK6tx7LuRkcyNFB6/I1IWNb8R9Xs0=
X-Google-Smtp-Source: ADFU+vvLcB3AURPRZa98YpmFbW3Y/I3fKBg0YZYrNUt5ritj0guLOxr9Lnw95nWASTeKyRGdwNKLdQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr760458plp.304.1583285834188;
        Tue, 03 Mar 2020 17:37:14 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id c3sm26006283pfb.85.2020.03.03.17.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 17:37:13 -0800 (PST)
Date:   Wed, 4 Mar 2020 07:07:11 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v5] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200304013711.GA5470@afzalpc>
References: <20200229153406.GA32479@afzalpc>
 <20200301012655.GA6035@afzalpc>
 <c2c04a29-4fc8-7cb5-6cc6-5bc3b125d047@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c04a29-4fc8-7cb5-6cc6-5bc3b125d047@linux-m68k.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Mar 02, 2020 at 11:32:53AM +1000, Greg Ungerer wrote:

> I have retested and everything works as expected, so:
> 
>   Tested-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> I have applied this to the m68knommu git tree, for next branch.

Thanks

> >   void hw_timer_init(irq_handler_t handler)
> >   {
> > +	int r;
> 
> You used 'r' here as the error return value holder.
> But in the previous cases you used 'ret'.
> I would have used the same name everywhere ('ret' probably being the
> most commonly used in the kernel).

That was a circus to dodge 80 char limit, i did think about it while
making the changes whether to do or not. If 'ret' is used request_irq()
line had to be split to two, slightly affecting the readability and
since 'r' was a local variable (though conventionally 'ret' or 'err'
is used) went ahead that way. Even if 're' is used as the local
variable, it would be 81 chars ;)

Let me know if you want to change it.

Regards
afzal

> > -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
> > +	r = request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL);
> > +	if (r) {
> > +		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
> > +		       ERR_PTR(r));
> > +	}
