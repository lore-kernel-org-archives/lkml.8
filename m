Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDB420774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Fq2WqHVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgFIAq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgFIAqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:46:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BAEC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 17:46:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l1so14932944ede.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zCH4n2iYndxCImQUVO1t9gw8KAnucClc8TKaXcz6VE=;
        b=Fq2WqHVeE81Nk6/Y0DGUX0PV2/hDVPJDGUYPIo3pxtCcQjIa6R//iPZadETarfnAzT
         tlwhSjrEN/2Mjan9gz24mXSQu9dOYhzwWdqc2Q0xT715EekdH3eg0fxIvFgM3eRLWgLN
         78TZPoqHOfMK62A9ZJhEzlwmtqtbesyOCnOYd4H/O4Ti5pd09CcSkCIUY1/sj0tPY8Xc
         3Wc13HH5AEC14rFecdON9Rt3tBXKBzr9b6or5LhepX6BXw5CLcEfmLZAwLOtuGpiRW//
         YK+q6h65xUPqiwCvAKne4a3em0MZjfum74LdoxdMkfCZkPYVK/UwQyfbfpME0PiWBIdQ
         h2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zCH4n2iYndxCImQUVO1t9gw8KAnucClc8TKaXcz6VE=;
        b=Nc85V2GA8Fr67aF1XZnwRGbUJPk1RFV0Ot22oFfxzlnO/cBvLVofGMlkbv/G+JugwS
         B5PK5O9s3yOQCKHiU1PrKSqNAf0JNK10h/jJRzwgOcHE7FYka/dqKS7RaHh4JWgOFreF
         DQ091TictiqqE8SRnDNHbgbcg2IEZ+wvBKuy4cGgPubu9lzeGVE+CJuxC1Jpbtzs9EG+
         lIv36El8TVl7xRJTkWXJdX8YrBe3nek1OFjGZDPb5dwWUF7KWdvfOjPcKbAUuxYwMr86
         GJkjNzMZa4CGVFKMeijbm8KdAbKhl0yaQtqxn8xm/dn2C1ZM4rJRAm55fDo+V2NRIssp
         Bx/w==
X-Gm-Message-State: AOAM5318h1/WIlnzx0z6A9sHxLZUrNaKUTx240+RmcQPFF/jlc5W2IzB
        0Kg+0OY7GCy13oTjTahfRODEt8Ry5DOoK505KDS7vA==
X-Google-Smtp-Source: ABdhPJyPiL73dzr0k16R7WSQX3Z3pfrFMXEsfHYxl183PZK4kpvT14ODaxWMSzzuq7exBiIPN3x17ifOOa1H+rWsmBY=
X-Received: by 2002:a50:eb0c:: with SMTP id y12mr23805262edp.165.1591663613143;
 Mon, 08 Jun 2020 17:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200607131339.476036-6-vaibhav@linux.ibm.com> <202006090059.o4CE5D9b%lkp@intel.com>
In-Reply-To: <202006090059.o4CE5D9b%lkp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Jun 2020 17:46:42 -0700
Message-ID: <CAPcyv4iQo_xgRGPx_j+RPzgWGZaigGRbc_kRzKEFePfVHenx5g@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
To:     kernel test robot <lkp@intel.com>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 5:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vaibhav,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on linus/master v5.7 next-20200605]
> [cannot apply to linux-nvdimm/libnvdimm-for-next scottwood/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Vaibhav-Jain/powerpc-papr_scm-Add-support-for-reporting-nvdimm-health/20200607-211653
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-randconfig-r016-20200607 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> In file included from <built-in>:1:
> >> ./usr/include/asm/papr_pdsm.h:69:20: warning: field 'hdr' with variable sized type 'struct nd_cmd_pkg' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> struct nd_cmd_pkg hdr;  /* Package header containing sub-cmd */

Hi Vaibhav,

This looks like it's going to need another round to get this fixed. I
don't think 'struct nd_pdsm_cmd_pkg' should embed a definition of
'struct nd_cmd_pkg'. An instance of 'struct nd_cmd_pkg' carries a
payload that is the 'pdsm' specifics. As the code has it now it's
defined as a superset of 'struct nd_cmd_pkg' and the compiler warning
is pointing out a real 'struct' organization problem.

Given the soak time needed in -next after the code is finalized this
there's no time to do another round of updates and still make the v5.8
merge window.
