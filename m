Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11ADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A947C2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OChVtVFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFAEyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:54:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3692FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:54:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o9so6482256ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFSYaUeH6bbEPrcWmIISYpjM8SJ6UtUjsuzuTLo613A=;
        b=OChVtVFMRePEkw6sCWnVXVnlXqexPXQF81+dbi/hEvAO2/FdcRtzm96MtavQREIkxi
         8ZVt4/5K5kWZBSSKL4rsy0V/sCLKvesv9HdctX7JvjqRqVNh4axTebCMUji5+teXj36B
         NMCuiXCF+1HjX74Jm67vXvK80iysmdxCBa26b5a6x8cLwz9h9/TXkPenJrhEof4Tvf1K
         vqeBXcM203sRAw/NyE6uQAf/J0aqx7HzfnHNZ5KUz9pQ919dIRNsGIRozP5K+YqSj45x
         IyDj49fvKuLwJv34HFoz+EWwSrEvn12AQK1ykomrjF7wWDLFP7OHOVvMTEWjnvdxcnqM
         7eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFSYaUeH6bbEPrcWmIISYpjM8SJ6UtUjsuzuTLo613A=;
        b=F4SzyDkHxstCf8WnHRqqi91yYwRqpYjMJACctG0ornOzbU8tumIAMo4Y7eyewYWu5g
         UXBX80SW/spZos/0d71d6dKvzJFAQ8bFhuk8EtvhJH43CSOCQlrlfasZIkWrTGFiUpet
         8s/TWNIVyZLdWzEc5XTnc/JjKWTrsDkxS7O5iR+TL5pc2/O/NWPYO6HVHZUHjeVdlltS
         RGrYUzG0rT0UTkFkLNsHRQxWcVB3Az4+whpLKie+y+dXvm9kMvFJPT6wzmmupHdsWM9w
         7atuxYnexYBOdOFr8/naMmbrXKJDplVXXCPM6OJRnjXDv4vPth7NF6EEnR0If3XARe4+
         k9CQ==
X-Gm-Message-State: AOAM531A8HJHQzlfGXs2NnkTSISixbjGGzoYDzblYA50lkcuQ4yu8sH5
        Kx/Yz3veGtt6tMjRDm7taegJYbFGHckRXyksF3u2tA==
X-Google-Smtp-Source: ABdhPJzjx4JrFGwf17KmTYfrs8QukHRA4wXCg660QnTwSRtyKKP8Wx7WX0nvnjxDMgdZH0L75v/i3CHka9+afTO///g=
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr24209ljo.110.1590987254498;
 Sun, 31 May 2020 21:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-5-git-send-email-sumit.garg@linaro.org> <202005311324.We2amqkp%lkp@intel.com>
In-Reply-To: <202005311324.We2amqkp%lkp@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 10:24:01 +0530
Message-ID: <CAFA6WYOLApZTXkE0KyN80Fr=9cnBHqzbA9suQvzG4D8ZzOnBeA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     kbuild test robot <lkp@intel.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 at 10:58, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Sumit,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tty/tty-testing]
> [also build test ERROR on usb/usb-testing v5.7-rc7 next-20200529]
> [cannot apply to kgdb/kgdb-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Sumit-Garg/kdb-Improve-console-handling/20200531-075431
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> drivers/usb/early/ehci-dbgp.c:1062:24: error: assigning to 'struct console *' from incompatible type 'struct console'; take the address with &
> kgdbdbgp_io_ops.cons = early_dbgp_console;
> ^ ~~~~~~~~~~~~~~~~~~
> &
> 1 error generated.
>

Ah, my bad. Will fix it up in the next version.

-Sumit

> vim +1062 drivers/usb/early/ehci-dbgp.c
>
>   1046
>   1047  static int __init kgdbdbgp_parse_config(char *str)
>   1048  {
>   1049          char *ptr;
>   1050
>   1051          if (!ehci_debug) {
>   1052                  if (early_dbgp_init(str))
>   1053                          return -1;
>   1054          }
>   1055          ptr = strchr(str, ',');
>   1056          if (ptr) {
>   1057                  ptr++;
>   1058                  kgdbdbgp_wait_time = simple_strtoul(ptr, &ptr, 10);
>   1059          }
>   1060          kgdb_register_io_module(&kgdbdbgp_io_ops);
>   1061          if (early_dbgp_console.index != -1)
> > 1062                  kgdbdbgp_io_ops.cons = early_dbgp_console;
>   1063
>   1064          return 0;
>   1065  }
>   1066  early_param("kgdbdbgp", kgdbdbgp_parse_config);
>   1067
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
