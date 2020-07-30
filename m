Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA940C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC09F20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgPBOOEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgG3JrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbgG3JrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hizMY7VP9LzcQ3FeVpCv/BY7A7ybnk2yUmR7sBLJoHo=;
        b=CgPBOOEBwfL3NZsfLmGHCUOf3Tn0Jy2D57PslMo8ZwAKj8ii19u4bgLiPbEO3o18YeAOrj
        e/nNmltGfJRv+cvjUXe7V1jAgowR1FAFEG62uvwRMHN4Lk7TFKOz9zJRKziMZR6a3D+/+X
        Cy/DtLkCRF/Y/1dOHfW9G6wHDuf0WvE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-w0zGnyc_NxK-LOJbsNMcpQ-1; Thu, 30 Jul 2020 05:46:57 -0400
X-MC-Unique: w0zGnyc_NxK-LOJbsNMcpQ-1
Received: by mail-wm1-f70.google.com with SMTP id p23so1299297wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hizMY7VP9LzcQ3FeVpCv/BY7A7ybnk2yUmR7sBLJoHo=;
        b=iLyXxRoEOKuQ+HlYFJAXbEpa/wX5LaQu1HvBneyynIwMH9FO2lAphucSDSmU9HByFR
         db/PyxV/76oi+oC+Rc+aYuaEvpYZfO6iJumbUDkn8BAErJByZaPTiz2VaEyezEiVBUdo
         MrF5QaB1k8jnC8fVOG+X8HB3dv+ZEk7yX6jW+SeoavUd3j3J73LQc7TsrDZEUAURgGQs
         fBMxo+0cW2XbQ4CiKa2BIyljnucwGgJQXp7flLND0fG22pfoUt5XICfGmgtd/k9PW7St
         Q6kGIN9Qwf4pzCTYVENjsu2Rbv8i27WJ2zjv4dBOsyRIbGrfRpGI1ygM9fQKUULTZUlC
         mjhg==
X-Gm-Message-State: AOAM533UsKRe3t+ErYjUCDlGBWfjy669hncrt4DZ7OGoD92H43T/adPm
        6rd44HPoe0mGhu42CoEEpXqoMyvZObunARO7BVOfJsRYM7TfYlsIxSJ0VxW2stxEyde4S3JivX4
        5dO59kwvRusiMyxpTBiE8NV23
X-Received: by 2002:a1c:40b:: with SMTP id 11mr6191401wme.116.1596102416245;
        Thu, 30 Jul 2020 02:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLA4IiNsCakNSZ/6egZvPhSMF38dQXYQsdbPz3arIBz4wC6wCYiO+IZQQ+rkBwI2plyW2//A==
X-Received: by 2002:a1c:40b:: with SMTP id 11mr6191386wme.116.1596102416012;
        Thu, 30 Jul 2020 02:46:56 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:46:55 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 0/9] Make check implementation arch agnostic
Date:   Thu, 30 Jul 2020 10:46:43 +0100
Message-Id: <20200730094652.28297-1-jthierry@redhat.com>
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
- Patches 7-9 abstracts the use of unwind hints, so some definitions
  can be shared across architectures while keeping arch specific
  semantics

Changes since v1 [4]:
- Rebased on recent tip/objtool/core
- Split the unwind hint rework into multiple patches as suggested by
  Miroslav

[1] https://lkml.org/lkml/2019/8/16/400
[2] https://lkml.org/lkml/2020/7/30/415
[3] https://github.com/julien-thierry/linux/tree/arch-independent-check
[4] https://lkml.org/lkml/2020/6/8/535

Cheers,

Julien

-->

Julien Thierry (8):
  objtool: Group headers to check in a single list
  objtool: Make sync-check consider the target architecture
  objtool: Move macros describing structures to arch-dependent code
  objtool: Abstract alternative special case handling
  objtool: Make relocation in alternative handling arch dependent
  frame: Only include valid definitions depending on source file type
  frame: Make unwind hints definitions available to other architectures
  objtool: Abstract unwind hint reading

Raphael Gault (1):
  objtool: Refactor switch-tables code to support other architectures

 arch/x86/include/asm/orc_types.h              |  13 --
 arch/x86/include/asm/unwind_hints.h           |  44 +----
 include/linux/frame.h                         |  78 ++++++++
 tools/arch/x86/include/asm/orc_types.h        |  13 --
 tools/include/linux/frame.h                   | 113 ++++++++++++
 tools/objtool/Makefile                        |   2 +-
 tools/objtool/arch.h                          |   5 +-
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/arch_special.c         | 145 +++++++++++++++
 tools/objtool/arch/x86/decode.c               |  54 ++++++
 tools/objtool/arch/x86/include/arch_special.h |  20 +++
 tools/objtool/cfi.h                           |   3 +-
 tools/objtool/check.c                         | 166 ++----------------
 tools/objtool/check.h                         |   7 +-
 tools/objtool/objtool.h                       |   2 +
 tools/objtool/orc_gen.c                       |   4 +-
 tools/objtool/special.c                       |  48 +----
 tools/objtool/special.h                       |  10 ++
 tools/objtool/sync-check.sh                   |  27 ++-
 tools/objtool/weak.c                          |   2 -
 20 files changed, 486 insertions(+), 271 deletions(-)
 create mode 100644 tools/include/linux/frame.h
 create mode 100644 tools/objtool/arch/x86/arch_special.c
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h

--
2.21.3

