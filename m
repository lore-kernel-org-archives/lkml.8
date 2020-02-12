Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8C5C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F123321734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzczW4Ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBLUVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:21:45 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:38722 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:21:45 -0500
Received: by mail-wr1-f73.google.com with SMTP id p8so1301118wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LMPJhMzPfaYAiOg4KXDrtaLoPSxo0Q5MCJWGzcuAkns=;
        b=tzczW4OxIUhqBMrvE/nen0aHH88YpFYcx4mkz4K+J00oXDgZWpYIlehNq1KXrUcdXE
         ZjvvpNlWXIUVWlYmeH+pG1Nbz5z7xBsykvNEmAUoqsBPnLfp9VDoNmWqxau0HD10IWoE
         /j3V016+VVB7P47+/dbVQ9jI1pOLE1z8Z8ohZ4mhu+QTRgprf9J1kjsrPE7lQyvr146n
         zpYzgp4KP2I5d2/k5uX9LdBPslPkdXbaWF1D5B60FfK3shdxfPJ6pT7PXkqXN6OeHEKH
         Wv9HLNEDRcXCmPCGxkd10VhDFLy50/h5adTdKbShuEHQkOiwgM7oyZNcwVvu5X/SoJZe
         oZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LMPJhMzPfaYAiOg4KXDrtaLoPSxo0Q5MCJWGzcuAkns=;
        b=Zc2zBPvPjjeZESkm0OkuMTvxoF8I5D8Yi2EvvywmTFNjhkoZVxBK+8WPEraEaj7Tnf
         VX1WB8rgI4HSwdEG1ASZTgBDXg2ljdLscrljRjjHVDuq9KElaYMrTpkT73H/mH3fSBf2
         cmT7QGvx3/LaMs4+R0y7PAS3ClPSrHYbIUwXL5Yan/jX9IWap5UA7k4849gDVR1eB1HW
         InEjsvlyL5RB8eOTg3rt5krybHJtLZwvK4volJ9QYRXpYnPER7H7c1lqa5+Z0pxRbcTZ
         oLiSeU7TzXO/uZQkaherFnTMPa+mkytU64Lawc+e++WE8zGRNVBv96B/4x7yth3jzTaJ
         7GSQ==
X-Gm-Message-State: APjAAAU13QB/p/KtdM638lU6hm7Wjw5QC8Z6oEsyiBqiDSiq1JYrW/3t
        fS1k9yq8HWN6RMaofwVqN3DuU5JKEBrI
X-Google-Smtp-Source: APXvYqy1AvDaWXYpUYfPuOgo7uvLIzY5UNgMyOPVQkKU4eiIhkbt+TrZSsYZIeLBvPq5LBAF9kA7rVCCYF8O
X-Received: by 2002:adf:f80c:: with SMTP id s12mr16957213wrp.1.1581538903144;
 Wed, 12 Feb 2020 12:21:43 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:21:37 +0000
Message-Id: <20200212202140.138092-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v4 0/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYM
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

 Makefile                    |  7 ++++--
 init/Kconfig                | 13 +++++++++++
 scripts/adjust_autoksyms.sh | 24 ++++----------------
 scripts/gen_autoksyms.sh    | 45 +++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 22 deletions(-)
 create mode 100755 scripts/gen_autoksyms.sh

-- 
2.25.0.225.g125e21ebc7-goog

