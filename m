Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 00:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8412075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 00:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWqGmXvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgIFAWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIFAWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 20:22:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA0CC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 17:22:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so9385814edk.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 17:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91sWkciFrUJmi/H5FwTYMFE8E2HIci8DUELtGp4EpwE=;
        b=LWqGmXvARkX5RTHNV9r1uC5oQZZPjvIthrPBs6oVQrXX6CsUmVUaXgTP6I7JHdbjoi
         f0uxzUaGfWQHAZ+PhrHlMZ+g+0mojIKw6/ePr+y6nhvrYdMAWtqi+UFuJXYJFJwofZKc
         u4gYZGN8w+0kUhM7YouMpCHk5Ucvd8osrj0Uk1LQoXM9jjmh4XpDmqatcciolDfhAv1d
         ckCVOKdKXaoMf7wBMlUcNt+gQDw+8u3BL1DltAgQUeNrdvUtUjsKgrpek41/VWg0VSAt
         2AapsO/sBAvpGqmGMqiJ757ug5ZszD4wVlFF5ho0mYPN13FIyG/86TaMaLJMi0uim4Ta
         jHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91sWkciFrUJmi/H5FwTYMFE8E2HIci8DUELtGp4EpwE=;
        b=sQ8ehLx8FqSa8s6b45Bpe3Ufc5qxUk7rDTRgtTnMhEiPnwDbCPJ0wlzsSMTEL0zH8m
         0BZlbaeyphmYPeYEf9TInf2LlrLDZLNZR+0GaRXB8aac6pdA8wnw0OHM08/aptY3pPf5
         /fXuS1iaMGmEDm+ScrnodcWLI+vdNePMfAsRsmyN2KPUXWyVv4vzxF/7hTY2pd2nNTT7
         A5kVZJ1Bd2bqlI1P+RPBKeEW0Z8R4tupXqMwYUfIgF9SohIp6fjpE7gOTbZWpUJ9Qj/h
         sNm93vYVjxDLrwxO2ibWkb/oU5zPutHBSrEbeng/wrCxCdTy7S3PXa6Fs0PHQmqAk1EJ
         xJMw==
X-Gm-Message-State: AOAM532PS1ZEu8Q6pXQxl/czfYoOLH/xJ6g9lMjHotNnB8F2GCQaD3Go
        Qd0DRgNTcJ6Lxlct1aWhWdo=
X-Google-Smtp-Source: ABdhPJxAZftUXMfxY45wOylfk2f0F6De8orRMIywDwDHappe7z4+o+TSm4SShNlRzV92faTfIPBzAQ==
X-Received: by 2002:a50:c182:: with SMTP id m2mr15088033edf.70.1599351750123;
        Sat, 05 Sep 2020 17:22:30 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:ac6e:dd2f:2483:32c4])
        by smtp.gmail.com with ESMTPSA id qu9sm10387823ejb.24.2020.09.05.17.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 17:22:29 -0700 (PDT)
Date:   Sun, 6 Sep 2020 02:22:28 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        LKML <linux-kernel@vger.kernel.org>,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
Message-ID: <20200906002228.mrbs7pdyrf5ooi3c@ltop.local>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
 <20200905135714.74bsr5h423k7guw4@ltop.local>
 <20200905213408.GI3562056@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905213408.GI3562056@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 06:34:08AM +0900, Stafford Horne wrote:
> On Sat, Sep 05, 2020 at 03:57:14PM +0200, Luc Van Oostenryck wrote:
> > On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:
> > 
> > Hi,
> > 
> > The change for 64-bit get_user() looks good to me.
> > But I wonder, given that openrisc is big-endian, what will happen
> > you have the opposite situation:
> > 	u32 *ptr;
> > 	u64 val;
> > 	...
> > 	get_user(val, ptr);
> > 
> > Won't you end with the value in the most significant part of
> > the register pair?
> 
> Hi Luc,
> 
> The get_user function uses the size of the ptr to determine how to do the load ,
> so this case would not use the 64-bit pair register logic.  I think it should be
> ok, the end result would be the same as c code:
> 
>   var = *ptr;

Hi,

Sorry to insist but both won't give the same result.
The problem comes from the output part of the asm: "=r" (x).

The following code:
	u32 getp(u32 *ptr)
	{
		u64 val;
		val = *ptr;
		return val;
	}
will compile to something like:
	getp:
		l.jr	r9
		l.lwz	r11, 0(r3)

The load is written to r11, which is what is returned. OK.

But the get_user() code with a u32 pointer *and* a u64 destination
is equivalent to something like:
	u32 getl(u32 *ptr)
	{
		u64 val;

		asm("l.lwz %0,0(%1)" : "=r"(val) : "r"(ptr));
		return val;
	}
and this compiles to:
	getl:
		l.lwz	r17,0(r3)
		l.jr	r9
		l.or	r11, r19, r19

The load is written to r17 but what is returned is the content of r19.
Not good.

I think that, in the get_user() code:
* if the pointer is a pointer to a 64-bit quantity, then variable
  used in as the output in the asm needs to be a 64-bit variable
* if the pointer is a pointer to a 32-bit quantity, then variable
  used in as the output in the asm needs to be a 64-bit variable
At least one way to guarantee this is to use a temporary variable
that matches the size of the pointer.

-- Luc
