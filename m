Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A5206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JHKB/nnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHDBAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:00:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 18:00:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so14771648ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E4dcwzNRyCIA11x+yOeXcsKOAHsD/aVIQfoPgyAAnjc=;
        b=JHKB/nnJ9CEEc182fFSPwQcyeo+JnZj0hlLQt2pwrGVBCFfW8N3/FazjPGunjixgNc
         yVBTsWoXXuMsqRrGhvMbfWTgkCQmfhCzGR694Bq3/zHD+1Z/NivMEGr6LJk4NXOOrDRY
         z+3qg/Kh1OFCRC3fni7iaoY/cos5dF8wlPqlLHDP9j4Ep8w0GQetsL12EauiaqgPssBY
         d7e5SH67S2QCvNS1iBrylbp8t/8Rdes55PzZcCHipmi0Gqr88Os5tnDKIG375MQ2oPll
         /0hnYMnjjkMqw7QpNCM6nX8aATvwiKCDsOihLJ3qoy8CpW/gdQhvfg2DaJtOBWhOab+R
         0dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E4dcwzNRyCIA11x+yOeXcsKOAHsD/aVIQfoPgyAAnjc=;
        b=n7eLUfdFKRVQFSK6YXsGfBrvkKfkRUYrX/TN3Q+rl5ICmizIyF2mPx9RCstcF1Drr5
         FK7b+iBwJnduL3c3kD4BJ00fDmz5717I1HiCJQ6u1jYeGhoEgtvsR7o2ZEsX+TU6rovA
         PFA3W2/FDLZGh8LyiOx0g+jZMJnT+ACetUr6LQ3YKqsiqtFbSQv5wAookUA0X2a3QD0Q
         qrYg+gDEdSQNv7JfXmn/QOZc0uiY0FrQdG7OXFsmmjdMJA9blSUkX9LPRSYRkn8FJZ/2
         ODCWyh48b/pnuRZGB0sUyafJArO4QIwr08N373WeYwNWuitLweTDqb+H11hWFWf8thKK
         8SRw==
X-Gm-Message-State: AOAM532OYfSoBwHSh/tIuxg3455OwejUA7fa/z50GRs5EkaIukzsrMy7
        bGP7teLBNee2ebYTXL5fLZrXmjpHQHiipwE6epVnVoupOF1c
X-Google-Smtp-Source: ABdhPJwa7qnKT8GjvxOcF1UrQ0uPfcMxR8CzMiDD9D+EzWQ73UyIICWivG4UHiut7B3X/G9k+JTx6exuNc4IcRGqF+U=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr18091864eje.431.1596502812036;
 Mon, 03 Aug 2020 18:00:12 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Aug 2020 21:00:01 -0400
Message-ID: <CAHC9VhRP3yN4dvrEe5_iAgVDnLNeedLOLXeb_zaE9OmBW_qSQw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the audit patches for the v5.9 merge window.  All of the
patches in this pull request pass our test suite and merged cleanly
with your tree from a few hours ago.

Aside from some smaller bug fixes, here are the highlights:

- Add a new backlog wait metric to the audit status message, this is
intended to help admins determine how long processes have been waiting
for the audit backlog queue to clear

- Generate audit records for nftables configuration changes

- Generate CWD audit records for for the relevant LSM audit records

Please merge for v5.9, thanks,
-Paul

--
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

 Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200803

for you to fetch changes up to b43870c74f3fdf0cd06bf5f1b7a5ed70a2cd4ed2:

 audit: report audit wait metric in audit status reply
   (2020-07-21 11:21:44 -0400)

----------------------------------------------------------------
audit/stable-5.9 PR 20200803

----------------------------------------------------------------
Gustavo A. R. Silva (1):
     audit: Use struct_size() helper in alloc_chunk

Max Englander (1):
     audit: report audit wait metric in audit status reply

Paul Moore (1):
     audit: use the proper gfp flags in the audit_log_nfcfg() calls

Richard Guy Briggs (5):
     audit: log nftables configuration change events
     audit: add gfp parameter to audit_log_nfcfg
     audit: remove unused !CONFIG_AUDITSYSCALL __audit_inode* stubs
     audit: issue CWD record to accompany LSM_AUDIT_DATA_* records
     audit: purge audit_log_string from the intra-kernel audit API

include/linux/audit.h           |  46 +++++++++++------
include/uapi/linux/audit.h      |  18 ++++---
kernel/audit.c                  |  39 +++++++++-----
kernel/audit_tree.c             |   4 +-
kernel/auditsc.c                |  45 +++++++++++++---
net/bridge/netfilter/ebtables.c |   6 +--
net/netfilter/nf_tables_api.c   | 112 ++++++++++++++++++++++++++++++++++++
net/netfilter/x_tables.c        |   5 +-
security/apparmor/audit.c       |  10 ++--
security/apparmor/file.c        |  25 +++------
security/apparmor/ipc.c         |  46 ++++++++---------
security/apparmor/net.c         |  14 ++---
security/lsm_audit.c            |   9 +++-
13 files changed, 273 insertions(+), 106 deletions(-)

-- 
paul moore
www.paul-moore.com
