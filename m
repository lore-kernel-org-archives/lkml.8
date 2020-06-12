Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE73BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXp9vM9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgFLVxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgFLVxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:53:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B3C03E96F;
        Fri, 12 Jun 2020 14:53:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z206so6289041lfc.6;
        Fri, 12 Jun 2020 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOElnJrxFX82zCegdC8CJL4A4jdek0Vm1aStzl7y+ic=;
        b=gXp9vM9n3ge6BhZsmJD9ksIhohLFm9UN/zIoj6mNfhOtfJioBKmvHW0fwY5x/GbU1v
         Kf8RMQGkmUSAabZAsqnQfPEKUnRgT7mkxxqkv8JrGUSOPmYZipgOosu/SsSMGo4aQs0n
         tHIVHPnGOU5fyr1iOUB7oqTy1oKD5TKoRmDgJ/tWd88wlLjOKAih3CTypJNU3jhumj7N
         1CjcrkziDeG8PiCzSJ8NfDo3FsbZgLvrBrFH6havbWUkyS/VQjctFpqp+cOorzOEUPrU
         OxLgEkO+5F2n72o6cYq93lAYysIZnij/b2cBpYUfXaoEF4jSruKoiDWmVJ+r/qgcbQLR
         uYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOElnJrxFX82zCegdC8CJL4A4jdek0Vm1aStzl7y+ic=;
        b=EGBXACxtrYllR0JFynmOAI6SaS1mJTJ6cPvGEo7bI6Bts+cz4xHWD6bfxtgf8piED+
         BlXaeDGXkR+Rh0AK4ShpNMLPAXbYj6EBiebLbk+9ycx4VuXPjR19Sw3r5nnqynBKwXti
         ujZzQPNUWw6jgYIlHQCX3kqLNr9KZbpboYpRlWGL15HHyUaa+sZ4g93fm8lEAlLa1ZoQ
         dWOWzG+zFWdSKPy2dYAgxG4IlSh7NJe3FP1pIteYMxrNuT+NTKkYiKi0FTSle2ocnE/x
         m7vtdc0ULytNvWSFgESEsrp8cwEOk6I3cy+gJ30pRZfC80WWGW5Weo4szddslDT3RVlV
         axmQ==
X-Gm-Message-State: AOAM530x5itoX/ji1Zecdc5lcRAs17pknhhO32qUyLmWjPOV+wcaU/CO
        LSzj07sx3Um7fYSavzxHGTiS1hVo
X-Google-Smtp-Source: ABdhPJzmwhK1lXiY/Qgd36vBnvVViqZWltRLjQJol/PlPOPqVI7Vu3PHUVi3sCmITZaFPdk6xhO2qQ==
X-Received: by 2002:a19:cb05:: with SMTP id b5mr7803699lfg.108.1591998819280;
        Fri, 12 Jun 2020 14:53:39 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id n1sm2046995ljg.131.2020.06.12.14.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:53:38 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] drm/tegra: output: rgb: Wrap directly-connected
 panel into DRM bridge
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200609132855.20975-7-digetx@gmail.com>
 <202006130511.AE6Kvrjm%lkp@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <48645520-047f-da72-f8b1-3520911f242e@gmail.com>
Date:   Sat, 13 Jun 2020 00:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202006130511.AE6Kvrjm%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.06.2020 00:23, kernel test robot пишет:
> Hi Dmitry,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on next-20200612]
> [cannot apply to tegra/for-next robh/for-next v5.7]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Support-DRM-bridges-on-NVIDIA-Tegra/20200609-213026
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git abfbb29297c27e3f101f348dc9e467b0fe70f919
> config: arm64-randconfig-r026-20200612 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3b43f006294971b8049d4807110032169780e5b8)

Interestingly, GCC doesn't report this warning.

> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> drivers/gpu/drm/tegra/rgb.c:100:48: warning: unused variable 'tegra_rgb_connector_helper_funcs' [-Wunused-const-variable]
> static const struct drm_connector_helper_funcs tegra_rgb_connector_helper_funcs = {
> ^
> 1 warning generated.


There are two unused structs in the code and one is referenced by the
other, I'll remove the unused structs in v7.
