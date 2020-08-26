Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E534820786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SQFo15B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHZJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgHZJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C22C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:26:33 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r8so959878ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZhkQxNLw77frpz6ZMdHyemforQJCP3lk4DGDC08wQk=;
        b=SQFo15B+++qeSPzHZf2QXnMtumb0EW49HHCk4BopK4PnC5U07MD1/tISq37ka7/WrU
         d0eQqlPHSmALWhupGDYFc80znGHBtRopb7r9iCO41v1ug9FPvzWfeIyaVbj35wY1WXe6
         PcOc3mMXNt1FuByQMrYJh89OMZA1uiRBQRFF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZhkQxNLw77frpz6ZMdHyemforQJCP3lk4DGDC08wQk=;
        b=CXUD/jv2+HG+fejCREd65EZkp0nIpdpsuEuocBvpDb9IzREW+LC34ECffls9RJPx+2
         YRMR7dq10DqB/uL+xES8zqi+t/dhGofZpJ4YEtXPhvpkE+fyrYh3awQ6/OKSGDnJ2+TR
         n08qoWgubWkg6hOqJi/RdAkJQZq2OyvfdmArs63vg6qG2jUXgEScU6J9HBxHBZi7bmmf
         nMM754TJjHEYFZh70bX3w4vpbkXs3p81bR7+ftzxHP2ZtmjcCyKFP4ibN1kOW2fa+xnj
         nJf0ugYMGeRZwCRcYY5YX22Dx9JHJM+LjR2SIiJam7gWoN7kqFvvmnUz4CEPc+yoTuzc
         4oqw==
X-Gm-Message-State: AOAM530BcCqm4BB3ZZyc215qthdFdwS/4zSNA6hN/V4LJm/O4SgSs+lw
        50LfqejGQ52dVvOd3cVTDegFzY/exPAxbA==
X-Google-Smtp-Source: ABdhPJwDyRbmucSw0fUuOOy/Hj3JvrK5tS8SAbv+eVLXoMVo8v6KlpalyfI/Z2UuMBfjrtT/5JlHjA==
X-Received: by 2002:a9d:4:: with SMTP id 4mr9475985ota.66.1598433990466;
        Wed, 26 Aug 2020 02:26:30 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id w15sm378265otp.57.2020.08.26.02.26.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 02:26:30 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id v13so916105oiv.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:26:30 -0700 (PDT)
X-Received: by 2002:a05:6808:482:: with SMTP id z2mr3200722oid.94.1598433579877;
 Wed, 26 Aug 2020 02:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200821103608.2310097-4-acourbot@chromium.org> <202008212314.jscpXSEF%lkp@intel.com>
In-Reply-To: <202008212314.jscpXSEF%lkp@intel.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 26 Aug 2020 18:19:29 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXD1RpGGCOb+7=cUUNOymbtgiDGvG_+S4DtsTU49-ORKA@mail.gmail.com>
Message-ID: <CAPBb6MXD1RpGGCOb+7=cUUNOymbtgiDGvG_+S4DtsTU49-ORKA@mail.gmail.com>
Subject: Re: [PATCH v4 03/17] media: mtk-vcodec: add SCP firmware ops
To:     kernel test robot <lkp@intel.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kbuild-all@lists.01.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 12:14 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Alexandre,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linuxtv-media/master]
> [also build test ERROR on robh/for-next v5.9-rc1 next-20200821]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Alexandre-Courbot/media-mtk-vcodec-venc-support-for-MT8183/20200821-184118
> base:   git://linuxtv.org/media_tree.git master
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "scp_get_venc_hw_capa" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_ipi_send" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_put" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_get" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_get_vdec_hw_capa" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_ipi_register" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_mapping_dm_addr" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "scp_get_rproc" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> >> ERROR: modpost: "rproc_boot" [drivers/media/platform/mtk-vcodec/mtk-vcodec-common.ko] undefined!
> ERROR: modpost: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!

This issue should be fixed by the following patch, sent to the
remoteproc tree:

https://lkml.org/lkml/2020/8/21/489
