Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77069C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44573206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUCRChqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgHKA4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHKA4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:56:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4DBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:56:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so957142pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HlvjiW8dzAbaXqfYGhMJcjxTaA+DNkDoINyYSnd/DVo=;
        b=fUCRChqpCvKxHDjh2tf7S96iF59Nd5I9ylRN3PLFDQ5O5peyku0mLlvEOmVCX/kuet
         lsac9BemHdN7GUSXCTosJqVFyS9etIetetQVJ1fHnjiGd+JArEHxu+tX7wCo6QRaJ02b
         87LZM5jg3qKx6S+tCgmBfF3c6HZnN95SNc3/sJNZ5qTknRCQ/x8dVuUa+9c+whAa1jCM
         PEJ6yyeNhltIG2PKOXwcsMqEtTBrxwB/wBA6gFjQI5LRuBa7s41MdHLod53Ey1a16ZO/
         T0aiXOO6bZ/Qdry35b3wgNWxEnSEVIQ4QYr0ahzSmxH+ACe95lcbi15hP7NNg42aaomj
         V9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HlvjiW8dzAbaXqfYGhMJcjxTaA+DNkDoINyYSnd/DVo=;
        b=FOWLbnepya1iT/j3t5c6V5hhvEIMl5x45LeaHxx5P/JIreP6DvuR8M0NFKZMw1ykyI
         w6IjRXdT+P+M2DQd2Ma9Q2R0pOuK+PgB6AUN41yZkGEBnEJb5kjtELPNb4IhnzbuW4CG
         cnmqgwkln3M8b9ar/0eONq4UtwXiltzy+nFtzoads8Ab37xxKrt5/K975ZhXbjhpEuvr
         VSe3XSqJXmEjuuxM+QkQuM7iyQjMLER/O1a9bCvtkw7BliB039ozBNL1JofSXxDm07QC
         XjgdOdS4L4+X2vyh6xC9gRX9OAGJwBjezKiwt8b/jlrmCm4kL+meEJS5XyNTRXnSh4EF
         WsPw==
X-Gm-Message-State: AOAM530vkJH3rKQJdEATCduhJ2x8c8Ldtv120hN2H5APzdzrgdEa8pWm
        r81ury1b73FkYlvQnaigteJPi3U9Qp3VRVKl8NF60Q==
X-Google-Smtp-Source: ABdhPJz/BPa0yVxFqgAjew+Ms70nR0F6wLX6Tru9pqm9zlryrq+Ct6kROH12q49VPRXQjI1i8pYi50q7JVuhG9UUjEw=
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr5320207pls.244.1597107408243;
 Mon, 10 Aug 2020 17:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLXBQ34FKs_0EX+D=iccJxBPCC4tJN1NP7e8OQy6q9Z_Fg@mail.gmail.com>
