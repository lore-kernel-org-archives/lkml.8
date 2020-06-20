Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D660C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5601223F58
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3qZyWxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgFTSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:07:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42994 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgFTSH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:07:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id t6so9826818otk.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=106X0Poqk7rNJqRZ54Uc7g11zNpMmlc8Bg2KXXYOEE4=;
        b=F3qZyWxpTkVVO+7K0IF8LlX8LNQx8FS/y3k1+QgnAbO0hAfM0DTat0Pn+Q2lPAmbWp
         yTQxy35uK74Odgf/VEM8+D9uJ4oMYRCc0OrXksDOVfM2bGKZLgTzJVF4L7oB86tn7Mmv
         ITm2N3GvRGA6splzYp/3oKA3llIeo2ZZ0iEyd3Ik/ld4FPFNJaKedVaEdCoVVwEzbpr2
         BOBzinpo0rPGt4iZMoZDkNVVVzf9HGx3g/5j9bm17rDdiuNT+W+2W6I9KmQbX7D3VqNC
         MV/rDQv1rORQRXPBw5HboUnbHCwXT0X6I1A0SDgCeoLYUBhO5N+FwbUygfahAhZJN9pD
         t4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=106X0Poqk7rNJqRZ54Uc7g11zNpMmlc8Bg2KXXYOEE4=;
        b=Dlb19iy06wHABCFkL5Ys7R6i8+kaQmo3plQWAtx3PPvqOyKVzwj8wiFswyFbEMgWjk
         /BxlnY/ZzY16fGvat1Up328VnQBe9jqzjcWFokCC+HcFj/7jn3mHN7+Q/FMilw83hGEQ
         hlHcVSvfg1B47XVBvkeDMyuWR3AIjhYNnsp/ByTjPoEJlRacDuBgaGskJfdcTco+Whjo
         aY2PJlYfiwVA34pJs3DOjcIRTxjld06uvb6XdD20jeg+M8Lyjx4IRh/QqnI/NI4HmjIA
         kPUPjKgv8ZneYPLnvMJ/7XACmqR5fNJuzNaj3IaUNs/H2gKK9lUZpXZloCUvFKRMDzct
         Kq6w==
X-Gm-Message-State: AOAM5306EtZN8M9baUX0NCnP++B+dJBWiDrTtE3OSaRynpf3obtFpZMY
        OKHJb8YhUZqybxFvfCvth6I=
X-Google-Smtp-Source: ABdhPJyfrYjnnxu3acPHhhgtYtpRruhD/t5apqSH+bWOF8Z+zDoMtFxGYdC6ip77oBhADV4GfXPhdw==
X-Received: by 2002:a9d:1727:: with SMTP id i39mr7636838ota.367.1592676415839;
        Sat, 20 Jun 2020 11:06:55 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:06:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 00/17] dynamic_debug cleanups, query features, export
Date:   Sat, 20 Jun 2020 12:06:26 -0600
Message-Id: <20200620180643.887546-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is v4, changes from previous:
 - dropped flags extensions, one internal optimization kept
 - export ddebug_exec_queries() - done previously, but warrants attention
 - add ^anchor to format matching
 
v3: https://lore.kernel.org/lkml/20200617162536.611386-1-jim.cromie@gmail.com/
v2: https://lore.kernel.org/lkml/20200613155738.2249399-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20200605162645.289174-1-jim.cromie@gmail.com/


Jim Cromie (17):

Patchset starts with 11 cleanups;
 - change section name from vague "__verbose" to "__dyndbg"
 - cleaner docs, drop obsolete comment & useless debug prints,
   refine verbosity, fix a BUG_ON, ram reporting miscounts. etc..

  dyndbg-docs: eschew file /full/path query in docs
  dyndbg-docs: initialization is done early, not arch
  dyndbg: drop obsolete comment on ddebug_proc_open
  dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
  dyndbg: rename __verbose section to __dyndbg
  dyndbg: fix overcounting of ram used by dyndbg
  dyndbg: fix a BUG_ON in ddebug_describe_flags
  dyndbg: fix pr_err with empty string
  dyndbg: prefer declarative init in caller, to memset in callee
  dyndbg: make ddebug_tables list LIFO for add/remove_module
  dyndbg: use gcc ?: to reduce word count

accept combined file:line & file:func forms
file inode.c:100-200		# file & line-range
file inode.c:start_*		# file & function

  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'

accept keyword=value, not just "keyword value" (and not keyword:value)
  dyndbg: accept query terms like file=bar and module=foo

  dyndbg: export ddebug_exec_queries

This will afford module authors complete run-time control over all the
*pr_debug* callsites theyve coded.  They can attach a callback to
their existing debug interface (drm.debug for example), and map bits,
bytes, or strings to particular queries.

  dyndbg: allow anchored match on format query term

This makes "format=^PCI" work, which is far more specific than just
"format=PCI".  It is ideal for the most common convention in logging;
a string prefix which classifies the log-entry in some way.

  dyndbg: combine flags & mask into a struct, simplify with it
  1 less parameter on the stack.


 .../admin-guide/dynamic-debug-howto.rst       |  29 +-
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   4 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 263 ++++++++++--------
 5 files changed, 169 insertions(+), 135 deletions(-)

-- 
2.26.2

