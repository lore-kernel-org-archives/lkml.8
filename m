Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57174C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F03B204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llD/wYAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgFDUnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgFDUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:43:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103CC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:43:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c8so7906910iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goYJSdVcb+PXjkKo7sE7PgZ+GNxicPpcCOMy+7tqyzw=;
        b=llD/wYAJd5ogKwgpI3ySzRMGFAtDp2ag5fjbbtuYyEe1Hd5jXTFkSG4Pws7uMbIMBP
         L9m91+6ZErrdqcHgxyLzT+JXzBaxT66TeVI8Sj5tPCvzQlcGASl1u8r+CUhXl6zcnh1F
         KsUkVENtK3E9/gxk4Vw2jrHMYWxAl+ZYbS18DQcGOgoqXLNzqEKO3yvRIidG4ceMpPr5
         tum/M/ECkmt4Bn5oOSIYy+nWUJEGt4SxkHSeeCLGiN6+Ox6XkNGRKqBXYKGXmIWKy9Xu
         HjuGMgx7ozLm2Xleo9qwtWH5va/iySTvCY40F5u/HA6lTcpNp6CaNEbJR1LXGx9BlmUC
         Z7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goYJSdVcb+PXjkKo7sE7PgZ+GNxicPpcCOMy+7tqyzw=;
        b=AVnuQPywmz5tuE+BaCai4j4L1MVmo3r8TV7ddE9OpCx/NBpn0opb51kyy6qaI0WeNl
         FhcS9s6hMYTO8vuzvDlndZyuPS2Jbtg3+In4ISyQUKUuUY7SdBxQSVineMbhsnHiAS1+
         3tKY0rQMt5de6B0QKCKwNdI3BD5oMpDqA5G1bE3djc1RpPMYTSerIa+vNKu+EPZkTGK7
         UNQgvKZc8RJkpZ12AJFFyf8X+eOKO8iC/AuTMgYuvyi2zLGLlz3u6lWkedZIkBh9x4n9
         mbfUU36Ntr0v5ENHfqTYxNLep88nvsNrEZBMNOHk7dvuNybeVImTjFqt6XG/u/vRwxIx
         T0mA==
X-Gm-Message-State: AOAM531KzxSRylMZqcjutvcbKzf2eOswgz5NBXcs0hU/LcUWJir0r038
        BOWTb2bxN9RlcyWdsj4iPkRQ5+dXfYeeeSTenRM=
X-Google-Smtp-Source: ABdhPJx08psJHqNdE3JBxRw2ZGzs+7FxtfNUHI3lg/VukHaEHV5L4gmyELZn4FVq0n3KJbpTCPxaZifAZ8YrzI/yNSA=
X-Received: by 2002:a05:6602:1204:: with SMTP id y4mr5721091iot.44.1591303386267;
 Thu, 04 Jun 2020 13:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <042eddd4b87f0db3588a79d829afe6b23fa8365c.1590017578.git.syednwaris@gmail.com>
 <202005310310.EOelU2v3%lkp@intel.com>
In-Reply-To: <202005310310.EOelU2v3%lkp@intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 5 Jun 2020 02:12:54 +0530
Message-ID: <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     kbuild test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:50 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Syed,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce]
>
> url:    https://github.com/0day-ci/linux/commits/Syed-Nayyar-Waris/Introduce-the-for_each_set_clump-macro/20200524-130931
> base:    b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
> config: x86_64-randconfig-s021-20200529 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-243-gc100a7ab-dirty
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> WARNING: modpost: lib/test_bitmap.o(.data+0xe80): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp1
> The variable clump_test_data references
> the variable __initconst clump_exp1
> If the reference is valid then annotate the
> variable with or __refdata (see linux/init.h) or name the variable:
>
> --
> >> WARNING: modpost: lib/test_bitmap.o(.data+0xec8): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp2
> The variable clump_test_data references
> the variable __initconst clump_exp2
> If the reference is valid then annotate the
> variable with or __refdata (see linux/init.h) or name the variable:
>
> --
> >> WARNING: modpost: lib/test_bitmap.o(.data+0xf10): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp3
> The variable clump_test_data references
> the variable __initconst clump_exp3
> If the reference is valid then annotate the
> variable with or __refdata (see linux/init.h) or name the variable:
>
> --
> >> WARNING: modpost: lib/test_bitmap.o(.data+0xf58): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp4
> The variable clump_test_data references
> the variable __initconst clump_exp4
> If the reference is valid then annotate the
> variable with or __refdata (see linux/init.h) or name the variable:
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

HI All,

Regarding the above compilation warning reported by bot. I think this is
different than GENMASK.

I am unable to reproduce the compilation warning.

I ran the command:
make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'  lib/

But the compilation warning didn't show up. Can anyone please point to me
what I am doing wrong here? How shall I reproduce the warning? Thanks !

Regards
Syed Nayyar Waris
