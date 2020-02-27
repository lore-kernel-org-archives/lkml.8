Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE036C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87DF2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ghhFE02M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgB0T4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:56:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45323 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgB0T4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:56:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so198118qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHZKSP3VYnp46GXjDiGlb2OsfVMbe+Fm/ufXK0JaZec=;
        b=ghhFE02MoIHofcbDHVRBX9U/7eYfI4j70g1jWmFx0XEAoGpx7H47Gm0IWki1DRpFWc
         AqetnajsS/aYstusDRdzWPmEqTkl4wXNs/GAvuHu+DaaQM59ogrAZGzjP0MCSo19sPDL
         Poe40EqlTElaA/+u1CqJaB2Z6SxWrAQw6x9MBcfaUuZoc51ePJ+a3oYqcvBWc0OBDBry
         h8ctnmZ6CZdjFXHF2seaePaRSJrTPH8gi7/+I0suTK/cROfvShjCwDl5XMmcxabuH+Jq
         JbVgIl+KZ5Ygbamyx4ahqc89JV07ytB/RvEZSH6GcE+40H9BMjdM4i0yhnwIUqYm/xka
         U1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHZKSP3VYnp46GXjDiGlb2OsfVMbe+Fm/ufXK0JaZec=;
        b=pADPyPZej6NgS5XrjEaclA2vLeUiQ9AhK+ZumXfa4YUSihgcym2Ql4goHWH8nMN/tx
         J8W1Avdl/WoKmyrHRO9KaBnKow7+jzfnOeLkl4iPUcS1rZZikzE+i+dmOJLVoMzycDKO
         NvjKwdeSPCfMSlUKDid4dsE+RijKenPk/m04wPM2GHrsGqvIcCkEHpDS3CfvPN0RpRsB
         0uuEwDgXtlspo+Zzf3ZAbm8OSXlpJuRaoKF8oVLNlVbDe4zBcoJmsfHONOsrH3JBdVk7
         D8yi3GTWAfoAtdP6GO6tCQEoyz+tJLkYg3P7sMxZLDHVoT/Nejr9ZXNap0JBuJAM9v0l
         wQkQ==
X-Gm-Message-State: APjAAAVKd/5yCrUt008vUfh/ZueaFoB+WJbM8lT0RsNCFY/JJVsFOXXO
        Z7lZKGzLpWmllNoLZZ0e3Zo66w==
X-Google-Smtp-Source: APXvYqzh0jqRZctAqyIQSv9JTnGx+dvR+KkZIYZ3fOMX0S/d4oZuqtuZNihdMoguFDPnTcO4mHEgzQ==
X-Received: by 2002:ac8:1a30:: with SMTP id v45mr958788qtj.80.1582833371894;
        Thu, 27 Feb 2020 11:56:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2450])
        by smtp.gmail.com with ESMTPSA id o17sm3788427qtj.80.2020.02.27.11.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:56:11 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] mm: memcontrol: recursive memory.low protection
Date:   Thu, 27 Feb 2020 14:56:03 -0500
Message-Id: <20200227195606.46212-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Changelog & documentation updates (Michal Hocko, Michal Koutny)

Changes since v1:
- improved Changelogs based on the discussion with Roman. Thanks!
- fix div0 when recursive & fixed protection is combined
- fix an unused compiler warning

The current memory.low (and memory.min) semantics require protection
to be assigned to a cgroup in an untinterrupted chain from the
top-level cgroup all the way to the leaf.

In practice, we want to protect entire cgroup subtrees from each other
(system management software vs. workload), but we would like the VM to
balance memory optimally *within* each subtree, without having to make
explicit weight allocations among individual components. The current
semantics make that impossible.

They also introduce unmanageable complexity into more advanced
resource trees. For example:

          host root
          `- system.slice
             `- rpm upgrades
             `- logging
          `- workload.slice
             `- a container
                `- system.slice
                `- workload.slice
                   `- job A
                      `- component 1
                      `- component 2
                   `- job B

From a host-level perspective, we would like to protect the outer
workload.slice subtree as a whole from rpm upgrades, logging etc. But
for that to be effective, right now we'd have to propagate it down
through the container, the inner workload.slice, into the job cgroup
and ultimately the component cgroups where memory is actually,
physically allocated. This may cross several tree delegation points
and namespace boundaries, which make such a setup near impossible.

CPU and IO on the other hand are already distributed recursively. The
user would simply configure allowances at the host level, and they
would apply to the entire subtree without any downward propagation.

To enable the above-mentioned usecases and bring memory in line with
other resource controllers, this patch series extends memory.low/min
such that settings apply recursively to the entire subtree. Users can
still assign explicit shares in subgroups, but if they don't, any
ancestral protection will be distributed such that children compete
freely amongst each other - as if no memory control were enabled
inside the subtree - but enjoy protection from neighboring trees.

In the above example, the user would then be able to configure shares
of CPU, IO and memory at the host level to comprehensively protect and
isolate the workload.slice as a whole from system.slice activity.

Patch #1 fixes an existing bug that can give a cgroup tree more
protection than it should receive as per ancestor configuration.

Patch #2 simplifies and documents the existing code to make it easier
to reason about the changes in the next patch.

Patch #3 finally implements recursive memory protection semantics.

Because of a risk of regressing legacy setups, the new semantics are
hidden behind a cgroup2 mount option, 'memory_recursiveprot'.

More details in patch #3.

 Documentation/admin-guide/cgroup-v2.rst |  11 ++
 include/linux/cgroup-defs.h             |   5 +
 kernel/cgroup/cgroup.c                  |  17 ++-
 mm/memcontrol.c                         | 220 +++++++++++++++++-------------
 mm/page_counter.c                       |  12 +-
 5 files changed, 160 insertions(+), 105 deletions(-)


