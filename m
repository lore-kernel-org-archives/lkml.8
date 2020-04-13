Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B31C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYZb4MqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbgDMWG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389432AbgDMWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:06:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D5C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:06:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w26so5237577qvd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVAxxHzDK/qARg7NchMjhRdvGGEcCTTmLqMEP50fxqk=;
        b=oYZb4MqSZ8X2CE6Y/k0aOzKLtL53RMFv1ShrKS9kAZLiSxbTQ/wZMM0ryIYVQLFhhT
         e+ZSddaE+zEhC3DF1QKsjRDUtNgJGnhRe9rM4lDBtjD6CloNjrA2WJk1gHzfbJum7MKL
         lKs4zbUC+eR3iJV6Uc1ONNr9Jby+bhRhWhjIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVAxxHzDK/qARg7NchMjhRdvGGEcCTTmLqMEP50fxqk=;
        b=b/i/BmPSIM/HtFtj5TK13cY//DDA0Gj+uRwBQRE9nWNdZKDx2VDttLFueIOA4axKpv
         PUMrf4Mc61ZoiYEBxvs/hD3SIaHRu9v5yFSnVo3tt64xroQAlNrctsoWFhE+G1vbv4WK
         wS7y3SdgiO0uF6juwIrNTx0EPwg1ugV0e/d/sOEfKs23CkgFoKAbgPM9MniyItBub6eF
         BoZyHsfjR3RLOL42I7+h5TCdxag/M5x6THk3zb9G2B+VxolC1/0ZKdEuSlCbLBKxcG0n
         77I0yFb+Vm2sPSq3LQd7xSPJzVTdOUXg/ogM5eCn+aV1VxUt/OhZ82aetz545nbHrxwX
         GCOA==
X-Gm-Message-State: AGi0Pub1epz4z1n3DgL2FJN2mgshSIo6CIoAb0oKbUoJKC+4imCK+gzU
        BUvSTuNHTYR7/95e5/Z3gRWhwr/vzpg=
X-Google-Smtp-Source: APiQypKU6geFrM1HjAUlkoAlnIDWYvGCD51cqQyM/wyIC4KJ/VAPdmYD3+wWL1aR25Qt2xo2rV0JAg==
X-Received: by 2002:a0c:f709:: with SMTP id w9mr19218904qvn.159.1586815601060;
        Mon, 13 Apr 2020 15:06:41 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z18sm10059297qtz.77.2020.04.13.15.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 15:06:40 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i2so6093100ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:06:40 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr10592105uab.8.1586815210988;
 Mon, 13 Apr 2020 15:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200410151632.4.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid>
 <202004110744.nPoRwmTD%lkp@intel.com>
In-Reply-To: <202004110744.nPoRwmTD%lkp@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Apr 2020 14:59:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UC-dKgmamNKFn_SEqcEisW1p4Z9iy8Nn8UqUxRsskZ3A@mail.gmail.com>
Message-ID: <CAD=FV=UC-dKgmamNKFn_SEqcEisW1p4Z9iy8Nn8UqUxRsskZ3A@mail.gmail.com>
Subject: Re: [PATCH 4/7] kgdboc: Add earlycon_kgdboc to support early kgdb
 using boot consoles
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, "H. Peter Anvin" <hpa@zytor.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, bp@alien8.de,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 10, 2020 at 4:56 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tty/tty-testing v5.6 next-20200410]
> [cannot apply to kgdb/kgdb-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Support-late-serial-drivers-enable-early-debug-w-boot-consoles/20200411-062123
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.3.0 make.cross ARCH=microblaze
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/misc/kgdbts.c: In function 'configure_kgdbts':
> >> drivers/misc/kgdbts.c:1080:8: error: too few arguments to function 'kgdb_register_io_module'
>     1080 |  err = kgdb_register_io_module(&kgdbts_io_ops);

Sigh, I knew I'd forget something stupid.  I have a fix for this and
have confirmed that "kgdbts" continues to work after I fix it.
Running it also found splats similar to what I fixed for "kgdboc" in
commit 81eaadcae81b ("kgdboc: disable the console lock when in kgdb").
I'll att a commit to my next version to move that fix into the kgdb
core and then remove it from "kgdboc".

I'm not setup to use kgdb over EHCI so I'll just fix that so it
compiles and trust that it continues to work.

For now I'll hold up on sending a new version to await feedback on v1.
If I don't hear anything after a little while I'll send a v2 with just
these fixes.

-Doug
