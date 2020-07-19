Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B281AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB6D20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8kiT/yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGSXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EBEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so10772396oty.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XTO/McJUYKG7gyOiFCXqfvUpH6Ya5ES9I+U6ko3eXI=;
        b=C8kiT/ypkdyNOcburRnKrONpmu9i3zDB+0Y4bfHqWhDFB22ZBV+0OEKXbUmZSVz45m
         6Ijxl+EQ3zr7/ASH2huxYt8oFcUzr6z5jUoSzS5XHlVQJs8rVcP6WQymJPDh7ne07ASc
         ChyR6cmNqvQBzFXYYYgx9/3/7E1V/0ZmLO44MKT2ULCo0BoA9sDYMw6dQC2L9rpwoJC5
         rYmdSm8Al1GVht/Kp6BTSwnLlatG3W4ynUVaT7TOKqAc1fLTPlKj7K8gga1vXEXXEQCv
         ga7JX8/jB6SjlPIOeTJTZ5Wyxq+zJC5pMVU6QAAB9XpNRTdoNqXLBwEIAKuPC8zwyGYR
         k0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XTO/McJUYKG7gyOiFCXqfvUpH6Ya5ES9I+U6ko3eXI=;
        b=Q05P2o7M8lTEYQVH76wPWmejl8AoG0eXBQD1HoQoABIcd4MOMlokS+ICELqaaP7ysZ
         bL5KuXGl7akq1WVXNc21p2zwP/D72xO3SuZMyQ8tSexyNSc3fAHQ9NhnWGC76hSu5yar
         FwHlX1Syys28/05YusDl4aTQnbgJREfmqvDb4BfyRMGSA660AHJ3v+7cjK/YcrhNc4xX
         ccN/gWwiPs+OB3hH/jNW5sXhmeQTyJlk3U2U7LpFr/uJ7tzYQYjyPGF4FDjADSFGbTh6
         LkKYRFXsVBWF7fzmJl6XUjwpmPrLlYTx5lNucAKUmQCxcUetTXc3q37aQbk88KYqs4rW
         A+2Q==
X-Gm-Message-State: AOAM532YQbE+aOIhOOXwaPgjkkfCLReTc5IlF4jiCv/or7JiQVQKH//K
        ASsZ0co1gs9x0HPwO9qk0Z0g1Qvh/Ck=
X-Google-Smtp-Source: ABdhPJxARE6PNNzSvDJAB+nESyWcwshE+WhsADfsv6rC3xYopuIxydBPyP9wvjRzIWoQe3548r3k8g==
X-Received: by 2002:a9d:4d9a:: with SMTP id u26mr17748542otk.277.1595200265775;
        Sun, 19 Jul 2020 16:11:05 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 00/18] dynamic_debug fixes, cleanups, features, export
Date:   Sun, 19 Jul 2020 17:10:40 -0600
Message-Id: <20200719231058.1586423-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is v5, changes from previous:
 - moved a chunk from patch 13 to 12, per Jason
 - shorten logging prefix to "dyndbg", drop __func__
 - now with more commit-log advocacy
 - shuffle EXPORT_GPL(ddebug_exec_queries) last.
 - v4+ series Acked-by: jbaron@akamai.com

v4: https://lore.kernel.org/lkml/20200620180643.887546-1-jim.cromie@gmail.com/
v3: https://lore.kernel.org/lkml/20200617162536.611386-1-jim.cromie@gmail.com/
v2: https://lore.kernel.org/lkml/20200613155738.2249399-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20200605162645.289174-1-jim.cromie@gmail.com/


Patchset starts with cleanups;
 - change section name from vague "__verbose" to specific "__dyndbg"
 - cleaner docs, drop obsolete comment & useless debug prints,
 - refine verbose/debug logging
 - fix a BUG_ON, ram reporting miscounts. etc..

Then adds query parsing conveniences
 - allow "file inode.c:100-200"		# combined file & line-range
 - allow "file inode.c:start_*"		# file & function
 - accept "module=foo" query form

internal improvement
 - combine flags & mask in a struct, clean 3 func interfaces with it.
 
make precise format queries easier
 - accept "format=^ClassString" anchored query

finally, EXPORT_GPL(ddebug_exec_queries)

This gives module authors complete run-time control over all their
*pr_debug* callsites (when CONFIG_DYNAMIC_DEBUG=y).

Following the drm.debug UI model, drm.debug_chan2 could be wired to a
callback which invokes ddebug_exec_queries to toggle arbitary groups
of pr_debug callsites.

Useful callsite groups would exploit existing message-prefix
classifcation schemes:

  "format=^[IF_TRACE]: +p; format=^[SURFACE]: +p" >control


Jim Cromie (18):
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
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
  dyndbg: accept query terms like file=bar and module=foo
  dyndbg: combine flags & mask into a struct, simplify with it
  dyndbg: allow anchored match on format query term
  dyndbg: shorten our logging prefix, drop __func__
  dyndbg: export ddebug_exec_queries

 .../admin-guide/dynamic-debug-howto.rst       |  29 +-
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   4 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 269 ++++++++++--------
 5 files changed, 173 insertions(+), 137 deletions(-)

-- 
2.26.2

