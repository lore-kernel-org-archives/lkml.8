Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3CB206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaUinhNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGGLpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgGGLpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42AC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:45:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m125so7832008yba.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LLQSBg64iwWxTtcpWWM6iR9wTgF8QbEH02Vy+2bg9Hg=;
        b=vaUinhNZkQN3RAVXNuIvu2m9UALKLZu6+nRg7EiTfijttvY5uvU/HlfVTs6MFI3BjD
         Er2jhbF7pByOmGUAkA0Rwjx6r1yRJYYD9O+cl25wvja83NKdtmmp1zngnkV02lhR5H60
         b5PjacpY1TP2NcUr9fiYcugKPCAjjR9rmlEhUHB0wiSX4QdOcSpvSGrvsQV0rT/nifCK
         2ZKi0Cmb2t3TuutVgBjI50QCH9omrBcU2W/h5TS/pS3DnoIpdnsJzSM7wmedPsCcY2wS
         ytB1vf691KXilc3nIafaO0kmcuwa8X3LA+tSoYg6SrxvtuS6RBnGMpkCLIhuojqhRuKM
         4b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LLQSBg64iwWxTtcpWWM6iR9wTgF8QbEH02Vy+2bg9Hg=;
        b=rL0r/RX6T5o0UqBnA5A4tVLpmvY4vOTJa+zDLsfXFqUz9U/IUk7fvMrLP+6hRjjusq
         g0vbHRRZqI13xh0rxFSmFjG/T68lQNT/1pOeSHjA4nu5JPuPqi/LnsoZvRwsI9iFBtzZ
         sNpc/HJCko9vdZB184OkfjjmFYx1Fg4AvLc81Zn91Eobz4Klh0FVi4N9hIPxDhk6XG/d
         BLnyczBk6MYyNJvAKgq5pFSMtbbxr4L9Nkes0O7QOidUO0cxRKif3WSSQNezpUk/gXCl
         yrqax1ntTUUrNad6keHlIQwZHAJnRCExhULwjBufs7CFNnp/Lq/J58eyoIYWn/bhJXFb
         W5Qw==
X-Gm-Message-State: AOAM5332jLBkK+qW1MyHGTNHAqSEHTd/re0n9hDcmB4g8UiZ3VDIF+Jk
        Iy7agiho5bnF22V9tpBLA3LWtO8u/sg=
X-Google-Smtp-Source: ABdhPJwLxIHBchd80Gve4mlw6g7Mb8civMvZG5ZcJoCOlzyO/mCAmx2JmX2IzIWBOuqsBIRGM+219TLjngU=
X-Received: by 2002:a25:b903:: with SMTP id x3mr32504935ybj.445.1594122311275;
 Tue, 07 Jul 2020 04:45:11 -0700 (PDT)
Date:   Tue,  7 Jul 2020 04:31:19 -0700
Message-Id: <20200707113123.3429337-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v10 0/4] Prepare for upcoming Casefolding/Encryption patches
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This lays the ground work for enabling casefolding and encryption at the
same time for ext4 and f2fs. A future set of patches will enable that
functionality.

These unify the highly similar dentry_operations that ext4 and f2fs both
use for casefolding. In addition, they improve d_hash by not requiring a
new string allocation, and ensure we don't attempt to casefold the no-key
token of an encrypted filename.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           | 64 +--------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++-----
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 83 ++++-------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 96 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 +++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 +++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 174 insertions(+), 184 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

