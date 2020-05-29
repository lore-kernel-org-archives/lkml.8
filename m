Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634A12074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq040eb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgE2L1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2L1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:27:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8BC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f21so1352621pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x3d4hVCjjVp2AvYrfQexVhqf97WQTWR6EO5yWpa4vpw=;
        b=Rq040eb8C4b2UxywVlI6/jO3R/CgcFFExt5NFZ64qhrUzY7GO2Et+A8WhUXnPhqTVp
         8Jhpplvkks9SV0f03ucleVTqvKvawIgRXjMfvl86+sr4bc5HZQUuc9LstDvkEA8ps4Sx
         V4ZR+1RMHvZSWSLhQSDxDFm+daleqV2OSSq918hJnCmgcEuQV2Hc6m7CJVg8uWetsI7b
         WeyIICuHwIR0LqQBjpPInzls4+NDEjXaRpOkWxaSzgf+FTE/B2JsLWX3MLlhVjj+J5A6
         atYJVS/9+ZRdI5XRsO2jfXAO+1GFdjs2UlZQfN8TPsdoum7NZJN2DHghiPlel/3Qb50y
         jYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x3d4hVCjjVp2AvYrfQexVhqf97WQTWR6EO5yWpa4vpw=;
        b=rd+AFxACgDNsls226asad0La70L043UzXBM0ifeXlBMJAkZe58LlSAniv457PLSxmI
         RM7r0dMzTE/5sY1IEa58QxiMOiIAOye9HlYgV4aqn/uCR1pzb4eutE0+t0qBGrA2rnRu
         Kx7y8Iey1NNoggAKX2TC/loKAewKB25XZxq6irZfPX9wKqPz0tlGktZanYpxjXZ3C9li
         bwmE4qFP9mPYIhDmeB3chQ6mkqShSRIe830l3q8MhZTI37rnJENuL3BMkGGj5XkyRSWT
         RpkVEKWthy43zPu1iKJ8FHtH+sPYYz8+bH5gBMWI3ZMSGoa+xfYV6Knwuwb8cgMUtGiH
         HRYg==
X-Gm-Message-State: AOAM5304CiBgC/uacmDyNZ0sfjq6y96RgbPjRAH8K8QY6a6f4irizHYY
        4pV+HTwdOpqyuxvbbH3hk3bdUw==
X-Google-Smtp-Source: ABdhPJy19feXmap0+eOpojGz3t6vUt0qopVefyZXmXVZebcX+FlcE+cEWxrVBK1pU5+KTGOoJwS8ZA==
X-Received: by 2002:a63:5f11:: with SMTP id t17mr7604547pgb.177.1590751637544;
        Fri, 29 May 2020 04:27:17 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id w190sm7016741pfw.35.2020.05.29.04.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:27:16 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/4] kdb: Improve console handling
Date:   Fri, 29 May 2020 16:56:43 +0530
Message-Id: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is aimed to improve console handling especially when kdb
operates in NMI context.

Brief description of enhancements:
- Add status check for console prior to invoking corresponding handler.
- Fixup to avoid possible deadlock in NMI context due to usage of locks
  in the console handlers.
- Prefer usage of polling I/O driver mode (lockless APIs) over invocation
  of console handlers.

Changes in v4:
- Use dbg_io_ops->write_char() directly instead of passing it as a
  function pointer.
- Use "struct console" rather than "struct tty_driver" for comparison.
- Make commit descriptions and comments more informative.
- Add review tag for patch #2.

Changes in v3:
- Split patch to have separate patch for console status check.
- New patch to re-factor kdb message emit code.
- New patch to prefer polling I/O over console mode.
- Add code comments to describe usage of oops_in_progress.

Changes in v2:
- Use oops_in_progress directly instead of bust_spinlocks().

Sumit Garg (4):
  kdb: Re-factor kdb_printf() message write code
  kdb: Check status of console prior to invoking handlers
  kdb: Make kdb_printf() console handling more robust
  kdb: Switch to use safer dbg_io_ops over console APIs

 drivers/tty/serial/kgdb_nmi.c |  2 +-
 drivers/tty/serial/kgdboc.c   |  4 +--
 drivers/usb/early/ehci-dbgp.c |  3 +-
 include/linux/kgdb.h          |  5 ++-
 kernel/debug/kdb/kdb_io.c     | 76 ++++++++++++++++++++++++++-----------------
 5 files changed, 54 insertions(+), 36 deletions(-)

-- 
2.7.4

