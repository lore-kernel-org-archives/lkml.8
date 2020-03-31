Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151B920787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmGBVg1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgCaUrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:47:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgCaUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so27805550wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8k+54bJLm5Dimlr1t4QPDlPtUOMnAoAxS5SgsOogOlY=;
        b=LmGBVg1DOtZ60gIw/g8eHRv8xijyuEXXEGTfmgCrKTE7TgqKrhTVuPbg8yPR9Z8GP8
         GVDkgq6dyazGS18fGc5bFZzWzkPIU8iUgJLqkmoa+PcX3yJAFK+V75LHofKOWECeBh4m
         CHqn4DVddZGKH+IVh47loGOM3pKMGkVww+OnTOsP01Mlp/n8jqJR2FZqp+NDEuBfjJrS
         L6deDlux7K6StgIe45wBc5xZZVUKcxvSSfjUG/lowiYbH8OUptPmqBCJRd/vZ3t7LTOt
         TzoEDOgtFFbN7737oh7bPqnBLW+WPCzNE9MUD7hNovi0a02R1pEHcJQ1rwCKKQmLBx7Y
         QAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8k+54bJLm5Dimlr1t4QPDlPtUOMnAoAxS5SgsOogOlY=;
        b=EdZSXxgm6jRvIrkEFlsp44QwAodpNDnNQDiazp6s7TINNAYN5+WRCRITvxbK82FKF/
         CQb6OLSH1EuyQhrU5gS1LIvCTAigdvP5TQyJ8EBIajd9hKG9EJ7aL4aq1QCclGuqntJj
         pJDuSIvoirfxTTi0MOwuhhJ7MiPNpB0WhBj83z7G5rbd8oncbH1gvigDC3CYBUHF8d97
         NqaWEHsxQLmkvAOnCx3fDBKRc/e57133WcfCy2bPKXQHbE/iRzCbLfGcD2M/GlfMjxbl
         O0jyBcG78gIY76udwlS7necm7GZxzXbyVYG2zxiwJmHLIGWKoeLIfuKKFBudcUnYZgdJ
         NCyg==
X-Gm-Message-State: ANhLgQ2vLg+lwG37QFAG4yTq1IDKS70Zsi1BMrUAvJMh6DYXPtK8PcT1
        LsAuf6hcsjfAlC5TM8yobWLH+nkkVA==
X-Google-Smtp-Source: ADFU+vs5RXE42yBjrb5nzjeGuLVck2ZDHTOsCG6POLyFiGSeEb79xvLH320mEkvypfrPoX6obW/c9g==
X-Received: by 2002:adf:a343:: with SMTP id d3mr21150628wrb.50.1585687630505;
        Tue, 31 Mar 2020 13:47:10 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:09 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com
Subject: [PATCH 0/7] Lock warnings cleanup
Date:   Tue, 31 Mar 2020 21:46:36 +0100
Message-Id: <20200331204643.11262-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/7>
References: <0/7>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to various functions,
that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings, improve on readability odf the code
and give better insight or directive on what the functions are actually doing.

Jules Irenge (7):
  fs: Add missing annotation for iput_final()
  fsnotify: Add missing annotation for fsnotify_finish_user_wait()
  dax: Add missing annotation for wait_entry_unlocked()
  sysctl: Add missing annotation for start_unregistering()
  btrfs: Add missing annotation for btrfs_lock_cluster()
  btrfs: Add missing annotation for btrfs_tree_lock()
  tty: serial_core: Add missing annotation for _unlock_and_check_sysrq()

 drivers/tty/serial/serial_core.c | 1 +
 fs/btrfs/extent-tree.c           | 1 +
 fs/btrfs/locking.c               | 1 +
 fs/dax.c                         | 1 +
 fs/inode.c                       | 1 +
 fs/notify/mark.c                 | 1 +
 fs/proc/proc_sysctl.c            | 1 +
 7 files changed, 7 insertions(+)

-- 
2.24.1

