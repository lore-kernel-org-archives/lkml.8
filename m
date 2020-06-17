Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED87C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D3C2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhDzcsvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFQQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:25:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:25:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t6so2081297otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLo4zQzK3jszC3QFkRxVMr8uxDLoUSi67u0ENTXch6Y=;
        b=KhDzcsvGvKakv/MwAN//Gmxq0kXllaY0gEKud/rgq6ooD45yR5LUXfwEa8Dlyw3Ky2
         csIBjGZT298bxWs1g3Wf/FMPq0NmjSjUUofLlczHp50mInUa96NX875iawptmEekqzAx
         w50AT4nhc2nyzNq7d4FO/cSdpRAlzvAuxt4g/8EWfiTmX2WN+zAl6cYbMVp0jOh73PXL
         giGSFWJIFOKKP9ytQ8pYaqnB7G3CfHpBQT0bJIPSFmRl4RpYB58CA+ngi+VKkCqCyLVH
         reQafI2Ce4ykPUY/afKQv1gWsmuTOOclUAvdVdFj5jWOGJ1JMsp5FdBaSWS51BZbyHTX
         nIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLo4zQzK3jszC3QFkRxVMr8uxDLoUSi67u0ENTXch6Y=;
        b=NTTun1dXVokErWy+tnA8k8WfVhh4xYKY0sEmH8XPZQ0cMzfRxMYoT18ylwd+vRXHYu
         veZeVEaqVXmEGzUeFS7OqRxiq8KHs3F/16kDmEYL20DSidHBql44EghBHHQtmYxXWaRY
         uG1vvQovV2Xkry6ooPSybL86cmzd0LOmW00oLlAYMoMzGwSlxLJhH0sMsZGhClWPz0pc
         uigXwW/HtvsJnwN2aWHpVASWsdoZwFSAms7VPx/mjIHJGZW9mZoAUO5OYfhtOXEQpmC7
         akLTmC/I9KVowa0PlwZ+g32OxrGCI1WK6gtKraHVdqpIfDYkrGLnXhwQ0dSXH/2OKSIy
         BBEQ==
X-Gm-Message-State: AOAM533NAjk/aW10JkidHgUIF8IX0DlgL6ish7O34yD5glX+fMUdTjxp
        mNPGS0RNDqymd+YjOKM2WatM2NLJ
X-Google-Smtp-Source: ABdhPJwkej574VKaEEon8TPLOuAYywh47QIlazhdKsoq5SHfJKMQSg8m8E2mLcTg6flN9vwnCVzxqQ==
X-Received: by 2002:a9d:32f7:: with SMTP id u110mr7484562otb.217.1592411153799;
        Wed, 17 Jun 2020 09:25:53 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:25:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 00/21] dynamic_debug cleanups, query features, export
Date:   Wed, 17 Jun 2020 10:25:13 -0600
Message-Id: <20200617162536.611386-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is v3, changes from previous:
 - moved non-controversial commits up front, refactors to help this.
 - a few more minor cleanups
 - left out the WIP patches
 - export ddebug_exec_queries()
 - accept file=foo:func only, not module:foo
 - varname changes
 
v2: https://lore.kernel.org/lkml/20200613155738.2249399-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20200605162645.289174-1-jim.cromie@gmail.com/

Patchset starts with 11 cleanups;
 - change section name from vague "__verbose" to "__dyndbg"
 - cleaner docs, drop obsolete comment & useless debug prints,
   refine verbosity, fix a BUG_ON, ram reporting miscounts. etc..

Next, add a few query parsing conveniences

accept combined file:line & file:func forms

  file inode.c:100-200		# file & line-range
  file inode.c:start_*		# file & function

accept keyword=value, not just "keyword value" (and not keyword:value)

Then export ddebug_exec_queries, to tie to drm.debug, etc.
Since its an export, I expect some discussion...
gpl-only would be fine.

The Flags extension stuff has received mixed reviews.
Ive refactored these commits, partly to move drive-by-cleanups up
front, which also decluttered these controversial patches; I think
theres a cleanup value to the early rework patches, even if
filterflags doesnt make it in.

Ive reworked all the flag-features commit messages to improve
the usefulness argument, hopefully well enough now.

Jim Cromie (21):
-cleanups:
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
-feature file:func
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
-feature, new in v3
  dyndbg: accept query terms like file=bar
-export, new in v3  
  dyndbg: export ddebug_exec_queries
-rework  
  dyndbg: combine flags & mask into a struct, simplify with it
  dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
  dyndbg: add filter channel to the internals
-flags features exposed
  dyndbg: extend ddebug_parse_flags to accept optional leading
    filter-flags
  dyndbg: add user-flag, negating-flags, and filtering on flags
  dyndbg: allow negating flag-chars in modifier flags

 .../admin-guide/dynamic-debug-howto.rst       |  79 +++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   5 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 334 ++++++++++--------
 5 files changed, 260 insertions(+), 166 deletions(-)

-- 
2.26.2

