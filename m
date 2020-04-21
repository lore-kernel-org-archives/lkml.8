Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF742087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="MUdJisV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgDUJax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgDUJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:30:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AFAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:30:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so2869368wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFdN0tjoADWgIVuSByNFkUCkMNZLboX/lcuRYVkeMFo=;
        b=MUdJisV6JA9VE3XAutr22+n72yng/uxLqCaRxqQjKkj519gh/BBVniW0T0WEgjN9dY
         boQlTnnLnVwerSTjipIj9DMiTf4eGRHWqvDuMML2blIsgMlYFvUlSOtPBaSEIoMvMi1h
         RmGbss3sNDae1HvsyOzweeGoBkENA3/KtrCgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AFdN0tjoADWgIVuSByNFkUCkMNZLboX/lcuRYVkeMFo=;
        b=N3rWRb/bY7jZKEMZvpxt1qNhXhGJGdIzTPHADZyDgA7XIvPoS750LjOheQ1luCW5IO
         lzoJpvRd+xyUvNbUMkWua3fE2uSIjug9h4hcTaS0kLI6efWAZn24o9mfVYRq4QTFhYEv
         +Rw90yztFvfUs+FsARpsbCDZScIKVP/KB8SU9t2orfumSihFlkiiEjLLIhAA/zSITT8D
         Qw2XHFonqAtxj8SWETz82MQ22OUvW6TXJKbyM19b85qYB4CBeRQYoFj4jzbGFzRJWNia
         CcnXiuLhoNCrJNurjliIhd+zAUV9cj67UELAsvg+NlVulBE8jO9snJJULoHV35EiI9PY
         WyuQ==
X-Gm-Message-State: AGi0PubdX+nXGXH+Bfo2NQZMIED1Mm3PrT7/JEjx7Kwi9ZlXeugnOf10
        oF/vxWtDsEvrDVyaqTx5orpovxNY/7s=
X-Google-Smtp-Source: APiQypKjB/LmeV2HeOAkXYR5q2ziEhhC1Nca36dLs+f5/YBY1PHKBocgUDhmHZcSp+icpbOuQc+YmQ==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr3942146wma.150.1587461448983;
        Tue, 21 Apr 2020 02:30:48 -0700 (PDT)
Received: from carbon ([94.26.108.4])
        by smtp.gmail.com with ESMTPSA id e11sm2834608wrn.87.2020.04.21.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 02:30:48 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:30:47 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200421093047.GB2970@carbon>
Mail-Followup-To: David Laight <David.Laight@ACULAB.COM>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72>
 <20200420163215.GA43378@carbon>
 <3a6f974efad4453e9af7a3152ca0bbce@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6f974efad4453e9af7a3152ca0bbce@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-21 08:00:48, David Laight wrote:
> From: Petko Manolov
> > Sent: 20 April 2020 17:32
> ...
> > > But one downside of declaring variables volatile is that it can prevent 
> > > KCSAN from spotting violations of the concurrency design for those 
> > > variables.
> > 
> > Which would be unfortunate.
> > 
> > I just wish there was C type declaration that would force the compiler to do 
> > what READ/WRITE_ONCE() does now, but i also know this is too naive... :)
> 
> It does, it is called 'volatile'.

Well, it doesn't.  I'd hate it if this thread become too academic so please 
read:

	https://lwn.net/Articles/233482/

I am really bad in naming things, but assume that something like "shared int a" 
tells the compiler everything what READ_ONCE(a) would if it was only "int a".  
Here "shared" is the magic qualifier.

	shared int a, b;

	a = x;
	y = b;

The compiler should also be forbidden from reordering these two statements, 
perform exactly one store to "a", exactly one load from "b", etc, etc.  IOW just 
like with:

	WRITE_ONCE(a, x);
	y = READ_ONCE(b);

> All READ_ONCE() does is force the access through a volatile pointer.

It does a lot more than that.  Again, please read the comments in:

	include/linux/compiler.h

> The thing to do is mark the structure elements 'volatile' rather than using a 
> 'pointer to volatile structure'.

Err, don't see the point in either of these.  It won't replace the need of 
locking or using some sort of barrier if these were to be used as some sort of 
shared memory.

> I'm sure KASAN could be taught about volatile structure members.

That it may.


		Petko
