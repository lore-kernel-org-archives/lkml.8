Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1AAC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F69206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1orOIIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDUWIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:08:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BFC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:08:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m6so2225187pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z6N5f375dBY4m1uR/wnSffrE9XS+PFN1smQ7QptKqmc=;
        b=h1orOIITl5820h9nt4zgLB2FHV3yOywfDBJxoXrw9p++spe4NWmKH3qSazmoSdOgc8
         biaY6wzN2T3DKAABm9if2CsPPZw6VsyRfqZYIznoGeDFVsN7AorNwHqPnqEER6qd+JgF
         jGpZKJ/uOPPkIW+uL5MLODsZuOeQ4pX9tFzJPrAFGx4PV3MxFZ7iXXDZx3ojjbMkwk+x
         iaQwPvnD28m7/V8GhxZccj9Q5S6Aj8TGI1yFF4wP36wFrEtuJqnwRz0fMl2X2FFkyVgc
         EhkFMFKJVBX3lCE0CU5DXEtA9smZHJ7VCnLAJTFscLMhNQzX5BaQr6R6G1Bo/hLIB7fl
         c6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z6N5f375dBY4m1uR/wnSffrE9XS+PFN1smQ7QptKqmc=;
        b=FflRYAFVg9aJ1IUwel0GxNsIFMqEr0hPuR4uGNnRwxCIq/XUkYfQ8MxRVVUvCLM1im
         p2hZO/XRC4ceg6HMFkWxWuRynUVGAPZJSvWbRHVJv3cYtAivlQg3Lzz/o/fIY5sXgaFO
         SNTKt+lvGjuKIMbVaQu3yLAGI148fz8bmoemAoQp29XejNnenu6RwUEXuOWuj4l6Pbx8
         Gb6W9QO+pGLpXdf5z71tgPuUhlBY3lmlfMlMoTbQ/qkqkRxy2mS8pW6zYHRrjxGxswdG
         WsX3w5Kjfwe1RS27dWRbzU63vkRP7QZ+U2mqpYbrBSPlFbcFfvt0IMr8pj8C2xImHul3
         r9Tw==
X-Gm-Message-State: AGi0PubwOM4yQiiZQZABiNd1jaay6Wgzi01jM0bOA9XR6fZtNI/1R/L9
        Kg+VW8eAUv2H2roW3Rova/pYX3xkUgxUfxcpUyg=
X-Google-Smtp-Source: APiQypLECdVwiMtRNfCaImuEBnCQFCCf1YPNnMKc8Q18Gk28+q0JRehoI5eCC6VVDYIfHQ+W39qN23uWmh+2FSChlsg=
X-Received: by 2002:a17:90a:3a81:: with SMTP id b1mr7941333pjc.184.1587506932209;
 Tue, 21 Apr 2020 15:08:52 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:08:41 -0700
In-Reply-To: <20200421180724.245410-1-samitolvanen@google.com>
Message-Id: <20200421220843.188260-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2 0/2] objtool: add support for >64k sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes objtool for binaries with >64k sections, and
includes optimizations to reduce the runtime for a binary with
~130k sections from >15 minutes to ~4 seconds.

Changes in v2:
 - Dropped the insn_hash optimization as Peter has a nearly
   similar change queued already.
 - Instead of storing the last instruction for each section,
   use find_insn to locate it.


Sami Tolvanen (2):
  objtool: use gelf_getsymshndx to handle >64k sections
  objtool: optimize add_dead_ends for split sections

 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 tools/objtool/elf.c   | 24 +++++++++++++++++-------
 2 files changed, 34 insertions(+), 26 deletions(-)


base-commit: 18bf34080c4c3beb6699181986cc97dd712498fe
-- 
2.26.1.301.g55bc3eb7cb9-goog