In-Reply-To: <CALAqxLXBQ34FKs_0EX+D=iccJxBPCC4tJN1NP7e8OQy6q9Z_Fg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 10 Aug 2020 17:56:12 -0700
Message-ID: <CAGETcx8=BAu62HWDmaoORTXt-_oHB9TPUG4gRRJmQbTi3Tyk4A@mail.gmail.com>
Subject: Re: Regression: serial crash on db845c using modular config w/ 5.9-rc
To:     John Stultz <john.stultz@linaro.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 5:31 PM John Stultz <john.stultz@linaro.org> wrote:
>
> When testing with modular configs w/ mainline on db845c, I've been
> running into an early boot crash (nothing on the console - but serial
> drivers as built as modules - so not surprising). After setting the
> CONFIG_SERIAL_QCOM_GENI=y (along with other QCOM_GENI configs) to
> debug, I've found the backtrace below.
>
> I'm a little stumped as to what the issue might be. But wanted to
> raise it in case anyone else is seeing similar. I don't see this issue
> when using my non-modular config.
>
> I've tried reverting most of the geni changes since v5.8, but that
> hasn't seemed to help much, making me suspicious it's something else.
>
> Any ideas?
>
> thanks
> -john
>
>
> [    6.469057] Unable to handle kernel paging request at virtual
> address ffffffe645d4e6cc
> [    6.481623] Mem abort info:
> [    6.484466]   ESR = 0x86000007
> [    6.487557]   EC = 0x21: IABT (current EL), IL = 32 bits
> [    6.492929]   SET = 0, FnV = 0
> [    6.496016]   EA = 0, S1PTW = 0
> [    6.499202] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000008151e000
> [    6.501286] ufshcd-qcom 1d84000.ufshc: ufshcd_print_pwr_info:[RX,
> TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
> [    6.505977] [ffffffe645d4e6cc] pgd=000000017df9f003,
> p4d=000000017df9f003, pud=000000017df9f003, pmd=000000017df9c003,
> pte=0000000000000000
> [    6.505990] Internal error: Oops: 86000007 [#1] PREEMPT SMP
> [    6.505995] Modules linked in: zl10353 zl10039 zl10036 zd1301_demod
> xc5000 xc4000 ves1x93 ves1820 tuner_xc2028 tuner_simple tuner_types
> tua9001 tua6100 1
> [    6.506152]  isl6405
> [    6.518104] ufshcd-qcom 1d84000.ufshc:
> ufshcd_find_max_sup_active_icc_level: Regulator capability was not
> set, actvIccLevel=0
> [    6.530549]  horus3a helene fc2580 fc0013 fc0012 fc0011 ec100 e4000
> dvb_pll ds3000 drxk drxd drx39xyj dib9000 dib8000 dib7000p dib7000m
> dib3000mc dibx003
> [    6.624271] CPU: 7 PID: 148 Comm: kworker/7:2 Tainted: G        W
>       5.8.0-mainline-12021-g6defd37ba1cd #3455
> [    6.624273] Hardware name: Thundercomm Dragonboard 845c (DT)
> [    6.624290] Workqueue: events deferred_probe_work_func
> [    6.624296] pstate: 40c00005 (nZcv daif +PAN +UAO BTYPE=--)
> [    6.624307] pc : qcom_geni_console_setup+0x0/0x110
> [    6.624316] lr : try_enable_new_console+0xa0/0x140
> [    6.624318] sp : ffffffc010843a30
> [    6.624320] x29: ffffffc010843a30 x28: ffffffe645c3e7d0
> [    6.624325] x27: ffffff80f8022180 x26: ffffffc010843b28
> [    6.637937] x25: 0000000000000000 x24: ffffffe6462a2000
> [    6.637941] x23: ffffffe646398000 x22: 0000000000000000
> [    6.637945] x21: 0000000000000000 x20: ffffffe6462a5ce8
> [    6.637952] x19: ffffffe646398e38 x18: ffffffffffffffff
> [    6.680296] x17: 0000000000000000 x16: ffffffe64492b900
> [    6.680300] x15: ffffffe6461e9d08 x14: 69202930203d2064
> [    6.680305] x13: 7561625f65736162 x12: 202c363331203d20
> [    6.696434] x11: 0000000000000030 x10: 0101010101010101
> [    6.696438] x9 : 4d4d20746120304d x8 : 7f7f7f7f7f7f7f7f
> [    6.707249] x7 : feff4c524c787373 x6 : 0000000000008080
> [    6.707253] x5 : 0000000000000000 x4 : 8080000000000000
> [    6.707257] x3 : 0000000000000000 x2 : ffffffe645d4e6cc
> [    6.744223] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> failed to find OPP for freq 102400000 (-34)
> [    6.744966] x1 : fffffffefe74e174 x0 : ffffffe6462a5ce8
> [    6.753580] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> failed to find OPP for freq 102400000 (-34)
> [    6.761634] Call trace:
> [    6.761639]  qcom_geni_console_setup+0x0/0x110
> [    6.761645]  register_console+0x29c/0x2f8
> [    6.767981] Bluetooth: hci0: Frame reassembly failed (-84)
> [    6.775252]  uart_add_one_port+0x438/0x500
> [    6.775258]  qcom_geni_serial_probe+0x2c4/0x4a8
> [    6.775266]  platform_drv_probe+0x58/0xa8
> [    6.855359]  really_probe+0xec/0x398
> [    6.855362]  driver_probe_device+0x5c/0xb8
> [    6.855367]  __device_attach_driver+0x98/0xb8
> [    7.184945]  bus_for_each_drv+0x74/0xd8
> [    7.188825]  __device_attach+0xec/0x148
> [    7.192705]  device_initial_probe+0x24/0x30
> [    7.196937]  bus_probe_device+0x9c/0xa8
> [    7.200816]  deferred_probe_work_func+0x7c/0xb8
> [    7.205398]  process_one_work+0x20c/0x4b0
> [    7.209456]  worker_thread+0x48/0x460
> [    7.213157]  kthread+0x14c/0x158
> [    7.216432]  ret_from_fork+0x10/0x18
> [    7.220049] Code: bad PC value
> [    7.223139] ---[ end trace 73f3b21e251d5a70 ]---

Ugh... I've hit this before. I didn't expect upstream to have this
issue so didn't bother checking. qcom_geni_console_setup is marked as
__init. That's the problem.


-Saravana
