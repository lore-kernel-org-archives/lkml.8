Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793D42065F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROKLXuq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgE2XfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:35:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgE2XfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590795320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynBmM72Iby+/hnbEq82vhPEvLd0uSLa2+oDmQ+vr5ZM=;
        b=ROKLXuq4YvU7fZmdXmGqWExfL2eZoUwbixDxgMtsFxvLykGUTcqa5BynPomhQ95rwKb7Yv
        6cqjDtncwCLEqks/rp4Hkl2u8hNEbKQQBtr6qgSf+RcZpa/h8Z+1rAwjU+/9rFgFCQwl2S
        VgPlq+LBHCobS2t+Ryj9dLPomID8yTs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-6K_4pBQUPVumeXKW3vFWrQ-1; Fri, 29 May 2020 19:35:10 -0400
X-MC-Unique: 6K_4pBQUPVumeXKW3vFWrQ-1
Received: by mail-ed1-f70.google.com with SMTP id a18so1913516eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynBmM72Iby+/hnbEq82vhPEvLd0uSLa2+oDmQ+vr5ZM=;
        b=rVAhtQRseUwfa4W3yV7i2lfpF/Kot1NIwPRthRbp4kFgB+mE52iG4KCQVOR1jkrEkZ
         cikOUHk6cAem2lRHZRr7R5Iu+v0s4hIFU2A7sNIVqdKX5vbF5NIFf8ySjOYMFqwiJ10E
         MK/vefXGjuX7vuI3zUwIWQngIIVNmz+soEaWimysrygni7eMxMr6z+yJjbsS7h3+QiA6
         BUeYIl7Ta51RkF/iWXmy/aeULnu8GQyN8MNAgViclmxp/9gKoagewnaNi4hw9J7Y3UGl
         dvfaZyqhZci0xlD+WZ+RroiOnPO62Kh4MQdWkfJDpF7tQUpIwAaWV8zotKJ5pkp7QoRe
         Jijw==
X-Gm-Message-State: AOAM531/IMFbO24PJELD+Sh8CpTZBXH91v2o+Ut+DxdT9Bs0tYpaPbPQ
        QeetDcwuK1eqnxfKlMiP9A+Ic1UUhYHV7MAEyHOtwkXfkJofYb6cn1wFZ3GIaZXpNjmDElXsmix
        g9/aToZklu5xe5VLjXuNzh/5W+EaNy+XFzkbamJdP
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr10851817edy.189.1590795309062;
        Fri, 29 May 2020 16:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztX41rxm7dOgwKnAFFfm1SNZ9ozwqw+3aqRt+jxNx6F0cmA+jw1Wtg+CQIPPqKW/9S5S08N1j4fxMwTvuKqXw=
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr10851802edy.189.1590795308808;
 Fri, 29 May 2020 16:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <202005300444.jEGzmGwi%lkp@intel.com>
In-Reply-To: <202005300444.jEGzmGwi%lkp@intel.com>
From:   Ben Skeggs <bskeggs@redhat.com>
Date:   Sat, 30 May 2020 09:34:57 +1000
Message-ID: <CABDvA=m7_sQHkCqs6samzEq=33uHrOHwWfAgtW81=unmJmvZvg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:2019:1: warning:
 no previous prototype for 'gf100_gr_dtor'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 6:04 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Ben,
>
> FYI, the error/warning still remains.
Thanks, I've got a patch in my tree.

Ben.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   75caf310d16cc5e2f851c048cd597f5437013368
> commit: ef16dc278ec22ddbf8da54bd06a6e662719c1420 drm/nouveau/gr/gf100-: select implementation based on available FW
> date:   5 months ago
> config: arm64-sof-customedconfig-sst-defconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ef16dc278ec22ddbf8da54bd06a6e662719c1420
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:745:1: warning: no previous prototype for 'gf100_gr_fecs_start_ctxsw' [-Wmissing-prototypes]
> 745 | gf100_gr_fecs_start_ctxsw(struct nvkm_gr *base)
> | ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:760:1: warning: no previous prototype for 'gf100_gr_fecs_stop_ctxsw' [-Wmissing-prototypes]
> 760 | gf100_gr_fecs_stop_ctxsw(struct nvkm_gr *base)
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:2019:1: warning: no previous prototype for 'gf100_gr_dtor' [-Wmissing-prototypes]
> 2019 | gf100_gr_dtor(struct nvkm_gr *base)
> | ^~~~~~~~~~~~~
>
> vim +/gf100_gr_dtor +2019 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
>
> 89cd6e2071b3d3b Alexandre Courbot 2016-12-13  2017
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2018  void *
> c85ee6ca79590cd Ben Skeggs        2015-08-20 @2019  gf100_gr_dtor(struct nvkm_gr *base)
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2020  {
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2021      struct gf100_gr *gr = gf100_gr(base);
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2022
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2023      kfree(gr->data);
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2024
> 8e44b987e8f1566 Ben Skeggs        2019-02-12  2025      nvkm_falcon_del(&gr->gpccs.falcon);
> 8e44b987e8f1566 Ben Skeggs        2019-02-12  2026      nvkm_falcon_del(&gr->fecs.falcon);
> 89cd6e2071b3d3b Alexandre Courbot 2016-12-13  2027
> 00e1b5dcf76648e Ben Skeggs        2020-01-15  2028      nvkm_blob_dtor(&gr->fecs.inst);
> 00e1b5dcf76648e Ben Skeggs        2020-01-15  2029      nvkm_blob_dtor(&gr->fecs.data);
> 00e1b5dcf76648e Ben Skeggs        2020-01-15  2030      nvkm_blob_dtor(&gr->gpccs.inst);
> 00e1b5dcf76648e Ben Skeggs        2020-01-15  2031      nvkm_blob_dtor(&gr->gpccs.data);
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2032
> 0033f15b44bc29e Ben Skeggs        2020-01-15  2033      vfree(gr->bundle);
> 0033f15b44bc29e Ben Skeggs        2020-01-15  2034      vfree(gr->method);
> 0033f15b44bc29e Ben Skeggs        2020-01-15  2035      vfree(gr->sw_ctx);
> 0033f15b44bc29e Ben Skeggs        2020-01-15  2036      vfree(gr->sw_nonctx);
> 336c46524fcd822 Alexandre Courbot 2016-02-24  2037
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2038      return gr;
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2039  }
> c85ee6ca79590cd Ben Skeggs        2015-08-20  2040
>
> :::::: The code at line 2019 was first introduced by commit
> :::::: c85ee6ca79590cd51356bf24fb8936bc352138cf drm/nouveau/gr: convert to new-style nvkm_engine
>
> :::::: TO: Ben Skeggs <bskeggs@redhat.com>
> :::::: CC: Ben Skeggs <bskeggs@redhat.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

