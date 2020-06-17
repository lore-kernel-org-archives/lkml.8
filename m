Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B7021789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIe2Vswy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFQTx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgFQTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:53:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A31C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so1812924pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HspOBWQFNVTqHKcQjJ7DMFYjwVDK4nykbOjxs8oECug=;
        b=iIe2Vswy0TY+sRYv+pLytwjoHEIfNisAagX0KZ0vRZecyk0Pd9/p0rl68+ExjofQ3J
         VHCh76x8fe+irdOQXTRgFjqJ47+41aIgdVqDJBkghAl1xDUzcd9AO/I9Mwv71GdOvnKC
         ROQqZdM2cbUEhVUyNQZ8WzcQO1FaU2yp/4hWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HspOBWQFNVTqHKcQjJ7DMFYjwVDK4nykbOjxs8oECug=;
        b=qj2ET1ZiRSrJL3kdf+yVMmyUyIYWpFHah+mcsFASSUOpFxibm9qXud382DwPr8LNXg
         wVjDYs9PyBla7i2naJe33SsyYcunt1+geo+jhLPvaoGtK2/6eys4iuy7u7+BJvVXbdu/
         bzhiTwvNXna46n+whyHnJ/sSiJBNUiPwECTVXTa1OXgbvdJhHqyI7ngvVPe1oOMG9ndJ
         lTbQX5F3OX/uJe8zVaYkNZplrTOaYCMLkjEUMM3VvLfvMS3IiHn9LFALW2Sb2vKdjk7b
         Jgew1U9yP2IrmXr8iD2GRd1AiDE/fwM24RzNBlzDbL2Ggv0+5ArfH+zoDpt8wCa5JuCZ
         1ahw==
X-Gm-Message-State: AOAM532tjpMkL7WXlEaAEsyL8LKh6UL8CRGsv0Dt/S98yxy9n3k6LVua
        kKfXgXT8oYlji5iQbOsICLqbvA==
X-Google-Smtp-Source: ABdhPJzU2MrCywm/yIqXZrWJqCrHeLxWKzoBvu0raHnNG08mgZ92LJXSezd98/LJ4Rz5kge/t19oGQ==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr393204pgl.101.1592423635779;
        Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm625330pfq.121.2020.06.17.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:53:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB and SLOB
Date:   Wed, 17 Jun 2020 12:53:47 -0700
Message-Id: <20200617195349.3471794-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In reviewing Vlastimil Babka's latest slub debug series, I realized[1]
that several checks under CONFIG_SLAB_FREELIST_HARDENED weren't being
applied to SLAB (or SLOB). Fix this by expanding the Kconfig coverage and
moving the cache_from_obj() check back into the common code. Additionally
adds a simple double-free test for SLAB.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/202006171039.FBDF2D7F4A@keescook/

Kees Cook (2):
  mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB and SLOB
  slab: Add naive detection of double free

 init/Kconfig |  8 ++++----
 mm/slab.c    | 22 ++++++++++++----------
 mm/slab.h    | 31 +++++++++++++++++++++++++++++++
 mm/slub.c    | 25 +------------------------
 4 files changed, 48 insertions(+), 38 deletions(-)

-- 
2.25.1

