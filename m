Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9EC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA62E207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cya3xNOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgG1TpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgG1TpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:45:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:45:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so15796180qkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GOowIkYgNWQMJY1z2glDszfCPetfRLh+NG8awSyRKwA=;
        b=cya3xNOkiBwf0XFJOc0t7Hv3b/7hGbd6OyyXU+Ex9UL2sXzVwOffXHiWV/cCrr8mZZ
         sMUOS8iKAWJYdfwwfbNJ1U1g9laf5eBaF7mHeGHrE3ZAS1De0nRuo0znpyn/ohbBDqaW
         Cy3yITRvHDPkG3DKQ6R1+8+S0OSWsQspfYHYAmb0ytq0I+ATFoS9XZE7SDXKZr6bNW+K
         sxu5zQONpBuwA+PM0ArjIG9+Fs12LWZeSW/uGzZE67kbU3D05XnPaTRut9MaixDgEfr7
         BdV6SNWsyuYbxZFqg9WoK3Vy9rJIliQ50W3Rm/YcgEoNsprzIoNeMvr2PHDyYLCmxmqs
         QqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GOowIkYgNWQMJY1z2glDszfCPetfRLh+NG8awSyRKwA=;
        b=aOtEq8rEGZSTlkpNpkuEIMbGgI/PuK6oqeXSw3M2sPAwnpaqgxxb/JTUCG1OfnHOEA
         KrQ4FWeJaGklHW2ANEWlQBfBxwHnb0inFaciJFZTMHH8YQqMKcnhyyeqbq6TXhreykv4
         kCh+XY9tl+wYPXE+Zz3h3SokPi70UFKN6H65jdBqkbJrv3oIzDEWvZqccMfkS+QQHEuG
         n0Lcr9SZclVHpgHvVnOqs+Pu+CAnGhU/WrNRJHwY4ywPCeZ/x3z5BkfX3abf2Isjh3WB
         p4HGRn/3wkAF2wiNNbkx1lkcdQFAVedirsS+eHpzj/0eRHnlUHnda4/8H+OTaqRh1Oef
         ez2A==
X-Gm-Message-State: AOAM5316kGteHawW4u5uN0w3J4BLOjsk7lDExdKl2DdUhARotsa9w9rv
        juhx9VSqHgplh1OSQ/uLQIs=
X-Google-Smtp-Source: ABdhPJwjdx4kArycc1ptj29HcORP2NxKlUVRX9lv8S/77lNZ2zmPt6uzKvGb0QMfleyFWxkyyS0Fnw==
X-Received: by 2002:a37:80c:: with SMTP id 12mr30581782qki.149.1595965512983;
        Tue, 28 Jul 2020 12:45:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b22sm21849553qka.43.2020.07.28.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:45:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 28 Jul 2020 15:45:11 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] x86/kaslr: Simplify process_gb_huge_pages
Message-ID: <20200728194511.GB4150860@rani.riverdale.lan>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-7-nivedita@alum.mit.edu>
 <202007281225.C24B966D7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007281225.C24B966D7@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:27:17PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 07:07:59PM -0400, Arvind Sankar wrote:
> > Short-circuit the whole function on 32-bit.
> > 
> > Replace the loop to determine the number of 1Gb pages with arithmetic.
> > 
> > Fix one minor bug: if the end of the region is aligned on a 1Gb
> > boundary, the current code will not use the last available 1Gb page due
> > to an off-by-one error.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Can you add some KUnit tests could be written to do validation of the
> refactorings? Touching this code is so painful. :)
> 
> -Kees

Can I try to do that later -- I've never written a KUnit test, though
it's probably a good opportunity to learn how to do one.

> 
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -546,49 +546,43 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
> >  static void
> >  process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
> >  {
> > -	unsigned long addr, size = 0;
> > +	unsigned long pud_start, pud_end, gb_huge_pages;
> >  	struct mem_vector tmp;
> > -	int i = 0;
> >  
> > -	if (!max_gb_huge_pages) {
> > +	if (IS_ENABLED(CONFIG_X86_32) || !max_gb_huge_pages) {
> >  		store_slot_info(region, image_size);
> >  		return;
> >  	}
> 
> Won't max_gb_huge_pages always be false for 32-bit?
> 
> -- 
> Kees Cook

It will, assuming someone doesn't pass bogus command-line arguments to
reserve Gb pages on 32-bit.

But the IS_ENABLED check allows the compiler to eliminate the entire
function at compile time.
