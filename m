Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E767C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A78206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzkD6Xes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRUcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:32:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62C0C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:32:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r1so23777935ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ciQQd+/pXK/f0EMi/u1Pk8CC/LxSnQd+e3ZPvgSyTts=;
        b=QzkD6Xes14l1nZ+rfAZ/G2NkiM3u8UX/fUQddrtx27Dzqn6rgvxSfSxpnKHKG24+Fd
         8XqMj3GFPKdM+Ll5pshabK2GvipbtKV/HC+TvxtXGVugjx5tcv4QiytjNV3u78MnjKXZ
         MwzmRxPdsGYbyIb/oUj94Jl6SImGkQyG3Zbbrj0uthBqDDEy1qBIFlxlENabhJqctXeD
         2+EhkotnbGF5o6/1JYs+lkHbvoyai1gNW6LeF92wht5+xLEhKDJOlsIXK7tguFetXj40
         CzFr8sxmKq3TBo60RWOEwg4Stl9I/oQw07Hre/48dyiy2fwHmsbifrpzl0fcPdXV5miA
         71SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ciQQd+/pXK/f0EMi/u1Pk8CC/LxSnQd+e3ZPvgSyTts=;
        b=jm8vG44Tkux9KT/6bUTGcJtT12yO9S8VN7+LVuIRiX217HDrVoUgyEt4jYWfsYMTl/
         6k4HJQoU6pMlb2lCpiR0eHCGvv6qPc8fb2G/6D01DUgrnhulWpXWFIF7Ea+NX8FqLVlJ
         IPh24bMrTG+AeX6oEYlkhD8lWwUdDqij5fjN7QbCo2m54EyQHTCgIo2H753i67W+AsKo
         5tAo4jRRBDo5tsWCR88v2fZTJ6B5f5885BAOuAYLZLXYxG+RuBWvT89dEHlTUU8F92qm
         ZkLgWjefLkwUfnU5ab8NCowWuhbaUlTkL5gmfsRJ/5QsaCfHDKGN67hUXdv70izUqFEA
         ahxQ==
X-Gm-Message-State: AOAM532CQojNcv5Bj+6c9FbYEGrBtg+YyvIE9b1kN8IqeZSYgG41mfq+
        J2LfzN5/sCh0zqcnyJafNdkdy9GItDM2WePAyog=
X-Google-Smtp-Source: ABdhPJzx/IPLNGduPnlPcnla0CcuoJ7gQ9ljQLTPEUZcOM4zXKdWO+N6UPNmPdmLW1+KZLkUmkSa5/O+k9diQav7dwM=
X-Received: by 2002:a25:d802:: with SMTP id p2mr31518862ybg.446.1597782739841;
 Tue, 18 Aug 2020 13:32:19 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:32:14 -0700
Message-Id: <20200818203214.659955-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] mailmap: add Andi Kleen
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Quentin Perret <qperret@qperret.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting bounce back from the suse.de address.

Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 97fd835bd2a4..21f965400a28 100644
--- a/.mailmap
+++ b/.mailmap
@@ -32,6 +32,7 @@ Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
 Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
+Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
 Andrew Morton <akpm@linux-foundation.org>
-- 
2.28.0.220.ged08abb693-goog

