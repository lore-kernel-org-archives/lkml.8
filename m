Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D25C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8A520690
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7gEDDzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbgEMSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:52:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38872 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390174AbgEMSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589395964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=klz1aIlltTyMvpQo6wp2CnVfN50qcHTeSgtHjx0WeI8=;
        b=O7gEDDzhd+Ediw2lolIyIWukU00BctGrUTwF1sJufx5l9z+iKVIkIoo7GS16V920kh+iXB
        xqA/116Fl73lyIAdhcijM/aeWFtJko+oL4L5wYQfUKikf4coKuaVLfcJUkniaVOsPvdpS7
        O8PPu3hM9NKV+MjItNCjlrT7/2LR67I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-YhkYWQwQOa64APFU1gPAgA-1; Wed, 13 May 2020 14:52:43 -0400
X-MC-Unique: YhkYWQwQOa64APFU1gPAgA-1
Received: by mail-pf1-f200.google.com with SMTP id t22so505633pfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=klz1aIlltTyMvpQo6wp2CnVfN50qcHTeSgtHjx0WeI8=;
        b=mYR21rbSwPtrtLQLaVqF1za1jnTp3BqskTBNwbgJ6NjaKRxWeWhRqBmU2dMFBsf20P
         1cqaaxzGpm6Ch4Sbpx7WGcw9b+/LZ8EwgHRqYhW/e7Fc/K2VwaiyTgYWD7tXYfCYK/vz
         mII4KscTNE07023/KvPeAJQpYIxjLil10Yx8mKbSu/UHXTVDUMBRH8KRvHfsSEibozAK
         mrdX5jguB0B4Dj0WpAI789k8FyQYzg3niT9K4HLSppnPR8pfU8IFcB+Eq4seMIX44tVO
         RMUo+CCe8ju5ArzPZaifyY8rWn/wYYLBYe0O9IebusiirY3bTtB+rr4teQns+N8bqnua
         Wb/g==
X-Gm-Message-State: AGi0PuazCvmzSuxXaR9D+H0dQ3P7uJ4heuYnD8QkJvbJYDYcdBqVSUed
        3L2oNf4uJ2OFBI+9aOV25yM/xLSPJXP7zBZFsAcC519fj6BjFM+N07sPJ6lKwbQrJA/yw36JRWo
        9zCULrnMNZzuCL6TLHwaK7+xM
X-Received: by 2002:a17:90a:bc4a:: with SMTP id t10mr35609769pjv.104.1589395961816;
        Wed, 13 May 2020 11:52:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIuLKmGrGFPHM791kHZAFCmnHIYlCo9XywvYUHAqAM5Bb2fZsRB2lyt+YcuSxBVSz35z/ovow==
X-Received: by 2002:a17:90a:bc4a:: with SMTP id t10mr35609740pjv.104.1589395961483;
        Wed, 13 May 2020 11:52:41 -0700 (PDT)
Received: from localhost ([122.177.166.225])
        by smtp.gmail.com with ESMTPSA id m18sm16270331pjl.14.2020.05.13.11.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:52:40 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        scott.branden@broadcom.com, Amit Kachhap <amit.kachhap@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ for arm64 and MAX_PHYSMEM_BITS for all archs)
Date:   Thu, 14 May 2020 00:22:35 +0530
Message-Id: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delayed update. Its been quite some time since I
posted the last version (v5), but I have been really caught up in some
other critical issues.

Changes since v5:
----------------
- v5 can be viewed here:
  http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
- Addressed review comments from James Morse and Boris.
- Added Tested-by received from John on v5 patchset.
- Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
  patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
  applied.

Changes since v4:
----------------
- v4 can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
- Addressed comments from Dave and added patches for documenting
  new variables appended to vmcoreinfo documentation.
- Added testing report shared by Akashi for PATCH 2/5.

Changes since v3:
----------------
- v3 can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-March/022590.html
- Addressed comments from James and exported TCR_EL1.T1SZ in vmcoreinfo
  instead of PTRS_PER_PGD.
- Added a new patch (via [PATCH 3/3]), which fixes a simple typo in
  'Documentation/arm64/memory.rst'

Changes since v2:
----------------
- v2 can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
- Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEMEM
  ifdef sections, as suggested by Kazu.
- Updated vmcoreinfo documentation to add description about
  'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).

Changes since v1:
----------------
- v1 was sent out as a single patch which can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-February/022411.html

- v2 breaks the single patch into two independent patches:
  [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
  [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)

This patchset primarily fixes the regression reported in user-space
utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
with the availability of 52-bit address space feature in underlying
kernel. These regressions have been reported both on CPUs which don't
support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
and also on prototype platforms (like ARMv8 FVP simulator model) which
support ARMv8.2 extensions and are running newer kernels.

The reason for these regressions is that right now user-space tools
have no direct access to these values (since these are not exported
from the kernel) and hence need to rely on a best-guess method of
determining value of 'vabits_actual' and 'MAX_PHYSMEM_BITS' supported
by underlying kernel.

Exporting these values via vmcoreinfo will help user-land in such cases.
In addition, as per suggestion from makedumpfile maintainer (Kazu),
it makes more sense to append 'MAX_PHYSMEM_BITS' to
vmcoreinfo in the core code itself rather than in arm64 arch-specific
code, so that the user-space code for other archs can also benefit from
this addition to the vmcoreinfo and use it as a standard way of
determining 'SECTIONS_SHIFT' value in user-land.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: John Donnelly <john.p.donnelly@oracle.com>
Cc: scott.branden@broadcom.com
Cc: Amit Kachhap <amit.kachhap@arm.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org

Bhupesh Sharma (2):
  crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
  arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo

 Documentation/admin-guide/kdump/vmcoreinfo.rst | 16 ++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
 arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
 kernel/crash_core.c                            |  1 +
 4 files changed, 28 insertions(+)

-- 
2.7.4

