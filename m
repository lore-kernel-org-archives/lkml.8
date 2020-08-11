Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEAAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD20206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcXOq68Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHKCT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgHKCT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:19:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C929C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:19:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z22so10882427oid.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjQkpUOMJoWm2gMKrsdwZ3HTMI2B7AcBE8u9UiT0A50=;
        b=XcXOq68QLGo5UMJwFjXWAZMPBpZOuaq7SSHhlBkqn2tJEHaOZn4IrA6UVqnnUFiZfw
         OXl4SfyF1rXl+Ngmlv/Zlex+RuQwrKEWXvwC27qbiDZXTtcdJssattTRuPt4d9EDcVSh
         L28f20GguLHAyXoLcsFiCXP2GVEzPuxlnTXsubKjp7ov9TECj+GUkGbuWvbVaxifO3hn
         MLr0N1wTCrxC1UwW2dlO280+lLmOqE2m+9ueDK+jLhXmUdtJvAgnDKWg/vP0gy1xE0sB
         FGDDbqJVLZFCGJ0qMoY0QPhgOQGdM3K143tw4oRg63kspUMYIy6TgXJCh8va+PUgIGrE
         wwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjQkpUOMJoWm2gMKrsdwZ3HTMI2B7AcBE8u9UiT0A50=;
        b=pfAN0JPYbjzoutics6ZFBghWqI5OE4i+z8bjHMfMMl/XF4F9dmP3a1SRwalLKMUVN7
         CbZwDu5avWeBOKBaWx8JnyC21FEPkTJ9JSLUeq/peKoDIy0ae4hhZb1Zn0mFZlO8az8Q
         Y08fIotz44DhWO2EGDQS+xVagf4D4q6iNLuupoybwlH/XdElqQclUP7m/5U/Aure68jS
         bVE3yGC/w2mbM6+5s+VJzLmycup7F4PN9jDqoxDugpMDmmFza95uzOQTVEo7MVwjVlGk
         /cptEeLMoYxetlvbFePBwC7K4w5ag4KeMSqoSxy9qhxZFijbfaWhK+P6+HcKxIa7/0/t
         54Hg==
X-Gm-Message-State: AOAM532G+I26hACtBlTSo8Dawc8ksnX+KkVrUob6PTAtl1UE0CCiIr6r
        Cs3mtN1JIzYHvBKLudie3tF/KH7wxlQw5OFkCz+huw==
X-Google-Smtp-Source: ABdhPJy5EBSPgMHBj30CmQ3VLNim3u9L60YKPQSmVEmTAcNV8eNQuIEKX/b0KU93go3nJ+sIf4Ze7Zr92SwfMuYDRCU=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr1915972oif.10.1597112367826;
 Mon, 10 Aug 2020 19:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLXBQ34FKs_0EX+D=iccJxBPCC4tJN1NP7e8OQy6q9Z_Fg@mail.gmail.com>
 <CAGETcx8=BAu62HWDmaoORTXt-_oHB9TPUG4gRRJmQbTi3Tyk4A@mail.gmail.com>
In-Reply-To: <CAGETcx8=BAu62HWDmaoORTXt-_oHB9TPUG4gRRJmQbTi3Tyk4A@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 10 Aug 2020 19:19:16 -0700
Message-ID: <CALAqxLVpsEzNh2-oK-emeYhKsOCFep34gqh=qmZ_hB1M387Bsg@mail.gmail.com>
Subject: Re: Regression: serial crash on db845c using modular config w/ 5.9-rc
To:     Saravana Kannan <saravanak@google.com>
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

