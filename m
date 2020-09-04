Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7099DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2222074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCwnYIsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIDP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730889AbgIDP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599233286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=umTLLbWNIKdgBaY8oamQNBodLX2YoAzBBUrL/6iK/FA=;
        b=WCwnYIsJTFUlu4DrbEiSlwhkzlBMVLJv8O9IVFF6PqVC+ddpya/x1KgBMPudW+FGsQylNW
        uAGWpJXDJWDDvnb5mriY6Ejq+7rCdWbzU1UPLE6v4koU9uQ3CgZv4TR8av9XX4etFzzGDg
        R6GCuFm1yID/yVv5OI/35EUOfrD/wos=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-J7jT90cyPPyRUO-aN02Akg-1; Fri, 04 Sep 2020 11:28:01 -0400
X-MC-Unique: J7jT90cyPPyRUO-aN02Akg-1
Received: by mail-ej1-f71.google.com with SMTP id d8so627620ejt.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umTLLbWNIKdgBaY8oamQNBodLX2YoAzBBUrL/6iK/FA=;
        b=hLnRsMbPXySIU7o6BAiJuTKGPJ+Q++o1bRTuYfOQ6uNXjm2dfhx5gMvYO8rjzhaa2b
         25GDdgMZ6PPfVfy4XRPVteCtBAlsFSv9Sg5sDjrfC0o+gjUr6jpn5CgYjd4liF3LfAjr
         JtXc25M9m/9Vh0W66BXdW/rjSwEQxMNXIdsfQ3V+9rAPcqMrLOthZ78LqYSR1faR8NWc
         PDo4oBRjpWhwXJ1Y/fwbITA04dgq8Am/RcscE9SbucMbEkpMtwX8Og7x9+BF5BtK31Ny
         Xo5n3iq75GUqHo0igk9xXTKIrHOLnPZ822dT5DdU0T8qbCirzTCnwuUytmo9Ox9qMMCg
         S7tA==
X-Gm-Message-State: AOAM532+MQM/AG1Jgor8xkfM7OHl98L/AZnvYFKr8utwiPSDbxLdPbS3
        dUDz60u9LPQfrfsWwpC+wwM7my5iduCKLKQU4bYbhGa46HQBPRHVKPIRcG30/iMCiqsj/gNd+JJ
        p3rmbVGYAfnqERnU0lWZMrZQe
X-Received: by 2002:a17:907:37b:: with SMTP id rs27mr8455510ejb.0.1599233280084;
        Fri, 04 Sep 2020 08:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7T7l9O/ybfKdjU+qvLUikdHdaUSCiILWHYrbM5ZVVa+YicRT10pKpVRojS1ZgFXyfzuKgUQ==
X-Received: by 2002:a17:907:37b:: with SMTP id rs27mr8455494ejb.0.1599233279880;
        Fri, 04 Sep 2020 08:27:59 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id a18sm6357110ejy.71.2020.09.04.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:27:59 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 00/10] Make check implementation arch agnostic
Date:   Fri,  4 Sep 2020 16:27:45 +0100
Message-Id: <20200904152755.32372-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current implementation of the check subcommand has various x86 bits
here and there. In order to prepare objtool to provide check for other
architectures, add some abstraction over the x86 specific bits, relying
on objtool arch specific code to provide some necessary operations.

This is part of the effort to implement check for arm64, initiated [1]
by Raphael. The series is based on top of the separation of check & orc
subcommands series[2].

I've push both series base on top of tip/objtool/core at [3].

- The first two patches make it simpler for new arches to provide their
list of kernel headers, without worrying about modifications in the x86
headers.
- Patch 3 Moves arch specific macros to more suitable location
- Patches 4 and 5 add abstraction to handle alternatives
- Patch 6 adds abstraction to handle jump table
- Patches 7-10 makes unwind hint definitions shared across architectures

Changes since v2 [4]:
- Rebased on v5.9-rc1
- Under tools/objtool/arch/x86/, rename arch_special.c to special.c
- Rename include/linux/frame.h to inclide/linux/objtool.h
- Share unwind hint types across architectures

[1] https://lkml.org/lkml/2019/8/16/400
[2] https://lkml.org/lkml/2020/6/4/675
[3] https://github.com/julien-thierry/linux/tree/arch-independent-check
[4] https://lkml.org/lkml/2020/7/30/424

Cheers,

Julien

-->

Julien Thierry (9):
  objtool: Group headers to check in a single list
  objtool: Make sync-check consider the target architecture
  objtool: Move macros describing structures to arch-dependent code
  objtool: Abstract alternative special case handling
  objtool: Make relocation in alternative handling arch dependent
  headers: Rename frame.h
  objtool: Only include valid definitions depending on source file type
  objtool: Make unwind hints definitions available to other
    architectures
  objtool: Decode unwind hint register depending on architecture

Raphael Gault (1):
  objtool: Refactor switch-tables code to support other architectures

 arch/x86/include/asm/nospec-branch.h          |   2 +-
 arch/x86/include/asm/orc_types.h              |  34 ----
 arch/x86/include/asm/unwind_hints.h           |  50 +-----
 arch/x86/kernel/kprobes/core.c                |   2 +-
 arch/x86/kernel/kprobes/opt.c                 |   2 +-
 arch/x86/kernel/reboot.c                      |   2 +-
 arch/x86/kernel/unwind_orc.c                  |  11 +-
 arch/x86/kvm/svm/svm.c                        |   2 +-
 arch/x86/kvm/vmx/nested.c                     |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c           |   3 +-
 include/linux/frame.h                         |  35 -----
 include/linux/objtool.h                       | 134 ++++++++++++++++
 kernel/bpf/core.c                             |   2 +-
 kernel/kexec_core.c                           |   2 +-
 tools/arch/x86/include/asm/orc_types.h        |  34 ----
 tools/include/linux/objtool.h                 | 134 ++++++++++++++++
 tools/objtool/Makefile                        |   2 +-
 tools/objtool/arch.h                          |   2 +
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/decode.c               |  37 +++++
 tools/objtool/arch/x86/include/arch_special.h |  20 +++
 tools/objtool/arch/x86/special.c              | 145 ++++++++++++++++++
 tools/objtool/check.c                         | 137 ++---------------
 tools/objtool/check.h                         |   7 +-
 tools/objtool/objtool.h                       |   2 +
 tools/objtool/orc_dump.c                      |   7 +-
 tools/objtool/orc_gen.c                       |   5 +-
 tools/objtool/special.c                       |  48 +-----
 tools/objtool/special.h                       |  10 ++
 tools/objtool/sync-check.sh                   |  27 ++--
 tools/objtool/weak.c                          |   2 -
 33 files changed, 561 insertions(+), 346 deletions(-)
 delete mode 100644 include/linux/frame.h
 create mode 100644 include/linux/objtool.h
 create mode 100644 tools/include/linux/objtool.h
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 create mode 100644 tools/objtool/arch/x86/special.c

--
2.21.3

