Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F54B207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSoTHvoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIBUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AAFC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so883955qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JdQwkuLYEyAFaAMN7JnHeEmf9KqMuiS3LAxUb4gzvY=;
        b=ZSoTHvoqM3YQj7xkHNSUHZeV/ZS5A7V2pD16ARz2BXKyep1ueJXJ7bosq7XSbS0H03
         8XU302L6I5ojWh9L9fE4QZbESVY4pkA7SFMIp7FnD3xaPvMJcvvT+L2nwRtzG54yvgfI
         bVwa1xP65NA1oY7cfRigZnchJfOXPinaNniCCoXfILVIWezMpWzd9iqO3pFgv1dPgHjP
         4yL6GcYIOIXPDDXiWoIF+qRpMczg22kY+sgaIvfCYay1Y757pueoD5HcOHYbMMGjVFU4
         kvnhUZ03sXhqL0jPY87zwtmsF7+OJz6mEo2RFQchBPc43XFJx/L8Xi3lRAXlStAYsqUr
         lhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JdQwkuLYEyAFaAMN7JnHeEmf9KqMuiS3LAxUb4gzvY=;
        b=BfL59D7uWcPQo9RU/a8Wnzxt8Jb/J+1j31pGqYII2zHUMU8cWkIZ3d/unqegqZIgep
         wXSp7e3tgUMHvel2WoEIxmNuBQKqBpbU249JIWBHVH65eCvn3tvxiK85wF9TDbLNH1ot
         ehQBeFQUmBXmVR4x6oEn7gliGj+lPW7L1WBldBaA7lZ1m9XIp+OMw47Qv885Y/Aj9C4S
         EvMJC6XCKKsbroyrod/Xct1DEBKgxBIwVKoDFUa7c9W5hvn7YEByOdjlS1GzrOsriN5H
         IlHFACLlnUEwZo0aCxY8dc0pn99/pSgSyNNRaHCSTYGQ38iJ47CHB5gizDCWjbpcU2CC
         ssMg==
X-Gm-Message-State: AOAM531NuwQmZum4G2E6ThUoHQHubamaHt70Sws302Qp5XT3c/scUcPm
        V03nP/RCTU8CBv/25R8uOqo=
X-Google-Smtp-Source: ABdhPJxbqqwpZTrRGBCTwYsuBDZvh5BCCxLcImcoyUAYC1vPX6bJy9TTNPQrgaP6+MXcckotyNxHcg==
X-Received: by 2002:a05:620a:a52:: with SMTP id j18mr8060706qka.445.1599076878970;
        Wed, 02 Sep 2020 13:01:18 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id d12sm472481qka.34.2020.09.02.13.01.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:18 -0700 (PDT)
From:   Nachammai Karuppiah <nachukannan@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Nachammai Karuppiah <nachukannan@gmail.com>
Subject: [RFC PATCH 0/7] Trace events to pstore
Date:   Wed,  2 Sep 2020 13:00:15 -0700
Message-Id: <cover.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds support to store trace events in pstore.

Storing trace entries in persistent RAM would help in understanding what 
happened just before the system went down. The trace events that led to the 
crash can be retrieved from the pstore after a warm reboot. This will help 
debug what happened before machine’s last breath. This has to be done in a 
scalable way so that tracing a live system does not impact the performance 
of the system.

This requires a new backend - ramtrace that allocates pages from 
persistent storage for the tracing utility. This feature can be enabled
using TRACE_EVENTS_TO_PSTORE.
In this feature, the new backend is used only as a page allocator and 
once the  users chooses to use pstore to record trace entries, the ring 
buffer pages are freed and allocated in pstore. Once this switch is done,
ring_buffer continues to operate just as before without much overhead.
Since the ring buffer uses the persistent RAM buffer directly to record 
trace entries, all tracers would also persist across reboot.

To test this feature, I used a simple module that would call panic during 
a write operation to file in tracefs directory. Before writing to the file, 
the ring buffer is moved to persistent RAM buffer through command line 
as shown below,

$echo 1 > /sys/kernel/tracing/options/persist 

Writing to the file,
$echo 1 > /sys/kernel/tracing/crash/panic_on_write

The above write operation results in system crash. After reboot, once the
pstore is mounted, the trace entries from previous boot are available in file,
/sys/fs/pstore/trace-ramtrace-0

Looking through this file, gives us the stack trace that led to the crash. 

           <...>-1     [001] ....    49.083909: __vfs_write <-vfs_write                         
           <...>-1     [001] ....    49.083933: panic <-panic_on_write                   
           <...>-1     [001] d...    49.084195: printk <-panic                                 
           <...>-1     [001] d...    49.084201: vprintk_func <-printk                          
           <...>-1     [001] d...    49.084207: vprintk_default <-printk                          
           <...>-1     [001] d...    49.084211: vprintk_emit <-printk                          
           <...>-1     [001] d...    49.084216: __printk_safe_enter <-vprintk_emit         
           <...>-1     [001] d...    49.084219: _raw_spin_lock <-vprintk_emit       
           <...>-1     [001] d...    49.084223: vprintk_store <-vprintk_emit                    

Patchwise oneline description is given below:

Patch 1 adds support to allocate ring buffer pages from persistent RAM buffer.

Patch 2 introduces a new backend, ramtrace.

Patch 3 adds methods to read previous boot pages from pstore.

Patch 4 adds the functionality to allocate page-sized memory from pstore.

Patch 5 adds the seq_operation methods to iterate through trace entries.

Patch 6 modifies ring_buffer to allocate from ramtrace when pstore is used.

Patch 7 adds ramtrace DT node as child-node of /reserved-memory. 

Nachammai Karuppiah (7):
  tracing: Add support to allocate pages from persistent memory
  pstore: Support a new backend, ramtrace
  pstore: Read and iterate through trace entries in PSTORE
  pstore: Allocate and free page-sized memory in persistent RAM buffer
  tracing: Add support to iterate through pages retrieved from pstore
  tracing: Use ramtrace alloc and free methods while using persistent
    RAM
  dt-bindings: ramtrace: Add ramtrace DT node

 .../bindings/reserved-memory/ramtrace.txt          |  13 +
 drivers/of/platform.c                              |   1 +
 fs/pstore/Makefile                                 |   2 +
 fs/pstore/inode.c                                  |  46 +-
 fs/pstore/platform.c                               |   1 +
 fs/pstore/ramtrace.c                               | 821 +++++++++++++++++++++
 include/linux/pstore.h                             |   3 +
 include/linux/ramtrace.h                           |  28 +
 include/linux/ring_buffer.h                        |  19 +
 include/linux/trace.h                              |  13 +
 kernel/trace/Kconfig                               |  10 +
 kernel/trace/ring_buffer.c                         | 663 ++++++++++++++++-
 kernel/trace/trace.c                               | 312 +++++++-
 kernel/trace/trace.h                               |   5 +-
 14 files changed, 1924 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramtrace.txt
 create mode 100644 fs/pstore/ramtrace.c
 create mode 100644 include/linux/ramtrace.h

-- 
2.7.4

