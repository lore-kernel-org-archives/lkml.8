Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E9C55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FCC2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSgfMoOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgDWLR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgDWLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:17:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE36C035495
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:17:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y4so5791593ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oAZ3axSS566ERI69yTRudA5pk37T198UyezMCJFyqg0=;
        b=KSgfMoObN3NHkidu9iYPdBnmPp3engyij0Ehfav1N/WhjTgeC0WAEqV4PiK/2se+vh
         02HoWakOzVncGdusZNQ8ZY+F4fGiQeQp11DgqhFA6LRJS/KpLsNb/rZLlt7C9BbjD2TH
         yoXItbqJBSgTggjo6BLsrgNnlCAbD96MbZpV9SlalV5NLuUMbH7QF8llxpE4PTExVmbw
         d5LdA6pZenEYzRWH599sjZKGNxJ9Yx61SR1VALDpJCDfcBh55QcXhxJE1GvV7OKHQjyy
         aghumRr0w+KpFu9by9ZQSRdUYR2Hxj4B30onoIvzgWmUdZgQn0CuWqW0NiJ9Mre70Wyh
         JqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oAZ3axSS566ERI69yTRudA5pk37T198UyezMCJFyqg0=;
        b=Yte5ovW+uUX9WnBC71/CnuVVgWioqWsQvhT8g4s6CPiyG8tCZoS5iXtNLTWUMjsqEu
         ZJmcV7NH9cm0C4AGeJBEBmC6+tGnnfm4D5F+E+3EDyCmCZMbS7z+EUyfKwmOF0aeEat3
         mtNMw1XOrOxb8Hhlzza0R9tZWxmEnX2zVfehS5+bGcXgmYBuY4a8kE7tNBdUET1Y7Win
         UxVIRo1ssTwNci1GSxSl8JXki4/EiOOYKNCSOG8ElN2DmQcKAHJCsQct+c/Pdpv1KLxs
         KoLSMm9uyqslC2TM1Bmulryxp87NeqkPAtuQ1bPRXqAGebRZ0cwCPfnEMOt2bLv13JPr
         7JOQ==
X-Gm-Message-State: AGi0PuYomk6Rr9ujb/E828UCWw6I893nuyX2HLTA5D/QOYpSWxL1Y7Np
        /qKz3kx5fAlC4aVZQyshG1WZ4z1QQ7Ys99BY4L/MiQ==
X-Google-Smtp-Source: APiQypK0Re1sUKs5qj9tLUP4qPP1QkFHT2aHcKdugHwEJw1KaZvbC8SiMNOvF4Qprdlmol4eRp7pXa/xXuHF+2LAOi8=
X-Received: by 2002:a2e:9496:: with SMTP id c22mr1938373ljh.165.1587640642860;
 Thu, 23 Apr 2020 04:17:22 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 16:47:11 +0530
Message-ID: <CA+G9fYtoYzRbrUVhboUgOOqEC2xt_i4ZmYb9yq33fRmf653_pQ@mail.gmail.com>
Subject: stable-rc 4.14: Internal error: Oops: 96000004 - pc : __pi_strcmp+0x18/0x154
To:     linux- stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     lkft-triage@lists.linaro.org, colin.king@canonical.com,
        open list <linux-kernel@vger.kernel.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Brian Masney <masneyb@onstation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still notice kernel warnings while booting stable rc 4.14.177-rc1 kernel
on qualcomm dragonboard 410c development board.

[    7.760140] msm_dsi_host_set_src_pll: can't set parent to
byte_clk_src. ret=-22
[    7.763963] msm_dsi_manager_register: failed to register mipi dsi
host for DSI 0
[    7.772434]   EA = 0, S1PTW = 0
[    7.774344] msm 1a00000.mdss: failed to bind 1a98000.dsi (ops
dsi_ops [msm]): -22
[    7.779241] Data abort info:
[    7.789056] msm 1a00000.mdss: master bind failed: -22
[    7.792091] msm_dsi: probe of 1a98000.dsi failed with error -22
[    7.794132]   ISV = 0, ISS = 0x00000004
[    7.802783]   CM = 0, WnR = 0
[    7.809436] user pgtable: 4k pages, 48-bit VAs, pgd = ffff80003b1d7000
[    7.809660] [0000000000000000] *pgd=0000000000000000
[    7.825466] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    7.825498] Modules linked in: rfkill crc32_ce adv7511 msm(+)
msm_rng mdt_loader drm_kms_helper rng_core drm fuse
[    7.829847] Process systemd-udevd (pid: 2635, stack limit =
0xffff00000f3c0000)
[    7.840261] CPU: 1 PID: 2635 Comm: systemd-udevd Not tainted 4.14.177-rc1 #1
[    7.847391] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    7.847397] task: ffff80003b279780 task.stack: ffff00000f3c0000
[    7.847410] pc : __pi_strcmp+0x18/0x154
[    7.866993] lr : platform_match+0xc8/0xe8
[    7.870809] sp : ffff00000f3c3b10 pstate : 40000145
[    7.874975] x29: ffff00000f3c3b10 x28: ffff80003a56a000
[    7.879663] x27: ffff0000081a0578 x26: ffff000000ef98d0
[    7.885219] x25: ffff00000f3c3e50 x24: ffff00000f515000
[    7.890514] x23: ffff0000095c8000 x22: 0000000000000000
[    7.895809] x21: 0000000000000000 x20: ffff000000ef8648
[    7.901104] x19: ffff80003d1998d0 x18: 0000ffff9a0bf0b0
[    7.906398] x17: 0000ffff9a06b6d0 x16: ffff000008160330
[    7.911694] x15: 000000002810bf43 x14: 0000000000000043
[    7.916990] x13: 3a6c6c7030697364 x12: 00000000bcc77e12
[    7.922283] x11: ffff80003b279fb8 x10: 0101010101010101
[    7.927581] x9 : 8efefeff06fefeff x8 : 0000000000000000
[    7.932874] x7 : 0000000000000000 x6 : 0000000000000000
[    7.938172] x5 : 0000000000000100 x4 : 0000000000000000
[    7.943466] x3 : 0000000000000000 x2 : ffff0000087be348
[    7.948761] x1 : ffff000000eed688 x0 : 0000000000000000
[    7.954056] Call trace:
[    7.959354]  __pi_strcmp+0x18/0x154
[    7.970033]  bus_for_each_dev+0x5c/0xa8
[    7.970056]  driver_attach+0x30/0x
[    7.972665]  bus_add_driver+0x1d0/0x240
[    7.976484]  driver_register+0x6c/0x118
[    7.980044]  __platform_driver_register+0x54/0x60
[    7.984103]  msm_drm_register+0x48/0x80 [msm]
[    7.988728]  do_one_initcall+0x44/0x138
[    7.993065]  do_init_module+0x64/0x1d0
[    7.996710]  load_module+0x1d48/0x2518
[    8.000530]  SyS_finit_module+0xb0/0xc8
[    8.004263]  __sys_trace_return+0x0/0x4
[    8.007998] Code: f24008ff 540002e1 f2400807 54000141 (f8408402)
[    8.011820] ---[ end trace 7d6fc616cc3d45e7 ]---

full test log,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.176-200-gcebd79de8787/testrun/1389032/log
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.176-200-gcebd79de8787/testrun/1389032/
https://lkft.validation.linaro.org/scheduler/job/1389032#L3519

Kernel config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-stable-rc-4.14/817/config

-- 
Linaro LKFT
https://lkft.linaro.org
