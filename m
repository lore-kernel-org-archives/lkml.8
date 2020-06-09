Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F68207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHkHqvlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgFIR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFIR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:28:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F253C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 10:28:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so9048025pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3B+9yTh46/BVwzmcepxOuDSOE+3/rQqLOGf+Ca3DMk=;
        b=kHkHqvljZcoQtitE4u0NGvji/DVLTD1F+TTnQRJ5ZhjVi36mECcY4XeQCeybRSRyEB
         Bo/9mFSNIt6sli7aFjXSRW/JJeRmkQ6dEN0sIC5pYv3R7j+9BUOH9CX0/A5IJnS16WUV
         jXaVDrkko3pcVjPxCXRhFTj0G3CphohwTJgJ28B5LHCPHR7zgn9OwedbTH0cUuOR437W
         Tjk06dHVrmEt75i46aoY3BNWSZQ+3geo0NzOPR7O/2bAvwb5ljWJNDNDDRRZiH06ZEPP
         BBt9eT71RVubGKSQUsyo0j26FAZqPYPKKn6phHe3wsq9MSWchx4umMracMgQUqspC0gF
         bStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3B+9yTh46/BVwzmcepxOuDSOE+3/rQqLOGf+Ca3DMk=;
        b=N6fm1Nc2aI8uGutY4Dq6Q00uF02vyWxqmp0J6xi2ywkkBVx7Xn2mcoO11apZYIhejY
         QgaI5GBb/yma5804o1SSLWSgvre8IWafB4GUPSuOhIdheEvd28fmDvkphazgRLHydTse
         Jik4jKagDWF9aY30tRwPkgbLGnzRGTMKQOQiBIZsLCKSp1JDHx1G6Uptn2df16EqK2ij
         tnd+TqL2eaKo8HJAFnVjP0DrmmQFLxiSzuIO0wgDKgu+mjGM2j/+mr/tEhXlLfdAvLgv
         NOCjfRU7nH9c9b6p3o6DDv9O2AP8I+qIPCavtvpnSqV5SJqSoV65T86UmINv4hP04XjE
         UnWA==
X-Gm-Message-State: AOAM532BCYrZEZOd3WNPWhChAjHCw3H0Y+hYRQjLPocezTcE1TNll9CS
        Yf7liYn4SfNctqnvcyFMcWOvTgEDWDwWUwnacJdA0g==
X-Google-Smtp-Source: ABdhPJylaCT6qWwaJUo0RsIs24R1HvNw63dAqL1wPLovQ1/uIwaEIqTKThta0IkjEXe6GftiO2UdrMIQlP+MBPlc+Ug=
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr24268741pfi.39.1591723701888;
 Tue, 09 Jun 2020 10:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <202006092115.nevT7m8D%lkp@intel.com>
In-Reply-To: <202006092115.nevT7m8D%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jun 2020 10:28:10 -0700
Message-ID: <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
Subject: Re: gcc-5: error: -gz is not supported in this configuration
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
> commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: support compressed debug info
> date:   12 days ago
> config: x86_64-randconfig-r032-20200609 (attached as .config)
> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> reproduce (this is a W=1 build):
>         git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> gcc-5: error: -gz is not supported in this configuration

Hmm...I wonder if the feature detection is incomplete?  I suspect it's
possible to not depend on zlib.

> make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] Error 1
> make[2]: Target '__build' not remade because of errors.
> make[1]: *** [Makefile:1169: prepare0] Error 2
> make[1]: Target 'prepare' not remade because of errors.
> make: *** [Makefile:185: __sub-make] Error 2
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
