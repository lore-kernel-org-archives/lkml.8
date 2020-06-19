Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602ED20773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNNQPXzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgFSCmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbgFSCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:42:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D611C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:42:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so3739240pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9e80yMHZbPkPTyU+sZPbiOukpOCOqIvKBeY3mrA0Y5A=;
        b=HNNQPXzqGVe/GMkz7DjfenyPubxRILX0j2RLdtVwD8GF7OTpLR5Pwc5RdoLwKmUsRk
         6iUU0KeYStS6h1lC7UGeQb9zcbCOBigomrxHYLLGNjnQ0QJr0Kplo58XqBacdAwt+u4R
         VCSKGWyVvmsnmjdG6bLHsADjECECpyCP/+mww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9e80yMHZbPkPTyU+sZPbiOukpOCOqIvKBeY3mrA0Y5A=;
        b=coh8gWMBhoHXiQz38XWi9ATFvqIWyZQJy8n5N8Iol1f/VCuusBdsgUgFGLkJ7cd7gl
         qhZpe3gDzLQlJQXCjwWDjiwo+uS3R6yrjXwITaws5BcE0gdTblXnOBYRRk2NjpGbKiWo
         XcpDbar+QJOf/wOhhZkE4j4+knHe3dGWu4525ZrXtlPZ+C4wW3c0PkOyWJj8AYcpUH5q
         UnjIN8lG7IvgnRRvBv8gbnhoyG2/Bz94m5lXLft9YSQIFVjBAWj0gZSXzvEVBYJ+/bnv
         UKSCYZ6DrOg1nLtou1lL5RlfqpVMtVemR7DmryBXKtQAGl52wJ9RVBvxSP8A9ZFKZzKS
         fPeQ==
X-Gm-Message-State: AOAM533ymtHVxHevsujP5ugazjvvicqxeRYf75wLnMie/uKbZdFwZWR9
        ADr+aMhxlz1QX0JQ2kWgixyyeg==
X-Google-Smtp-Source: ABdhPJybrrj0a9EBMYt0EbHe0jA6QfVUNY2GxJXQaUaLQWJmUfQYGIhzEObjIJu/CMKpY1Png1WPMQ==
X-Received: by 2002:a63:e455:: with SMTP id i21mr1290469pgk.23.1592534535152;
        Thu, 18 Jun 2020 19:42:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm3598944pjr.39.2020.06.18.19.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 19:42:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 19:42:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] overflow helper addition for v5.8-rc2
Message-ID: <202006181937.CA6017A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny overflow helper addition for v5.8-rc2. During the
treewide clean-ups of zero-length "flexible arrays", the struct_size()
helper was heavily used, but it was noticed that many times it would
have been nice to have an additional helper to get the size of just the
flexible array itself. This need appears to be even more common when
cleaning up the 1-byte array "flexible arrays", so Gustavo implemented
it. I'd love to get this landed before -rc2 so it can be used during
the v5.9 dev cycle to ease the 1-byte array cleanups.

Thanks!

-Kees

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.8-rc2

for you to fetch changes up to b19d57d0f3cc6f1022edf94daf1d70506a09e3c2:

  overflow.h: Add flex_array_size() helper (2020-06-16 20:45:08 -0700)

----------------------------------------------------------------
Add flex-array size helper

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      overflow.h: Add flex_array_size() helper

 include/linux/overflow.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

-- 
Kees Cook
