Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63943C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6D920717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lnFSVtvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGQMbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgGQMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:31:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98635C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:31:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so7525843edz.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7u2iFOgKHqjo41MgY1WBSWOfZtx91cQ+CoxSWh8TEdE=;
        b=lnFSVtvgG8oiTXOJPN6CxHa4rgsbI9h+cfxYx7tEKdxsvMB8ZUv7CwHmxdRRp/enVF
         NxIaAu+c4Ca4NtGj4LHuJu9Hy9uwG5K273O0sTBMGhkFuW5meHu/SefC9QHIRrJxN9tM
         97hiMyOM6lvE7iyMcAnCuJrYC5sP5aIRBYhXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7u2iFOgKHqjo41MgY1WBSWOfZtx91cQ+CoxSWh8TEdE=;
        b=tzrt4RHXjtE4SSgJnZDugk55mtdJnfSy5VEYbztE/4yOI5JHlVLNTPD4ZSOlNJcEGq
         Y/hCU+Dhaw20nwOO5BN7ZAfkkixbJS8IN5+ouY5M6rIEbJheQSsTmcER3ByJGGZOubkD
         SqtRuwblOfx8ff4De6SsSpTc/ltMr/2WXvzNXwd4ailsQRs4up17rS7IGk7tE0xBo9EA
         zLhqfUkX+RKzy5iJ/JeXUTPWfZChsbsP/ktsHNksiwLPCBPkzJ7WzRvRGmzVbYVbnkV7
         swNGWbuT4zWKAJn7EwmreYAAUQyY6zH7U754mUtNSb6ScH5V42nNJnIr78Lo4/t5Ln12
         tyfg==
X-Gm-Message-State: AOAM531IeZAa/SA2dZU3x56h5JPmy47aY7JezGmoQ2m1lJy267/DOJuH
        Jn14Vlr3FsjugIQhj3V4WQjezQ==
X-Google-Smtp-Source: ABdhPJzy8wuJ2wDhV9lC4jRJfSCnndOC5DlIe/EoPH7DxGGWieYtR8G5T2kKe5AniMqOb7E1aeq0Bg==
X-Received: by 2002:a50:bf09:: with SMTP id f9mr8792564edk.249.1594989102115;
        Fri, 17 Jul 2020 05:31:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id o15sm8099417edv.55.2020.07.17.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 05:31:41 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:31:39 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.8-rc6
Message-ID: <20200717123139.GE6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.8-rc6

Fix the following:

 - two regressions in this cycle caused by the conversion of writepage list
   to an rb_tree

 - two regressions in v5.4 cause by the conversion to the new mount API

 - saner behavior of fsconfig(2) for the reconfigure case

 - an ancient issue with FS_IOC_{GET,SET}FLAGS ioctls.


Thanks,
Miklos

----------------------------------------------------------------
Chirantan Ekbote (1):
      fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS

Miklos Szeredi (6):
      fuse: move rb_erase() before tree_insert()
      fuse: fix warning in tree_insert() and clean up writepage insertion
      fuse: use ->reconfigure() instead of ->remount_fs()
      fuse: ignore 'data' argument of mount(..., MS_REMOUNT)
      fuse: reject options on reconfigure via fsconfig(2)
      fuse: clean up condition for writepage sending

Vasily Averin (1):
      fuse: don't ignore errors from fuse_writepages_fill()

---
 fs/fuse/file.c             | 132 ++++++++++++++++++++++++++-------------------
 fs/fuse/inode.c            |  19 +++++--
 fs/namespace.c             |   1 +
 include/linux/fs_context.h |   1 +
 4 files changed, 96 insertions(+), 57 deletions(-)
