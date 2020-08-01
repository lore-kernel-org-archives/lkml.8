Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F120A2072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeWs6jKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgHABmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:42:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:42:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w126so15138651pfw.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=54Xb86doBYI3Gzy/6NwUgNMzY24kCE7OJF55vTZ8zhY=;
        b=OeWs6jKdSZLAirvOWVY/6f23H3mJ1D8USpnZg7aJLUAtwu/4Ogt8Lo8OhEY944D13G
         jCh8w87bGjNKVJdvyr/8/JJR0lmo3xAJ2pQ3dkBpezyyUYzfpMHylaQsc9/qzrGXOr46
         NnS2ZAYEGtNDN+u/GPr/pv02qvhnreyGbk3jHQdryVEL3U5hVZt7K2+YwquOpGfi/jad
         dsSQd+DcFfy7C0Z5bplnX9NKtrrVrVnvupqUfzHiVBzS2fNs2i8eIUgI631vKktnBE2f
         8/AxRROlatrCb4bBLaRxkMGmx5fuMkzUnEhzlh+3Cm6rCziv+MUNz79+1zXr4sEH7ZB4
         d0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=54Xb86doBYI3Gzy/6NwUgNMzY24kCE7OJF55vTZ8zhY=;
        b=EHg4prwiuDv05R4wGGfUlRgY2xYzKheZUrzeXX+7UzzQUz/EeNPKpI67TCsjHn31/h
         6R2OSvv4jNm//jG19/Rm5UiFvlkrQqdGnw05ytujDJUakxLFgKJRDoalAnoBEPfhFgmz
         JhPaa9Va8U9g3+7updX/fDBPxEBImXDCNL9us5ocSDDNjAQj1d91+iphFBwo/8mWvZoT
         1ffMNL+anYE7YlBs7mPgqIQbhHTZ0qlkogcF6c81okjoGCjtu3CPDBXW6IoJmYBEvK91
         cQCoKUFuKwyFVVsBp8x442U9/AbJLaSG6zvnFUW/G++MdrHpiEHkjDJExeWen/FPy9co
         8aRw==
X-Gm-Message-State: AOAM53351SFo+B2kBaLmv3GtLBZUMFoEkv2YMfE+yYN/iOj7lFYwtMyY
        gK9fSOcm5W5DVK37jCUc5L4=
X-Google-Smtp-Source: ABdhPJyE56uyvkGh1pbvLmynjWmgPMv3OlI+cQ0tX6flUN4cLZXPIm/5GSOb2ypExsvj2SDCge0NQw==
X-Received: by 2002:a63:7251:: with SMTP id c17mr6226568pgn.101.1596246138401;
        Fri, 31 Jul 2020 18:42:18 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id v3sm12365649pfb.207.2020.07.31.18.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:42:17 -0700 (PDT)
Date:   Sat, 1 Aug 2020 10:42:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
Message-ID: <20200801014215.GD796@jagdpanzerIV.localdomain>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
 <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
 <f8f423cd6afeca88cfa635f20a0b2bf85ddda3c5.camel@perches.com>
 <20200731164809.352f4b89@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731164809.352f4b89@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/31 16:48), Steven Rostedt wrote:
[..]
> > > -	static const struct printf_spec num_spec = {
> > > -		.flags = SMALL,
> > > -		.field_width = -1,
> > > -		.precision = -1,
> > > -		.base = 10,
> > > -	};
> > >  
> > >  	struct printf_spec str_spec = spec;
> > >  	str_spec.field_width = -1;
> > > @@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> > >  			str_spec.precision = precision;
> > >  			break;
> > >  		case 'p':	/* phandle */
> > > -			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
> > > +			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);  
> > 
> > Could changing .precision = -1 to 0 change any output?
> > 
> 
> static const struct printf_spec default_dec_spec = {
> 	.base = 10,
> 	.precision = -1,
> };
> 
> 
> It's the field_width that changes from -1 to 0, which shouldn't cause
> any issue.

That's a good question, both .field_width and .precision are now zeroes,
and not -1. But it seems that this doesn't change anything in the end.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
