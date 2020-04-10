Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C61720801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586542287;
	bh=Udbue11Y7K+5/BDJ3P04aSOlksmdB6NjcH4kx6DkLaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OVjs3s//dglnhAscFggx8dOKK+rf+1kp06XSJvtrAux1l7OGxQ+oeGU/o74c3bQrF
	 pgv3XUwyHP41Sx+aJkY4zrbNZqykcrqKz0P3DYYQbsO8ybfYrDd2Wb5bm8Cnc5lCUc
	 5qEcE6O2UnwGuTVN7Yin4lYdmzOOyLYtOZWJqRvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:11:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38087 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:11:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id l11so1924853lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoUTKN447rYhDUCN56uMR/chlcP88GGyZtE/qIjuFKs=;
        b=ASQgGesINz9Opxq6FAkIyEhtbvVy6t/vRm6CLWHckpnYIPBB1/bRzQ1FKUHNTr5ex4
         gDG2zfBq+7Bgxe7+c5T6qMf12anoHl04FiB0vjhkgO52a6kOGPLuIGhRH+pEsJPp6WwA
         csl/5VJt+wHmaaLPKcl7b+pvZHcz1OurBHfJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoUTKN447rYhDUCN56uMR/chlcP88GGyZtE/qIjuFKs=;
        b=IqVd9okrxKuvDOAR1XtKZ0aHWKPIwjw/xoRIL+kya68w03H4wzkZhuuWFO5oBTMXnU
         b28ejgQQMxasilxob/VZ3MiXh0t3X1d35R/Zi3rpL0kC1ifTi86PwXjxJsnOX6+TDp7x
         GT97KZDqIBOiaZsbfaN7bfGoD0KawzkfGNV1dMXinTKi8P2iPfh/yRlzo/vL2xcgKVMx
         ZgTqNiyo5hLKHrFGV2IMV2mGyv6fO2GxrrMZUjsi8FtpjUnaCb8Zz4Q5v2fU9tbFbLTo
         bt+Wv8Gsrn2pdNtC7kv1n/DJpRnbbbwKgo4icZqNekSXj2bxuI0tW4/Ta+CUtEjZK3+i
         1L8w==
X-Gm-Message-State: AGi0PuZr3Oom311NBz8VIL1RP4Nbr75dhaYhOY4ah49BVuzD4esvUJc+
        AnU2Wsm+IwPsicjRayDX1/nCH84W94I=
X-Google-Smtp-Source: APiQypJBm4To7jBxn7D1Cq9CfzjjTtZNgpl2IuBFxf3Fcg6Q/N+Hon/CFACGR8FO1UWqhri6nefZbg==
X-Received: by 2002:a19:e308:: with SMTP id a8mr3193799lfh.135.1586542282782;
        Fri, 10 Apr 2020 11:11:22 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k18sm2271689lfg.81.2020.04.10.11.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 11:11:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q19so2731169ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:11:21 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr3471575ljc.209.1586542280902;
 Fri, 10 Apr 2020 11:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200410132706.170811b7@canb.auug.org.au> <27c212c4-b522-561d-411c-e74dc0ff0b74@infradead.org>
In-Reply-To: <27c212c4-b522-561d-411c-e74dc0ff0b74@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Apr 2020 11:11:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhsM-n_NzSh=cSdpThX+62-x3EmyKjhMqGHFYEyG0nPg@mail.gmail.com>
Message-ID: <CAHk-=wjhsM-n_NzSh=cSdpThX+62-x3EmyKjhMqGHFYEyG0nPg@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 10 (lib/test_printf.ko)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 9:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> KASAN detects a use-after-free in _raw_spin_lock_irqsave while
> running lib/test_printf.ko.

Btw, can you run these kinds of reports through scripts/decode_stacktrace.sh?

If you have debug info in your build, it will give much more
meaningful backtraces with file names and line numbers (and points to
inlining decisions etc too)

(For individual symbols, use scripts/faddr2line, but the
decode_stacktrace script does them all in one go).

I wonder if these scripts aren't well enough known, I see a lot of raw
dumps that could be immensely improved with a little scripting - but
they need the original vmlinux binary with debug info, so you can't do
it after-the-fact somewhere else..

                Linus
