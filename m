Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F2A207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IG5ZWN6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgFIRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732599AbgFIRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B52C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 10:49:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so8327616plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jxw7SQE7IH2X4d9HfgPhhYW34Jo16ukZRQvK9MgirSU=;
        b=IG5ZWN6Awq8yhiA2Np+VMzFdkY6ggmVPtGvmKZaaOE2sIL2OyyYtxrW+J1EaP8c7VE
         rWKPAStlOVi4LznxoRCaje1R98TtgwMyFPXewLSepVH8AQK8U+zuG8AWrOAQUlTci5nR
         oi2IheCskDUY7qIAb7oQTHAqcOQbO2tGzbq50DbMl9dw7iAAtH3uJj43KHMnR/kP/cgO
         PQUo/03EPMTy5RkrfARr9IA7EELTP82nLlTzvWpFOJvqLaxLEiuNuT8Qc8KsEhsn6neX
         mJoZCIQmT0SyfZftwuCKSQ2cvu01ukHpbFXUzJ7yvE+lPBFaCdRCCSjmHuLEpgoki6MT
         DZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jxw7SQE7IH2X4d9HfgPhhYW34Jo16ukZRQvK9MgirSU=;
        b=nn1MmcrvKDrdppBLnVhKNxnMY9KtlInEoarutDIeFOUH9PJcZJJksz+l0/v+Srdm4r
         f49VMML7wwg8xlzm8ITthjIx81Fuh1fzfStqzmgfLIQDjv/WwpmR5xIXbb/7mK2VqDUz
         uWY5KZqjIBEg8epxQFV5RuXxw6lN9sr/eD/KI/cG10pi4uBXUENH3NMxapqtaEBvDISQ
         6H5xY+pO02bN0/FxXl5Ih+thFalgng8c8yOjl5/c1hB60fAHIYYi52ICLPf7ROZ9rMkp
         u/361I3FRGGufMjcLiatwrG8iXbu2OtIsb7aFrk9td1LK9Cwky2Tjdo1b2GyklX6xotN
         EZKQ==
X-Gm-Message-State: AOAM533fT8LWHvhhvyR/B/X7EQs791/iMcd0Gq5eCj3unMR0bMaCwZEp
        rNf2k/w4snF9gVidlIJwZhVtMQ==
X-Google-Smtp-Source: ABdhPJwsNsaSNldo/AfnEBbWrWF7UYY8Wx/+CW9NAaFPVCd5sUHtiwAC0OhnaSJw0z+5Sq+3JQHB6g==
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr6109263pjb.20.1591724998938;
        Tue, 09 Jun 2020 10:49:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id c9sm10609680pfp.100.2020.06.09.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:49:57 -0700 (PDT)
Date:   Tue, 9 Jun 2020 10:49:54 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc-5: error: -gz is not supported in this configuration
Message-ID: <20200609174954.cckelwl6etwztmhv@google.com>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09, Nick Desaulniers wrote:
>On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
>> commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: support compressed debug info
>> date:   12 days ago
>> config: x86_64-randconfig-r032-20200609 (attached as .config)
>> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
>> reproduce (this is a W=1 build):
>>         git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
>>         # save the attached .config to linux build tree
>>         make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>> >> gcc-5: error: -gz is not supported in this configuration
>
>Hmm...I wonder if the feature detection is incomplete?  I suspect it's
>possible to not depend on zlib.
>
>> make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] Error 1
>> make[2]: Target '__build' not remade because of errors.
>> make[1]: *** [Makefile:1169: prepare0] Error 2
>> make[1]: Target 'prepare' not remade because of errors.
>> make: *** [Makefile:185: __sub-make] Error 2

The output of gcc-5 -v --version on that machine may help.  The
convoluted gcc_cv_ld_compress_de logic in gcc/configure.ac may be
related, but I can't find any mistake that our
CONFIG_DEBUG_INFO_COMPRESSED conditions may make.
