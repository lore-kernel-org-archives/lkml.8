Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F310246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3q8eocg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1RUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:20:21 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:40395 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:20:20 -0500
Received: by mail-wm1-f74.google.com with SMTP id m4so1435883wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8B+dOG44BYNk71vIo3UTJFu/Q4ng693c64kO3MR/EGU=;
        b=Q3q8eocgpz6FAxvOHxF7G2OrFHAteLdnW9TkL266xzrwe/QeH/B7k9KYsWjfAJHmn9
         gvNlW5YexZWkc4pm63qpcc67IrszxlZ5MYLg5KeIH+4+M819e1tBAKE/A0ziVfD9g8wb
         LVJP8TJLa9A8gMjsufBzgpxvUU8KzJ4M2YzpGMfYkFet6j5NGbn7ydSHsGeVSU4y+DcZ
         RIqg2ifyviPfU/NKjVWjIIAlnaTzgQjrmE/OK9GqjMk7UaIQXIEplbwNNPGCQQA2OxaE
         r+eK1tdlxOz5kYqrlVsHgPGGbKsaGzd5slWo8/kA4OHfs3q1lzf0ryQclMhtnANTcdOp
         CFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8B+dOG44BYNk71vIo3UTJFu/Q4ng693c64kO3MR/EGU=;
        b=hgAWzm4+6ROIsfi8V+180OVdmcJsN7GZsS5nbf1yDikJBWxOIcoofCW8+wzTP9zP8y
         UwNkhbKMBdnp1a4dWTg+MVWJyLEq9EPwxRzUqa1bfxI0/djtr4IED9ZuhxuqTcCYyeJn
         pzcoAjI/KryNHQ6u75fsr+WOOWwi32a4R1Uuov3q1pTqZU+FbvYEdZcNQrTIBb3OaD+A
         6Y7VnzumDBulkXIN2OZ5spShZzoA81hB9/kypCfO158ljbyu6bWWhEg8j9N73AEs+Zb+
         FAdsi0gBiLKNB1qjpQee7y3/6HBXYseLi4AG+A3jLbaSivWV5jKLOHMFSj80zO0ZAwWK
         AhJA==
X-Gm-Message-State: APjAAAVrwjs/pHx/ih9nExhtLxYj800eiubJFIUmXZazxxppy+gCYUy7
        SgZjtJ9kF3NXmdILRsrvWA6bZErROPWB
X-Google-Smtp-Source: APXvYqwRr4EbwxUSXXuLhA9z9xkVJrc4Qn9A/g9wdiii2O5g37rKox2NUcxqGWVaUwJZ1bdwL+vgeY6fF0/W
X-Received: by 2002:a5d:6802:: with SMTP id w2mr5603845wru.353.1582910418209;
 Fri, 28 Feb 2020 09:20:18 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:20:12 +0000
Message-Id: <20200228172015.44369-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v6 0/3] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYM
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

v6:
 - made permission checks on the whitelist file more robust (Masahiro)
 - better style/identation in Makefile (Masahiro)

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
2.25.1.481.gfbce0eb801-goog

