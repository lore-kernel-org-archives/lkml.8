Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F136C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F7320722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4H51g1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgCZSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:15:12 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:36069 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCZSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:15:12 -0400
Received: by mail-qv1-f74.google.com with SMTP id v4so5511436qvt.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9W2imRwNIX90Y+pv7hvZUio45RVHKjTkCMpOp3XQz5g=;
        b=L4H51g1ye0QBy1pKesN7K+qpxcMZHaR/pvy4tsx/SOQ791OkKaMGWDK8acZTk9VIvo
         79JW3+veC4INQH6pDPz3HMLI5aMFnzztdMR7KcXsOg2upVPHvZ5+/9NY9d99M9AwsHxr
         0HywX1EfJOf+TjX+zojuN3zm1Rq0DcTyRlJCyG9OMVaQwX1VwLwOH89FeCWjtk0CaNY9
         DxCYvgfbdWT2LSpz7hnG+2EE6W3BuqfCdVvxI2Qj0jh6oObj8Zd456/UGglmhP8oo3pF
         IpTY/tcb2l+BkqjcDQeaamxI4lbEhzTiRJJtuLRYW4vTY8iTvatwecihnymCxzMYIDbS
         hvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9W2imRwNIX90Y+pv7hvZUio45RVHKjTkCMpOp3XQz5g=;
        b=uVWy1o01it14qXteMjPS0b8oZ0mLNNs0QU8fTH406nmXlPwC09ztOV34o0zt5wusxZ
         GD4mTbbeJ29A35PwHARiTA+cU+vnndy1EpTaC0ay28ZIxXbC0LUbSjYC9eW0hJ8SUt9O
         e89ezurF7Hn3FP69eoVzpNNFO8RcOF0bQWXXonBQWbDpDxxvlQV8HvFU83p6zN4jCLJs
         KxFuwibbeDTqeFQxFystWC2nolxL8p5yyXTVufSTUVXBfS5pCUAfV6gSDpm6jq50uJCr
         J8cRJsvx6KX+8pRNfqKUUsIZpt8p7Oy9Al3fteapVSLRVRq9XgPzREiKrdTg2/R2JIWD
         RTPg==
X-Gm-Message-State: ANhLgQ0bP7349b0jPsTQnFyPDUTnH7bGqHE1Txj1XoK5X/RVgHJAQH/2
        slgSFywQUflLne8eM2Hizqd5kixHf84=
X-Google-Smtp-Source: ADFU+vuXYWs53KZQSCzq/xUwtE1DCsUixB0nXsvXZzDLn/OQfnLie5fjL6+pvJ2MBJlcFVtiiQax9ZZZqwI=
X-Received: by 2002:aed:37c3:: with SMTP id j61mr639522qtb.284.1585246510936;
 Thu, 26 Mar 2020 11:15:10 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:14:53 -0700
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200326181456.132742-1-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 0/3] SELinux support for anonymous inodes and UFFD
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and in the future, other kinds of
anonymous-inode-based file descriptor.  SELinux policy authors can
apply policy types to anonymous inodes by providing name-based
transition rules keyed off the anonymous inode internal name (
"[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
applying policy to the new SIDs thus produced.

Inside the kernel, a pair of new anon_inodes interface,
anon_inode_getfile_secure and anon_inode_getfd_secure, allow callers
to opt into this SELinux management. In this new "secure" mode,
anon_inodes creates new ephemeral inodes for anonymous file objects
instead of reusing the normal anon_inodes singleton dummy inode. A new
LSM hook gives security modules an opportunity to configure and veto
these ephemeral inodes.

This patch series is one of two fork of [1] and is an
alternative to [2].

The primary difference between the two patch series is that this
partch series creates a unique inode for each "secure" anonymous
inode, while the other patch series ([2]) continues using the
singleton dummy anonymous inode and adds a way to attach SELinux
security information directly to file objects.

I prefer the approach in this patch series because 1) it's a smaller
patch than [2], and 2) it produces a more regular security
architecture: in this patch series, secure anonymous inodes aren't
S_PRIVATE and they maintain the SELinux property that the label for a
file is in its inode. We do need an additional inode per anonymous
file, but per-struct-file inode creation doesn't seem to be a problem
for pipes and sockets.

The previous version of this feature ([1]) created a new SELinux
security class for userfaultfd file descriptors. This version adopts
the generic transition-based approach of [2].

This patch series also differs from [2] in that it doesn't affect all
anonymous inodes right away --- instead requiring anon_inodes callers
to opt in --- but this difference isn't one of basic approach. The
important question to resolve is whether we should be creating new
inodes or enhancing per-file data.

Changes from the first version of the patch:

  - Removed some error checks
  - Defined a new anon_inode SELinux class to resolve the
    ambiguity in [3]
  - Inherit sclass as well as descriptor from context inode

Changes from the second version of the patch:

  - Fixed example policy in the commit message to reflect the use of
    the new anon_inode class.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 196 ++++++++++++++++++++++------
 fs/userfaultfd.c                    |  30 ++++-
 include/linux/anon_inodes.h         |  13 ++
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |   4 +
 security/security.c                 |  10 ++
 security/selinux/hooks.c            |  54 ++++++++
 security/selinux/include/classmap.h |   2 +
 8 files changed, 272 insertions(+), 46 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

