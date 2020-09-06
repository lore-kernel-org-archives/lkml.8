Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE42137B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efpaYjdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIFVAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 17:00:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9CAC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 14:00:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so5483455pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1oB7ySbJzhXfoNWBmNgQXBWcU1mfNfTlC7+qBvtFhg=;
        b=efpaYjdt9SVm2ywPYXlj4yrrEvq8AVqERON4d0w7DHu2Skfekh0oQMMAYAFfCMb8P1
         h2n0esJ4V/5c0rGuu4S1EoQZOtob1qxllezT2Dri2t4Mk2PZGpmzxn5tBuTGMql9iIuh
         axheouI4/HX4AxNdVpHqfDYP/5uaicuN7ApqaZoiaUjle/4kzSFQAUPLJKDEdpa0FgPq
         eTtqyVJA6nrODrackky1vhZxUaA9Ox7LDC6Am2D4Ok4dKcoSzoa7Ns5WaKfnFxEXYmnv
         79exXkd2NlQqq1dncuYZhePJifPjCqvaY+wnZQFNztNxY5lzWSbZBCNN7UmxVTyy50vI
         BQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1oB7ySbJzhXfoNWBmNgQXBWcU1mfNfTlC7+qBvtFhg=;
        b=kmVlqi8WSTbxpSFGwBKZJwnISLdrAxHdsY25tYyZW8WA4yuie/96s3O4yMOFge1LDl
         ECy6RM5egLHf+06K1PjCJAgHSR0HLidOhtUSuEcG5cehRDdoLULFkNj4vnkuaBTsb2vX
         uhnqd3tq6d5JCV8Qkg2CahzRRjcdNtqRnvWYXzctX8/Inj9bluRBv4kC/nN0Ykv19Dp4
         xvxVeNpj3+X1zqMhI4uQ8T2t+xZGUbW/09D2UfYdNK6GH15V1l16paVTBPFNyb2YkDT0
         aMpGxA0K4JsWz3i/89CiCBR+9Ff5JVBvYLVaFzW/cAAibTpxTKdb6ua/MgmYJ5D43g3g
         7WZg==
X-Gm-Message-State: AOAM530c15ONllAbP6ChTteo6eXaI/HPQCNswgEggBqycoOFbM46FCgT
        zKaTzUONVRrwVCNFubw+u78=
X-Google-Smtp-Source: ABdhPJx4kM3dYEiZLcwfjTeboiVQbRKFdi/+sJFneYsrc0TbFIZdPbE2kj7RVvRET0yZkXvCavYHVQ==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr6789220pjk.189.1599426044575;
        Sun, 06 Sep 2020 14:00:44 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id m25sm12735683pfa.32.2020.09.06.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:00:43 -0700 (PDT)
Date:   Mon, 7 Sep 2020 06:00:41 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        LKML <linux-kernel@vger.kernel.org>,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [OpenRISC] [PATCH v2 3/3] openrisc: Fix issue with get_user for
 64-bit values
Message-ID: <20200906210041.GK3562056@lianli.shorne-pla.net>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
 <20200905135714.74bsr5h423k7guw4@ltop.local>
 <20200905213408.GI3562056@lianli.shorne-pla.net>
 <20200906002228.mrbs7pdyrf5ooi3c@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906002228.mrbs7pdyrf5ooi3c@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 02:22:28AM +0200, Luc Van Oostenryck wrote:
> On Sun, Sep 06, 2020 at 06:34:08AM +0900, Stafford Horne wrote:
> > On Sat, Sep 05, 2020 at 03:57:14PM +0200, Luc Van Oostenryck wrote:
> > > On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:
> > > 
> > > Hi,
> > > 
> > > The change for 64-bit get_user() looks good to me.
> > > But I wonder, given that openrisc is big-endian, what will happen
> > > you have the opposite situation:
> > > 	u32 *ptr;
> > > 	u64 val;
> > > 	...
> > > 	get_user(val, ptr);
> > > 
> > > Won't you end with the value in the most significant part of
> > > the register pair?
> > 
> > Hi Luc,
> > 
> > The get_user function uses the size of the ptr to determine how to do the load ,
> > so this case would not use the 64-bit pair register logic.  I think it should be
> > ok, the end result would be the same as c code:
> > 
> >   var = *ptr;
> 
> Hi,
> 
> Sorry to insist but both won't give the same result.
> The problem comes from the output part of the asm: "=r" (x).
> 
> The following code:
> 	u32 getp(u32 *ptr)
> 	{
> 		u64 val;
> 		val = *ptr;
> 		return val;
> 	}
> will compile to something like:
> 	getp:
> 		l.jr	r9
> 		l.lwz	r11, 0(r3)
> 
> The load is written to r11, which is what is returned. OK.
> 
> But the get_user() code with a u32 pointer *and* a u64 destination
> is equivalent to something like:
> 	u32 getl(u32 *ptr)
> 	{
> 		u64 val;
> 
> 		asm("l.lwz %0,0(%1)" : "=r"(val) : "r"(ptr));
> 		return val;
> 	}
> and this compiles to:
> 	getl:
> 		l.lwz	r17,0(r3)
> 		l.jr	r9
> 		l.or	r11, r19, r19
> 
> The load is written to r17 but what is returned is the content of r19.
> Not good.
> 
> I think that, in the get_user() code:
> * if the pointer is a pointer to a 64-bit quantity, then variable
>   used in as the output in the asm needs to be a 64-bit variable
> * if the pointer is a pointer to a 32-bit quantity, then variable
>   used in as the output in the asm needs to be a 64-bit variable
> At least one way to guarantee this is to use a temporary variable
> that matches the size of the pointer.

Hello,

Thanks for taking the time to explain.  I see your point, it makes sense I will
fix this up.

-Stafford
