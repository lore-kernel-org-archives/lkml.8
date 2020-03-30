Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D98C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936D9206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g20xzvu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgC3BZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:25:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39874 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgC3BZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:25:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so19416492wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL92qf5dJQGlNO9IGHOn2G/wiICxkj1gwIxnuiCxh00=;
        b=g20xzvu1vSov7nOOikv/A8/WkrAQ8aWVTw+0yxbu/E0e09rfRn5zb1RZooVE769Ezn
         t+pJ64W5x1/QpNgS1NNPXKpDazEkIMEJYZ7w9mEUEQ7Vin1yKKAF5hEjlWTaSwH7VVu0
         J0qFF9oUi9rnCjhiHy2/Hi6W+5YTOixYiqpHk9cwL/r3kjoTRZFWw2u4mcOHMv/WMWYk
         V9yDAUOIXQRHSH029so5UMcrhV1LpFCvkZZ6ItSfau2OZUB4taYrXl3MsjAqLomyire5
         mmRGkQWFFC9SyvPqDSuaQF4iFbRf3NvT8Yvzici3W6xG+j6obZ4yjdl9woZQy0oiavUA
         3R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL92qf5dJQGlNO9IGHOn2G/wiICxkj1gwIxnuiCxh00=;
        b=eGyCV8HneZiOIctVJE0RROtgRlcdcS9cSgLiIf0/EJrcc9uHoyBL5jGiEaF6XLhkjB
         0N8WyGBelu4sMYCefOepfCoRMcOLvbo54rHh/Po8Y0EZaLPHiJ1X8aSeCtv9O5oVRPwC
         0NNTAGhd3KtRJiwcC2BasdirgZGiresW2YMZYYJo+iPJk5DHjngwLMiQoGTobjaXKdyS
         G/FCi2kjkhIlRj2/Vd8/ZGrAY0qcndlaxXHcm8ej9yh4O33nvCgZMfcJbcpbQ+CiKUjy
         G1oOKx9j9mc5KO1j34dbEZ29nKCVORA/AmH/grsLN26pSrt+Tdkc8ljX26opNh6neB1Q
         QxCQ==
X-Gm-Message-State: ANhLgQ10ur2AKN4RTXha6+SqeHM9fYcbWGyEW3gGbjrQjgcxZs+UYwgk
        iQd6QC0BkOqKXJRz3VaoKd/3khP56A==
X-Google-Smtp-Source: ADFU+vv5mG85EeIpoA5NQA3U5Pkh4vQ2pWuNASkAaNz36AL6nJ1YQjP7r7NzVa5nBH/lY5aVME2ziQ==
X-Received: by 2002:adf:c511:: with SMTP id q17mr12349634wrf.275.1585531503360;
        Sun, 29 Mar 2020 18:25:03 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id f12sm18679545wmh.4.2020.03.29.18.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:25:02 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com
Subject: [PATCH v2 0/4] Coccinelle cleanups
Date:   Mon, 30 Mar 2020 02:24:46 +0100
Message-Id: <20200330012450.312155-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0/4>
References: <0/4>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series clean up some warnings by the Coccinelle tool.

Jules Irenge (4):
  cpu: Remove Comparison to bool
  rcu: Replace 1 by true
  genirq: Replace 1 by true
  locking/rtmutex: Remove Comparison to bool

 kernel/cpu.c             | 2 +-
 kernel/irq/spurious.c    | 2 +-
 kernel/locking/rtmutex.c | 2 +-
 kernel/rcu/tree.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Changes since v2:
- Improve on commit log 
- Correct mistake of mixing two different subsystems patches into one.
2.25.1

