Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D83C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F68C2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JT7uXRe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgFJPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgFJPbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:31:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B65C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:31:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c35so1705255edf.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=RPRWMDi9dHl0rDLgLXdVcFXijNB8/Wji5rynt4uz2HE=;
        b=JT7uXRe2qYhx1okmLD2zOXgyCVnmm0XOMEQcl3Vd9MXGcXTQRVeRs+i3XvyYTBccLk
         upmBX0GCRT3QRqTCNAMFCIPdTKD2fW7mC3mITOToBsVIq/2CIbCOw8/Hd7lXMlCFzhVX
         p/aAPqTGARSPOEyi3zZNS2CKsn69pq1sDN0Q+GFa7FFy7dJfcBmjwTVykAEBJECNW3yt
         kdXWpo62D27vyP33vcBcxfvQ8kf1iQgCcJNhMvWbkAYTt5P92nLi6mzT4UzQEVTnu6A1
         ZQ7rPt/lCcaYcvMY9uwDvCPeFsQk/f1dRaTMBAn26TD7gq44lLegCw6sPAtqjYENosfe
         Dvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=RPRWMDi9dHl0rDLgLXdVcFXijNB8/Wji5rynt4uz2HE=;
        b=XKkym1xDGnNfp0bKqAnWcsFi2ur6apvGtH6xTg1RLU49ZRJKcxSgMHrL9M3JNySpb2
         rJ4X7xqij7kR9Qsmt/2EFdrIi7Kk7GVJKkj1fiyDGyKo2L8HjxZfnlCUXMmcx2g9pD+v
         +y4/9PnE1VcJEPZUaUOQMkE0RVAuvdvbhMSA9Xa8ILVmI5/YB8TPR2HEHRJsTu2qWBSS
         gOrUpwyvxi+o98mkFdJoOaZpvuqJP1s51fUFwRT+5Mc0HDnkFrw5aciM2LE+K/6xVIXV
         W29WV3VnCmT1PNguJsxJDFGCt4EMB0TLY1nFbDVmoQzWAueStuv3G72Gqm568dT3h6Rp
         7ipQ==
X-Gm-Message-State: AOAM532pLoYGURlOdFjxQR5wtK6Fnm9jd3Ahgho0aha8U+u4SPgiR6f8
        Vvmn7eumbUMh9LUxR16r8aKabw==
X-Google-Smtp-Source: ABdhPJy0d8cCKolNg97WfPvyEXB+t5UALbAk6jJPJu41XbDz0BAbjjJMNAeuZWv//X2o7Pmpk4vnKg==
X-Received: by 2002:a05:6402:690:: with SMTP id f16mr3042853edy.9.1591803066151;
        Wed, 10 Jun 2020 08:31:06 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k10sm77009ejs.108.2020.06.10.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:31:04 -0700 (PDT)
References: <202005311147.iLK0hQoe%lkp@intel.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/meson/t9015.c:315:34: warning: unused variable 't9015_ids'
In-reply-to: <202005311147.iLK0hQoe%lkp@intel.com>
Date:   Wed, 10 Jun 2020 17:31:03 +0200
Message-ID: <1jftb32b0o.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 31 May 2020 at 05:00, kbuild test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ffeb595d84811dde16a28b33d8a7cf26d51d51b3
> commit: 33901f5b9b16d212ee58865e9e8e80fc813f12da ASoC: meson: add t9015 internal DAC driver
> date:   3 months ago
> config: x86_64-randconfig-r033-20200531 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout 33901f5b9b16d212ee58865e9e8e80fc813f12da
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> sound/soc/meson/t9015.c:315:34: warning: unused variable 't9015_ids' [-Wunused-const-variable]
> static const struct of_device_id t9015_ids[] = {
> ^
> 1 warning generated.
>
> vim +/t9015_ids +315 sound/soc/meson/t9015.c
>
>    314	
>  > 315	static const struct of_device_id t9015_ids[] = {
>    316		{ .compatible = "amlogic,t9015", },
>    317		{ }
>    318	};
>    319	MODULE_DEVICE_TABLE(of, t9015_ids);
>    320	

Hi,

I'm not sure what to do with this report.
I tried to reproduce has instructed, the log is full of warnings and the
compilation eventually fails to link.

It seems that most (if not all) drivers with a MODULE_DEVICE_TABLE() show
this warning with the provided .config (COMPILE_TEST).

When compiled with gcc, no such warning is shown.
I can remove COMPILE_TEST for this driver, it will make the warning go
away but I'm not sure it is appropriate.

>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

