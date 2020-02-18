Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72026C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43530206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lANL6p2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgBRJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:41:45 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:57194 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgBRJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:41:44 -0500
Received: by mail-wm1-f73.google.com with SMTP id g26so787104wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QNDLs7l5J8RmAhjpuRmr0/PxcwWDOhEmr8wUXVMCS2g=;
        b=lANL6p2mxZ67NSBsDtLRBYxP1dnT4hLBAedhNx7ZmTLwbVjaSwPc6ETlhgNtHB/jzu
         gHp15hKseyftrJCbIZVDUudAMcQ216VYl5pV1ZopaXZnugurtnzgIBjyFG0DTLT6HXEf
         5B+8C4QFBEZYRaWl/4hp+j7DRzUVdRjoqXHHtO/CcYkjlP6ClzR+Z/o5nRanCJJU8LV5
         MifU7kIk+0YYfMFsNPgp+iQHgl229wu6nrD21G44TYiBVe46j7litx2KvF4jE36nfzko
         I+vjI826KsmfZUaXQveeJ0wUldepShLPUDQ72OfZvFtVmY74bMDe1E0LNyJQsg6sygFk
         V3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QNDLs7l5J8RmAhjpuRmr0/PxcwWDOhEmr8wUXVMCS2g=;
        b=oLuRpvTwAvj4iTS/1SKI0omvEHCM7ppBKsJ+nS9OY+kr2lUsuruSOm/C/RYiYs4PNz
         apCh21fMo/RUg57CeoqfGCqFGee3PKWopXsVmULamZvbHQKJu/H/8dRjjDMAKsahDxQx
         E/Yg26Pi5Z4yr/3uu28664PFhi97+Qyj8a6B+ZIMGWX0vju96HhCYe4xmhHpBRRomrAP
         iE3Apj0Huo/xeSR88hfyKcaubX5Yt5qi0/eYKxUuuthAaXhwZ8hv4VNlMtSDwOlfe974
         IrWBp2Q0HYHLL6IGU3eqoEaEyXb/OaZEyLKocfVUNL7uPMvLFL8QyDEPgSz8Ru400odU
         NOgQ==
X-Gm-Message-State: APjAAAXXrdlmOvLts79P6N/0QmEfmhFhoKY834Z6sYfkLO9S625vmcB1
        hB2U6P/gaod6wI/WjSg3BO8fA/z+UDXu
X-Google-Smtp-Source: APXvYqzWf2YA23J1Glf8VxU8Do8ukZPloJr+JQccpQyyqafNEHRr0VlS6DnEGn/nGNBIEFKw6C+etcmhXXLV
X-Received: by 2002:a5d:5485:: with SMTP id h5mr23613735wrv.346.1582018902233;
 Tue, 18 Feb 2020 01:41:42 -0800 (PST)
Date:   Tue, 18 Feb 2020 09:41:36 +0000
Message-Id: <20200218094139.78835-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v5 0/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYM
From:   Quentin Perret <qperret@google.com>
To:     masahiroy@kernel.org, nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, jeyu@kernel.org,
        hch@infradead.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current norm on Android and many other systems is for vendors to
introduce significant changes to their downstream kernels, and to
contribute very little (if any) code back upstream. The Generic Kernel
Image (GKI) project in Android attempts to improve the status-quo by
having a unique kernel for all android devices of the same architecture,
regardless of the SoC vendor. The key idea is to make all interested
parties agree on a common solution, and contribute their code upstream
to make it available to use by the wider community.

The kernel-to-drivers ABI on Android devices varies significantly from
one vendor kernel to another today because of changes to exported
symbols, dependencies on vendor symbols, and surely other things. The
first step for GKI is to try and put some order into this by agreeing on
one version of the ABI that works for everybody.

For practical reasons, we need to reduce the ABI surface to a subset of
the exported symbols, simply to make the problem realistically solvable,
but there is currently no upstream support for this use-case.

As such, this series attempts to improve the situation by enabling users
to specify a symbol 'whitelist' at compile time. Any symbol specified in
this whitelist will be kept exported when CONFIG_TRIM_UNUSED_KSYMS is
set, even if it has no in-tree user. The whitelist is defined as a
simple text file, listing symbols, one per line.

v5:
 - made sure to be POSIX-compliant (+ tested with dash and posh)
 - added failure path if the whitelist path is incorrect (Matthias,
   Nicolas)
 - collected Acked-By (and other) tags from Nicolas and Matthias

v4:
 - removed [[]] bash-specific pattern from the scripts (Nicolas)
 - use $CONFIG_SHELL consistently in all patches (Masahiro)
 - added shortlog for initial generation of autoksyms.h (Masahiro)
 - added comment on how 'eval' expands the whitelist path (Masahiro)

v3:
 - added a cover letter to explain why this is in fact an attempt to
   help upstream in the long term (Christoph)
 - made path relative to the kernel source tree (Matthias)
 - made the Kconfig help text less confusing (Jessica)
 - added patch 02 and 03 to optimize build time when a whitelist is
   provided

v2:
 - make sure to quote the whitelist path properly (Nicolas)

Quentin Perret (3):
  kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
  kbuild: split adjust_autoksyms.sh in two parts
  kbuild: generate autoksyms.h early

 Makefile                    |  7 +++--
 init/Kconfig                | 13 ++++++++++
 scripts/adjust_autoksyms.sh | 24 +++--------------
 scripts/gen_autoksyms.sh    | 52 +++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 22 deletions(-)
 create mode 100755 scripts/gen_autoksyms.sh

-- 
2.25.0.265.gbab2e86ba0-goog

