Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B0BC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83540208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na+ViCn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBSHPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:15:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37995 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgBSHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:15:29 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so25270624iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 23:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ujk8TeZ6lFQaNC+5jMi7wSqIzVjAACDNNJKjD1EGy0U=;
        b=Na+ViCn5k6qvCOOV3wZ0/4ElpEqB1lYZ+CyDsGfOmcQSBjBBc3G732iT5aRJyCi6Ju
         PPoxQN4M7xxhd80yZv7wbOS/SJWe2xSW3l3/zIbPzCPN+Kb3kAg0iTsAG4Y4tU5RN2/x
         H33/+9AT+6uDltxTazBqfEj9sDZvNZHYTBLWoZl7XZLt+vit9o7na+GM40+y+ePhMq6H
         7NglfgPP4RIo1eEA9+BFox6amnHNVx8NnAYYWHpTTW7rd6UboRYW4ThmKqGebegwytIP
         EAcUszVS1BQgXiT/JCHuAenz6SgM8Jcii5f7aUqfjUOUtNBkNY/1c1Ha4R9exITuyLk/
         C/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ujk8TeZ6lFQaNC+5jMi7wSqIzVjAACDNNJKjD1EGy0U=;
        b=aurq175A9HM5kbJoUNKeZB5/0RGcRuA1wryqn/YMHaJry/MwA/hJYz3sJ8JYaa3nmI
         sQgENHfkAmkklFCt259cXV49p4BaqHM101USJmz1ezagDsj6ERabxO3OlkAhiayEBy1D
         kgrqABXDRfr2HnBKCKeOuu665tinKqGQnfUFZ2pqXmmjF/7dbmq4nxJFIiE8bq2l8mcX
         pknEx3dMuwTb9kTJKN/AQIGhqYHSBdBhvCkNybzmjoHPf3DZSYKDP7iipTqEV938jhbs
         kqtmL+zpSFiu1/Pia/N9wMOSnZQjb+JueQAhsWElNLt+F1TRLYtVh7/FbTzKcMpkyPwd
         nVxw==
X-Gm-Message-State: APjAAAUpi9FSIZ8hT7rEWRpEi6oUUzpN633yh7vyeVkidKPA/TmLfyF4
        98v6v5Mu8LqzpFD5WNKkx+OprRk1d3ZwNm+sq2G4cLM3
X-Google-Smtp-Source: APXvYqzfR/P531calyCEn8/7CycpHo/p0ZQkgcNgICHS8YC1oWS1w+pOTksiE0vnnXqAnSpZek2gnhF3+nHy+kreblM=
X-Received: by 2002:a6b:cd0e:: with SMTP id d14mr18381605iog.272.1582096528971;
 Tue, 18 Feb 2020 23:15:28 -0800 (PST)
MIME-Version: 1.0
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 19 Feb 2020 15:15:16 +0800
Message-ID: <CADjb_WQ0wFgZWBo0Xo1Q+NWS6vF0BSs5H0ho+5FM82Mu-JVYoQ@mail.gmail.com>
Subject: [RFC] Display the cpu of sched domain in procfs
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Tony Luck <tony.luck@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
sched domain topology is not always consistent with the CPU topology exposed at
/sys/devices/system/cpu/cpuX/topology,  which makes it
hard for monitor tools to distinguish the CPUs among different sched domains.

For example, on x86 if there are NUMA nodes within a package, say,
SNC(Sub-Numa-Cluster),
then there would be no die sched domain but only NUMA sched domains
created. As a result,
you don't know what the sched domain hierarchical is by only looking
at /sys/devices/system/cpu/cpuX/topology.

Although by appending sched_debug in command line would show the sched
domain CPU topology,
it is only printed once during boot up, which makes it hard to track
at run-time.

Proposal:
Add *span* filed under proc sched_domain directory to represent the
set of CPUs in each
sched domain.

Question:
*Before sending the patch out, may I have you opinions on whether this
is doable?*


Here are the sample output on a SNC system after the patch been applied:
grep . /proc/sys/kernel/sched_domain/cpu0/domain*/span
/proc/sys/kernel/sched_domain/cpu0/domain0/span:0,96     (SMT domain)
/proc/sys/kernel/sched_domain/cpu0/domain1/span:0-3,7-9,13-15,19-20,
(MC domain)

                   96-99,103-105,109-111,

                   115-116
/proc/sys/kernel/sched_domain/cpu0/domain2/span:0-23,96-119
         (NUMA domain)
/proc/sys/kernel/sched_domain/cpu0/domain3/span:0-191
           (NUMA domain)


FYI, the corresponding CPU topology is:
grep . /sys/devices/system/cpu/cpu0/topology/*cpus_list
/sys/devices/system/cpu/cpu0/topology/core_cpus_list:0,96
/sys/devices/system/cpu/cpu0/topology/die_cpus_list:0-23,96-119
/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-47,96-143


thanks,
Chenyu
