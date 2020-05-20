Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB9207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKm4+EwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgETMDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:03:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:03:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so1179230pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSTZY+FCH/CsbXzCEs1ajXnnqSDIAGZV3gPCDr9dJDI=;
        b=OKm4+EwS5DhdDxYcBsveRI/pq2+Eb7ZuGjPHfVxDACoZQJrihB8xe+Gw7dNU6tInkO
         LgpV5U+BjMXzlu/DdJ2cj6KZbBRzfAxIVrLaSoF6jiHQxSCYjarqHiNlpoXCuybtrLa8
         bKwHymbdwb+yNHuT7dvrS317yS09HDnhYwjK5Hl484kPz5A1++onfYG5rMBRX0kCcTz0
         5RDUJo5HbvZoNRij6pQAICFEYaMXsV3hyX4ksvGz2EfGrDxOwuzyCpnr6z6j4JiBrwU9
         i+FA3koeAUlMVqS2eN/PkBC1HHFvUYHbTLKmb9ffYEa24884t6YvPN5EUqGgf5LubRpx
         nYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSTZY+FCH/CsbXzCEs1ajXnnqSDIAGZV3gPCDr9dJDI=;
        b=XsUMYUPEp37Y2dvfsoZKJ+1804as1kdZsRdYM4/IIvLSv51SFrfWLIZFukndD4dnhu
         AvD1Q01kqWsT9xcuwdx5zCBWbMPNykjPhtomPApnmksWO48URHHaPKd9gYhbmsSfebhN
         pO8PDGl88RPkyufQVdVIUO/SjS4hHtHpg+Q2i8RtIG221rk3S5p4o6Z5olGi6Ly5zAzX
         6D/5DgtDjVCHN3uamfrXeQoF+CR0hh+SDUaEz7Zl/3YR1niXumWV6+ZIJtdO+Do/ihwI
         sS1wI01FfsIqc8zIxA4alNAVwaQkNxgjO3wx1vocTDycnOQrnCL4LwGzci/4v71RK+oN
         /WZw==
X-Gm-Message-State: AOAM531OvWsjYfuBfeEcGfnHUlYQQhMlURuKugSPvo+rqmL/G0FdEGIb
        6faSoX00MhoUPxpl5yni5rNYzba+KGFqAajkbw0=
X-Google-Smtp-Source: ABdhPJzlS0/QLumcsxy/AkcPqpC5Qj+ROn+VA0uMqCHu4uTcyy/8IRu5SVpkweJZ8phlfvhYFMenpmAcw+VhQDfw5Gg=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr5160248pjb.228.1589976219013;
 Wed, 20 May 2020 05:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <202005201042.yjSO10j2%lkp@intel.com>
In-Reply-To: <202005201042.yjSO10j2%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 May 2020 15:03:26 +0300
Message-ID: <CAHp75VcwekGU3bQDWkaTmLE8SPU7NZoUY6Es9Fy8oG5E=LT81A@mail.gmail.com>
Subject: Re: drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match'
To:     kbuild test robot <lkp@intel.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 5:23 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Chris,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   115a54162a6c0d0ef2aef25ebd0b61fc5e179ebe
> commit: e9e40543ad5b38b848879768359fd13650529961 spi: Add generic SPI multiplexer
> date:   3 months ago
> config: x86_64-randconfig-r022-20200519 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout e9e40543ad5b38b848879768359fd13650529961
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>

Fix has been submitted:
https://lore.kernel.org/lkml/20200520120122.67528-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko
