Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1103C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC792080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9Rcs/9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFZNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFZNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989AC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so9317395wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDWWkLHYhi+NWHPmZmzTxoNvoolmaRA4XjsE7nwPw44=;
        b=d9Rcs/9lcPCklazFfNFa3V9ubb/OajIYDfizHeet7iBOFNCtcdNXB3PIIUcpnIya+B
         aI5PwETaCxiueQ3yzd6IKCQ9kwVmz9/IgQcEjRMx5SBKltPJw8E+isSESUm5ebq2/WA5
         aVexDFPHnE8TL2WsEQ43aPgYP3xf3Y0n6jPfyD7FvdzPFtY3uniiuS9OEVzQi1dqkLBO
         0ecC2umzH+fezz6JvxDk+IMmf65lDY5z08dzxm8+lJm4pIEMWJkwDARPprNf+fzJoree
         MoFVqpiL6z3LEes6QK6PvSwNeU5WuuF/UaHVyWQq+3vbgtTHXjBP2k1oqu/mDAwkSRYN
         WiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDWWkLHYhi+NWHPmZmzTxoNvoolmaRA4XjsE7nwPw44=;
        b=Ov5ej5yYIKrHRdA3/a8tYtkr3gXBzDlykOJMNMN02yk/jz1I4Fpj8uFUZ/vvgz4aA6
         69ALRYHCII13o/cajy2ZHSrpVJLNNitVRzJgOmJMeAxAtO+5NBKIYF1GYWASAjZBV27C
         Fg76t5C/hlvPgp8R11VPIAQja1EZu40a411iM50eqpjdacJ3DVyedbWEB3HvXThqVkgX
         JJn6XuNbnW2KxJuT03qU/VN/mJfhbSGsw1r6x8tQsSxuZ0aq0Mya82uhfOLe1vpoEMu+
         M6McVIOM6BNAuHzI4qtuopSXf2UxSAxfqlUQOVSb+CZQWxZNY+yKzxv+rD/b1YPTa4q5
         zPxg==
X-Gm-Message-State: AOAM5324PAZyp/6ktSrA6xtaFT7iQVKXRMsqtclGUiSBMCGjlYy17EIp
        2gafBpWvQwGec4pbmvTb+Ku5+PKIMt0=
X-Google-Smtp-Source: ABdhPJyE6IRdC/LqHbaYWP7MgAgO6i5Haxrz3B9CliCiUkfcYT0gij1SYLk8PhIBPbkzOiFJQt6ehg==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr3547819wmc.185.1593176728628;
        Fri, 26 Jun 2020 06:05:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/10] Fix a bunch of W=1 warnings in Misc
Date:   Fri, 26 Jun 2020 14:05:15 +0100
Message-Id: <20200626130525.389469-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (10):
  misc: c2port: core: Ensure source size does not equal destination size
    in strncpy()
  misc: ti-st: st_core: Tidy-up bespoke commentry
  misc: ti-st: st_kim: Tidy-up bespoke commentry
  misc: lkdtm: bugs: At least try to use popuated variable
  misc: lkdtm: Always provide prototype for lkdtm_DOUBLE_FAULT()
  misc: eeprom: eeprom_93cx6: Repair function arg descriptions
  misc: mic: vop: vop_main: Remove set but unused variable 'ret'
  misc: cb710: sgbuf2: Add missing documentation for
    cb710_sg_dwiter_write_next_block()'s 'data' arg
  misc: habanalabs: irq: Add missing struct identifier for 'struct
    hl_eqe_work'
  misc: pti: Fix documentation for bit-rotted function
    pti_tty_driver_write()

 drivers/misc/c2port/core.c         |  2 +-
 drivers/misc/cb710/sgbuf2.c        |  1 +
 drivers/misc/eeprom/eeprom_93cx6.c |  4 +-
 drivers/misc/habanalabs/irq.c      |  3 +-
 drivers/misc/lkdtm/bugs.c          |  4 +-
 drivers/misc/lkdtm/lkdtm.h         |  2 -
 drivers/misc/mic/vop/vop_main.c    |  3 +-
 drivers/misc/pti.c                 |  5 +-
 drivers/misc/ti-st/st_core.c       | 79 ++++++++++++++++++------------
 drivers/misc/ti-st/st_kim.c        | 71 +++++++++++++++++----------
 10 files changed, 104 insertions(+), 70 deletions(-)

-- 
2.25.1

