Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4272076A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dde7AdUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFJDMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:12:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9BC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:12:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g7so399962qvx.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L39uq7tgQn/Q6N8FJzDDK131LcASt6R40FcZy+Bcgco=;
        b=dde7AdUTLSSK661bqFsPMTGrBIGq+3UodJCl5Ji1htValQRtNPmA8oFFTmmhUB8VU0
         ajSIxtDI2HqtrCzRYNPQB2nDURN8E8Bayxjxd/bXrEkIFS1jhU3e5/kDnNONc210LA5t
         ytgJGaZvbMLf54A+aKyCb6WFWe1ZsRcWUos5LiPPbf0Xk2GXBgmMgHUXw3aNMNimtI+i
         t37mhL97KjIpxra0K4uRjdhF3FsxqESE0WsEixJ3huap5hw2hsTTLNsTX22Dws3cXM0F
         aTEFOzOEm/AicW/z2VczEjYJYUsmEjs9o00flqWkbW1Q33297P91F2bvuef0vf25XVlM
         MhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=L39uq7tgQn/Q6N8FJzDDK131LcASt6R40FcZy+Bcgco=;
        b=sG6hFVqSTG9HtYz+aLsUADmiJlpIJ/w21+5flcAz9FdBJnTgo6dJnbQ06tljUyKhua
         Ehnq02CdtfJUJdN6HKL33WSdmfLi4qkMPdaujnhhILYmxVqV3aVxGmXT7vC5uqjRy0oA
         VFAa95RNdXhejEIAEVXeLlG8n9QahhdQz935ZEc9GrjRzA4paiYP3X4lt6wcKVowuEzb
         I7cAWoTeGFMP+WSCEaiqNiei/BR+/qnptLCYinQTD1yoxMkcqzICOvFpdnmw+Q/3dRBj
         Tjpn5/ZP2GlTK0Wnz4uNnX++oN3Z5sKytO0O7DMWYf7xw9egXHO4UFaUrlX0S9f5JXeA
         wJrA==
X-Gm-Message-State: AOAM530KUuT3GOLGLNHeJ9m4ioTGq/etR9TZYlGzct9EuMaiSASJ340h
        ocotxY/BVTzNvge8NghYjk4=
X-Google-Smtp-Source: ABdhPJzSus6ECYmVDAYO3sGMHUBlB6Y3I0+kH9RtU/EQi/LVhXLVdL85ijpTEFfp5fqMIfa1FdRJCA==
X-Received: by 2002:a0c:efcf:: with SMTP id a15mr1267656qvt.108.1591758747543;
        Tue, 09 Jun 2020 20:12:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v8sm11247174qto.21.2020.06.09.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 20:12:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 9 Jun 2020 23:12:25 -0400
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
Message-ID: <20200610031225.GA1917869@rani.riverdale.lan>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
 <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
 <20200610005830.s6gus7r3umwgzozk@google.com>
 <c2c2c2db-439f-5c60-068d-e53adbe960c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2c2c2db-439f-5c60-068d-e53adbe960c1@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:49:01AM +0800, Rong Chen wrote:
> 
> 
> On 6/10/20 8:58 AM, Fangrui Song wrote:
> > On 2020-06-10, Rong Chen wrote:
> >>
> >>
> >> On 6/10/20 1:49 AM, Fangrui Song wrote:
> >>> On 2020-06-09, Nick Desaulniers wrote:
> >>>> On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> 
> >>>> wrote:
> >>>>>
> >>>>> tree: 
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> >>>>> master
> >>>>> head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
> >>>>> commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: support 
> >>>>> compressed debug info
> >>>>> date:   12 days ago
> >>>>> config: x86_64-randconfig-r032-20200609 (attached as .config)
> >>>>> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> >>>>> reproduce (this is a W=1 build):
> >>>>>         git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
> >>>>>         # save the attached .config to linux build tree
> >>>>>         make W=1 ARCH=x86_64
> >>>>>
> >>>>> If you fix the issue, kindly add following tag as appropriate
> >>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>>
> >>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
> >>>>>
> >>>>>>> gcc-5: error: -gz is not supported in this configuration
> >>>>
> >>>> Hmm...I wonder if the feature detection is incomplete?  I suspect it's
> >>>> possible to not depend on zlib.
> >>>>
> >>>>> make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] 
> >>>>> Error 1
> >>>>> make[2]: Target '__build' not remade because of errors.
> >>>>> make[1]: *** [Makefile:1169: prepare0] Error 2
> >>>>> make[1]: Target 'prepare' not remade because of errors.
> >>>>> make: *** [Makefile:185: __sub-make] Error 2
> >>>
> >>> The output of gcc-5 -v --version on that machine may help. The
> >>> convoluted gcc_cv_ld_compress_de logic in gcc/configure.ac may be
> >>> related, but I can't find any mistake that our
> >>> CONFIG_DEBUG_INFO_COMPRESSED conditions may make.
> >>

The output of gcc-5 -dumpspecs may also be useful.

The exact Kconfig check should have been
	gcc-5 -Werror -gz=zlib -S -x c /dev/null -o /dev/null

I can't see how that would succeed if the a.c test didn't but maybe just
in case?
