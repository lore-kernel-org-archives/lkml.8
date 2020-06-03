Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32722C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3720679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZkL/mXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCHWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:22:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E5FC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t7so1176835pgt.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sFHwcYSPIAh2Jj0qa/cpOPKVZENd3AGMzBBQqYwi8fI=;
        b=qZkL/mXJwIrnssnR3nwvS3ogWwJlwkBYYLFqCM55iFXgsyN7HTcPXZUnnPva+TApSP
         bA7x95Rvwp4TX/juPI2tBvWmKu5YF3jxWj/gSA58Lr7mHnqWVYVdNgJhn6nE3o8Ecfwr
         npProNTKjX/dsjTkgGDDvqTHTqoyhLRBIErCIUSRLB2werNOi08K4tcchexeQ8f1471y
         f1YNmAy/Rio8g/eW0AJCxZUvtyW3fCbR2hPzNOI6klOs66EInWZMwShTRclGqgqOGLg8
         Mh3WWS0EMOYFeTVkywYELtS4khgEN4MsB/rWhXIR/pt5DjaG3AD/7ke852VtjS41H0fb
         aZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFHwcYSPIAh2Jj0qa/cpOPKVZENd3AGMzBBQqYwi8fI=;
        b=tkKvX/Gd8ZM48nCSkUjj9Qii3nd9gvIvqIMojjq4FoNvW2cQbYk01Mw1Iw9YB2Zmuk
         BkvtfuHr66N3LhUMAnYFFB3jK2am9SBtyBfTEaYDRAnGZNR78fixOBtilOTxYrVjlgg/
         rxBW/uFcFCOs1+4XKT0cS3aCejZKDDRsHg+nq+eH3V5HkccMg7P516pAenVdoSLt5XE/
         4MYQgg2ohjwrUQ4bjtnyMFQl7noqg2mtW6xfKTFo6TC4i6ux9DnOkbwaPntm2ASo9UgQ
         B+On1iTVUbz/sgx5+DSdND/Ua4VR13vxbwA2knuWH4feJBmbH0sf9fx4fJEKnTrrqcIu
         YXqg==
X-Gm-Message-State: AOAM530w/p67ics+B6iN22TilqBRiW+19CjKXBfPa++9KdoA3WzmqXzp
        0Ay3wWsrM/NCiuqo1ShnHaVA3g==
X-Google-Smtp-Source: ABdhPJzYrtSuBzWBxQeHuhyPGoIWSMJmm2YZ33qvTuLmq1Kfeq7Iqz/43WDaMW+sx+et84376Qck9g==
X-Received: by 2002:a63:4c1f:: with SMTP id z31mr26862932pga.143.1591168954526;
        Wed, 03 Jun 2020 00:22:34 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id j17sm1407272pjy.22.2020.06.03.00.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/4] kdb: Improve console handling
Date:   Wed,  3 Jun 2020 12:52:11 +0530
Message-Id: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
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

Changes in v5:
- Rebased on top of tags/kgdb-5.8-rc1.
- Get rid of kdb_io_write().
- Fixed issue reported by kbuild test robot.
- Remove is_console from kgdboc_earlycon_io_ops as well.
- Misc. comments.
- Added Doug's review tag.

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
 drivers/tty/serial/kgdboc.c   |  6 ++--
 drivers/usb/early/ehci-dbgp.c |  3 +-
 include/linux/kgdb.h          |  5 ++-
 kernel/debug/kdb/kdb_io.c     | 72 ++++++++++++++++++++++++++-----------------
 5 files changed, 51 insertions(+), 37 deletions(-)

-- 
2.7.4

