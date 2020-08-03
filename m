Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F329C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6995D206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGJ+cGs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHCOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:47:45 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCAFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:47:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r12so2190303qvx.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jSEcpjJOquc529ZwoycPhflNQKRcL97Z3GUPK/MTFhg=;
        b=NGJ+cGs/7Y5yanvxauvBQNlpaQtun8x5OXswBR95fjESI+Q1GyxIm26mBIJiQZlchx
         DnHpQPnaiAYiQeJ7fbILu6QdY5Rd11V8/qKJe4l/2w1iWVLomfjMRhY7F1HbDB+a88/v
         OxW7fJVYu/9qupGnZQbIDl8RQ39QYHWJjpj6Y7eEVD2A8NOnmSLcJvTqsh8RSUHTZPrm
         iB78LpIkLOgboZguy+rRN/6HLRUkZASiQtIdBkfmKC7u09IfxeH6wtHsiiiO6m7p/yy5
         JixVWy5wqO/esbMdb7V3i86xLFulz50ivT2vhoOcOZ+NFnlgeqV1YkGRMJJ5EjFVX0il
         hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jSEcpjJOquc529ZwoycPhflNQKRcL97Z3GUPK/MTFhg=;
        b=seGN8mqQn+BmqVaLnL5vQaZjrJ/w8eUCG/wRy9gsNBc8ZFI2AoSi5hMqsAwNTaNXBM
         OlhZxcO99jQuHidPo3yjE+r7v2vP4Ge8wIlUbHvdLbHWl2imz4Qmzu0N4+qdo0JN5Wn1
         RDbJCQ+P3E3poLzuPYIjSVcgdyOp1GO9Qw0RSkd7r1b+2UKmb3zDGF1nnux3FQV1mPTd
         dQ9h7lV+D7L1DHleZAoxX5K1lFdCRGuCRnogr2QFm64p3ubYvoHiNvmacpM8/cmB/I7L
         fJ97H7tQneRqyMKke+vL1aIQ8HTBfTpaD7AEf/pN0FohR217zZu11Oe/oPwC7pjSRTxP
         EIfw==
X-Gm-Message-State: AOAM53111xWi1g/TvaKFYhrkij9j8Ovg8VZeMWjkBGefk2qfMN/XIRzs
        6/psXXb50x+3CqnOZAiI4ckxe2dEUPeWt5HEpA==
X-Google-Smtp-Source: ABdhPJw7sHEqkxXBQdZEh6QBRcoghAHfysqJXJXhfAsQDkKtCR//v760mqThiImnXfcrSB5dpdxJ6/pM/TKRNguNpQ==
X-Received: by 2002:ad4:4482:: with SMTP id m2mr15332118qvt.102.1596466063346;
 Mon, 03 Aug 2020 07:47:43 -0700 (PDT)
Date:   Mon,  3 Aug 2020 14:47:17 +0000
Message-Id: <20200803144719.3184138-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/2] Per process tracking of dma buffers
From:   Kalesh Singh <kaleshsingh@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs doesn't have stable abi. This patch series enables per
process accounting of dma buffers using trace events.

Kalesh Singh (2):
  fs: Add fd_install file operation
  dmabuf/tracing: Add dma-buf trace events

 Documentation/filesystems/vfs.rst |  5 ++
 drivers/dma-buf/dma-buf.c         | 29 ++++++++++++
 fs/file.c                         |  3 ++
 include/linux/fs.h                |  1 +
 include/trace/events/dma_buf.h    | 77 +++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 include/trace/events/dma_buf.h

-- 
2.28.0.163.g6104cc2f0b6-goog

