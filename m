Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A6CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C77F20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXa+7rKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFMP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFMP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:57:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E2C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:57:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b8so11768349oic.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaWAY6waJBn9LCCXSXRy1YARsCRQFAo45EO1oPJJSSI=;
        b=MXa+7rKf4aQosvvNNCgLYi967vwh+c6ho5hqzt981oOeSAu00xqrThGE/XtoDoLM1T
         RMhhF+Rt46m6XWvgL1B//iOnWEjGtWykvfKGBOiZ1k3PQsioyVdRQuwA+tcaLGH40Cml
         vcmPlHaTISuVBhkL3Ld3SDMyMyO+CzLHiXaUSSkXly34aoejzxk9DMW+mM9trV+P9tmU
         mdylOa0a/8Zny88uT1vvfKYsxBYehrGGIAYEzIJo0oFsTwMa9p2ZJJLMYBEDh9DVLrnu
         9DD/u9oix1zYx26lPm2f27ONe66kEubIRDEgSZEIlnO7akU8aIzW3+ZMb0wTv5+fZ8PK
         DVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaWAY6waJBn9LCCXSXRy1YARsCRQFAo45EO1oPJJSSI=;
        b=FIa5PePmDX3ONWQFzRJ4UaGaxnbHsISpRxMI8MUag0gvZ2NaWAwsdaa62T24s47S/w
         eRyV45ZIkktDs2skrwCKgYDKyGx7sbqTm7WQwwCYh7T3XJM40tLlmaI70D1T05MGbKRj
         L99PWSqZXfux9iBTwOeZ5ItPkHtflUm+qtMvcheovh3V9aOFTMi5F9PoGbet14aoUiZp
         xbyhDNKXBcLXzg6+BVviFDxLBn2fUnLFxd7UidgNG15pHexA0se1IgJahbZdZRT+xqAI
         5lROCj4VMiKDTz+DTXZR6SH40w307sjoJhcyrI5uk3T2G/Ay+xp5bAWAInKyTaOu2mx8
         d2bg==
X-Gm-Message-State: AOAM530FBEccpuPMQuENXi+7AV1Wuci+7CJDdAbvcNORLT10qwku2BYc
        bb8gsEiY1WqBf6KxpFxSn5E=
X-Google-Smtp-Source: ABdhPJxcCKJ97DFI1Apcf3quOxurW69c4tmCErGM1Xb06jTbJYDgYx6M9kGCNSPxgWuiL9L+hHZ9KA==
X-Received: by 2002:aca:57d7:: with SMTP id l206mr3085782oib.84.1592063873684;
        Sat, 13 Jun 2020 08:57:53 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:57:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        stanimir.varbanov@linaro.org
Subject: [PATCH v2 00/24] dynamic_debug cleanups, query features, WIP print-classes
Date:   Sat, 13 Jun 2020 09:57:14 -0600
Message-Id: <20200613155738.2249399-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset starts with 9 "cleanups";
 - change section name from vague "__verbose" to "__dyndbg"
 - cleaner docs, drop obsolete comment & useless debug prints,
   refine verbosity, fix a BUG_ON, ram reporting miscounts.

It adds a few query parsing conveniences;
accept combined file:line & file:func forms

  file inode.c:100-200		# file & line-range
  file inode.c:start_*		# file & function

Then it expands flags:

Adds 'u' user flag, allowing user to compose an arbitrary set of
callsites by marking them with 'u', without altering current
print-modifying flags.

Adds 'PFMLTU' flags, which negate their lower-case counterparts.

Adds filter-flags, which select callsites for modification based upon
their current flags.  This lets user activate the set of callsites
marked with 'u' in a batch.

  echo 'u+p' > control

By using negating-flags in your filter, you can match on an exact
flagstate; not just required flags, but prohibited ones.

So if youre using dyndbg to track 2 separate problems, you can use
different patterns of [fmltu] flags to keep the 2 sets of pr-debug
activations separate.

By also using negating-flags in your modflags (after the [+-=] op) you
can fully control the new flagstate, or modify any part of it (unlike
if =p is used).

Also, a late addition:
parse args like: file=afile:afunc module:kvm*
I tried to drag this up to cleanups, but has a conflict so I punted.


WIP print-classes (new from previous)

cc: <stanimir.varbanov@linaro.org>

A patchset from Stanimir tried to create mutually exclusive HI, MID,
LO print-classes for his module, which drove some discussion. These
patches implement a working scheme:

The whole macro stack in dynamic_debug.h is adapted to *_cl()
versions, and old names are redefined to use the new *_cl names, with
a default print-class=0.

pr_debug_n(pr_class>0) provides a way to "create" HI MID LO classes,
by just claiming an N>0. print-classes are meant to be module-scoped;
so manual allocation of them in module #defines is practical.

"mflags <print-classes>" the query term is implemented,
crudely but functional.

To partly enforce print-class locality to a module, "module foo" is
required if "mflags flags" is used; but this can be defeated by
"module *".  Its easy to error out if '*' is used in query, but maybe
"module kvm*" should work, as kvm* developers could probably reach
agreement on print-class constants

Use of above is demonstrated in a patch to samples/kobject/kset-example

I hope this WIP doesnt distract from the non-WIP stuff.


Previous submission (in this release cycle)
  https://lkml.org/lkml/2020/6/5/766
changes since:
  WIP print-classes
  rebase over a recent conflict in master
  2 more "cleanups": Docs ~= s/arch_init/early_init/, maybe macro
  else coding style fix. thx JB
  commit message corrections, improvements based on comments

Jim Cromie (24):

cleanups:
  dyndbg-docs: eschew file /full/path query in docs
  dyndbg-docs: initialization is done early, not arch
  dyndbg: drop obsolete comment on ddebug_proc_open
  dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
  dyndbg: rename __verbose section to __dyndbg
  dyndbg: fix overcounting of ram used by dyndbg
  dyndbg: fix a BUG_ON in ddebug_describe_flags
  dyndbg: make ddebug_tables list LIFO for add/remove_module
  dyndbg: add maybe(str,"") macro to reduce code

file:(func|lines)
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'

internal rework
  dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
  dyndbg: combine flags & mask into a struct, use that
  dyndbg: add filter parameter to ddebug_parse_flags
  dyndbg: extend ddebug_parse_flags to accept optional filter-flags
  dyndbg: prefer declarative init in caller, to memset in callee

expose features
  dyndbg: add user-flag, negating-flags, and filtering on flags
  dyndbg: allow negating flag-chars in modflags

recent, not trivially backport
  dyndbg: accept query terms like module:foo and file=bar

WIP
  dyndbg: WIP towards debug-print-class based callsite controls
  dyndbg: adapt header macros to pass print-class
  dyndbg: add print-class as trailing number to control output
  kset-example: add pr_debug()s for easy visibility of its operation
  kset-example: use pr_debug_n to create example print-classes

 .../admin-guide/dynamic-debug-howto.rst       |  79 ++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |  75 ++--
 include/linux/printk.h                        |   5 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 369 +++++++++++-------
 samples/kobject/kset-example.c                |  32 ++
 7 files changed, 374 insertions(+), 194 deletions(-)

-- 
2.26.2

