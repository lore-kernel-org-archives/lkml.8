Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E4420882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx3qeeet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFPOXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:23:30 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07907C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so22081654iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4U1AfLGfbsqzclrKp54jPi9In5PnDmi1Caq80dY41A=;
        b=Cx3qeeetNETMSLLjMLDoFlb+lDoZ6kuK8weLKFqIrlpu8dK9u/vI9KmcHO5Z3bfam/
         kBTT06m7baIxeaXc/2T01peE5OR2v6ehrVU+BcGVUKhxFhxk9CbJ32e/5GeQSDjvf9Fc
         NtqtHQGxodM2SiyZtM/CNAC8H7frCOUnO5fzg9emG16IX0VNK41as/IGdKzNja7Ji/Yw
         7KdfdNEzbFghL7ky/XQuUX3WRxIqcGzmXF2EA7lUjANtq1Nkx6NTxsLBTpFQuI63V3z2
         0XrB42HmUD4QRS2aWcCjNtKce8skyQwcTDPcVmlva6nt4SrtYvvvqqzrgAVxjkvxHZe8
         M1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4U1AfLGfbsqzclrKp54jPi9In5PnDmi1Caq80dY41A=;
        b=Df2e2JvlFJyGQ/jRg/ZYsrdTWauNLfLIBAtUgEC0W94Hiihi3nH2he4mzaxJe1VHfd
         336aTVTGnKrGE41BpGH4zJ87zahgjjvt9lQSvteC+a9S3cvlIvszBrdS+0Hx/ZeGK5Hx
         QW5c6/AA6OtQ/DgqOKO42rJ1wCAfzonkRxmHdW6JbgSh3mimnDkwYLK+/rZtod1A8aGx
         GblCDebtN4f6HcsDlvcG6ijQ2oT+9SmTj2TyXl/E42ODsI7WEUOIsGlIf2As5sacB3Fy
         5C1X203Ib7XMFjTG9jQG9I9yMLZu3jYJfNlnR+sy6uuvOlHg6YLRvdG+0nGOwdgdh6MZ
         0NdQ==
X-Gm-Message-State: AOAM5338/XFAtmq308PcA7zv87FxkIY331xy40pHGHcTvg0hraVmOPro
        3fErO3/NErosbXTjAjzXoT2f7eVGwg==
X-Google-Smtp-Source: ABdhPJzHeQwK0pkNPKPVmacPZFczxrpK+FmbMED11czNyck7YdmQPWaZGyYvdTlmpp3XWg7ftkgKLA==
X-Received: by 2002:a5e:981a:: with SMTP id s26mr2914477ioj.131.1592317408955;
        Tue, 16 Jun 2020 07:23:28 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm10049881ilk.14.2020.06.16.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:23:28 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/2] X32 syscall cleanups
Date:   Tue, 16 Jun 2020 10:23:13 -0400
Message-Id: <20200616142315.375918-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig uncovered an issue with how we currently handle X32
syscalls.  Currently, we can only use COMPAT_SYS_DEFINEx() for X32
specific syscalls.  These changes remove that restriction and allow
native syscalls.

Brian Gerst (2):
  x86/x32: Use __x64 prefix for X32 compat syscalls
  x86/x32: Convert x32_rt_sigreturn to native syscall

 arch/x86/entry/syscall_x32.c                      |  8 +++-----
 arch/x86/entry/syscalls/syscall_64.tbl            |  2 +-
 arch/x86/include/asm/syscall_wrapper.h            | 10 +++++-----
 arch/x86/kernel/signal.c                          |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |  2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)


base-commit: 83cdaef93988a6bc6875623781de571b2694fe02
-- 
2.26.2

