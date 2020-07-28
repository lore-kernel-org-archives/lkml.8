Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96482065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKKf6n8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgG1UEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1UEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:04:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:04:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so19951032qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hB4I8gbXPDAOrRPhS1xStEqtCyznRgbpVs2xbFH4Fn0=;
        b=gKKf6n8XLIBJG3vLHKbPS7KVDqzXFwmDNYwVWBH88E66gNvHvS3fjfCzuLuL3OU4yz
         o5Wsw1rfvufaLj1fKbx7bb5ZsSZFQfhmgQMLGv3a4q4l1GDVFK0nBO7/DNc0nQmVdOhE
         oFm7Wp7H1jCDRP4dAGBgnzilYwxJI9pkuRK3Lxbrdh3j8WNXsLsjWwx7kKZzpzgm2xz3
         Mtilmc7nDIF3RYoUYXNTHBVgBmvbaSZ/sovexVU8r74iktJ1HEay2tRAF+MgWPHB2L9A
         dpQnFISaD3rAp0NppDl3dmmLVBmBMmvRSHYJsjWjVwW//WPq0o6l9T7RXa1iLylq0P9u
         9Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hB4I8gbXPDAOrRPhS1xStEqtCyznRgbpVs2xbFH4Fn0=;
        b=ojIsnwS7Z89Wx/XlvVN3KrFdf6DwSwDqWaniCwlt1rwf/r2GgI8ryOa6Bpac6HvgVI
         /4BJ87AJGjEudX92wXbDIY4JkGsf0grIVbblxZ4/NdqiXTflcC2VvcNws4eu82xLFuJZ
         DpWgwfarsaWw+321Fm7jHMXzYt5AHSFb8ppZn06dNb6gQhQ0pye6kX15Zp0pUE6BejRZ
         ZZ1P6oh9au8Yxb1tvaR4gDPixFTX0whvbckWpduHfJo4Y2o5gUcFCELrXFKizo4eio9u
         zb3hxkezPDvKwIwvHuISoON/82xsO1i30fBEFIxIXTHm2VXz2fEWoqkmAmhkXl5f93IR
         t2gQ==
X-Gm-Message-State: AOAM531OLo4vpIYDeDZL8MUTyFiiWF8WtJWJyGl+2cGxNd0XBq9w0WQY
        e6QiGG/wdPkBgw0M8zuQkO0=
X-Google-Smtp-Source: ABdhPJxatdFA3lKyHiFyIdhYr0HpHcLTz+1t/L2+Xm3ea7W5WGPs3FR186LQIqeNcwSlqMeHh4TQAw==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr29459075qkd.191.1595966688057;
        Tue, 28 Jul 2020 13:04:48 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s184sm6759918qkf.50.2020.07.28.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:04:47 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 28 Jul 2020 16:04:45 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] x86/kaslr: Clean up slot handling
Message-ID: <20200728200445.GC4150860@rani.riverdale.lan>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-8-nivedita@alum.mit.edu>
 <202007281228.B5011DC7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007281228.B5011DC7@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:34:45PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 07:08:00PM -0400, Arvind Sankar wrote:
> > The number of slots and slot areas can be unsigned int, since on 64-bit,
> > the maximum amount of memory is 2^52, the minimum alignment is 2^21, so
> > the slot number cannot be greater than 2^31. The slot areas are limited
> > by MAX_SLOT_AREA, currently 100. Replace the type used for slot number,
> > which is currently a mix of int and unsigned long, with unsigned int
> > consistently.
> 
> I think it's good to standardize the type, but let's go to unsigned long
> then we don't have to think about this again in the future.

Ok, I can do that instead.

> 
> > Drop unnecessary check that number of slots is not zero in
> > store_slot_info, it's guaranteed to be at least 1 by the calculation.
> > 
> > Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
> > find_random_virt_addr, it cannot change the result: the largest valid
> > slot is the largest n that satisfies
> 
> I view all of these things as robustness checks. It doesn't hurt to do
> these checks and it'll avoid crashing into problems if future
> refactoring breaks assumptions.

Well, at least the first one should really be unnecessary: the previous
line sets it as 1 + x. When I see that it actually confuses me: I think
I must be missing some edge case where it could be zero.

The second one is also unnecessary, but I agree it might require a bit
of analysis to see that it is.

> > -	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
> > -		 CONFIG_PHYSICAL_ALIGN + 1;
> > +	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;
> 
> These are the same -- why change the code?
> 

It's just reformatting now that we can have more than 80-column lines. I
think it's clearer this way, more obvious that you're dividing by
CONFIG_PHYSICAL_ALIGN and adding one, rather than "did he forget the
parentheses here".
