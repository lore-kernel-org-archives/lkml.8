Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B2FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769B1206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qY13hf7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHKAbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgHKAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:31:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE00C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:31:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so8776896otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6FXqV6TCVv01vnQ7eKZ9J+1T+8pfZHBOiyxnJe1m3e4=;
        b=qY13hf7KwH6cWFTtlCjFLERraJwFfG1y6fBAbyJgE5Gu0x5DcpMaip0oy3jC2Ppq6J
         gaCuJSvsF1Jit0MMvy4BEhH2u9ZBmMYivLbA4W/PNs5q+R22j3LcrYRSHY0bZKJYLDwX
         rHslP9jBkLo7AZk1ii4K7M3M7Zxph18A/MVC8kREL+S9uQoh703ZgT1CYEHRZGQSCibr
         E5YAYMknsLjD9cC2/rfq4kIaTF43gyhX5r5G+prl1o5Ktn830rYfjeu2+WoSv4JTX9yx
         k7wFnkxMWMlC8mCm5e2XpZxwN2vn4zAZo8J4X5J0f7KTxXf3r/ghgE9P95iE636+kgnc
         r+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6FXqV6TCVv01vnQ7eKZ9J+1T+8pfZHBOiyxnJe1m3e4=;
        b=cJaMJIUyMpXe5FFfQ9WPpQsmTqygbN3X88SqLF/Za+xOrHdw/KDrzl2IRuW/rPSLI+
         MES3spTrcdrR7fr1j7s2wGh6qr7mkEdDDWOWgkAQqzxD9JAC0t0TeuF5IcKoWypbjSUL
         fTXlhJAIyEc9Gbs2jV0Yf2vYs8w5tCOeoXsvgybOJfgG2G+Kpx3wWp2tYwCNfjELj0VN
         h5FPCy4ggJVzGZWWMedPGYpKFU31XCu8mtmxGDfuVsZ0N+Y2gog43YvJGVmgL6YB0cPW
         eE5dh6y8Vs9RgntEsfrSUrfHud+odNo4ZBhnarY7fIxMEHKqfkcV+qtsB+EUPuSlMO/P
         Yr4g==
X-Gm-Message-State: AOAM53066SuvDKvCV65ChifSCouIrU6R0zsedmnyzC1uS/erthbVis9a
        IAOUGs6LqQ1C9GMNY0l7tGbWV3ruRq4Lg99cY3juww==
X-Google-Smtp-Source: ABdhPJw0qzDLyRdj9xOk0xj+IkEXR0m45OkvS3jh01kzTckBtEcFUjSKZk1kZVStQpkCAjyIgkVS9296sZCpLanQSEw=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr2779426otq.221.1597105880962;
 Mon, 10 Aug 2020 17:31:20 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 10 Aug 2020 17:31:08 -0700
Message-ID: <CALAqxLXBQ34FKs_0EX+D=iccJxBPCC4tJN1NP7e8OQy6q9Z_Fg@mail.gmail.com>
Subject: Regression: serial crash on db845c using modular config w/ 5.9-rc
To:     Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>, Todd Kjos <tkjos@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing with modular configs w/ mainline on db845c, I've been
running into an early boot crash (nothing on the console - but serial
drivers as built as modules - so not surprising). After setting the
CONFIG_SERIAL_QCOM_GENI=y (along with other QCOM_GENI configs) to
debug, I've found the backtrace below.

I'm a little stumped as to what the issue might be. But wanted to
raise it in case anyone else is seeing similar. I don't see this issue
when using my non-modular config.

I've tried reverting most of the geni changes since v5.8, but that
hasn't seemed to help much, making me suspicious it's something else.

Any ideas?

thanks
-john


