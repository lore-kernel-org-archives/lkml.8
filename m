Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC96A207CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NXw4byTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGDIw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGDIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 04:52:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C2C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 01:52:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so36406161wml.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1RRawWEUAbaYj9hai3Y1mVQN8Mmny2tih4VJXMW7VI=;
        b=NXw4byTH6c/4wVlwe51yy/GHnB/PsCTy5gZ/fStDCLZPSa6L9gMtpa4dDqUGmFwlYF
         z57NrvDOtGhzcj4gM/i9nF1j67kQYT91VSm3zolf5j5exV0E4OTW1K9yNRWAkSXplcSL
         zg4m8ZhCjbULTcXOVlII7BiH6qtnS5n07lv9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1RRawWEUAbaYj9hai3Y1mVQN8Mmny2tih4VJXMW7VI=;
        b=GpftYajT4OHTofOf9JvB4nQO7NB6HFbBO0S4l51jRwpzuXdemqwEX1FQF/ZJNjDhEW
         wueCb9OWrLi5fw49Yf4wJHxWxr81jeP57kVRhHA4CDP7r/n0QrOvBdsbT2q9/PL1cWct
         hBnOZeLj2YVIVPa5XT+SzjgQ8ygpHq1XxVPI8PHK0d3NoQMoD9Kt7P10bhxcX7dvIp8Q
         rhfyAiRjPFbTTXpDt5xfAuE75Qc3yav0m8W2HsbNzZ01HuteZqgIa9sbqmQmiiMndTbY
         vmPoDHZvqxZU7bSYxUX4ByN7iCcL6OeqvAg3YGXbqoFtQbSnJT/8MenaFrfOkZF+n1J9
         LFag==
X-Gm-Message-State: AOAM532mrhvxVrwacfdVfTbD5v9aFb/IVqTG5oRKntMK52Xlq+hvl2aH
        FqoxfRLPbzZno19Stcyzqyfp6Q==
X-Google-Smtp-Source: ABdhPJxc/FImEhC1BwqkYSCXIWFqczxuWicZQqQADZdj6EnRGtDrJ+R9ZQCR16vZJKzIHVMWgRooww==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr39986102wmi.98.1593852746570;
        Sat, 04 Jul 2020 01:52:26 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-139.host.pobb.as13285.net. [88.144.169.139])
        by smtp.gmail.com with ESMTPSA id a22sm15195915wmb.4.2020.07.04.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 01:52:25 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 0/3] um: allow static linking for non-glibc libc implementations
Date:   Sat,  4 Jul 2020 09:52:10 +0100
Message-Id: <20200704085213.444645-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of [1]. Since I was able to produce a working UML binary
with UML_NET_VECTOR linked with musl with the changes included in the patches
here. I was compiling on Arch Linux, so hopefully all the latest versions of
the compiler, libraries and binutils.

I also tested allyesconfig with both musl and glibc. The compilation succeeds
with both, however both binaries (glibc one being dynamically linked) segfault
on start. This is probably of some incompatible config option/module being
included and not related to musl/glibc.

[1]: https://patchwork.ozlabs.org/project/linux-um/patch/20200624212319.403689-1-ignat@cloudflare.com/

Ignat Korchagin (3):
  um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
  um: some fixes to build UML with musl
  um: allow static linking for non-glibc implementations

 arch/um/Kconfig               |  2 +-
 arch/um/drivers/Kconfig       |  3 ---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 init/Kconfig                  |  6 ++++++
 scripts/cc-can-link.sh        |  5 +++--
 10 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.20.1

