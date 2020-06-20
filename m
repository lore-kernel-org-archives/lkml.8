Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA04EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F059217BA
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cWfhB8cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFTMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 08:20:18 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B5C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 05:20:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p15so5785799qvr.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91lSncxetWOYi8GWSm5zPOBq7+Lsz6FqHQ6JMSbwAUg=;
        b=cWfhB8cwZFrUhqraEO/CubyhIdnOKRDo1D7NW924OVO4jDyi98Fkvll7bdaHAgEmEm
         tEjwZHKx2Aq+EXz191ZIcuGs2H7a8cwmWlsXVR5gP6qUUbcxk9xq8JwZT5ePqD4LI7JS
         gHLi8rxbHnwuwkATvXAmp2p16TovMAeLmCHqysj0tlNNbABDWbXg7vEXAvGfJtDou3iQ
         nhm/Pz3a0sCKMVnq0pYmB9zUf9CH0x6kRs0zqsHtERhMOQtQLLvVRanXUDxjLKVnZVza
         /0WV/Y/f4IcL/TK84B9GR0+2mKuS/xJGogk1YyC+722CGKnD7bKQcCTi8XLjIwFOBcOD
         Ttvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91lSncxetWOYi8GWSm5zPOBq7+Lsz6FqHQ6JMSbwAUg=;
        b=ukkS8EhBVY/6YxUtVJc5wqpZzuE0uqVfB6ObdwCSprPAmqNwksu8CVXy8cZ+AmbbW2
         aavbI/G1eG+J5IG1az0AHSu6IP3TQqEFTCeoCoeBNIepWwzz81vch78qUrCrqSkE7jtq
         K0hERMi1lp5JojTdAYO70RAlyPF67pTQWN2rwCsMG6HlWFsk2rc0gqySnFJpYlzhekwq
         NQgvIm843Omgh6OFW4eEUH4fNhsVfmnGDQTry5OUnWXWBWh7tVB7JJzWHLtE0lWZUPru
         gE8GxyREV2qw5BJFAo3zamjNAYz0fsgV6Uu8Kz4IySiHpajRsfNrjcMY38+I9l4atxc2
         aUxw==
X-Gm-Message-State: AOAM532UrRUNbjkC9dvbHCawbEeU83mIsmE2j1Iqf9eDZRipmMDcVS4a
        TMYmbEcR5+1FtLC8Y0pLrzbK2K0fQaRRjLAoynlHVvf+
X-Google-Smtp-Source: ABdhPJyjjw/G8m14q4sN785nGBLEERcuiz6aU9cU7oo4/BR9bTLBGoIX8+UUvoUPlfrxQQTEdZkirpNP4/4g8J8PkHg=
X-Received: by 2002:ad4:552b:: with SMTP id ba11mr13563208qvb.145.1592655617013;
 Sat, 20 Jun 2020 05:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <202006201829.cD1eClfJ%lkp@intel.com>
In-Reply-To: <202006201829.cD1eClfJ%lkp@intel.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Sat, 20 Jun 2020 20:20:06 +0800
Message-ID: <CABvJ_xh7dResyquiQRKnVjrS_4YEuMg+XsCLR345z6dRVRufgQ@mail.gmail.com>
Subject: Re: riscv64-linux-objcopy: 'arch/riscv/kernel/vdso/vdso.so.dbg': No
 such file
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 6:11 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vincent,
>
> FYI, the error/warning still remains.
>
I have found out the root cause of this error and I will send a patch
to fix it in a couple of days.
Thanks for pointing out my mistake.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
> commit: ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757 riscv: use vDSO common flow to reduce the latency of the time-related functions
> date:   9 days ago
> config: riscv-randconfig-r023-20200619 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> riscv64-linux-objcopy: 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
