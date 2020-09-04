Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7675AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D59220791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUCoywIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgIDI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgIDI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:58:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54837C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:58:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so7057365ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvKSzRaC+slqI0boQDvPn5VjIkUhzVPSJsTQT05BEnQ=;
        b=OUCoywIKiuOTCA/w0iBN8UdrldjuTbPg6ekRpmt0WPBwDN3nCNZhEEUJnFIvAEAgHh
         AxtBJSzSzetRQNld3KGYI6zfeVe0LfofU3+UfMFdo3Rluafb/vrSmQi8YMgu9dHCdkVS
         sKZU+C1KTfIigS7pKRZpE+0Oy8BCB2Gsk8P3cCAIlbKG74g/YFgEAcP0vYm34c5SZbID
         KHQ7zLHCV7TXk/mbRuE6kXINzRCvq8g8T7XuCmRJ+JoHpuLk7EgzNLegPAEJzUGhV8Jh
         DmqjKW2otvSQQvYlm1z4eZa5DzTPk9/LG7+KD+CoC7tHRo2BSd3e2fAVR4WCMe7Hrc8d
         lRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvKSzRaC+slqI0boQDvPn5VjIkUhzVPSJsTQT05BEnQ=;
        b=tK2tWm7RWPHl9WaGhgK3dXHZmEE4Ewhc6Y97RVKjvgEGXgwgL+zr9EpWlejDoCOSWG
         JHKJ8iNEGO7YP+LhscPyEjiZ4aUnnFWOI1f9n8mf1U3k8oq/2FrhwEUD+X+ILtuKiJuR
         MMCwS53h6/Bqmm43vHCjTXPqMKcJjF6A33BuNIJZTMCzKonYmBO9sX2IkfMpJEpDvCar
         WDUm9i6iriPVVgop3j41w3SGkpWVUFS7uBdSYoVgs45h3fev4Mw3bcmJBRvPDjOnrqcm
         INIiuWsiKYZE62SlEGtOH+XC+5ZUvnI3zcmrp5r+UJR1o/FoR6xKPysXpsQ6zck3siHa
         Lmgw==
X-Gm-Message-State: AOAM533If70zxVzIksiZBbHNI8Qb10mCA3UPy1wqUpLfBgwU7opFkCOa
        9R58lmpD8apHrvvFYTtGPvz+XuDsjd3GcHgB1qmeCQ==
X-Google-Smtp-Source: ABdhPJwubRm98/6EvG8/epeQ5srE8WB6kkdOuZnDSo2Ik+eb1O9SEN/uSYkGrmY3Q8BOaQ1UzbfCzHOB/y7y0hsICAo=
X-Received: by 2002:a2e:b00e:: with SMTP id y14mr861769ljk.427.1599209909692;
 Fri, 04 Sep 2020 01:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
In-Reply-To: <20200819133419.526889-1-alexandru.elisei@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 4 Sep 2020 14:28:18 +0530
Message-ID: <CAFA6WYM9zTXCsPwVWzFYMrJvPpQXzR1XjQ3b_FWvhW+vOr3fRA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, 19 Aug 2020 at 19:03, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> The series makes the arm_pmu driver use NMIs for the perf interrupt when
> NMIs are available on the platform (currently, only arm64 + GICv3). To make
> it easier to play with the patches, I've pushed a branch at [1]:
>
> $ git clone -b pmu-nmi-v6 git://linux-arm.org/linux-ae
>
> I've tested the series on an espressobin v7*. These are the results of
> running perf record -a -- sleep 60:
>
> 1. Without the patches:
>
>     16.73%  [k] arch_local_irq_enable
>     12.20%  [k] arch_cpu_idle
>      8.61%  [k] _raw_spin_unlock_irqrestore
>      4.09%  [k] arch_local_irq_enable
>      2.25%  [k] arch_local_irq_enable
>      1.82%  [k] arch_counter_get_cntpct
>      [..]
>
> 2. Using NMIs:
>
>      3.37%  [k] arch_counter_get_cntpct
>      2.62%  [.] _IO_fwrite
>      1.62%  [.] __gconv_transform_ascii_internal
>      1.49%  [.] __mbrtowc
>      1.44%  [k] el0_svc_common
>      1.31%  [.] strchr
>      [..]
>
> When running perf record -a -- iperf3 -c 127.0.0.1 -t 60:
>
> 1. Without the patches:
>     24.25%  [k] __arch_copy_from_user
>     20.94%  [k] __arch_copy_to_user
>      5.71%  [k] arch_local_irq_enable
>      3.12%  [k] _raw_spin_unlock_irqrestore
>      2.01%  [k] __free_pages_ok
>      1.48%  [k] arch_cpu_idle
>      [..]
>
> 2. Using NMIs:
>
>     23.15%  [k] __arch_copy_from_user
>     21.68%  [k] __arch_copy_to_user
>      1.23%  [k] tcp_ack
>      1.08%  [k] tcp_sendmsg_locked
>      0.97%  [k] rmqueue
>      0.91%  [k] __free_pages_ok
>      [..]
>
> I've ran the same tests in a VM when both host+guest use NMIs, and when
> neither use them. All of these tests were also ran on the model.  Similar
> results in all cases.
>
> * All the firmware versions for espressobin v7 that I've tried clear
> SCR_EL3.FIQ, which means that NMIs don't work. To make them work on the
> board, I modified the GICv3 driver. That's why I would really appreciate
> someone testing this series on a board where NMIs work without any GIC
> changes.