[    6.469057] Unable to handle kernel paging request at virtual
address ffffffe645d4e6cc
[    6.481623] Mem abort info:
[    6.484466]   ESR = 0x86000007
[    6.487557]   EC = 0x21: IABT (current EL), IL = 32 bits
[    6.492929]   SET = 0, FnV = 0
[    6.496016]   EA = 0, S1PTW = 0
[    6.499202] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000008151e000
[    6.501286] ufshcd-qcom 1d84000.ufshc: ufshcd_print_pwr_info:[RX,
TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
[    6.505977] [ffffffe645d4e6cc] pgd=000000017df9f003,
p4d=000000017df9f003, pud=000000017df9f003, pmd=000000017df9c003,
pte=0000000000000000
[    6.505990] Internal error: Oops: 86000007 [#1] PREEMPT SMP
[    6.505995] Modules linked in: zl10353 zl10039 zl10036 zd1301_demod
xc5000 xc4000 ves1x93 ves1820 tuner_xc2028 tuner_simple tuner_types
tua9001 tua6100 1
[    6.506152]  isl6405
[    6.518104] ufshcd-qcom 1d84000.ufshc:
ufshcd_find_max_sup_active_icc_level: Regulator capability was not
set, actvIccLevel=0
[    6.530549]  horus3a helene fc2580 fc0013 fc0012 fc0011 ec100 e4000
dvb_pll ds3000 drxk drxd drx39xyj dib9000 dib8000 dib7000p dib7000m
dib3000mc dibx003
[    6.624271] CPU: 7 PID: 148 Comm: kworker/7:2 Tainted: G        W
      5.8.0-mainline-12021-g6defd37ba1cd #3455
[    6.624273] Hardware name: Thundercomm Dragonboard 845c (DT)
[    6.624290] Workqueue: events deferred_probe_work_func
[    6.624296] pstate: 40c00005 (nZcv daif +PAN +UAO BTYPE=--)
[    6.624307] pc : qcom_geni_console_setup+0x0/0x110
[    6.624316] lr : try_enable_new_console+0xa0/0x140
[    6.624318] sp : ffffffc010843a30
[    6.624320] x29: ffffffc010843a30 x28: ffffffe645c3e7d0
[    6.624325] x27: ffffff80f8022180 x26: ffffffc010843b28
[    6.637937] x25: 0000000000000000 x24: ffffffe6462a2000
[    6.637941] x23: ffffffe646398000 x22: 0000000000000000
[    6.637945] x21: 0000000000000000 x20: ffffffe6462a5ce8
[    6.637952] x19: ffffffe646398e38 x18: ffffffffffffffff
[    6.680296] x17: 0000000000000000 x16: ffffffe64492b900
[    6.680300] x15: ffffffe6461e9d08 x14: 69202930203d2064
[    6.680305] x13: 7561625f65736162 x12: 202c363331203d20
[    6.696434] x11: 0000000000000030 x10: 0101010101010101
[    6.696438] x9 : 4d4d20746120304d x8 : 7f7f7f7f7f7f7f7f
[    6.707249] x7 : feff4c524c787373 x6 : 0000000000008080
[    6.707253] x5 : 0000000000000000 x4 : 8080000000000000
[    6.707257] x3 : 0000000000000000 x2 : ffffffe645d4e6cc
[    6.744223] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
failed to find OPP for freq 102400000 (-34)
[    6.744966] x1 : fffffffefe74e174 x0 : ffffffe6462a5ce8
[    6.753580] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
failed to find OPP for freq 102400000 (-34)
[    6.761634] Call trace:
[    6.761639]  qcom_geni_console_setup+0x0/0x110
[    6.761645]  register_console+0x29c/0x2f8
[    6.767981] Bluetooth: hci0: Frame reassembly failed (-84)
[    6.775252]  uart_add_one_port+0x438/0x500
[    6.775258]  qcom_geni_serial_probe+0x2c4/0x4a8
[    6.775266]  platform_drv_probe+0x58/0xa8
[    6.855359]  really_probe+0xec/0x398
[    6.855362]  driver_probe_device+0x5c/0xb8
[    6.855367]  __device_attach_driver+0x98/0xb8
[    7.184945]  bus_for_each_drv+0x74/0xd8
[    7.188825]  __device_attach+0xec/0x148
[    7.192705]  device_initial_probe+0x24/0x30
[    7.196937]  bus_probe_device+0x9c/0xa8
[    7.200816]  deferred_probe_work_func+0x7c/0xb8
[    7.205398]  process_one_work+0x20c/0x4b0
[    7.209456]  worker_thread+0x48/0x460
[    7.213157]  kthread+0x14c/0x158
[    7.216432]  ret_from_fork+0x10/0x18
[    7.220049] Code: bad PC value
[    7.223139] ---[ end trace 73f3b21e251d5a70 ]---
