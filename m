Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A42C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352DE206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoEAjqjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgFHP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729787AbgFHP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqOHSA9Yl6yUcrMKWwmNFBGsqIUpYuLoXm9Jkw8eAdU=;
        b=EoEAjqjNJP2dWn9fya9HJeNqIoLnHVF8/G0QRZS+YH74/KKl0T7ow9XHFfwnhPXmncIyyn
        LD7MCC07C0t3lA1kzoLX1eLKxr/MXk7BbiX547gFiLXA0JcbJ4zjViHU6ZDbd4Kz4JuObV
        QmGlHZtLrrLQEsapdGe43rK57cHGLwY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-rQZ3271YPoC0tfFXKE-Xew-1; Mon, 08 Jun 2020 11:27:58 -0400
X-MC-Unique: rQZ3271YPoC0tfFXKE-Xew-1
Received: by mail-wm1-f71.google.com with SMTP id p24so5381433wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqOHSA9Yl6yUcrMKWwmNFBGsqIUpYuLoXm9Jkw8eAdU=;
        b=N8bKZ+dwCDQJseBun64iaE/Ic8DX9TSfOXyDS6p4lqLjC8d4lcjY7p7VSMWAsbMCuD
         CU/K1wZJKnaYcNujMEI3AV8kEs3DfQZJ+mEFP6n67SJTshALKAs/7fhhnqwmY1tC1tDl
         oyjPIskIKS5r2tJO5iRxRhMyUT/P6kOpu2FXZ1LHLFPi3wZeFqSOuwY/HrgY6nIbJicZ
         wN0fJfltlwaaBoIfeh9uerY2G7WjXONvfXdRAlsmSIUhabJP14BHKLpoJ3woOb3s9HHp
         gPicv8ae/cNnZYh9gPk3ZmxoaBT5FVg9mY57KBze5+daJ1/MjLFBh5pmZoFeqQoDcHDA
         7vTg==
X-Gm-Message-State: AOAM532hh/CHxj9FCDpdlyAWISdyUfdaKbx+cu3WbaMFgJyTsN8ry5ET
        JoCk+yfGz4tRw1yveOwfgcGUai/w4wHdtM3r7gwcEgFiBPrSWTSkv3M/xXUpEpBitJJT061m5wr
        JFD6iKskWLrSnDIwxFIGt8upG
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr25517489wrx.66.1591630077428;
        Mon, 08 Jun 2020 08:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGvh7VbCtfd0O4K5v/MW8Dq3g3rKDO5RxyXs6MjJX9dwCb4njA9QejfB2zeOuUClMab70gtg==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr25517476wrx.66.1591630077246;
        Mon, 08 Jun 2020 08:27:57 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:27:56 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 0/7] Make check implementation arch agnostic
Date:   Mon,  8 Jun 2020 16:27:47 +0100
Message-Id: <20200608152754.2483-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
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
- Patch 7 abstracts the use of unwind hints. Adding it as RFC as I'm sure
  there's room for improvement.

[1] https://lkml.org/lkml/2019/8/16/400
[2] https://lkml.org/lkml/2020/6/8/59
[3] https://github.com/julien-thierry/linux/tree/arch-independent-check

Cheers,

Julien

-->

Julien Thierry (6):
  objtool: Group headers to check in a single list
  objtool: Make sync-check consider the target architecture
  objtool: Move macros describing structures to arch-dependent code
  objtool: Abstract alternative special case handling
  objtool: Make relocation in alternative handling arch dependent
  objtool: Make unwind_hints available for all architectures

Raphael Gault (1):
  objtool: Refactor switch-tables code to support other architectures

 arch/x86/include/asm/orc_types.h              |  13 --
 arch/x86/include/asm/unwind_hints.h           |  44 +----
 include/linux/frame.h                         |  83 ++++++++-
 tools/arch/x86/include/asm/orc_types.h        |  13 --
 tools/include/linux/frame.h                   | 114 ++++++++++++
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
 20 files changed, 490 insertions(+), 273 deletions(-)
 create mode 100644 tools/include/linux/frame.h
 create mode 100644 tools/objtool/arch/x86/arch_special.c
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h

--
2.21.1

