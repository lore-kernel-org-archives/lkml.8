Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418CC20674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnHOXpWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGIEgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgGIEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:36:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B4C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:36:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so813136ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 21:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FwMHQwkgTEwQRptlW5b6jzutVAPRI0aEXcdLLOfXyrw=;
        b=cnHOXpWiDEMUEEnM/npZ01dnQ0+XeacZ4HDG0MkrzFEdqj1Hinv22sosTGO8htk8Ei
         t6FtfVP2OkWl4fM7jXfc766XO9uacNco8e9LxoGKbfiVSs+Dq7X2+kdBn3sXyZDJml04
         C5nUKTA3XSgSzyo79lqDL9lQ1WPpZoY4eM9K8LMaqC9ydDBhRHMjOqfZbAExdDOdk36k
         NqSb0i+QJMlDGHnbII+jXKD9mEA31S5gFydR54ExjJ90QwVAInx86P8OA63lriqW4Ir9
         1z9QxJ6rMSvFEkPsqQ3oJMDeQAH0jUU+gmrW1rUATFRxgAQsCgzBVXqSnZ/OkJxtsWAo
         aJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FwMHQwkgTEwQRptlW5b6jzutVAPRI0aEXcdLLOfXyrw=;
        b=cGk2vw0A/JV8NmnCETBN6lUiJPAfhoSKQAU5Va3YczxsLNeL2Mqylrsh+2995TrfBU
         rQYa/ddhWhHop27q2iHrXxKnvEkSx/PChrEgjnNm95zpCl3pEbD5L58OlO7v9YzStnFw
         Sz7uF/DanWqn6xtBxCQF7ksgYdnIGVf7kEcMxQJsM5B2YIVoBUvKxL/6EiaGwQbEuqp1
         yRT2I6K/G37dT60UWhQP8B+HvKIUnMq7XBkV+GxOndMyEYyNg7241S1pm1S/IZqujCC+
         BogyN8W9q9TmlBfSnE4UhoIaOZQMjwbYNEPuhMdyz7dkCKbxWzqhJu30yAslwALvIgUr
         acnA==
X-Gm-Message-State: AOAM531vuXaM2hEZkveaNZMoPl0nIxdbuFw4UQflhM0Rg0kYE0WoCiFn
        PlrRk82/CxtQgxXLoKXJwgj0OczxhiTQPjpwy1H0aDIz7FHZLg==
X-Google-Smtp-Source: ABdhPJzYJsqzNKsY4EAkHAFqAD9WzPmTSzI/cSxjIUQZyqXtIMrWqPk/XFPswbYH7OGJEtEIjVIwdNbXjTus2j+Hm1I=
X-Received: by 2002:a05:651c:1a6:: with SMTP id c6mr26721004ljn.358.1594269396489;
 Wed, 08 Jul 2020 21:36:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Jul 2020 10:06:24 +0530
Message-ID: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
Subject: BUG: KASAN: global-out-of-bounds in is_affected_midr_range_list on arm64
To:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        linux-arm-kernel@lists.infradead.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, james.morse@arm.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        saiprakash.ranjan@codeaurora.org, steven.price@arm.com,
        suzuki.poulose@arm.com, Mark Rutland <mark.rutland@arm.com>,
        ascull@google.com, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP cpuhotplug test on mainline 5.8.0-rc4 the kernel BUG noticed
on arm64 Juno-r2 KASAN config enabled kernel.

steps to reproduce:
- boot KASAN enabled Juno-r2 device
- cd /opt/ltp
- ./runltp -f cpuhotplug

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: 63e1968a2c87e9461e9694a96991935116e0cec7
  kernel-config:
https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/kernel.config
  vmlinux: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/vmlinux.xz
  system.map: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/System.map

Test log:
Name:   cpuhotplug02
Date:   Thu Jul  9 00:09:24 UTC 2020
Desc:   What happens to a process when its CPU is offlined?

CPU is 1
[  123.400330] process 722 (cpuhotplug_do_s) no longer affine to cpu1
[  123.400428] CPU1: shutdown
[  123.409425] psci: CPU1 killed (polled 0 ms)
[  123.752216] ==================================================================
[  123.759476] BUG: KASAN: global-out-of-bounds in
is_affected_midr_range_list+0x50/0xe8
[  123.767327] Read of size 4 at addr ffffa0001159bf78 by task swapper/1/0
[  123.773953]
[  123.775453] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc4 #1
[  123.781648] Hardware name: ARM Juno development board (r2) (DT)
[  123.787579] Call trace:
[  123.790041]  dump_backtrace+0x0/0x2b8
[  123.793716]  show_stack+0x18/0x28
[  123.797043]  dump_stack+0xec/0x158
[  123.800456]  print_address_description.isra.0+0x6c/0x448
[  123.805785]  kasan_report+0x134/0x200
[  123.809457]  __asan_load4+0x9c/0xd8
[  123.812957]  is_affected_midr_range_list+0x50/0xe8
[  123.817763]  has_cortex_a76_erratum_1463225+0x10/0x30
[  123.822830]  verify_local_cpu_caps+0xbc/0x1a0
[  123.827202]  check_local_cpu_capabilities+0x24/0x128
[  123.832183]  secondary_start_kernel+0x1b8/0x2b0
[  123.836719]
[  123.838211] The buggy address belongs to the variable:
[  123.843364]  erratum_1463225+0x18/0x40
[  123.847117]
[  123.848607] Memory state around the buggy address:
[  123.853413]  ffffa0001159be00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  123.860654]  ffffa0001159be80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  123.867895] >ffffa0001159bf00: 00 00 00 00 00 00 00 00 fa fa fa fa
00 00 00 fa
[  123.875131]                                                                 ^
[  123.882286]  ffffa0001159bf80: fa fa fa fa 00 00 00 00 00 00 00 00
00 fa fa fa
[  123.889526]  ffffa0001159c000: fa fa fa fa 00 00 00 00 00 00 00 00
00 00 00 00
[  123.896762] ==================================================================
[  123.903997] Disabling lock debugging due to kernel taint
[  123.909333] Detected PIPT I-cache on CPU1
[  123.913420] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]

Full test log link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.8-rc4-81-g63e1968a2c87/testrun/2911119/suite/linux-log-parser/test/check-kernel-bug-1548361/log

-- 
Linaro LKFT
https://lkft.linaro.org
