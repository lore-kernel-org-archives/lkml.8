Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050EDC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1507207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZUcRieqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgHTLtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbgHTLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:47:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:47:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so1711058ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85mDl2XRAWxgMF4mNsc2vG2t2o48E+xjhQQLuiAlw3Q=;
        b=ZUcRieqe0aBzHLPGHrrGT4sAZDtl+9aXgLMCQ/RDOlOUaBfuP1DhGtlmWOMYusks9/
         aOefopIADH4HrGXJbj7IFK3Wc73XmNZEjKIUkSc1lij0bLsXe/Uys0dcB4vOYKnnRv88
         bNWPy6WaGvO/YPOgb/IrWMFf3Buo3rNKsCJ/hYKI0r/VgFj1G29N58TLrNRZk7OWauu/
         iC3XRsndSFaheGd2ky965/2RluIuiKSFtVMDl1KU85E2EF1KWjueIMe+tjdSKdxSLDO/
         cWvIrk1KmtqNNTSaV4iFk6TOgS4n62Ni+SYNrncFIFe/Tif6G7qDtJC0IOgHObYJitR8
         cFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85mDl2XRAWxgMF4mNsc2vG2t2o48E+xjhQQLuiAlw3Q=;
        b=GmJi8fpLipwr+TqR1Rb4VcmElFGwPH2jyJqv6kL+bJEcKr3Zjo+E3APOb9WT5tJ4Qa
         WSxb8htdTmZjQPuXml8KiK2ie9SUA0Cq2Tii+LdTjd+8hPn+zJdi7xDePqs2OT19FshT
         To9FwVUQZz6O6KHfySFCTAlRRXBPoV9KkxbHcusMsRyUxRMwmACBDQkN/Jsfmc+vyZFT
         1UNU8GedvbvUgqdj+Lsf8e3qVID9J2b7TBG5pI9bT1FIPabnJFH507I0vOZ55+wy6mC3
         lISIf1VpTyDcTwR/64xvMBXSA0ELuAxQEDuR+/vnSc8Gu1BBJLJYtcuIqNRKqw0nViFI
         X9VQ==
X-Gm-Message-State: AOAM531qldMi7yh74VdvUnIy19X0Zt8TT7qKOEshlDgfdHlq3zJyJieB
        OVWxabO0v0FL7mya9F+8Jz3mPqqnbo7FaGETCVCqJQ==
X-Google-Smtp-Source: ABdhPJwXtQX6L6pFWRnWBgrmQIcbjIr81PgWqpzE4b7Qr6nEQQ+0rsGGEjPHUa0TXMMiypCdmYO4z0v/YDAR3c/RQJA=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1372814lji.292.1597924055257;
 Thu, 20 Aug 2020 04:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200820075133.87040-1-maco@android.com> <202008201814.TxGOq6Z2%lkp@intel.com>
In-Reply-To: <202008201814.TxGOq6Z2%lkp@intel.com>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 20 Aug 2020 13:47:24 +0200
Message-ID: <CAB0TPYGc_cfXYA3AgbEff_c=h_RsOpc=tR-+tztfHCLeEQQ8gA@mail.gmail.com>
Subject: Re: [PATCH] binder: print warnings when detecting oneway spamming.
To:     kernel test robot <lkp@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Todd Kjos <tkjos@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:41 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Martijn,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on v5.9-rc1 next-20200820]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Martijn-Coenen/binder-print-warnings-when-detecting-oneway-spamming/20200820-155358
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git bc752d2f345bf55d71b3422a6a24890ea03168dc
> config: s390-randconfig-r002-20200818 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4deda57106f7c9b982a49cb907c33e3966c8de7f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/android/binder_alloc_selftest.c:122:61: error: too few arguments to function call, expected 6, have 5
>                    buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);

missed this call-site, will send v2.

Martijn
>                                 ~~~~~~~~~~~~~~~~~~~~                         ^
>    drivers/android/binder_alloc.h:118:30: note: 'binder_alloc_new_buf' declared here
>    extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>                                 ^
>    1 error generated.
>
> # https://github.com/0day-ci/linux/commit/9d0b269f4468d6793f6fd76a410fdde39dbf6ac2
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Martijn-Coenen/binder-print-warnings-when-detecting-oneway-spamming/20200820-155358
> git checkout 9d0b269f4468d6793f6fd76a410fdde39dbf6ac2
> vim +122 drivers/android/binder_alloc_selftest.c
>
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  114
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  115  static void binder_selftest_alloc_buf(struct binder_alloc *alloc,
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  116                                    struct binder_buffer *buffers[],
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  117                                    size_t *sizes, int *seq)
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  118  {
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  119      int i;
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  120
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  121      for (i = 0; i < BUFFER_NUM; i++) {
> 4175e2b46fd4b9 Sherry Yang 2017-08-23 @122              buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  123              if (IS_ERR(buffers[i]) ||
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  124                  !check_buffer_pages_allocated(alloc, buffers[i],
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  125                                                sizes[i])) {
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  126                      pr_err_size_seq(sizes, seq);
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  127                      binder_selftest_failures++;
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  128              }
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  129      }
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  130  }
> 4175e2b46fd4b9 Sherry Yang 2017-08-23  131
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
