Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CD1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162172067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589804453;
	bh=IGtFnKA3PTWP8rsR4j+vSqYn3bZBs96vL7tOCMtjgM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aB9N5soHlGxOZwejHgTnOE4Vhb5xF1AtGAxro8FIdB9sX6xUB++NcwEtpxWhLHyVY
	 QkhwBRBzzXCWARJrsOrkZZbFIvBK3g9C3keg4H10cF2CrIMBmrTxzyT70fEB15MepW
	 idBYM57r/uuFbfnpcDDwXkVyPU71ltGQ2XzZMZxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgERMUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgERMUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:20:52 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1552F207E8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589804451;
        bh=IGtFnKA3PTWP8rsR4j+vSqYn3bZBs96vL7tOCMtjgM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tsXaUVKAoEnaCWFJ9o3uoDw402mQmpmGRwvboZAT5yx2IX2wU2ebACTtpoRWdOLMP
         NGTkLPwWD/hcTD4Ktp60dh1kH/xtl0YHtzxueJpK7E7t7sUO11NFXUgHQS3FVfl5DF
         hO+5jSgp2HsTgW2cHL7YruzA+oMgM7KnLglxObBc=
Received: by mail-lj1-f174.google.com with SMTP id k5so3012378lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:20:50 -0700 (PDT)
X-Gm-Message-State: AOAM531yYftw+C4fzj21WokX92eL4FPF/6fVZpTqp1Ya2TkyJv2J3AU3
        f2y+qgNp0VUp9MrkZb8U7jTrIl342Ktt8qVir2Q=
X-Google-Smtp-Source: ABdhPJwxGBhX034lD8nMf0ETFIFjxuj9WWsn6zNJrx4fakx4upciH6XL6SMtKyIwQOE8VrFbgOImyd8Iovj6arYpxPU=
X-Received: by 2002:a2e:7e04:: with SMTP id z4mr10510107ljc.50.1589804449167;
 Mon, 18 May 2020 05:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <202005160245.q5ILqcLs%lkp@intel.com>
In-Reply-To: <202005160245.q5ILqcLs%lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 May 2020 14:20:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfL37pCgMRAv=2iOWjDtW0jeM20FTORvH0MaJRjaDYxVg@mail.gmail.com>
Message-ID: <CAJKOXPfL37pCgMRAv=2iOWjDtW0jeM20FTORvH0MaJRjaDYxVg@mail.gmail.com>
Subject: Re: drivers/iommu/rockchip-iommu.c:839:43: error: 'struct
 dev_archdata' has no member named 'iommu'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 21:00, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Krzysztof,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   051e6b7e34b9bd24f46725f74994a4d3a653966e
> commit: e93a1695d7fb551376b1c1220a267d032b6ad159 iommu: Enable compile testing for some of drivers
> date:   2 months ago
> config: ia64-randconfig-r015-20200515 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e93a1695d7fb551376b1c1220a267d032b6ad159
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=ia64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>

Hi all,

I fixed this and Exynos IOMMU compile-test error with the patch here:
https://lore.kernel.org/linux-iommu/20200518120855.27822-1-krzk@kernel.org/T/#t

Best regards,
Krzysztof
