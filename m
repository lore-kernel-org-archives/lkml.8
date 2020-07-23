Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD1C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53404206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvq/2AkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgGWM1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgGWM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:27:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F2C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:27:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so2933520pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lieebjtDdlU4fQmXZR5p7nEaYKK/7RzpZddWMXNez6s=;
        b=Xvq/2AkVeAoreBTplwDbHA6TE9XTz9Hvj6kvDSLdTdrZ40ZsLQP8gTJda1duBq+BVE
         L5QGm+BpnYstK/J3kAegn5QN5lB+4Oad5iVPy2ZO5cSawTFECQAsWAPYtiFDa2YXJ5kP
         /1IEm76imNIr1IVh3SLzTKVZ8XvlspCXPFjXaB5o6vF4OAWvbg8MjCRU1zh1PrwWhKEq
         k8IZn0kqdeQoIref7mi/YV0hMWtE98x5ZHAkAcJSSdse7jZAEOV54UQAN48gBcM4/opq
         cfU5NNKRvW3kAWAdNUhobnwwmwU/j2acFH1Earg4JH3gHfrgPygmP1q/Wa9Ub8Ge0xrX
         uLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lieebjtDdlU4fQmXZR5p7nEaYKK/7RzpZddWMXNez6s=;
        b=QhQd+16KM+p+3fUx/HBasSrZWKF4dD+T1248g9AzhhpVAGNuVPefl3+XQCJiCZqmcI
         FmCqaEnVAuB1ehCYCHNrh55CEVnPXagdbcDylu/+smaMG3BsHIvh/u6sM+/73SoXmZ8U
         ssUd3FOlfUVyubf5ko8wIRHX2nh/yHE/SORIpYV3AsUXa6PXs9qRlbRoBodKYS6meewC
         TDlZ6hltI0qEpaqUs8sFDxZrJEkfaKZStIbudprsfdv2sj4Bm6Na7DzbYKFt3stuxrIj
         oHInq/9UBF92mW1juBz2gJ33SP2XhbThMWmBde+Ao0loc0yfWpZvPetVd2Gm2xd50Nda
         Zfww==
X-Gm-Message-State: AOAM531t3Z+jq9DA+k/c02qhIlu9r/E/Bmzu2k0KpPIPIDlyGz8iToRK
        LRQZFSdLlyseqiqPD/oI5FU4TsyM/VTv8tU1EOmPe/is
X-Google-Smtp-Source: ABdhPJxvx67nipqokrX921pbgYRvniV3tyBDvTu65YFq8A7iywwhOw5ApPvL4+vz6erQzqdAISgoO+AATgdoiXrMwuA=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr3819505pfd.170.1595507228551;
 Thu, 23 Jul 2020 05:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <202007231701.CV9tyb31%lkp@intel.com> <20200723121617.GM3634@localhost>
In-Reply-To: <20200723121617.GM3634@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jul 2020 15:26:54 +0300
Message-ID: <CAHp75VeXh0vsydRay1a3uBP2kSsr6bNV7bT=vgCS7CSSRYT1mw@mail.gmail.com>
Subject: Re: drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context
 imbalance in 'pmz_receive_chars' - unexpected unlock
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 3:19 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jul 23, 2020 at 05:29:14PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
> > commit: 08d5470308ac3598e7709d08b8979ce6e9de8da2 serial: core: fix sysrq overhead regression
> > date:   4 weeks ago
> > config: m68k-randconfig-s032-20200723 (attached as .config)
> > compiler: m68k-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-93-g4c6cbe55-dirty
> >         git checkout 08d5470308ac3598e7709d08b8979ce6e9de8da2
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >
> > >> drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context imbalance in 'pmz_receive_chars' - unexpected unlock
>
> This warning is far from new,

I suspect it's a new sparse and kbuildbot that decided to unveil old sins.

> but let's add the missing annotation
> nonetheless:
>
>         https://lore.kernel.org/r/20200723121423.24217-1-johan@kernel.org

Feel free to add Reviewed-by: Andy Shevchenko
<andy.shevchenko@gmail.com> to them.

-- 
With Best Regards,
Andy Shevchenko
