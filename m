Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377BC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C198E20767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meV1X0Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgDWQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729480AbgDWQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:31:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F972C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:31:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so7100427otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nc4huYVzVXQa2iHIqmj93nir6SYe8DbxmfBtv9Rk6Y=;
        b=meV1X0FjXR2mrFSlpEo2HdtLnf+nQDbWPbQNIH4L/WoER0iZBBKDxnL6U9OZdOMkKJ
         CaZ6tjyKArkAs6MmcIxg4AZb0ljPZ3TWnEYwb1OhvnCYpu3bTvV5UShHtoq/2ZD6uozX
         xEHLANVa7I/15IwEwvO5JBDubTVtRx4JEkG2IUqYKFRLJsCVUTjlEVGYG8FEgdu2lZgX
         iHb1PhAMQd8fREL8LswBILcWrkjvGI+H/4ruWWnfRSWjVZ0kDk5B3hhfc0SQUy9JanaS
         /pyn2KQ53UA1+YGpi9kRfyJMHLMlnL4KaFaDe+eyR0FuJi/haIgOSif2CSnxP47aZxYM
         Z05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nc4huYVzVXQa2iHIqmj93nir6SYe8DbxmfBtv9Rk6Y=;
        b=kH5vLGl7HACU68qo2KJa38sZ4/6PE5g96yDXSD5vEb7sP8+H+B0c+ZJP8kBk8WKPwj
         7sjUaQ0jkB82iAYtUYWAAWCqqAz3+PWdliDuXN5QgT3jz2VTwLuPv530nPZj/XwIeZBm
         l1O7KpxA06n/GzHRrFWQ3V2M/ilv/stzHexWT6BSj75LklkRjNuIjicvbtNWRPIUOZ75
         NiuAmNZmXlU/amTgG+nMbSGJAuhyt8r03RQPMBY928iylTP0Q6SxJM31B2VOhaNjQPqx
         V6gr2igYW/aDUQeS3nsIhbI9neCv73J0Io1ZxUHLIDPK086TytM2ww3KHSamEfFbKIJG
         tXXw==
X-Gm-Message-State: AGi0PuZsL5ALmY3mZSevZDVvpDtx+VJMwdyLSIlPOiJpdS3vBF+R/Xss
        N61MDGf3cFLUg7g3Bjm4duQ=
X-Google-Smtp-Source: APiQypLQtkFlpwbKe2MjFzT5uGypksGv3ciJO2RS1cuntGew2xP3rTmjBOrQKvz3qa/lo7EA+Bt+Mw==
X-Received: by 2002:a9d:7c1:: with SMTP id 59mr3958647oto.69.1587659459636;
        Thu, 23 Apr 2020 09:30:59 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y2sm783408ook.29.2020.04.23.09.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 09:30:58 -0700 (PDT)
Date:   Thu, 23 Apr 2020 09:30:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: drivers/usb/gadget/udc/s3c2410_udc.c:255:11: warning: comparison
 of address of 'ep->queue' equal to a null pointer is always false
Message-ID: <20200423163057.GA43481@ubuntu-s3-xlarge-x86>
References: <202004231508.Yo0J11ax%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004231508.Yo0J11ax%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 03:02:27PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c578ddb39e565139897124e74e5a43e56538cb33
> commit: afe956c577b2d5a3d9834e4424587c1ebcf90c4c kbuild: Enable -Wtautological-compare
> date:   2 weeks ago
> config: arm-tct_hammer_defconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2de52422acf04662b45599f77c14ce1b2cec2b81)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         git checkout afe956c577b2d5a3d9834e4424587c1ebcf90c4c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/usb/gadget/udc/s3c2410_udc.c:255:11: warning: comparison of address of 'ep->queue' equal to a null pointer is always false [-Wtautological-pointer-compare]
>            if (&ep->queue == NULL)
>                 ~~~~^~~~~    ~~~~
>    1 warning generated.

Thank you, patch sent:

https://lore.kernel.org/lkml/20200423162923.10886-1-natechancellor@gmail.com/

Cheers,
Nathan
