Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97E120838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfG9TFFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHMXRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:17:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A2C061385
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so3594971pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMaIwjW9eusb+2TY79hGdNFXq8NkyNcWXc0iY+eQ23I=;
        b=kfG9TFFepAXDbzZfcw0mIK2vP0Gs1b3ZmYF0kSK4W/am738KDkGh7FF8/Zr8D2V350
         I6j06PiROMtFU4GYDLCslZrzfNACffjK7jTvJ37/N7puZ99I4lobMtmdvcyYOWQ8/vRt
         2ew8Q22zSowQfty8z7JmIcPduU7pJ5GYBG47E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMaIwjW9eusb+2TY79hGdNFXq8NkyNcWXc0iY+eQ23I=;
        b=NSW784DnFCqL7qzqfSAWfFx/8wGjFnBLwTBTVxTtWiFCc6K2zDg7/OsXnGpdmYoBKX
         1oGCWbbTlRlbix1qSfD1x6QnvQcdcOge6LaPHjaboylm07vADR45l8bugwY5wDTO9+6t
         rVDMgU7cX5FYb1xuypqrzPI+7fvqQAI8KfjIJ9LXweJc8sUqzJwkwqdbHecjZ1iTpY5t
         itJBHMjJqNsQl6DoyKy00ktZSSPn7RfCHVQCxgdTSvZah2TCfzs4KZoBgj6GN9piYQXK
         QDjaCfc7TmiqE239vYrxEqcxdFdQbH717rClxeH0myTmPLZrtT9SRdiWXmjTxSETpVJF
         OQxA==
X-Gm-Message-State: AOAM532nJrXARtDJaGI6LUpPoUmqvk2nG3Ng7rDVxXrfgJa1RYapguBN
        AkFuwKTd+FtToRJG1RtCfuPqQg==
X-Google-Smtp-Source: ABdhPJwbu9pop4TT3+LDw1+TCnb4W2C3I+Iy5K/KYiM8BEpOhw/+PM2YnAajKwFfSJaZm6S65ht0CA==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr5370668pgd.55.1597360651664;
        Thu, 13 Aug 2020 16:17:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y29sm6929728pfr.11.2020.08.13.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:17:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] Fix S_ISDIR execve() errno
Date:   Thu, 13 Aug 2020 16:17:21 -0700
Message-Id: <20200813231723.2725102-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This fixes an errno change for execve() of directories, noticed by Marc
Zyngier[1]. Along with the fix, include a regression test to avoid seeing
this return in the future.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20200813151305.6191993b@why

Kees Cook (2):
  exec: Restore EACCES of S_ISDIR execve()
  selftests/exec: Add file type errno tests

 fs/namei.c                                 |   4 +-
 tools/testing/selftests/exec/.gitignore    |   1 +
 tools/testing/selftests/exec/Makefile      |   5 +-
 tools/testing/selftests/exec/non-regular.c | 196 +++++++++++++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/exec/non-regular.c

-- 
2.25.1

