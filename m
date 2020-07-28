Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB5C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5482065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUOdSiSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgG1TmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbgG1TmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:42:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:42:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so9689470qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Suawz9Cepe9SlpfuSMPAOovHufOGD0v6BIGWG6sQ+tc=;
        b=ZUOdSiSuKMR6t3+4nhxzrUdcF+Y+05h16qdSGTOpiF7kCyT/WBzJOuTFumOJYK0yDB
         pXpD2sSvQuL+CgzOVPL4su6YA62k5nom6jpXTNRY0qpvxLGWgUEEzhr14Rj9bl+LXVE3
         OGPiermHYTYCj6zq71A+Sj53qv5L5uEMT9zgqfNKTFg033xYhesFfzBlHFjx4LbDuCOO
         //TmWeV+3eKaAeKdLCHMwrUk2YlUfAluoXCeof2d9wWlxH6mGwDsHd7H1Rf4TBeTGDzl
         dw+Kqv9wV9iAjdUffTnLrYgtzBre/LxHXZGpdi5brAV6w8GNMLXOrupgrkyswb6vSubq
         PVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Suawz9Cepe9SlpfuSMPAOovHufOGD0v6BIGWG6sQ+tc=;
        b=elVBgZQlkscdLKUlbNlyYpPxhPZTNgy4Qn8tS7FRm8SWCN/aLPwBTHzDdf88gxjCtv
         cfKdex3AeafLaYggHUSlGzbFGDdcMqIbYsZo//I43pNnfh//y49vl7mTGRUTe5yQcCG0
         HirM1UJ6IexkVhyNJ9Zhf52N8NM1pWwQB/TfF/oRqklFwLPuEQG85BkTQ76D3W7OwHk8
         PRI6hVz6LmXgPWU98sfU0PKW81rF4ZwPRykqMNs6j8Eyxv3FNk6v8TuHb9H8UjWzDjnm
         LfE/+DH7/cNgGGpUyI0pU009HBE4Y9roOM8PrnLXc1xpdPZXDXUxOS1W1FEftqa1CiDl
         pYZg==
X-Gm-Message-State: AOAM533Yw478zGN+4Pz1iINjFebxz4/f2JCsp+o0uvwMDSAZDYfinMjm
        hRvriP3PEF/Jwdqwki/UdOY=
X-Google-Smtp-Source: ABdhPJwRZRNqwaIGFtJNpOMCdGLwP+NBDGspR2smvefgS0dBtfuMyR4bH4L11eehxAcvm+JwUX2pyw==
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr7275406qvb.78.1595965328577;
        Tue, 28 Jul 2020 12:42:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t5sm23541963qkh.46.2020.07.28.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:42:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 28 Jul 2020 15:42:06 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] x86/kaslr: Simplify __process_mem_region
Message-ID: <20200728194206.GA4150860@rani.riverdale.lan>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-6-nivedita@alum.mit.edu>
 <202007281152.6B15179@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007281152.6B15179@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:25:16PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 07:07:58PM -0400, Arvind Sankar wrote:
> > Get rid of unnecessary temporary variables and redundant tests in
> > __process_mem_region.
> > 
> > Fix one minor bug: in case of an overlap, the beginning of the region
> > should be used even if it is exactly image_size, not just strictly
> > larger.
> > 
> > Change type of minimum/image_size arguments in process_mem_region to
> > unsigned long. These actually can never be above 4G (even on x86_64),
> > and they're unsigned long in every other function except this one.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Please split this up (which I think is already planned):
> 
> - bug fix (which looks like a correct fix to me)
> - arg type size changes
> - refactoring
> 
> I don't currently agree that the refactoring makes things easier to
> read, but let's see v3. :)
> 
> -- 
> Kees Cook

Yep
