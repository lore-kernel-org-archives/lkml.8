Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4189CC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142DB2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EbFgLJlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:05:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41705 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:05:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so1278658oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mz7Ey9gSAauDy/gNIB43lQyeRt2xn0zd/o4g7lTFRzY=;
        b=EbFgLJlUCVtdm+nm5zkXqa6IQ1oUHjUAG8sWUHvhz9ARUDzaZroyehH337WrjDq3ay
         LK32Hr3BEJDbDTRCKxqICnH2TMhsMQ0TmtEaX62cnkitw5tLUPIyqWHYHcZcAJ8YY4RO
         pr6LEHiF7oM5QsnYOoqfZvozpKd5rCilqqGwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mz7Ey9gSAauDy/gNIB43lQyeRt2xn0zd/o4g7lTFRzY=;
        b=fLJUmVfWxU4YdsCIv9o895bhq8dfXb/myaDeuj9ovnbF02Z1+D+EpdeOPVGWxe/OdM
         lZg4/EeOeUPzR4ADbfPnwRuM6H9pGUgP+bF1vpPnyBikiEwAeHkVMGyI9GJTyKkN6pyb
         WbFR3tfWY8nvcrGmXsRqiO9xrnlcVj5hLmuXijt9wjG9fGGXCj3maZa1VtgWLJ3EeB2U
         GvKOSttVytXeU3f9CW1JGKXhcrPZ+lJmEHS14Ord8dqTONcz+VIoqrZGz3cTcDDGPNr6
         +GNCv0r7DQ0aWJLJAOvHxh9iKKx5tXyJxPgSzpZ00rGJMqC9IjvT+cf8Xfxw90yo4Yrz
         T18Q==
X-Gm-Message-State: APjAAAVmXlR1PYltrpz+EiTsYF5cgBS6auSkpNzAxvyeNysmOTsmeL9/
        4flP4RMzFJnsITxBuqgJHeDScg==
X-Google-Smtp-Source: APXvYqzjyacdcE5uV2m9By4861i/XXZeEXEomnp7R2AYCO4AqIAmoT4qO2IqKdEbRwL+9EhuP/kHTQ==
X-Received: by 2002:aca:4ad8:: with SMTP id x207mr1333594oia.55.1581066305665;
        Fri, 07 Feb 2020 01:05:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t203sm845468oig.39.2020.02.07.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:05:04 -0800 (PST)
Date:   Fri, 7 Feb 2020 01:05:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 04/11] x86/boot/KASLR: Introduce PRNG for faster
 shuffling
Message-ID: <202002070100.2521E7563@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-5-kristen@linux.intel.com>
 <20200206151001.GA280489@zx2c4.com>
 <CAGiyFdes26XnNeDfaz-vkm+bU7MBYQiK3xty2EigGjOXBGui2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiyFdes26XnNeDfaz-vkm+bU7MBYQiK3xty2EigGjOXBGui2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 08:23:53AM +0100, Jean-Philippe Aumasson wrote:
> 
> On Thu, Feb 6, 2020 at 4:10 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > Hey Kees,
> >
> > On Wed, Feb 05, 2020 at 02:39:43PM -0800, Kristen Carlson Accardi wrote:
> > > +#define rot(x, k) (((x)<<(k))|((x)>>(64-(k))))
> > > +static u64 prng_u64(struct prng_state *x)
> > > +{
> > > +     u64 e;
> > > +
> > > +     e = x->a - rot(x->b, 7);
> > > +     x->a = x->b ^ rot(x->c, 13);
> > > +     x->b = x->c + rot(x->d, 37);
> > > +     x->c = x->d + e;
> > > +     x->d = e + x->a;
> > > +
> > > +     return x->d;
> > > +}
> >
> > I haven't looked closely at where the original entropy sources are
> > coming from and how all this works, but on first glance, this prng
> > doesn't look like an especially cryptographically secure one. I realize
> > that isn't necessarily your intention (you're focused on speed), but
> > actually might this be sort of important? If I understand correctly, the
> > objective of this patch set is so that leaking the address of one
> > function doesn't leak the address of all other functions, as is the case
> > with fixed-offset kaslr. But if you leak the addresses of _some_ set of
> > functions, and your prng is bogus, might it be possible to figure out
> > the rest? For some prngs, if you give me the output stream of a few
> > numbers, I can predict the rest. For others, it's not this straight
> > forward, but there are some varieties of similar attacks. If any of that
> > set of concerns turns out to apply to your prng_u64 here, would that
> > undermine kaslr in similar ways as the current fixed-offset variety? Or
> > does it not matter because it's some kind of blinded fixed-size shuffle
> > with complex reasoning that makes this not a problem?
> 
> Let me share my 2 cents:
> 
> That permutation might be safe but afaict it hasn't been analyzed wrt
> modern cryptographic techniques and there might well be differential
> characteristics, statistical biases, etc.
> 
> What about just using SipHash's permutation, already in the kernel? It
> works on 4*u64 words too, and 6 rounds would be enough.
> 
> Doing a basic ops count, we currently have 5 group operations and 3
> rotations per round or 150 and 90 for the 30 init rounds. With SipHash it'd
> be 48 and 36 with the proposed 6 rounds. Probably insignificant speed wise
> as init is only done once but just to show that we'd get both better
> security assurance and better performance.

Yeah, this was never meant to be anything but a POC and after timing
tests, it seemed like an unneeded abstraction but was kept for this
RFC so it was possible to specify a stable seed at boot for debugging,
etc. I think this patch will not survive to v1. :)

-- 
Kees Cook
