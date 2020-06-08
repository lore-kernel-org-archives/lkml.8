Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F53206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUFbq78O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgFHMIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbgFHMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:08:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D5C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:08:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a9so16582306ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVAlJ3ENw6iA1llBw77h70B7LKCg5s0+Fsgmgt32t0A=;
        b=NUFbq78O8TZa5gq48JT652lCI13tv+Cj890fyZENeoLHgvu0yriNuP84rHD4AFNmRP
         nbf0XqeFJDEnrQrMiaLB1FTwaMk37gtPlL7fHuX257DuLecgRLhbgGxUiB50sqmFxt7T
         ovo7cQQA59+hPnNclow+RLxZMM0iwNCwYM7KWQnH0qScFp2IdaCAx3sXJuYM73CMIaoG
         NardiJ1us3g5b9B4PdTnP7j+63esEy8uUrhwbKYSVUreMH4lULwxeik5AUnSAjit4jMT
         l7QGBMyY+vPOtl6cc6ap2cIR31UZbaide0nqXX2nxbqKpCqiXBYnpiWLPOa3m586t5ci
         ymrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVAlJ3ENw6iA1llBw77h70B7LKCg5s0+Fsgmgt32t0A=;
        b=dF3NnOp9rdlXc+9xNkIrvHUkioCLu3ogfNscPtGGBHHUCljODmf22YZzJjIcuQmIC7
         jDu+/9KWY8A9R6q+Kt2eQN/ZjN7jaCZfO1GtbKW86f8ErhgkOHAR54FTgMETh5K914hp
         atkn2AnrfZEn38IGQobu/wmTTD/tT3vYYMtWvjRj4NCleJh45e2SUL/BFxjyUk4pNCrU
         v6lLXfNVCNYBFjI2kBygk7yE155gCpaUwtzwtDX5yP+D3m+8SIugwgKHZbglg2TjNTpH
         5d6wvysTpYrDecHNUUKB2BADEJfQmv5NqFL1fSTofTS187dx9mYoz+7ZXnTuUz0d1Cce
         qr5Q==
X-Gm-Message-State: AOAM530kNgggScOmzWIYW19sfUD29+drXqfYEi6+9+xU+Hnv9RJuqQ+c
        SExQQTJgT+cVDTwvkK62BLmG2fk9WTWonGCLpJc=
X-Google-Smtp-Source: ABdhPJxjEDGndqA79nMvT+RfirGdYB/AMAQHxy38HosGZ4pQ3QHmx1QVN56pdxR8Crg2cSGSfeFDv68qgIP2MaDKfyA=
X-Received: by 2002:a2e:1453:: with SMTP id 19mr11718756lju.155.1591618111949;
 Mon, 08 Jun 2020 05:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <202006080221.W31nOYBR%lkp@intel.com>
In-Reply-To: <202006080221.W31nOYBR%lkp@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 8 Jun 2020 20:07:29 +0800
Message-ID: <CADBw62qBkjftmi-4pR+NVs3P=os+nzjF9wK06=oU89w9kdxQAg@mail.gmail.com>
Subject: Re: drivers/hwspinlock/sirf_hwspinlock.c:87:34: warning: unused
 variable 'sirf_hwpinlock_ids'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 2:38 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3b69e8b4571125bec1f77f886174fe6cab6b9d75
> commit: ffd0bbfb378ecd56eac22bf932ccdbf89ac7f725 hwspinlock: Allow drivers to be built with COMPILE_TEST
> date:   2 months ago
> config: arm-randconfig-r001-20200607 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         git checkout ffd0bbfb378ecd56eac22bf932ccdbf89ac7f725
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> drivers/hwspinlock/sirf_hwspinlock.c:87:34: warning: unused variable 'sirf_hwpinlock_ids' [-Wunused-const-variable]
> static const struct of_device_id sirf_hwpinlock_ids[] = {

In your testing configuration, the CONFIG_OF is not select, so the
macro 'of_match_ptr' becomes NULL, which triggers this waring. I think
we can remove the redundant "of_match_ptr" to fix this warning. Thanks
for your report.

> ^
> 1 warning generated.
>
> vim +/sirf_hwpinlock_ids +87 drivers/hwspinlock/sirf_hwspinlock.c
>
> cc16d664e21ef6 Wei Chen 2015-05-26  86
> cc16d664e21ef6 Wei Chen 2015-05-26 @87  static const struct of_device_id sirf_hwpinlock_ids[] = {
> cc16d664e21ef6 Wei Chen 2015-05-26  88          { .compatible = "sirf,hwspinlock", },
> cc16d664e21ef6 Wei Chen 2015-05-26  89          {},
> cc16d664e21ef6 Wei Chen 2015-05-26  90  };
> cc16d664e21ef6 Wei Chen 2015-05-26  91  MODULE_DEVICE_TABLE(of, sirf_hwpinlock_ids);
> cc16d664e21ef6 Wei Chen 2015-05-26  92
>
> :::::: The code at line 87 was first introduced by commit
> :::::: cc16d664e21ef640faaf51e9952384cf90b92d9f hwspinlock: add a CSR atlas7 driver
>
> :::::: TO: Wei Chen <wei.chen@csr.com>
> :::::: CC: Ohad Ben-Cohen <ohad@wizery.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Baolin Wang
