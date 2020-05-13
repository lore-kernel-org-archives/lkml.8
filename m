Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kG3ag9UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbgEMRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732670AbgEMRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:41:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:41:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d21so492727ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QjuRXtzGVnN+Kn08SyiNAcKzsAyUI59HPJcsYAxmw0Y=;
        b=kG3ag9UDRW5Cz2Hlbx+/keGxFBYSJbznsQ6G0lnTz9Vk/5WihVEgcSuJc4HOhZxVIa
         1QW3TapgBwXxMM5bGsVZ51wKL/tBNIPAZvsIX5pcU3DZGRv9Lozmv5o3oUoMcsTFCFnr
         10yujkvlI45um35YJuOI1pFnUoYx7vae/TsTEUbKHfckM8cemdfujq0Vrjtf7rWwjmfd
         CGbtwkq55z7kCHlncT2TbUiKMBSXFZAvvP8m41WZH8L37nY1S0rjuRlWBGb45ZKB95rg
         qfnwKD/XHV8wYIAMtPtSsoW5/lhv5VRji4b7M0y0rRqMIOhN//4Di9rF+gSfbyiQOTo4
         Hiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QjuRXtzGVnN+Kn08SyiNAcKzsAyUI59HPJcsYAxmw0Y=;
        b=LcOiOebzXaGhP9Bl8XBwLuwhjfvJGlXJc0jG9GRdYE3uG7Q+BDFOwSfSmCC4Sdz65Q
         rmFlcklUXILc3rbPVeOYicmhDjYnsL/6DNX0zRImieM9IDmW2v2XsQy8Rm3NxqT6qUqM
         ClW3bE5vGyLC2Ll4PcjlcMoIz2glTGiexSV58mFOwJOboa0rYWZK9Ns3KBqLf7wx9DKf
         Y4TXC69lryxS+5r3nqne4S1Tfwc8NSQtoyzCZXStvS3Kgf+dq2g2F4A10zehSJJPMboR
         3RwOfx26++s81A+YP7LWeQjv/L6hGNy0vwHkXybpPzhMNt95H9ka2GtKqfQRd8ISlPDP
         +gnA==
X-Gm-Message-State: AOAM5329cImN07LNyDFf6IDpPQBcH9Wzi+2aTaoaghFbYBQHADBf2Cvo
        IMqWCZisiKo0u2lI7OrhvOD0ziGN1uL63OPBjfkcNw==
X-Google-Smtp-Source: ABdhPJx+AjJe8Wv9bvNiYj9gq2JqtcVDPVb3/KfH4V96pHYttjJ8Mfthw2JyDaK9+RRdwUJtpJL6ddIfj7SbfPgkDE8=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr140215lji.73.1589391712344;
 Wed, 13 May 2020 10:41:52 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 May 2020 23:11:40 +0530
Message-ID: <CA+G9fYvvDjA5t+zi0Zyn2F6D=7aE-Gu-m13o47LXYYfCD3SvrA@mail.gmail.com>
Subject: stable-rc 5.4: libhugetlbfs fallocate_stress.sh: Unable to handle
 kernel paging request at virtual address ffff00006772f000
To:     linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running libhugetlbfs fallocate_stress.sh on stable-rc 5.4 branch kernel
on arm64 hikey device. The following kernel Internal error: Oops:
crash dump noticed.

fallocate_stress.sh (2M: 64):
[  129.706506] Unable to handle kernel paging request at virtual
address ffff00006772f000
[  129.714638] Mem abort info:
[  129.717553]   ESR = 0x96000047
[  129.720726]   EC = 0x25: DABT (current EL), IL = 32 bits
[  129.726188]   SET = 0, FnV = 0
[  129.729338]   EA = 0, S1PTW = 0
[  129.732573] Data abort info:
[  129.735546]   ISV = 0, ISS = 0x00000047
[  129.739493]   CM = 0, WnR = 1
[  129.742534] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000013ad000
[  129.749409] [ffff00006772f000] pgd=0000000077ff7003,
pud=0000000077e0d003, pmd=0000000077cd1003, pte=006800006772f713
[  129.760294] Internal error: Oops: 96000047 [#1] PREEMPT SMP
[  129.765988] Modules linked in: wl18xx wlcore mac80211 cfg80211
hci_uart snd_soc_audio_graph_card adv7511 crct10dif_ce wlcore_sdio
btbcm snd_soc_simple_card_utils cec kirin_drm bluetooth drm_kms_helper
dw_drm_dsi rfkill drm fuse
[  129.786626] CPU: 1 PID: 1263 Comm: fallocate_stres Not tainted
5.4.41-rc1-00091-g132220af41e6 #1
[  129.795601] Hardware name: HiKey Development Board (DT)
[  129.800940] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  129.805847] pc : clear_page+0x10/0x24
[  129.809594] lr : __cpu_clear_user_page+0xc/0x18
[  129.814225] sp : ffff800012a1bbe0
[  129.817609] x29: ffff800012a1bbe0 x28: fffffe00017d8000
[  129.823039] x27: ffff000073070268 x26: ffff800011adf000
[  129.828466] x25: ffff800011ae06c8 x24: 0000000000001000
[  129.833893] x23: 0000000000000000 x22: fffffe00017d8000
[  129.839320] x21: 0000000000000000 x20: 0000000006a00000
[  129.844747] x19: ffff000037945400 x18: 0000000000000000
[  129.850174] x17: 0000000000000000 x16: 0000000000000000
[  129.855602] x15: 0000000000000000 x14: 0000000000000000
[  129.861031] x13: 0000000000000000 x12: 0000000000000000
[  129.866458] x11: 0000000000000000 x10: ffff800012a1bbd0
[  129.871886] x9 : 0000000000000200 x8 : 0ffff00000010000
[  129.877314] x7 : 0000000000000000 x6 : 0000000000000080
[  129.882741] x5 : 0000000000000036 x4 : 0000020000200000
[  129.888170] x3 : 0000000000004bc0 x2 : 0000000000000004
[  129.893597] x1 : 0000000000000040 x0 : ffff00006772f000
[  129.899025] Call trace:
[  129.901530]  clear_page+0x10/0x24
[  129.904926]  clear_subpage+0x54/0x90
[  129.908580]  clear_huge_page+0x6c/0x208
[  129.912503]  hugetlbfs_fallocate+0x2e0/0x4a0
[  129.916869]  vfs_fallocate+0x1b8/0x2e0
[  129.920699]  ksys_fallocate+0x44/0x90
[  129.924446]  __arm64_sys_fallocate+0x1c/0x28
[  129.928811]  el0_svc_common.constprop.0+0x68/0x160
[  129.933708]  el0_svc_handler+0x20/0x80
[  129.937539]  el0_svc+0x8/0xc
[  129.940488] Code: d53b00e1 12000c21 d2800082 9ac12041 (d50b7420)
[  129.946719] ---[ end trace df98e92a449be749 ]---
[  129.959274] note: fallocate_stres[1263] exited with preempt_count 1

ref:
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/build/v5.4.40-91-g132220af41e6/testrun/1428986/log
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/build/v5.4.40-91-g132220af41e6/testrun/1428986/

kernel config:
https://builds.tuxbuild.com/SqvcoklXmvQsC70j6rfcgA/kernel.config

-- 
Linaro LKFT
https://lkft.linaro.org
