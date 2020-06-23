Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED70D20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD8BvuUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbgFWV1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388976AbgFWV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:27:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE33C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:27:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so14495pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QwoBjXxFI8dB+I08ZRqPOWzeMhxoaAlX8z2Pyczloc=;
        b=BD8BvuUIwxYjkB05U50Nu0xKmYs7qgFwtfM0T3hu8ZZKixFL9uPEJ68Q55BgYVvw/f
         QmyhXEJ3+ihuaQKDkpAinbhKPLu4AGfOCn0YlCRQksPV/3UuRO2lb3mmPfutZy/ak8Fd
         mSicVaxLe8+63UED5Vr9GptFvjmoU4AKAncdIVfoMO9LEWfIJerWd77ubteWfh0yiYAR
         ilVCsIMXLjNuBktgb7qcpqBc4qWI9s/H+ikfADl9t4N6B/yVs70cm5ERaLq/OEEhs4I9
         3yTuWCURr1mIs7XrP6DXEnfZ2stkaHzYO6z+CQiRsNfoJHtVjjl5QyM4uXmWlk5D10Lb
         KyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QwoBjXxFI8dB+I08ZRqPOWzeMhxoaAlX8z2Pyczloc=;
        b=mhQEKgc0iYhstCpVNXChhRX9Ipg+iwjcim7L7Gt1j4Rjl0UjONxPWwUKleac2Ur0BD
         AozY6TuRf9/JNMIaBr5Y0HykcJsufJIAo0+HzyJjRa+ekciYFRkuBodPIWitIVMquaK1
         KfI4YZvCryDx5oFuKslzG6+4BdKZj209CcnMtcyBowTLhqVABU/XyLz7Kej5TVXSn7tY
         37Kfe4fMvDsYVS/ZVaFIarJMnjGtlbcAIa+PD8AOgKCJVnZ8mmNUhCO/pq/QFcC1aUAE
         vvdTEnEicOlZWgN6LjFYo/31G0dhGkEiu250QaAVmYBI+HFz2Pz9hFKNTQDp3B7IcVVW
         PRKQ==
X-Gm-Message-State: AOAM530Kq4HngitmNQzCO09BqzN004A0H/PZ1EjC6AN3MGoKqwuY3kcF
        otjnnkiToyo/s9rfHWqrGcXP2xBtichNxGmWeUEYiw==
X-Google-Smtp-Source: ABdhPJyDsoil1tNZymqblaiq/Gpm3jD949DXL5kBrQN6nbUeVPWa2cQPXlLN3ezdoZLR3zf+AR8vBePxUoPyKosL1Oc=
X-Received: by 2002:aa7:979b:: with SMTP id o27mr25288704pfp.284.1592947663618;
 Tue, 23 Jun 2020 14:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <202006201644.0TU5y2nU%lkp@intel.com>
In-Reply-To: <202006201644.0TU5y2nU%lkp@intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 23 Jun 2020 14:27:32 -0700
Message-ID: <CAFd5g44jTP9qtYE1knkRzwTWATKfZREWDrTn=T_WwZEGkNSemw@mail.gmail.com>
Subject: Re: xilinx_axienet_main.c:undefined reference to `devm_ioremap_resource'
To:     kernel test robot <lkp@intel.com>, radheys@xilinx.com,
        michals@xilinx.com
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 1:59 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Brendan,
>
> It's probably a bug fix that unveils the link errors.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
> commit: 1af73a25e6e7d9f2f1e2a14259cc9ffce6d8f6d4 staging: exfat: fix multiple definition error of `rename_file'
> date:   6 months ago
> config: um-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout 1af73a25e6e7d9f2f1e2a14259cc9ffce6d8f6d4
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
> >> xilinx_axienet_main.c:(.text+0x1aa6): undefined reference to `devm_ioremap_resource'
> >> /usr/bin/ld: xilinx_axienet_main.c:(.text+0x1d06): undefined reference to `devm_ioremap_resource'
>    /usr/bin/ld: xilinx_axienet_main.c:(.text+0x2001): undefined reference to `devm_ioremap_resource'
>    collect2: error: ld returned 1 exit status

I posted a fix for this months ago:

https://patchwork.ozlabs.org/project/linux-um/patch/20191211192742.95699-4-brendanhiggins@google.com/

I thought it got picked up by the maintainer.