On Mon, Aug 10, 2020 at 5:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Aug 10, 2020 at 5:31 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > When testing with modular configs w/ mainline on db845c, I've been
> > running into an early boot crash (nothing on the console - but serial
> > drivers as built as modules - so not surprising). After setting the
> > CONFIG_SERIAL_QCOM_GENI=y (along with other QCOM_GENI configs) to
> > debug, I've found the backtrace below.
> >
> > I'm a little stumped as to what the issue might be. But wanted to
> > raise it in case anyone else is seeing similar. I don't see this issue
> > when using my non-modular config.
> >
> > I've tried reverting most of the geni changes since v5.8, but that
> > hasn't seemed to help much, making me suspicious it's something else.
> >
> > Any ideas?
> >
> > thanks
> > -john
> >
> >
> > [    6.469057] Unable to handle kernel paging request at virtual
> > address ffffffe645d4e6cc
> > [    6.481623] Mem abort info:
> > [    6.484466]   ESR = 0x86000007
> > [    6.487557]   EC = 0x21: IABT (current EL), IL = 32 bits
> > [    6.492929]   SET = 0, FnV = 0
> > [    6.496016]   EA = 0, S1PTW = 0
> > [    6.499202] swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000008151e000
> > [    6.501286] ufshcd-qcom 1d84000.ufshc: ufshcd_print_pwr_info:[RX,
> > TX]: gear=[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
> > [    6.505977] [ffffffe645d4e6cc] pgd=000000017df9f003,
> > p4d=000000017df9f003, pud=000000017df9f003, pmd=000000017df9c003,
> > pte=0000000000000000
> > [    6.505990] Internal error: Oops: 86000007 [#1] PREEMPT SMP
> > [    6.505995] Modules linked in: zl10353 zl10039 zl10036 zd1301_demod
> > xc5000 xc4000 ves1x93 ves1820 tuner_xc2028 tuner_simple tuner_types
> > tua9001 tua6100 1
> > [    6.506152]  isl6405
> > [    6.518104] ufshcd-qcom 1d84000.ufshc:
> > ufshcd_find_max_sup_active_icc_level: Regulator capability was not
> > set, actvIccLevel=0
> > [    6.530549]  horus3a helene fc2580 fc0013 fc0012 fc0011 ec100 e4000
> > dvb_pll ds3000 drxk drxd drx39xyj dib9000 dib8000 dib7000p dib7000m
> > dib3000mc dibx003
> > [    6.624271] CPU: 7 PID: 148 Comm: kworker/7:2 Tainted: G        W
> >       5.8.0-mainline-12021-g6defd37ba1cd #3455
> > [    6.624273] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [    6.624290] Workqueue: events deferred_probe_work_func
> > [    6.624296] pstate: 40c00005 (nZcv daif +PAN +UAO BTYPE=--)
> > [    6.624307] pc : qcom_geni_console_setup+0x0/0x110
> > [    6.624316] lr : try_enable_new_console+0xa0/0x140
> > [    6.624318] sp : ffffffc010843a30
> > [    6.624320] x29: ffffffc010843a30 x28: ffffffe645c3e7d0
> > [    6.624325] x27: ffffff80f8022180 x26: ffffffc010843b28
> > [    6.637937] x25: 0000000000000000 x24: ffffffe6462a2000
> > [    6.637941] x23: ffffffe646398000 x22: 0000000000000000
> > [    6.637945] x21: 0000000000000000 x20: ffffffe6462a5ce8
> > [    6.637952] x19: ffffffe646398e38 x18: ffffffffffffffff
> > [    6.680296] x17: 0000000000000000 x16: ffffffe64492b900
> > [    6.680300] x15: ffffffe6461e9d08 x14: 69202930203d2064
> > [    6.680305] x13: 7561625f65736162 x12: 202c363331203d20
> > [    6.696434] x11: 0000000000000030 x10: 0101010101010101
> > [    6.696438] x9 : 4d4d20746120304d x8 : 7f7f7f7f7f7f7f7f
> > [    6.707249] x7 : feff4c524c787373 x6 : 0000000000008080
> > [    6.707253] x5 : 0000000000000000 x4 : 8080000000000000
> > [    6.707257] x3 : 0000000000000000 x2 : ffffffe645d4e6cc
> > [    6.744223] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> > failed to find OPP for freq 102400000 (-34)
> > [    6.744966] x1 : fffffffefe74e174 x0 : ffffffe6462a5ce8
> > [    6.753580] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
> > failed to find OPP for freq 102400000 (-34)
> > [    6.761634] Call trace:
> > [    6.761639]  qcom_geni_console_setup+0x0/0x110
> > [    6.761645]  register_console+0x29c/0x2f8
> > [    6.767981] Bluetooth: hci0: Frame reassembly failed (-84)
> > [    6.775252]  uart_add_one_port+0x438/0x500
> > [    6.775258]  qcom_geni_serial_probe+0x2c4/0x4a8
> > [    6.775266]  platform_drv_probe+0x58/0xa8
> > [    6.855359]  really_probe+0xec/0x398
> > [    6.855362]  driver_probe_device+0x5c/0xb8
> > [    6.855367]  __device_attach_driver+0x98/0xb8
> > [    7.184945]  bus_for_each_drv+0x74/0xd8
> > [    7.188825]  __device_attach+0xec/0x148
> > [    7.192705]  device_initial_probe+0x24/0x30
> > [    7.196937]  bus_probe_device+0x9c/0xa8
> > [    7.200816]  deferred_probe_work_func+0x7c/0xb8
> > [    7.205398]  process_one_work+0x20c/0x4b0
> > [    7.209456]  worker_thread+0x48/0x460
> > [    7.213157]  kthread+0x14c/0x158
> > [    7.216432]  ret_from_fork+0x10/0x18
> > [    7.220049] Code: bad PC value
> > [    7.223139] ---[ end trace 73f3b21e251d5a70 ]---
>
> Ugh... I've hit this before. I didn't expect upstream to have this
> issue so didn't bother checking. qcom_geni_console_setup is marked as
> __init. That's the problem.

Ah! That would make sense!  I'll give that a try and if it works I'll
see about submitting a fix upstream.

Much appreciated!
-john
