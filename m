Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA720C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD35B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMec02Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgE0Rvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgE0Rve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:51:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF7C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:51:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l15so29678313lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yz1OFVtKUg5e0Gh5JS6gGVn6q7BEXtsG6klU5YEyoTQ=;
        b=vMec02LhOQkAgOnTprMH1UTqxNgSiFlWm4pStE88P3nzVsnVgptVgiCFXvOcRLRdRC
         0c+R+0RoUeYFanulKc/Cpe3BuFVog5SVHpYLuUYsASc6Zfc2qsfKa+1g7zv0/Wr077oH
         +8tSR3i5pihnAFLfZOEAE9ZPw/o/mJvxt0AHzPa/fStrjmdzvpGXiIqH5/m0EL3XQzdu
         /36txsLWTB3/0kX6VI4tLfgOBE37KQMN9o89cOrpe/mBN4BDXl91g4Z8POR3F6feni9Y
         M42k5aCCIBIC5Wg2RdfJKT1YdU57IwMZMWx+poTHvWLGEMMNJQjHrZm+rKEA/w1v3vVj
         zPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yz1OFVtKUg5e0Gh5JS6gGVn6q7BEXtsG6klU5YEyoTQ=;
        b=fj6Of9nAjh8QB7bcZ0nkqy/Z/gKrI2rKFRE01CqXuZbzTgp4ABHi7Z4jYWHCwoNlFl
         WwE93e/WSaPnCUkNLoM86GYq+vydzjOmMRxnpeZ2g35/8qFBSb7ybhEWH5sDQfUWEBZg
         IP8n0hflbHerEgH54HbaufSHI+FAwfB8MfQG14+WGqopOhLX1InAXJ2KoqpeyD9ckrjO
         NS+pg0eQfjv/se7ufTX2vI7/CFLDPQ1Ee09TB9Oqr4dO+rcbPQMpRcYTUV6krzspQ/eQ
         ojvh2FXikpYxGfYG8NS+u5DeTbvI7Bw/NaiFVvnaumOWTLw56W0LKof3JmNAOMhkpvok
         0D2w==
X-Gm-Message-State: AOAM530x40dgMSE9K7S0C6wOnWSjiR3JwhD4cYFG1PG99t5u7/atjmjY
        8e/UR+N+WPJUj7s8b6f0erwsPTeHi5lAgG+Ly1zFhw==
X-Google-Smtp-Source: ABdhPJyKmRM8mieKJ5Y/3GVFXkHHiPY82ctnKLzzvbcP1OGLyNmqRsDEQBuVAH5qsL/q/tGr9E0PSX1ZpQY0C8SKtLs=
X-Received: by 2002:a2e:9684:: with SMTP id q4mr3618805lji.431.1590601889878;
 Wed, 27 May 2020 10:51:29 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 23:21:18 +0530
Message-ID: <CA+G9fYs6pMmR9jA5xJPk+vaAcRsH2OVNtm6UdY-wDb=Wnw0GBg@mail.gmail.com>
Subject: selftests: cgroup: config fragments required
To:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftest cgroup tests are getting skipped due to missing kernel config
fragments.
Please create the required config fragments "config" file.

Our CI system merges these kernel config fragments and builds the kernel
 for testing. You may refer config files in other test directories.

Test output log,
# selftests cgroup test_memcontrol
cgroup: test_memcontrol_ #
[SKIP] not ok 1 # SKIP memory controller isn't available
ok: 1_# [SKIP]
[SKIP] 1 selftests cgroup test_memcontrol # SKIP
selftests: cgroup_test_memcontrol [SKIP]
# selftests cgroup test_core
cgroup: test_core_ #
[SKIP] not ok 1 # SKIP Failed to set memory controller
ok: 1_# [SKIP]
[SKIP] 2 selftests cgroup test_core # SKIP
selftests: cgroup_test_core [SKIP]
# selftests cgroup test_freezer
cgroup: test_freezer_ #
# ok 1 test_cgfreezer_simple
1: test_cgfreezer_simple_ #
# ok 2 test_cgfreezer_tree
2: test_cgfreezer_tree_ #
# ok 3 test_cgfreezer_forkbomb
3: test_cgfreezer_forkbomb_ #
# ok 4 test_cgfreezer_mkdir
4: test_cgfreezer_mkdir_ #
# ok 5 test_cgfreezer_rmdir
5: test_cgfreezer_rmdir_ #
# ok 6 test_cgfreezer_migrate
6: test_cgfreezer_migrate_ #
# Cgroup /sys/fs/cgroup/unified/cg_test_ptrace isn't frozen
/sys/fs/cgroup/unified/cg_test_ptrace: isn't_frozen #
# not ok 7 test_cgfreezer_ptrace
ok: 7_test_cgfreezer_ptrace #
# ok 8 test_cgfreezer_stopped
8: test_cgfreezer_stopped_ #
# ok 9 test_cgfreezer_ptraced
9: test_cgfreezer_ptraced_ #
# ok 10 test_cgfreezer_vfork
10: test_cgfreezer_vfork_ #
[FAIL] 3 selftests cgroup test_freezer # exit=1
selftests: cgroup_test_freezer [FAIL]
# selftests cgroup test_stress.sh
cgroup: test_stress.sh_ #
# ./with_stress.sh line 34 echo write error No such file or directory
line: 34_echo #
# Skipping cannot enable cpuset in /sys/fs/cgroup/unified
cannot: enable_cpuset #
[SKIP] 4 selftests cgroup test_stress.sh # SKIP
selftests: cgroup_test_stress.sh [SKIP]

You may create config file like this,
CONFIG_CGROUPS=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y


-- 
Linaro LKFT
https://lkft.linaro.org
