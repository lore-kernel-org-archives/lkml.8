Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB182C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A012076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="A94S6RHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgDVVZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:25:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E12C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:25:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r7so2682633edo.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mRuIQRX3UeU0blGuPEnScFGYp7NwM8RgwXBeGeDaOVI=;
        b=A94S6RHhP0FD2gZNczyvML/aEqAk/Z6paQl9qmz/cmB0Hdp710uzwwkRCp3vHY9vlX
         TEC1whYyICjn1NEDIOmwEmZG1PBmQenTO+bnRLHfzUToY+MRZpUQ735Iyhw4Z/1Mq+na
         hMNwUgeK/gGYq0eYdZ2D0C5VKgbR6Rmd1J0eGPLndbdrenN/dvkyZ5Bncgj06bX9O/b4
         LiIbyX2fgDz6WwWg/a4xOkLXK2JcdVYh/5nigWxvJAZ7R0AnssIo6MWVYfhYNIpg5DB+
         UpMna9h/UeJTRF/Xk7P1tSyzWZeYI8LNuuQcBJsI0gkyjUegRO38KgF8U7NlCuibZjtr
         8oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mRuIQRX3UeU0blGuPEnScFGYp7NwM8RgwXBeGeDaOVI=;
        b=fxoKE7YOgSUzsFrPbd/ZjMah6/DV8XbcLWdtnSKaOLBgfi5I81rOCYa65brGpfWX3G
         iG/ZL6K+i7kxmIXVSUpVnqjFPZlpkM9trrwJXMdyYbaqg8nbfpNkDEljGttytj2BpwzL
         lCXf5FVTpKshPCBvN6ky1F47DTyaD4rjztzV/wZYbS7ELJAT7JcOaV5t7+VsM5ZZRX6W
         RsPtuWEn5szCJ/qPWYP5nTYRWDiWquqKkv5rOVFLh0b4HZlMYGDiicoKqKLquXWHn9y4
         8mU7YyaeJlk13pzAjII1lFVzQXlwOUISQZ5FyRb2fNkav5DEN3HyukisYku5U0DfTX8s
         Z5oA==
X-Gm-Message-State: AGi0PuYkvxdYAJIJoPltadzZr03JYrWQgiA5oJLpVoC8qZwTz9iaqCL4
        9P9RRNn+rUOgE/IfXKCVeomdHyyp43OF1Q0IKgSh
X-Google-Smtp-Source: APiQypKDbUBEnzDY7XXQBQy9V9Ty73Piah8yLs/mTDj7UdFZP9Jmx8O3fzY7/dgsubMcaJ2oXKarinHY5Iptk1hVcso=
X-Received: by 2002:a05:6402:1b0b:: with SMTP id by11mr460843edb.269.1587590755431;
 Wed, 22 Apr 2020 14:25:55 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Apr 2020 17:25:44 -0400
Message-ID: <CAHC9VhQNo=Z3G-K8KvTGiu0Fzmwv4byFQriNuTsu+vwnx85YXg@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.7 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small audit patch for the next v5.7-rcX release.  You can read the
commit description, but basically it fixes a missing length check on
input from userspace, nothing crazy.

Thanks,
-Paul
--
The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

 Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200422

for you to fetch changes up to 763dafc520add02a1f4639b500c509acc0ea8e5b:

 audit: check the length of userspace generated audit records
   (2020-04-20 17:10:58 -0400)

----------------------------------------------------------------
audit/stable-5.7 PR 20200422

----------------------------------------------------------------
Paul Moore (1):
     audit: check the length of userspace generated audit records

kernel/audit.c | 3 +++
1 file changed, 3 insertions(+)

-- 
paul moore
www.paul-moore.com
