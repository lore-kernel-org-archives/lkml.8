Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB71BC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E7321BE5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVCWdnIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgEGTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728765AbgEGTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:22:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE60C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:22:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so2467757plt.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCmfLDT8Xg7KPWdKGsHrM2wJdMC2w066YnMbUyG6BXw=;
        b=CVCWdnIeskzXgjEvarxpiqkffrQBPs2WijjSDxPkUwJ88jvue9p8Q6qNV7j3mUyeO2
         D2mvbyqxacJUrQSCSThA+zohdxCizwaw6chIgnZ4c5qV27xYnAHyw+Lw+rILBt64PlBY
         5VB+VH8MF6ViEQZV+1rMnUMCyqi0ucXmWRWHwsgp8IE9CMQ2Zly+G01wDMYURAjiDEQ3
         L4Wf1fpshwO3J+v+pdW0hR/518mf35doIpWL5bgJpwepfkXRwQiVaxiq81tBBJf0i4l5
         w5kEnEVCa5/n7Bp+U9naTAsgjX4XBCUk7TAyWv3c83Iccma+VlOVqs2T+BtxDlo/9Nvm
         Bqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCmfLDT8Xg7KPWdKGsHrM2wJdMC2w066YnMbUyG6BXw=;
        b=J1j/7AtuBw7bKBc9w8DxuQwcvpzf0966Ygx+K+7n3AkOxM8y6tICJUiMQHYh7RHxmr
         evRsUct9O7qY7tb2eG9mKZLT65a0XtngeQCfuNqUNfmFWnBq1FvnA03SclpQbzly/Gll
         8pYFR9HmGEf9sLVAXRou2NHU+4OiaXtnazUzDncBDglg9HAUB5x+WskKBNewH+dF77+z
         kjOjR53Y/rP4dohkjY6qAbx7ddZmqyW6nsx7v0tuEJTYNnIYl9HgJAUZbORSkpefeSeG
         XvVB8apF/A95JRAeCP5AKAGXimKwXxx0bSqdQeSrmzffEWEwRTuH3581Xfwp3u+tA7nT
         NVPQ==
X-Gm-Message-State: AGi0PubaDLu8xrB+q0LH7PeRQXLa4uIQaNoa4v1GQAu13184jACED6rs
        /n9aG/VdEmt6ykCOC+v7YPwpQvaKerNxohUtDzN7eA==
X-Google-Smtp-Source: APiQypKZf8A090ZDvGuBz3CHEyUiXsMKYwK21ZQueA0X9dCsq/lPGgTnG11u9kIQXG9S8PQBykNWGB5k04jsWiGEo1k=
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr12412963pli.179.1588879361657;
 Thu, 07 May 2020 12:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com> <CAMzpN2idWF2_4wtPebM2B2HVyksknr9hAqK8HJi_vjQ06bgu2g@mail.gmail.com>
In-Reply-To: <CAMzpN2idWF2_4wtPebM2B2HVyksknr9hAqK8HJi_vjQ06bgu2g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 May 2020 12:22:30 -0700
Message-ID: <CAKwvOdkBaxyOiO8+_cdBenkOj5cqcn9OhThOLmbt1uMyTW1P6g@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        stable <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 11:18 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> I think a better fix would be to make CONST_MASK() return a u8 value
> rather than have to cast on every use.
>
> Also I question the need for the "q" constraint.  It was added in
> commit 437a0a54 as a workaround for GCC 3.4.4.  Now that the minimum
> GCC version is 4.6, is this still necessary?

TL;DR yes

ah, thanks for the git archeology, it's useful.  I don't think this is
a compiler bug however, just the compiler being more strict that the
`b` suffix on `orb` requires a 8b register operand.  For 32b x86, `q`
asm constraint is required, because not all GPR's had lower 8b
register aliases, as Arnd found and HPA noted as well.

I like your suggested change to CONST_MASK, and will send that in a bit.
-- 
Thanks,
~Nick Desaulniers
