Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A283C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BA82077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIYaazuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFEQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgFEQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B8C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 25so7766437oiy.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQFydgePOocQu3btyVs/kadHJxlM7zf0jsKl5sc8/Uw=;
        b=BIYaazuOnrhe77bys+7h1TZcEGy4/RV6AqtwKjOULq4WDQyi+BTcvp0rJQ6n2ievEr
         DtC7ooUnjoTDiJc8ogHbzCqVCWaMULJBus72RTTHYTbZMhFtaopcDG6gzbGjc0gyAkKZ
         eE1WU9AMl2kk8N6bVPgMLHqEsubDfg0QMCwoNVjjD0tG5xvQf7d0o8dU8botxv/BCh3Y
         zcPNcvsiIu60CizeOM5CaEUuDADsYbIF30G3VFus6fg1NEUfBxLtzhBSTbHFKreyo/gb
         T0oJg3ks95Rqvt5SXCgiNHDMclWIykdXpTqn2o6xW/v+vDCOB/9rP7/pPCX4wLq8Cizw
         twtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQFydgePOocQu3btyVs/kadHJxlM7zf0jsKl5sc8/Uw=;
        b=rA8iuqn4RlNbW6NDvGjswPV9m2iZcT9rsfGPIYi1NmH2cM/yZBz4NlGyxBy3lUc5Jx
         MxQXgqbBkBnbYwYFFO8WEmGsfhXYKjzlHBOXagkJSOzQwIpCt/6U3c7t0T/4isg3LG2s
         2Uskvhc+lT4CjG5XOwPJVwL6vh0ynQLGa7+IV4X81FiqAWm9cE8QXa03f5MVw5d1dg7G
         2Q5RFQcdyFE6+UrweAMyjRwKDVpk/xbrBappwgDXVCMf12steujrhVDQ5Jc8v81onLZA
         urzV7rc81rI3Am6ibqAuvwK8rHkMc2wP9vEKMBgM8bWGzqLmnezPtl+neq95Ojn3+rrf
         LxIw==
X-Gm-Message-State: AOAM531JsGcpfdzPhFyxnaukVVdakM9xhHrFFMiJnn6W8VeTYGZ4qxDw
        VPUXmflz/q/zQAETVdwQFYs=
X-Google-Smtp-Source: ABdhPJyn3UxZ8n8J6M6rCNDUlKnhz8dpwkHSPU+52oytYgd8b4M+EdjoN+3dByYbLy/QJ/lzwnGCWw==
X-Received: by 2002:aca:3c82:: with SMTP id j124mr2455122oia.62.1591374426634;
        Fri, 05 Jun 2020 09:27:06 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:05 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/16] dynamic_debug: cleanups, 2 features
Date:   Fri,  5 Jun 2020 10:26:29 -0600
Message-Id: <20200605162645.289174-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset starts with 7 "cleanups";
- it changes section name from vague "__verbose" to "__dyndbg"
- cleaner docs, drop obsolete comment & useless debug prints, refine
  verbosity, fix a BUG_ON, ram reporting miscounts.

It adds a few query parsing conveniences;
accept combined file:line & file:func forms

  file inode.c:100-200		# file & line-range
  file inode.c:start_*		# file & function

Then it expands flags:

Adds 'u' user flag, allowing user to compose an arbitrary set of
callsites by marking them with 'u', without altering current
print-modifying flags.

Adds 'PFMLTU' flags, which negate their lower-case counterparts.

Extends flags-spec with filter-flags, which select callsites for
modification based upon their current flags.  This lets user activate
the set of callsites marked with 'u' in a batch.

  echo 'u+p' > control

This was previously submitted before events overtook.
 v1: https://lkml.org/lkml/2019/10/29/989
 v2: https://lkml.org/lkml/2019/11/27/547

Jim Cromie (16):
cleanups:
  dyndbg-docs: eschew file /full/path query in docs
  dyndbg: drop obsolete comment on ddebug_proc_open
  dyndbg: refine debug verbosity
  dyndbg: rename __verbose section to __dyndbg
  dyndbg: fix overcounting of ram used by dyndbg
  dyndbg: fix a BUG_ON in ddebug_describe_flags
  dyndbg: make ddebug_tables list LIFO for add/remove_module
new features:
-parsing conveniences
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
-flags extensions
--internal rework
  dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
  dyndbg: combine flags & mask into a struct, use that
  dyndbg: add filter parameter to ddebug_parse_flags
  dyndbg: extend ddebug_parse_flags to accept optional filter-flags
  dyndbg: prefer declarative init in caller, to memset in callee
--expose the features
  dyndbg: add user-flag, negating-flags, and filtering on flags
  dyndbg: allow negating flag-chars in modflags

 .../admin-guide/dynamic-debug-howto.rst       |  75 +++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   5 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 282 ++++++++++--------
 5 files changed, 225 insertions(+), 145 deletions(-)

-- 
2.26.2

