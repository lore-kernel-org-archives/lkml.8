Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB62C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BBC20784
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586363016;
	bh=dyhwkj/dKQpYApxWhwE9fer97bTtNvwIn3SZatW6GIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gVlJFBDFtfPGSnJ1C+NhWQC2u/fJe5Vz0Lal3IO/0VC520Wk+3h5XsKzHDis8wEV1
	 +WSt7j/m2BDuEmSiXI+LApybJc8oDAVIw3ONovBlaboEYqcQ+EnKLMKXE0LRXs0u68
	 r+2Cjn7uU+phoHdYCTptLk/uTIwW8pNhlWNgH83k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgDHQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:23:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42299 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgDHQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:23:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so8237658ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeyuJaGsNvNj6lpnK7K9Yru14CFjP1xhZJAUfZMr7aI=;
        b=IGz34XNmrlLU/pF3e6BHZO3cspAyx/bs3KdtgD8UMpxNNZAUTM4RBEsRUp4gFH4FJO
         hIofPAOTbxV4PbxvxDDfjolqztRwIRQIfmOFTLSGFyKi7nMCrsTeazdreoU8EcH26rIR
         2Z25v5YqmyreWF3qo1hoXxWPnJ8hS7UewdkvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeyuJaGsNvNj6lpnK7K9Yru14CFjP1xhZJAUfZMr7aI=;
        b=NGNUWMskxQhgh1mW7gVPT2my3YtqLeLNUzIgHJuxxHIpTlcxKeKK+yzSipeA+wFXap
         a2jpSOWdZ4x4ofi1QC85Od6+PM93z5xIhFKnztXpssO8xKSgbgs8Gg5Lwt9x+haPv/Lc
         3skGg7XbGHCTesyoz1S7/Tb/yjirSVZ2/yaOt9NW6LIZcbvCuUK/uxQ2ZDVczoUS7R7T
         Bcn3p86O6ULvXdm1fB9fcyvGIZyKssRr+N8EuppoiNhPRxCLn+eeShQAzk3Z8lEjP4PE
         gRbcm4uC2Pdc/f0M2AZRXYFtEzSxoxcVKFh56M9OZpDlkNphBPG06HaBMfCqMCu/XypI
         EBHw==
X-Gm-Message-State: AGi0Pua5M5XUbBRrRpbGy9nSn4GeHr1Ixk+x/05KfTBv19U0KSTp/fx9
        7kflXr8t8EPrvAHapFQbspCZLwuOqIQ=
X-Google-Smtp-Source: APiQypJ79mkF+O2hiJlheD+PcbWFEANdzG1+COyybC3IZH+COOdXsdur7yJRabIca9sO3XxJ8Sry0g==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr398101ljh.122.1586363010529;
        Wed, 08 Apr 2020 09:23:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a4sm17211006ljb.27.2020.04.08.09.23.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:23:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id k21so8318020ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:23:28 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr5525159lji.150.1586363008508;
 Wed, 08 Apr 2020 09:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
 <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
 <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com> <20200408150643.GD3676135@smile.fi.intel.com>
In-Reply-To: <20200408150643.GD3676135@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 09:23:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgndVg4U2rh_6e8YBuhN+78wEiyTuCRTqfWuSZzGC6f_w@mail.gmail.com>
Message-ID: <CAHk-=wgndVg4U2rh_6e8YBuhN+78wEiyTuCRTqfWuSZzGC6f_w@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 8:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> For the better understanding the current state of affairs I suggest to respin
> new version after rc1 and we will see again.

For something simple and straightforward like the obfuscation patches,
I can take them directly if people are unavailable.

Just make sure to re-post the patches, and make it clear that it's to
me (because usually if I'm cc'd I end up just reading and then
ignoring things that I expect to go through a maintainer).

              Linus
