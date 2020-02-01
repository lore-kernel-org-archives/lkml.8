Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_SHORTNER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A090C35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C92064C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZdQSUNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBAVtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:49:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54804 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBAVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:49:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id g1so11776014wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8g4n8OPntHUCEDrr9QgY8zCg00Uu42nL/dnCx3MOvtg=;
        b=KZdQSUNXxj0gNOaEOw+7vpce0kDASKgZ9c5Mrkfe0JSyvv4xu4Y7rVk3M8Ieh5fYZN
         5yo5+v7Nm2OH6IrkvU4+SI/U+7g8aGo5rWTjh1SIFQbrsOQdryMnqnrhg24XpSfOIP49
         jZri3jXHOXWlgZ46zniLuaAAv9zlIx+Sr07pp4t7ed45+LkYHXA/jAsFotISQNJqpnV2
         bBVb1h4YYmSyhf1ea0+vKJaE7mPWwC7xWuYf6rbMgqaxjcKrjaJYFZ8oOAwMkYx24SFH
         LyUV969tueaYp6HBCxol4XKHmGYM2BFQsL/Igu54d9nGyhevgmICFvHiLw76fFSr7fJC
         EKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8g4n8OPntHUCEDrr9QgY8zCg00Uu42nL/dnCx3MOvtg=;
        b=I4TxpM5rBE8X4YPw20dvp0SFkc8l2XILIrgJxNcSjS1qMqG2YnwMhKGf7AjeEdG600
         vgv+KgTLh1WoJRvszIANja5jabdK/e3oPZ1kbpcFuoRQZMjew7MsVOwIWfRPAhW64Tle
         orxVgiOBX0YHlLR1iKebKmE/OoXMrpzasequNOEBVBv48TS0Rxat9pNJb6FkrJ/cO41g
         z+3XY1N1NGnGc+pe6sG+2CAet3WfNwLVwz397x5UuAAg0xkEjpslVmxV8bRMlOVEDBRa
         0fMvhThMrVZeDwdDM4VcHGea0hFYIoiovw/17VVO8z2BCzae1fIYbCxm5z7BjFKB05fR
         Xsdw==
X-Gm-Message-State: APjAAAXbq00SPgEagajYsneOF07YKtpnNG/n/UFeW/sz+90nYstwvrRz
        cfXSDTQCrE5Kqx4hIbbZwdPWGLUbpNie/+ZGeRyOGg==
X-Google-Smtp-Source: APXvYqzqHLYV0zjuoU2Zxa1XqyYA5vWbjit0CjVQF2xU5w6hv4zTf9rlJWz52pQQVJe7/xb3TxXmf2fYJObIigiwx1g=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr19188999wmf.40.1580593785798;
 Sat, 01 Feb 2020 13:49:45 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAKv+Gu-oPrM7oh-oTbpQsUmXcYvp9KxjXFb3DUGk__qu59rdBQ@mail.gmail.com>
 <CAPcyv4j7oraMPOhSePaXhULaNJNTFTx+TcJ-y2bqQmvNsTQDmg@mail.gmail.com>
In-Reply-To: <CAPcyv4j7oraMPOhSePaXhULaNJNTFTx+TcJ-y2bqQmvNsTQDmg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 1 Feb 2020 22:49:35 +0100
Message-ID: <CAKv+Gu-bAbc7a1-H5gadQ=YkfKpQUt__3J5cctDNLz1g8gH92A@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2020 at 22:44, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jan 31, 2020 at 10:45 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > earlycon=efifb may help to get better diagnostics, but you will need to use a camera to capture the output
>
> https://photos.app.goo.gl/uA3Wkaxc8x6A4gK47

Yeah, so it definitely has to do with the n_removal > 0 path.

Did you try the change I suggested to Joerg?
