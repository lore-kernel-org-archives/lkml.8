Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D49C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2F23F57
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592671954;
	bh=lc7v8dBdySWZJVKaRCaXBIyecuVR2aekPz7TkBHJxQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fonm9p0+KlJx8XNpwSp6XrY/Om60K6BcsM59wLmBHRLudTc6uTjsVuPPRE0uGn4gr
	 ceWfrCI7BF0NLx70vlh8Py87cy0JIZ1sslD9PxdhhbbOZyKEFCS89sahX7BfFAOzCb
	 MzyIOWzNsUNdS0xChfxTO4LkaQLJE38V8Tob8KE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgFTQvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:51:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:51:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so14910725lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gXamD6tdco3sX1rsWjyx/DNsG9Dx7HvJbp4Sgjo81s=;
        b=JB70eXW6129XbjPHpJQunGUIMM53GNDzabriZYPRfLkmsKWzMVZsseChD9TekSyUpA
         EVQwpFR3L7FM2Y9I+rLVZY00YWZJHYTfxve8+q//i3CHatLmxT3cCeBSGHuvknRjI6Pb
         rL8GLj3b9jPvOO46NbZTvdDo/PPx58jx7G+YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gXamD6tdco3sX1rsWjyx/DNsG9Dx7HvJbp4Sgjo81s=;
        b=cfYc/cO3dMgKeWH6nnm9LU4ptFUsj2BvOJYqBuxwVs+MJOtAiVcKXlt3oGgb2S4Mse
         LSkoKnI1UkuxCbzMmF4bV0oM5xifkcr8g0RGan1aX90AQJfEBbl8953+BYM5QhnbR4VC
         cBRcHHfx6eFkj467hcfxVCeNMNjY/tuTlvdjnJFV7fTGgcvWlnT7wxvLXhRUaLFo3pMj
         4zX8urnSB4n7AOnXu+mUhnR3Z3MgTD4Z6DUlrtuWMATzZcu/XeKRBg5GlJNwBhyzvLF2
         OYH3s2sL0lYyZAC2kgtkqfUZ9AB1dVkaygdwBmC4DsUPqPLiR8bBrxkrfpmhXdCn/R8l
         InCg==
X-Gm-Message-State: AOAM532pk1Pvc005O/VOsjJsSlc+EBfeOGP1Nelhyql7cFoLvnAduvX6
        e+9beBJuMh/lleyxJXlC4ZRN7/gfPTo=
X-Google-Smtp-Source: ABdhPJwmFdZynAkqymSpoFkU3tDwyXUrwM1u7eFu6j+cbukAmZbOQuioWKlJ1epO7E8Vb4mkBo3t1g==
X-Received: by 2002:a2e:7006:: with SMTP id l6mr4857516ljc.453.1592671804614;
        Sat, 20 Jun 2020 09:50:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c6sm2174731lff.77.2020.06.20.09.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 09:50:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a9so14869009ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:50:03 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr4470977ljj.371.1592671803344;
 Sat, 20 Jun 2020 09:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390>
 <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
 <20200619074233.GA3723@lst.de> <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
In-Reply-To: <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 09:49:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
Message-ID: <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 6:46 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
> So, be totally surprised :) I've just booted with "maccess: rename
> probe_kernel_address to get_kernel_nofault" intact and your probe_roms.c
> patch with no issues.
>
> (Perhaps there's some sort of compiler optimization going on?)

Hmm.

Very strange. I was a tiny bit worried about that part of the patch,
because I also changed the types (from "unsigned char *" to "void *"),
but pointer arithmetic in "unsigned char *" and "void *" is the same,
and Christoph's partial revert patch doesn't even revert that part.

But I really don't see what Christoph's revert would really even
change It switches the order of the arguments back..

It does re-introduce a bug in that macro that I fixed. This macro is
buggy garbage:

+#define probe_kernel_address(addr, retval)             \
+       copy_from_kernel_nofault(&retval, addr, sizeof(retval))

in case 'retval' is a complex expression, becasue of possibly changing
the C order of operations. So it needs to be "&(retval)" in the macro
body.

But that is never the case for 'retval'. For 'addr', yes, but 'addr'
is only used simply (and copy_from_kernel_nofault() isn't a macro).

I'm staring at that opatch and not seeing how it could _possibly_ make
any difference in code generation.

Which is the obvious next step: would you mind compiling that file
with and without the patch and sending me the two object files?

              Linus
