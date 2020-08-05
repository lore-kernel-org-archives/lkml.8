Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89610C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5829C2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596615257;
	bh=tDoaZnPmAkSo26FvJN+TuPO65z2/kyma/APN7Yv1kcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7rJbSWR/8ZOukvLkKLfZBc6NqEUvSufhusP4TzkouwOHNMbrM7NNua71jeZl+rJj
	 eYs3NycAYBTkMq7Drket2d6n/LkAQCdsi7rEK2AoqPI6K85tih+grLXt2d1XYDtefl
	 JNuua8q643NUJrkqMynyWClOFn3Bn/4QACoNgx+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgHEIOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:14:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51025 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHEINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:13:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id c80so4979540wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fV+7qezkUGkLqh8TqlDz1gqV6CXztqe5Iqf2Sfq5CX4=;
        b=qTWdEW2CTLWS41gu8jY5jzZiUp+JJ9QDJK4pWLv6m+H+g8h2kXw12Ea4pjuFSWalkL
         yzuGpsu04GdYl7+aZ3RTvKZ3ATf/T1zm47zYob0FKmYwOpWi6kjTBCBlnu9EsZQFNNjb
         lLfUaf5bzDI+ls5x+aEPR1xIRCDWNd9i5xD6p8WPqekVDdaAWCsjYzeMDE95DXBDNX3q
         4L2M+PNbt9of6zJxzoZywLJnfHms4BRXBP0ZSpsYtZ8w5lG5yk47FkxnBlpq+eGzfAR5
         8DpoiDBd4Bz33JRoHSZPSAP4q1+XVeKT5a2sLZnrsOqilBvD92VuFMOkEj3yiLOx3eiJ
         6Ozw==
X-Gm-Message-State: AOAM533jM7Bb/D4EA3+VVcKxpMTO4+pqAObAbMBYVgdU1tBHGuejO8eL
        0P0SmrvGuunhApiU2DG01yU=
X-Google-Smtp-Source: ABdhPJzRYzfvNdARJQUbxVj+Iw+e0/hwK/uM6kqXP+/lH6odw5BXYwf4BzaAWgAGcO1aZDwanZv8xA==
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr2114025wmt.44.1596615223151;
        Wed, 05 Aug 2020 01:13:43 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id l7sm2042611wrf.32.2020.08.05.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 01:13:42 -0700 (PDT)
Date:   Wed, 5 Aug 2020 10:13:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: ERROR: "ap_driver_register" undefined!
Message-ID: <20200805080809.GA5268@pi3>
References: <202008042249.EnHi1w22%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202008042249.EnHi1w22%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:29:53PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c0842fbc1b18c7a044e6ff3e8fa78bfa822c7d1a
> commit: e93a1695d7fb551376b1c1220a267d032b6ad159 iommu: Enable compile testing for some of drivers
> date:   5 months ago
> config: s390-randconfig-m031-20200804 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e93a1695d7fb551376b1c1220a267d032b6ad159
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "ap_driver_register" [drivers/s390/crypto/vfio_ap.ko] undefined!
> >> ERROR: "ap_driver_unregister" [drivers/s390/crypto/vfio_ap.ko] undefined!

I have a fix for this ready. I'll send it soon.

Best regards,
Krzysztof

