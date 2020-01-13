Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA9C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242C0214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfkvo1cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:59:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43497 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgAMR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:59:41 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so4396737qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=akPqj1hDBaqbpXb9B3zu2DNw5bCF2JyiU7CxHW4s5s4=;
        b=nfkvo1cG4LbFdosmJ9XpAWLZMQxjDvbzRUZrkB3y5LDfR+/F5JgK3O4KI5pWCQPKEd
         DJBjTlaPWzL/fxr2Y5RaZy9niqxdMatGbri+ut5gt46JVvxFDdp14FzGt7+rBNZleXN5
         TVP9qiXY7QBKbB/bZ0I9cJJAJviHi16UV90P56Vs4OJS7y7C6BLwax+9Vj7kvulRXsaV
         mYoRnfHMCNZAUPEuoiCgqYXg6kpv4xpzMEUvhVnkNI3q57bEGvbzLEBSq15cRBVAzVgf
         bM62sWlQdduMmzKpmjzbTjPxxnjJ88B0cioaHgtVamTjrcHaWxtoAcXyILQAXxhAw5AD
         nXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=akPqj1hDBaqbpXb9B3zu2DNw5bCF2JyiU7CxHW4s5s4=;
        b=D8Y9v1Z4dn1m1b4NzBP3rgiyhRbePOuH+GTGIui+u+C0aySEmyIwX1uAMlhDbWVsE+
         7ZxnCGO+YRP4y/2qmawcK0eVptmrJF0T/Kw5ZhVo+rauUdNIB/fmfYgZ1Et81OBIu21U
         hxvvlTJjX2HkkgrLse40BKbFfE4eFgu/xLefvh8CLpMe1bR5l/QSQtwrk+r6iU7j22Cu
         cklMiPHHy0BbXAmqDe1SPlKlHBKCjE3LEELHjNMy3YYfi45Z8IATn1Hi2a9i+AXTPNi1
         Hkkzv9oQiDPOjN7aCsvFQ6hxRgia70I+c8mYMkHQRvfwzJAScKeGHmmeywZ6FKaw6oUf
         a9/A==
X-Gm-Message-State: APjAAAUGiskjqXouWg9EjqvOOF9rviyK3S6lY4qnxYRzHodrEDOB5asV
        83UaVrFjCBkPFB2jmta4baA=
X-Google-Smtp-Source: APXvYqyjXsoMNYSx5TBOAFkXl85n8fRIn1gPsTuFGiit59nd1adeuRBAEx1r5nxvDMk6deQAszRHoA==
X-Received: by 2002:a05:6214:28b:: with SMTP id l11mr17175577qvv.15.1578938380458;
        Mon, 13 Jan 2020 09:59:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c184sm5265818qke.118.2020.01.13.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 09:59:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 12:59:38 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200113175937.GA428553@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113163855.GK13310@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:38:55PM +0100, Borislav Petkov wrote:
> On Mon, Jan 13, 2020 at 11:13:10AM -0500, Arvind Sankar wrote:
> > How to reproduce is just "build with old binutils". I don't see it's
> > reasonable to include a tutorial on how to build the kernel with a
> > toolchain that's not installed in the default PATH, as part of the commit
> > message.
> 
> The point is that it should be clear that it should state whether it is
> something you trigger with some stock distro which has been shipping
> this way or it is something you've customly created. Huge difference.
> 
> So pls make sure that is clear from the commit message.
> 

How is "breaks with binutils before version 2.23" not clear enough? It
will break regardless of whether distro shipped v2.21 or you built
v2.21. I'm _not_ creating a custom binutils with my own patches
specifically to trigger this issue, it's stock binutils, as stock as you
can get it.

Do you really want me to say in the commit message "to reproduce, first
compile binutils-2.21 from source, then try to build the kernel with
it"? Including this information would make sense only if the problem
wasn't with stock binutils, but only with some specific distro's patched
version. _Then_ it would make sense to say something like "binutils
package v-xxx shipped with OpenSUSE v-yyy was broken, this commit works
around it". This is a problem with _any_ binutils-2.21, there's nothing
special about how you need to build it.
