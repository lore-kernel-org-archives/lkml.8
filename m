Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA55C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F8C207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8TetLd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETLu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:50:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:50:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so1210532plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rlbHhtSt/xcrvhM5A0GF9wWbU/IcVFxtGWv1ssbgxW4=;
        b=S8TetLd7QvUWWlUuIfALgrinHGwGkbEo7MXvQ5Pr6p5xM8G+aJmUH9qdSF6T39vdk5
         9GC6UHH2xKZdJEJw+IeUzS/SmwEJJGF/TlK/sXi7oFKw2AsDLMKlDTGTWFtdO+IXAi/l
         QeNQhOMAQIFaVwpACzAxfoYBvmYhdIVp8HgG0THaT7QVL4ZxmsC0VQ2joeqsdD8tP17f
         YBTI5+X5MhUR+18tHEOfRaiM4BWOTc10e6G+uq0rSj8jtijrxVN0rUWZFSgPEChCFGRd
         NC509bf9ZsIdx7cmKY5/t48vP2JkD1FilIKhKoq9Sje1lFMtMEaFA4DypVmqnxSwO9Lh
         4EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rlbHhtSt/xcrvhM5A0GF9wWbU/IcVFxtGWv1ssbgxW4=;
        b=MhfTAulOk0NxpmuM8V/TNlj6bBpAgiNaRrC8UjD6evAuCuFV06uRhjKf2uPH3mUCDh
         Zbgc9rjVjqrxw7GgA575bbGh0m7aFpCqfiAUwjZMGHUpwjxmmAj38ehppCwQeCGd2GWB
         uxqe63+tQ+hT4ggawRkPo4zsfyjCz/rkkLpNCrCcc4YtpEtgBaiLs13OYOGM2l3u5JLx
         8hv6I1aPvKakO7OYKIv6zCd0ebXtRJAB5CL0ymSco8PhMvEeWkG19CB37nR7YpMCi4Jz
         rWnyvrUg4it0pBs8W8MmwJfZihHCRUhTxJYPo0qExEN/pRR8gyKoAMa2hbBn2411LBIj
         vxfw==
X-Gm-Message-State: AOAM53263kpMiyODEvbcsGG981bQfQuEfMLQ5B6v6f55Bjj1CjN/LAyy
        q/YP5WtAwl6xuV2aWiXa3vQ=
X-Google-Smtp-Source: ABdhPJyvwje3ym2DY1VDFaUMEqjgLAb6Emnuld42sW4g1ZzV+Kjxu3rq/M9c6qvoGqvh5xdAjvPfvw==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr4213737pls.102.1589975425901;
        Wed, 20 May 2020 04:50:25 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id z5sm2050483pfz.109.2020.05.20.04.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:50:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 20:50:23 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200520115023.GD520@jagdpanzerIV.localdomain>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
 <20200515152418.GH7340@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515152418.GH7340@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/15 17:24), Petr Mladek wrote:
[..]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ad4606234545..e9ad730991e0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
> >  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> >  	char *s, *options, *brl_options = NULL;
> >  	int idx;
> > -
> > +	if (str[0] == 0) {
> > +		console_loglevel = 0;
> 
> What is the reason to set console_loglevel here, please?

Yeah, doesn't look necessary.

> > +		return 1;
> > +	}
> 
> Anyway, for example, earlycon parameter is allowed to be used with
> empty string when the console parameters can be set via ACPI SPCR,
> see param_setup_earlycon(). Therefore I am afraid that every setup()
> function has to handle this on its own and this patch makes sense.

Hmm, OK.

FWIW,
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
