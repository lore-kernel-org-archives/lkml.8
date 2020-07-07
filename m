Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5117C206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byd/f9TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGGU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGGU4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:56:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629A8C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:56:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so9512125pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w+KZo1sPWTutiATsxk3Uy2pZjCjintgvyK96Yf9RfKc=;
        b=byd/f9TOVQc3JmoxGzurellv8qYNwshDPxpudLMSpoQM9PXIdnFsKaJ9zv8+LjHkWt
         Leo4c50JOA4qXA0q3+rtKY0nYEcZ9d1mYgf/2BrCcZp2+Uw1v+MgX5geDMjo26ahQ/Xq
         WG2e0WGcuRqGJCLCZE9qF8ctnON5a8fs64ZRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+KZo1sPWTutiATsxk3Uy2pZjCjintgvyK96Yf9RfKc=;
        b=roqKXJhekDDjLrl5VDiPnu8PvxvM7KlEBmIz9q/ecEXyYATMcpN/P7XkoxwfVMobmr
         ZwUVLaPeVRQ2RKz8xhxDbNEDjYHbnsPWn2yo5P02bD/XPAMpbkp8V0To8pMIAs8ftEkU
         mZvxkEN4ecZXzM7e7UmqVWlCsIMXoT4EeYAfZQ1JzDkHL2LLI9nk02SQaR0vve6GDSwB
         6oYDQZ9pNRgDzrPeuIgMCutsBAWz55ij8YfWNgALV2JKq7UB0vFNNuWVU8GI6/jrkB5C
         myIN8G9GNr8+0cFrLxAGo7GnHOIOIGyRUPnn/1v/oq7Nge17qzXUiDS7vJudH1Fg76cB
         qIUg==
X-Gm-Message-State: AOAM53270MQ6S+YiKjrRiHDqXmT1Antv1UOu2ICz5uf/MstdPV3tA1st
        I9NQi0CniscqMlvAJsth/TnQoA==
X-Google-Smtp-Source: ABdhPJxVvLhi5KAqgk+fO2zPVpbTI4B38DeQ3QOZndyWiKG1akDQwEeglJUxopKEbgdAvRuSbH353g==
X-Received: by 2002:a62:ce46:: with SMTP id y67mr47587752pfg.118.1594155392908;
        Tue, 07 Jul 2020 13:56:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k100sm3315034pjb.57.2020.07.07.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:56:32 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:56:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <202007071346.F123B0A57@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
 <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
 <202007070137.3ADBEDC@keescook>
 <20200707094147.213e0a82@oasis.local.home>
 <20200707144542.GD9411@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707144542.GD9411@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:45:42PM +0300, Mike Rapoport wrote:
> On Tue, Jul 07, 2020 at 09:41:47AM -0400, Steven Rostedt wrote:
> > On Tue, 7 Jul 2020 01:54:23 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > "I will whitelist the syscall" -- sounds correct to me (same for
> > > "it is whitelisted" or "it is in whitelisting mode").
> > > 
> > > "I will allow-list the syscall" -- sounds wrong to me (same for
> > > "it is allow-listed" or "it is in allow-listing mode").
> > 
> > That's because we can't just make "allow-list" a drop in replacement
> > for "whitelist" as I too (native English speaker) find it awkward. But
> > then we don't need to make it a drop in replacement.
> > 
> > "I will whitelist the syscall" will become "I will add the syscall to
> > the allow-list", which sounds perfectly fine, and even better than
> > saying "I will add the syscall to the whitelist".
> 
> I will allow the syscall?

Kind of, but it's this change to verb-noun from adj-noun that confuses the
resulting language: the verb form of the verb-noun doesn't distinguish
between its stand-alone action ("allowed") or its combined action
("allow-list-ed") in the same way that the verb form of the adj-noun does
(the verbed adj-noun is its own word). To me to looks like "allowed" and
"whitelisted" mean distinct things (as in, a single allowance vs being
added to the persistent list of allowances).

So "I will allow this system call once" and "I will allow all instances
of this syscall", or we just get used to using the verb-noun as a whole,
and embrace "I allowlisted the syscall."

But yes, as I and others come back to: it's fine. We'll just use different
surrounding constructs to avoid confusion. But it is an odd characteristic
of English's grammar (or lack of appropriately descriptive adjectives) to
not have a drop-in replacement. (Which is where I think the master/slave
replacements fair far better -- the whitelist replacement is more complex,
but it's mostly just English glitchiness.)

-- 
Kees Cook
