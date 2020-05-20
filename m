Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC87C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876EE2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ys5fYNwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgETRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgETRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:19:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21683C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:19:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n15so1634613pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2xLidJ0hnI935YYnFtWGyJUIRc3KTILqlbh4Uyn5Nk=;
        b=Ys5fYNwkAiCwQkbSl8A3xSidKXPIBkiPCsRQK1/xAMFnfuu0DH+Kcia9BOzgsHgvB2
         hY+gBAkOB3dZsJ/IlBVMbWTXJoUOxzkHjcKnnPpO2LIhlL7NT0kyHrVGRi5dcUWusETo
         ekDBfTEYDJSK6LwPWl39lHOJX+hCyNytLRhjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2xLidJ0hnI935YYnFtWGyJUIRc3KTILqlbh4Uyn5Nk=;
        b=pJuHsuOwodnpgD4R9NFHu3S8b0dudmQUglwZ32bdE7qopkAmLtOXSzTZ6dtm8OHKOp
         YX7qfyfW5uEvtCsLb6ooLvip3txqpA1081zlZauUlJYQxVsEejEEibp8mzDX2OfNYUEs
         YzEoLycQaqsxE9RgPtzqKpN/qbZuQj5UP0sJ0CVnH59BYPgg86W/J8xN3WXHNp3Hpk8y
         THdmfFtm4/1OxQn7s35WiKm7RELBZrKbXKHBUXPWe/Vm8CyY15ek7Lpgz6c+KU71iHDy
         gq404DEKQZCypWzwY6U5AYH8ANL5GPh7wFsP/KS+n7Hhl62uaZXwEKABypQJmOUSGvQq
         Aycw==
X-Gm-Message-State: AOAM530pLNVjSnHtD1VD94vLh7hDG9ImtOw23QYuAmDnAWkbayLQx/Lq
        jZZvyJBhc9WNscgmxrqzMwYu1awsX7Jw2A==
X-Google-Smtp-Source: ABdhPJxS8oFXRCCwkPUhDwoZ7BSTC8ta5ZZ0pp5FVpscOuK3PGI5YPCworulmUIJ9nn6NPqMSVXVdw==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20mr5339806plr.15.1589995149589;
        Wed, 20 May 2020 10:19:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1sm2260026pgb.37.2020.05.20.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:19:08 -0700 (PDT)
Date:   Wed, 20 May 2020 10:19:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
Message-ID: <202005201017.72D1B3A@keescook>
References: <20200518190114.GA7757@embeddedor>
 <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:09:16PM -0700, Joe Perches wrote:
> On Mon, 2020-05-18 at 14:01 -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of one-element arrays in the following
> > form:
> > 
> > struct something {
> >     int length;
> >     u8 data[1];
> > };
> []
> > This issue has been out there since 2009.
> > This issue was found with the help of Coccinelle and fixed _manually_.
> []
> > diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> > index 7af31b245636..993a8ae6fdfb 100644
> > --- a/arch/x86/platform/uv/uv_time.c
> > +++ b/arch/x86/platform/uv/uv_time.c
> > @@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
> >  	struct {
> >  		int	lcpu;		/* systemwide logical cpu number */
> >  		u64	expires;	/* next timer expiration for this cpu */
> > -	} cpu[1];
> > +	} cpu[];
> >  };
> >  
> >  /*
> > @@ -156,9 +156,8 @@ static __init int uv_rtc_allocate_timers(void)
> >  		struct uv_rtc_timer_head *head = blade_info[bid];
> >  
> >  		if (!head) {
> > -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> > -				(uv_blade_nr_possible_cpus(bid) *
> > -					2 * sizeof(u64)),
> > +			head = kmalloc_node(struct_size(head, cpu,
> > +				uv_blade_nr_possible_cpus(bid)),
> 
> It's probably safer to use kzalloc_node here as well.

Hm, I think it's not actually needed here. All three members are
immediately initialized and it doesn't look to ever be copied to
userspace.

> 
> >  				GFP_KERNEL, nid);
> >  			if (!head) {
> >  				uv_rtc_deallocate_timers();
> 

FWIW, I think this change is good as-is. Always nice to get back a
little memory. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
