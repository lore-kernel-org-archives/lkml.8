Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F6D2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDXYfS9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHJSg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHJSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:36:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF67C061756;
        Mon, 10 Aug 2020 11:36:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so5492127plk.1;
        Mon, 10 Aug 2020 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJZO52EypTYHSYjNdKUzoiygtIPVe4OjaYIrjZLPnvQ=;
        b=kDXYfS9f9lvRcb9iK4bZ1ZpNzK/qn3jvpOE/SaSSzxMZ+juCDxvQwiaubEU/aAU2YQ
         KxHTGW94JEn8+r701lHRniWHK+XX5/AbQF2wJKi4f+RXyZNIOnnvPT4W4R6gegMUpNTS
         UcfvknKFKaC6ZCne4g/5RmN7KHecOzR6lCPh9O4E3lpKtHiX71lNhHQEKOsS9NdzasxC
         rNKSbkFRRgCep5+jo6zrbzs1HI32i1Go01OeYtKLee/BN8PXDQTMR6bpyb969BuBzwM2
         8CSwKtfVMs6BU9jg49dFk+xYrs4YOErxBBDSzpcRL+VUvPWGHdPrV/ShVoVHWMn+A5WV
         hZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJZO52EypTYHSYjNdKUzoiygtIPVe4OjaYIrjZLPnvQ=;
        b=N/+mIsSrNMJ/0fjbc0GUbd9+DNBqDk5eVf7w7/v1StUgaBqtUW0XzSQbLjvfve23rz
         DkHtRTOL+q9+ZW0k5J8VkEVXPnk5tQm4zbaxROymnSaWrs8j6cBbbu8oeUHpY5Mwe4Qy
         55fCs+q3BYDdjzFVY+G76xDpHGD9mviefYjmYQua48dnn3910hx4TmhZTitEBvFb4z4+
         QenigiOOnuuSbnALvkyQojUbBq1z4dzdkkjhVkKoeSgjh2OXyxcLnt7KeucWgmIhnQCE
         VXfsXTXFH2Q8wDttjVQRuHZI0++NimaJ+wXFLMSOEMi0l42j7KoOB/F1xc93TU92f7gy
         1uWQ==
X-Gm-Message-State: AOAM531lripgQ3Ki3pPF/IULhsKk7tscuItsK2zJXyj8edqUHWWonsZy
        dNq7SzJMypSmzi2B1BkFK/4=
X-Google-Smtp-Source: ABdhPJwfI1hSagNB50QX5v1PgFswVEskV8SeB6Dj/aUaZ/VhyTOKzAEWK+6a9BWn3002NK9boxiC+Q==
X-Received: by 2002:a17:90b:1093:: with SMTP id gj19mr617434pjb.149.1597084585696;
        Mon, 10 Aug 2020 11:36:25 -0700 (PDT)
Received: from localhost.localdomain ([124.253.77.168])
        by smtp.googlemail.com with ESMTPSA id c143sm4701092pfb.84.2020.08.10.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:36:24 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Dev-tools: Documentation: Replace deprecated :c:func: Usage
Date:   Tue, 11 Aug 2020 00:06:13 +0530
Message-Id: <20200810183613.25643-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with func() as the previous usage is deprecated.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/dev-tools/kgdb.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index 61293f40bc6e..d756c7b1c346 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -316,7 +316,7 @@ driver as a loadable kernel module kgdbwait will not do anything.
 Kernel parameter: ``kgdbcon``
 -----------------------------
 
-The ``kgdbcon`` feature allows you to see :c:func:`printk` messages inside gdb
+The ``kgdbcon`` feature allows you to see printk() messages inside gdb
 while gdb is connected to the kernel. Kdb does not make use of the kgdbcon
 feature.
 
@@ -432,7 +432,7 @@ This is a quick example of how to use kdb.
    ``ps``      Displays only the active processes
    ``ps A``    Shows all the processes
    ``summary`` Shows kernel version info and memory usage
-   ``bt``      Get a backtrace of the current process using :c:func:`dump_stack`
+   ``bt``      Get a backtrace of the current process using dump_stack()
    ``dmesg``   View the kernel syslog buffer
    ``go``      Continue the system
    =========== =================================================================
@@ -724,7 +724,7 @@ The kernel debugger is organized into a number of components:
    The arch-specific portion implements:
 
    -  contains an arch-specific trap catcher which invokes
-      :c:func:`kgdb_handle_exception` to start kgdb about doing its work
+      kgdb_handle_exception() to start kgdb about doing its work
 
    -  translation to and from gdb specific packet format to :c:type:`pt_regs`
 
@@ -769,7 +769,7 @@ The kernel debugger is organized into a number of components:
          config. Later run ``modprobe kdb_hello`` and the next time you
          enter the kdb shell, you can run the ``hello`` command.
 
-   -  The implementation for :c:func:`kdb_printf` which emits messages directly
+   -  The implementation for kdb_printf() which emits messages directly
       to I/O drivers, bypassing the kernel log.
 
    -  SW / HW breakpoint management for the kdb shell
@@ -875,7 +875,7 @@ kernel when ``CONFIG_KDB_KEYBOARD=y`` is set in the kernel configuration.
 The core polled keyboard driver driver for PS/2 type keyboards is in
 ``drivers/char/kdb_keyboard.c``. This driver is hooked into the debug core
 when kgdboc populates the callback in the array called
-:c:type:`kdb_poll_funcs[]`. The :c:func:`kdb_get_kbd_char` is the top-level
+:c:type:`kdb_poll_funcs[]`. The kdb_get_kbd_char() is the top-level
 function which polls hardware for single character input.
 
 kgdboc and kms
@@ -887,10 +887,10 @@ that you have a video driver which has a frame buffer console and atomic
 kernel mode setting support.
 
 Every time the kernel debugger is entered it calls
-:c:func:`kgdboc_pre_exp_handler` which in turn calls :c:func:`con_debug_enter`
+kgdboc_pre_exp_handler() which in turn calls con_debug_enter()
 in the virtual console layer. On resuming kernel execution, the kernel
-debugger calls :c:func:`kgdboc_post_exp_handler` which in turn calls
-:c:func:`con_debug_leave`.
+debugger calls kgdboc_post_exp_handler() which in turn calls
+con_debug_leave().
 
 Any video driver that wants to be compatible with the kernel debugger
 and the atomic kms callbacks must implement the ``mode_set_base_atomic``,
-- 
2.27.0

