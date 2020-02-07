Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6ACC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A270121927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pNDfYKDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:34:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39396 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:34:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so3229036wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ubc3i5ioC2Mng+1ZCGgqSjrhQMsUN/k5l/kXQrpKbbE=;
        b=pNDfYKDmis0ZIoYPys46LJ3eBdCjoVxn/3v2EnQ5eEWQihKfa+ZrD8+lDIJelNtsNE
         zCo0dqacfo1f14irXeNginpPFf3515oPjUrcUERQz+lgH3XM4gqZDueiPG9dYdxnmXNM
         7EvdJylctaaygZHqEZLPF2Fo0khFqQ9PxyZfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ubc3i5ioC2Mng+1ZCGgqSjrhQMsUN/k5l/kXQrpKbbE=;
        b=fBm6yrev08SjCbQwMIRBsvyDdEs97Ph0XMdNsTw5fxg0cQ8WhkTCDBXYdqF9EmxMNs
         zjUq+GvIGUq/QKCHHBuSrsCNhcrVzjrioOfLE54yicHqNrcI9bkGcxbh7P5nLqDpqUtl
         EEprrL2FwXqsEqNmSq+JIGgLtScJm7SiQG0VfZZiIUE9WcdosYY8uEx0LxGHxcbbeiXx
         rQwd/WZidWptHQK6mFdUA4W2maA10jTtltSGxGrb6vgS7DNxmgx7BoKt+xPNSYpDRP9O
         GnGOnaEKbjUzEbgzVnxmqnBccaUnJ+v8bC+4kSV+v8wu/JEbjFcl34yI2tea1n7uNu9G
         pn7g==
X-Gm-Message-State: APjAAAUe/g9ZQMdkiBl6F4f2W8zzmEGR8hPTLP+RNG7+wR+GrIscGCkb
        TD7RIdgtRrnOyJkAkTZPjOe8nNALl0E=
X-Google-Smtp-Source: APXvYqy/NpI+jwi7ubi9A744y5HRTbyCjOoLff8EQAzbvpxGaSxGkf5a/khVgfzxuK6X4nsXyrH/yw==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr4922099wme.161.1581089644697;
        Fri, 07 Feb 2020 07:34:04 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id i16sm3983836wmb.36.2020.02.07.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:34:04 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:34:01 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.6-rc1
Message-ID: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc1

- Fix a regression introduced in v5.1 that triggers WARNINGs for some fuse
filesystems.

- Fix an xfstest failure.

- Allow overlayfs to be used on top of fuse/virtiofs.

- Code and documentation cleanups.

Thanks,
Miklos

----------------------------------------------------------------
Daniel W. S. Almeida (1):
      Documentation: filesystems: convert fuse to RST

Miklos Szeredi (2):
      fix up iter on short count in fuse_direct_io()
      fuse: don't overflow LLONG_MAX with end offset

Vivek Goyal (1):
      fuse: Support RENAME_WHITEOUT flag

zhengbin (1):
      fuse: use true,false for bool variable

---
 Documentation/filesystems/{fuse.txt => fuse.rst} | 163 ++++++++++-------------
 Documentation/filesystems/index.rst              |   1 +
 MAINTAINERS                                      |   2 +-
 fs/fuse/cuse.c                                   |   4 +-
 fs/fuse/dir.c                                    |   2 +-
 fs/fuse/file.c                                   |  21 ++-
 fs/fuse/inode.c                                  |  14 +-
 fs/fuse/readdir.c                                |   2 +-
 8 files changed, 104 insertions(+), 105 deletions(-)
 rename Documentation/filesystems/{fuse.txt => fuse.rst} (80%)
