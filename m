Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA64C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E814B20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y91L1uXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGSIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:08:01 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:46763 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:08:00 -0500
Received: by mail-vs1-f73.google.com with SMTP id x71so17650vsx.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mSGi1BVNlmditJM4fRm+rDENjQW+HhkSF8B3glFVnpg=;
        b=Y91L1uXTf2awXQO+uBVdXHZU8HCUNdIQsjzQiuvYNcqr/Qg08ny8VJf+mhsL5QlXQO
         8try15JSIXJiOSsR7EFMxnWN9X+orC1q09te8w78JzpzdLmfu53irZiF03QwEcfSvvBb
         UObLSjrTYF1feRZ89t4RTW2Vqfdgfw91TsWlrZglEmUrYDL+dAUz5TZCypq84K+WbjaL
         enMmP8OUSN3JKM96OObunWgzoESB1J6/x5MlBOR1NPZnsLA9NHrGhkg/34+0C14mGslt
         H6NQdWosuVmvxS35YeCmHk3dg+ezw7h52YNHk4nrHimsUKABwI4o1gR4H/m7NiyvsCvV
         qRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mSGi1BVNlmditJM4fRm+rDENjQW+HhkSF8B3glFVnpg=;
        b=XcQbvzwITuo0iQezE0RE4hAxgSg9dU4oyfIrXMSROmNmi/ZTJr2W//655i64PkX3GJ
         D56CCTIYxicMOMUqi95oDOifWYBwKrQLww0rKQX1G29PoNPPPIRXWQ5ROzP1EukMqPtd
         XNQktRJuyOwkrzGkJmbjAxv6CYOup0RnYPrdSCNkxwAn8NERmh4OcoBEK/JQRm7oaB4m
         4ub23NjFSvlZppQHnROO2EZDbBbcYCMUTt9dbDqrp0Ng2dufV5/hfd+iRskwoafmg5N9
         azk84RPns9gdCUE+9OwQdMewyL5RFEfuiphZe4nv/IS3PYVZIoi5vmOIDr5ylrDiCPYv
         KfUQ==
X-Gm-Message-State: APjAAAW9/7/+IbIP0cBaQVMdlFe4bdLXoSqR8rYGwOUODfOluVqkJKPx
        iUedAG22wSHBYVO97pQoyRr8fP1nK3ba
X-Google-Smtp-Source: APXvYqziKEBW3W5mmaFfdbidi6/kSXkrtep5KXxVSIyrpuAILMZF8PBOLP6pqbApOFLsps39N7pkfSEcWx4a
X-Received: by 2002:a1f:2753:: with SMTP id n80mr265425vkn.24.1581098878430;
 Fri, 07 Feb 2020 10:07:58 -0800 (PST)
Date:   Fri,  7 Feb 2020 18:07:52 +0000
Message-Id: <20200207180755.100561-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 0/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYM
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

v2 -> v3:
 - added a cover letter to explain why this is in fact an attempt to
   help usptream in the long term (Christoph)
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

 Makefile                    |  2 +-
 init/Kconfig                | 13 +++++++++++
 scripts/adjust_autoksyms.sh | 27 ++++------------------
 scripts/gen_autoksyms.sh    | 45 +++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 24 deletions(-)
 create mode 100755 scripts/gen_autoksyms.sh

-- 
2.25.0.341.g760bfbb309-goog

