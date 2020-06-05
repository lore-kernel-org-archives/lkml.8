Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DB206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N87sRbGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFEQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgFEQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:00:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2BC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:00:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so5082999pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFzuPg87lia15bj0MACfGhh8dROQtUU99JStdLteJm8=;
        b=N87sRbGURjNVH3cGexUjqOcgDYvYJMy8VoG9ckFH0aB1QHhjcmTB3IoUw+n7gla5Gl
         Nu4+9An1lTW5DFM57UkJtPrMYk4gc1B2g3ORLnaocIqUJYsZ+6I4d5lvKJr/btsT+ObU
         4d5/LypDNzjbQvWdIBOtLpeN/dS/2bG1Wvp5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFzuPg87lia15bj0MACfGhh8dROQtUU99JStdLteJm8=;
        b=RdiOZqFV4851tRJqpv3Tl5398QtxUTZw8vdDgBE9nW0eL2zPRqKqz42dONrkV8qdMd
         heoM5+QCxI4Bm4QcUoHbNqPS5qtmuBp9zahgMlWBIAIGfwvw0lPnjo6aKRjyxe4sAvMX
         pHktp4BIQYNfq9L00i73Jaya3m8WCOnKPlt3fk1xucUve3sZiXFInwjYaum8SPBxFlea
         k3I0bc6kv/pNbXPV6ovNrBN8tt4LMc6pTc4ZMAKon33w4fLtf3NTKHzd+i59MTgHTmZs
         ViXuFROnZd07a4D+vXClMr9GOB6upg9KWP719+QYt+U+S3C0yMAOLTDUNgtN0KPDUeqo
         hjnA==
X-Gm-Message-State: AOAM5335R2W5fLQfMR50m2gO7QzpHArLxuO5O5yKwqdjwR2NPwo2C75h
        rx7e9pE7dkfTHmxquXCAa51seQ==
X-Google-Smtp-Source: ABdhPJzZcH6mbwWsYQHLkHWiTXgnP9bVA4PXBKPDvl3u7f6oXPodSpEarfATZfskj2IlzdjeiODrfg==
X-Received: by 2002:a63:3384:: with SMTP id z126mr9940695pgz.7.1591372820569;
        Fri, 05 Jun 2020 09:00:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm11sm8391860pjb.9.2020.06.05.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:00:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Relocate execve() sanity checks
Date:   Fri,  5 Jun 2020 09:00:10 -0700
Message-Id: <20200605160013.3954297-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking at the code paths for the proposed O_MAYEXEC flag, I saw
some things that looked like they should be fixed up.

  exec: Change uselib(2) IS_SREG() failure to EACCES
	This just regularizes the return code on uselib(2).

  exec: Move S_ISREG() check earlier
	This moves the S_ISREG() check even earlier than it was already.

  exec: Move path_noexec() check earlier
	This adds the path_noexec() check to the same place as the
	S_ISREG() check.

v2:
- move checks into may_open() using acc_mode instead of f_mode to correctly
  compose with other inode file type tests[1].
- drop the FMODE_EXEC f_flags -> f_mode change for now since it remains
  unclear if it's useful (and is not needed any more for this series).
v1: https://lore.kernel.org/linux-api/20200518055457.12302-1-keescook@chromium.org/

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/

Kees Cook (3):
  exec: Change uselib(2) IS_SREG() failure to EACCES
  exec: Move S_ISREG() check earlier
  exec: Move path_noexec() check earlier

 fs/exec.c  | 23 ++++++++++++++---------
 fs/namei.c | 10 ++++++++--
 fs/open.c  |  6 ------
 3 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.25.1

