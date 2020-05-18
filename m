Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A478C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4275F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQz+8bQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgERIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7AFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:45:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g14so21826021wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lQcR7rc88qiFdQ3niJ5g2HFQDZypdi0sjdSAF5m+mXE=;
        b=LQz+8bQD7Azu/alnLS8eVuDgZaQL2HBkrxFR4x1ORQoOlKv0s1+9KAObbwQ+gq5kUi
         3QMVcCDUNivXZ2mTfKQfUfU8paEL9m8Pk9NonK3eRFqGOcdyJQswAsO+RiXi6ZZ0IEGA
         Z0bjYhYcvSCpwOh/7sJrqtKYAw6rFgFoqgvg1PnBX51/hydS5ceNsDVb3Oq5B/SeoRxh
         pPEzpftrwDjaEJ532uDaxuS4YMWdPL7/dnPIOzq4LkGuT3iwfhOkStH4KOit1SRkYpfH
         8ygVgFHVkB8KJpJSTu99jHGZz7+x1gSDwj9Jhfg6FjDpOixWPpc7oj1gnwUrZrmPTjwn
         Xmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lQcR7rc88qiFdQ3niJ5g2HFQDZypdi0sjdSAF5m+mXE=;
        b=bZVmGkqs0Uhznq0CyCLEoqeJL5/Hlw6K5N9yg1Yrc8FqwOe4y8r5M85AKKcAipBIfw
         9xfdIAjkCMSWGwWGGq5UXrFkWymVb6G0rK0kwUQbGpykZXoGms+XtVDHiDjfagx9MTGL
         LIwzm96rRtbs1K7jXjDbI2hrsStjeC1/bPex+s/sOycxvns+vgyYEssxITiiyvmom08Q
         hbVGUd/rgh4VEVharofJctBtmhmV7kikbbgJxShKX9Xra8Af/0Rdaly6fHfm12faN0qB
         sQ9WDRDreADLHXAt+mrhLQX/DQ5UYQM0vpn9SehTYBxXwoJW2Jqyn0Xq0g3czCAEDRKu
         bQQg==
X-Gm-Message-State: AOAM531ZXpJ/NNPsbQDv80Pl/C5ghVVs+mgBKvVHqTZxMFN7o5WBrB3n
        Cw701ZWQNMutl608kcbjgaQJfg==
X-Google-Smtp-Source: ABdhPJzyNKGOfgB0GBTeJ/STu6e3LH7Ofv9VsbEX80kA+BZnAwC7/xGEiG5RufatlgLjy9+yg3RrtQ==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr17693264wml.19.1589791527362;
        Mon, 18 May 2020 01:45:27 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id m13sm9266598wmi.42.2020.05.18.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 01:45:26 -0700 (PDT)
Date:   Mon, 18 May 2020 09:45:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: mfd_cell: constify platform_data
Message-ID: <20200518084525.GM271301@dell>
References: <20200516110609.22013-3-tomas.winkler@intel.com>
 <202005162129.QQOL64er%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005162129.QQOL64er%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020, kbuild test robot wrote:

> Hi Tomas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v5.7-rc5 next-20200515]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Tomas-Winkler/mfd-constify-pointers/20200516-190733
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: arm-randconfig-r006-20200515 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 13d44b2a0c7ef404b13b16644765977cd5310fe2)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> drivers/hid/hid-sensor-hub.c:738:33: error: initializing 'struct hid_sensor_hub_device *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> struct hid_sensor_hub_device *hsdev =
> ^

Obviously this would need fixing before it can be considered.

> 1 error generated.
> 
> vim +738 drivers/hid/hid-sensor-hub.c
> 
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  726  
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  727  static void sensor_hub_remove(struct hid_device *hdev)
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  728  {
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  729  	struct sensor_hub_data *data = hid_get_drvdata(hdev);
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  730  	unsigned long flags;
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  731  	int i;
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  732  
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  733  	hid_dbg(hdev, " hardware removed\n");
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  734  	hid_hw_close(hdev);
> f2f13a68c37c13a Axel Lin            2012-09-19  735  	hid_hw_stop(hdev);
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  736  	spin_lock_irqsave(&data->lock, flags);
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  737  	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19 @738  		struct hid_sensor_hub_device *hsdev =
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  739  			data->hid_sensor_hub_client_devs[i].platform_data;
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  740  		if (hsdev->pending.status)
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  741  			complete(&hsdev->pending.ready);
> e651a1da442ae02 Srinivas Pandruvada 2015-02-19  742  	}
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  743  	spin_unlock_irqrestore(&data->lock, flags);
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  744  	mfd_remove_devices(&hdev->dev);
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  745  	mutex_destroy(&data->mutex);
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  746  }
> 401ca24fb34aee0 srinivas pandruvada 2012-09-05  747  
> 
> :::::: The code at line 738 was first introduced by commit
> :::::: e651a1da442ae02a50081e38309dea5e89da2d41 HID: hid-sensor-hub: Allow parallel synchronous reads
> 
> :::::: TO: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> :::::: CC: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