This series works perfectly fine for me without any GIC changes on
Developerbox. FWIW:

Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)

-Sumit

> For people who want to test the series, but don't have a board
> with firmware that sets SCR_EL3.FIQ, I've pushed a branch [2] with the
> GICv3 drivers changes necessary to make NMIs work:
>
> $ git clone -b pmu-nmi-v6-nmi-fiq-clear-v2 git://linux-arm.org/linux-ae
>
> Summary of the patches:
> * Patch 1 is a fix for a bug that Julien found during the review for v4.
> * Patches 2 and 3 remove locking from arm64 perf event code.
> * Patches 4 and 5 makes the arm64 PMU interrupt handler NMI safe.
> * Patches 6 and 7 enable the use of NMIs on arm64 with a GICv3 irqchip.
>
> Changes since v5 [3]:
> - Rebased on top of v5.9-rc1.
> - Typo fixes.
> - Added comments to the ISB added by patches #1 and #2.
> - Reworded message for patch #4, as per Mark's excellent suggestion.
>
> Changes since v4 [4]:
> - Rebased on top of v5.8-rc1 and dropped the Tested-by tags because it's
>   been almost a year since the series has been tested.
> - Dropped patch 3 because I couldn't find any instance where
>   armv7pmu_read_counter() was called with interrupts enabled. I've also
>   tested this by running several instances of perf for a few hours, and the
>   function was called every time with interrupts disabled.
> - Dropped patches 4 and 5 because the tradeoff wasn't worth it in my
>   opinion: the irq handler was slower all the time (because it
>   saved/restored the counter select register), in exchange for being
>   slightly faster on the rare ocassions when it triggered at the beginning
>   of the critical sections.
> - Minor changes here and there to address review comments.
>
> Changes since v3 [5]:
> - Added tags
> - Fix build issue for perf_event_v6
> - Don't disable preemption in pmu->enable()
> - Always rely on IPI_IRQ_WORK to run the queued work
> - Fixed typos + cleanups
>
> Changes since v2 [6]:
> - Rebased on recent linux-next (next-20190708)
> - Fixed a number of bugs with indices (reported by Wei)
> - Minor style fixes
>
> Changes since v1 [7]:
> - Rebased on v5.1-rc1
> - Pseudo-NMI has changed a lot since then, use the (now merged) NMI API
> - Remove locking from armv7 perf_event
> - Use locking only in armv6 perf_event
> - Use direct counter/type registers insted of selector register for armv8
>
> [1] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v6
> [2] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v6-nmi-fiq-clear-v2
> [3] https://www.spinics.net/lists/kernel/msg3554236.html
> [4] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/666824.html
> [5] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/665339.html
> [6] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640536.html
> [7] https://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554611.html
>
> Alexandru Elisei (1):
>   arm64: perf: Add missing ISB in armv8pmu_enable_event()
>
> Julien Thierry (5):
>   arm64: perf: Remove PMU locking
>   arm64: perf: Defer irq_work to IPI_IRQ_WORK
>   KVM: arm64: pmu: Make overflow handler NMI safe
>   arm_pmu: Introduce pmu_irq_ops
>   arm_pmu: arm64: Use NMIs for PMU
>
> Mark Rutland (1):
>   arm64: perf: Avoid PMXEV* indirection
>
>  arch/arm64/kernel/perf_event.c | 145 +++++++++++++++++++++------------
>  arch/arm64/kvm/pmu-emul.c      |  25 +++++-
>  drivers/perf/arm_pmu.c         | 142 +++++++++++++++++++++++++++-----
>  include/kvm/arm_pmu.h          |   1 +
>  4 files changed, 241 insertions(+), 72 deletions(-)
>
> --
> 2.28.0
>
