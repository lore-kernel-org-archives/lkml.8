Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84744C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562BE20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJS2OKag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgDXIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:00:49 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2488C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:00:49 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c24so8555300uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KT0ahyHQQ6gZXWpQoZA/Wi1N5ZzEw0pqyKM79kr8AIg=;
        b=jJS2OKagAG3YVjMSSdHFZhiXJZqikXQQ1g/BZ5/A0NY2+0JZo9/aMPqPwDDV0JF/3U
         YMlgE1dLxU7DhHzA5CJ0081ciC/6YRMdTmSm8a6A1y9eUAzrJANZmkRQzC+4pAgZyQeU
         wlhNSDNGDcpEhCvDNDspS9YzxWQByPq9a6jcNTd+HRduR+GjgR8SXtNPI+gLQPQyhpV5
         thheI8bvxkpW86YDSvDix8EcjXVVZHQjeE+yg81o/33eTnplK/8W+k0YIwk9I7tCatA5
         NNmyU3sIVDhRuFtd8PC2GGzzWcxDQ8echyGVDqvnmJg/RmjtGD+AJ00DQE0YLiLTHIbu
         YcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KT0ahyHQQ6gZXWpQoZA/Wi1N5ZzEw0pqyKM79kr8AIg=;
        b=d/ZBZ0dy81Mdt3TL6q34VF2HwKAxPrX0hiC6jqr3ip64muLlf579h68DmQ10ZZ7nqw
         3KyaPOM/QVJX4rYGT5nNtT15Fd4FvxVIZGdsLeZUv6lZSixjP2sVwEuqxvzkH3cybRws
         HnVRGeK+keiP5bwIRWAUAHIIs4RqXWUNBqegySb2vDX8iWDBc/iDsKIAhKqvRp/Dex78
         9JWiQLjXYkMfxTj8SGzrNbLGJJRH4k/10sWqQ90BdvGQpz8S/G/f+QknNyZyE9bpreYD
         GdV52lk41ixbMb3YYwriDZo+gz9iBdbnSZ8BlSZHfbAxemPINBu8aAxeNoalnFWNIhdA
         Yfeg==
X-Gm-Message-State: AGi0PuagwUofdgLXO6Xy0373xgMeuJRO9+O4JcgkFCORKF4HPAXJuWFH
        pLAhj0t2+H70gq1v2WCCVhuKiPUDbpGgboWb/Q==
X-Google-Smtp-Source: APiQypLbTcezdba2T+ITPdTS8NO9E9qrRb66FvkVTfHBSgDnAqH8tKiaL9m0+YAhSZSbXPLHSulYyDaxEI4GLxmmbAc=
X-Received: by 2002:ab0:238f:: with SMTP id b15mr6476468uan.32.1587715248802;
 Fri, 24 Apr 2020 01:00:48 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 24 Apr 2020 09:00:37 +0100
Message-ID: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
Subject: [BISECTED] bug/regression, x86-64: completely unbootable machine
To:     ggherdovich@suse.cz, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone,

Starting with Linux 5.7-rc1, my Arrandale (Core i3-380M) laptop is
completely unbootable (the last messages on screen are GRUB's loading
kernel/initramfs). I was hoping someone would have noticed it before
5.7-rc2 had been tagged, but alas. Anyway, I bisected it down to
commit 1567c3e3467cddeb019a7b53ec632f834b6a9239 (x86, sched: Add
support for frequency invariance). After reverting it, the machine
boots again, obviously.

Let me know if you need any further info in order to fix this issue.

Complete bisection log follows.

git bisect start
# good: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
git bisect good 7111951b8d4973bda27ff663f2cf18b663d15b48
# bad: [8f3d9f354286745c751374f5f1fcafee6b3f3136] Linux 5.7-rc1
git bisect bad 8f3d9f354286745c751374f5f1fcafee6b3f3136
# bad: [4646de87d32526ee87b46c2e0130413367fb5362] Merge tag
'mailbox-v5.7' of
git://git.linaro.org/landing-teams/working/fujitsu/integration
git bisect bad 4646de87d32526ee87b46c2e0130413367fb5362
# bad: [5b67fbfc32b544daa7f4e0f4e0ecdec4e4895938] Merge tag
'kbuild-v5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 5b67fbfc32b544daa7f4e0f4e0ecdec4e4895938
# good: [e129940938d84d8b71074e40a9cc4f69278eb1e1] Merge tag
'regmap-v5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect good e129940938d84d8b71074e40a9cc4f69278eb1e1
# bad: [2d385336afcc43732aef1d51528c03f177ecd54e] Merge tag
'irq-core-2020-03-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 2d385336afcc43732aef1d51528c03f177ecd54e
# good: [7c4fa150714fb319d4e2bb2303ebbd7307b0fb6d] Merge branch
'core-rcu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 7c4fa150714fb319d4e2bb2303ebbd7307b0fb6d
# good: [4b9fd8a829a1eec7442e38afff21d610604de56a] Merge branch
'locking-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4b9fd8a829a1eec7442e38afff21d610604de56a
# good: [9b82f05f869a823d43ea4186f5f732f2924d3693] Merge branch
'perf-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 9b82f05f869a823d43ea4186f5f732f2924d3693
# bad: [313f16e2e35abb833eab5bdebc6ae30699adca18] Merge branch
'sched/rt' into sched/core, to pick up completed topic tree
git bisect bad 313f16e2e35abb833eab5bdebc6ae30699adca18
# bad: [ae1677c0bbe23fe30d634ac0d9f5c147ee4adbc1] arm64/topology:
Populate arch_scale_thermal_pressure() for arm64 platforms
git bisect bad ae1677c0bbe23fe30d634ac0d9f5c147ee4adbc1
# bad: [b2b2042b204796190af7c20069ab790a614c36d0] sched/numa:
Distinguish between the different task_numa_migrate() failure cases
git bisect bad b2b2042b204796190af7c20069ab790a614c36d0
# bad: [b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7] sched/rt: Optimize
checking group RT scheduler constraints
git bisect bad b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7
# bad: [eacf0474aec8bdccdc7f19386319127c67be3588] x86, sched: Add
support for frequency invariance on ATOM_GOLDMONT*
git bisect bad eacf0474aec8bdccdc7f19386319127c67be3588
# bad: [2a0abc59699896f03bf6f16efb8a3a490511216f] x86, sched: Add
support for frequency invariance on SKYLAKE_X
git bisect bad 2a0abc59699896f03bf6f16efb8a3a490511216f
# bad: [1567c3e3467cddeb019a7b53ec632f834b6a9239] x86, sched: Add
support for frequency invariance
git bisect bad 1567c3e3467cddeb019a7b53ec632f834b6a9239
# first bad commit: [1567c3e3467cddeb019a7b53ec632f834b6a9239] x86,
sched: Add support for frequency invariance

Thanks,
Rui
