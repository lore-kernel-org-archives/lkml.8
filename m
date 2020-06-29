Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B83C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A86204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxupq2wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgF2Sym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DACC02E2C8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so16252078wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4QVWBt78fjc/zXuQ5WSrvh+bVzw9oMxw1mvQFTNt5A=;
        b=qxupq2wL0vtzmROyM6U/2Nn/WQWmm2e6F12+dsmst5VVlWuoK6gtTr3MIXepH5bo7N
         Si7Pq+RVqNpQiFxQ2RbG+oCRPYq/cAsadGi/Cx5C0m2OH32nEKmkCgw6kIWLdzlkO8sz
         eASMM3fslN2LgCjhj34gtUu9hg9uPAn/UhPI1o2umQb7efYohrsJs3Mvj+Q1zve0pRm5
         nICui8Id6ipARNed0tcwgPy8yFVwW04/m0h4bIMwEzATPNfgcaOKdekX6DREKRSEIaEU
         bQMqCj8IctrGk5rNU1bbS38PhOQyP25s7K4pFFZrVVRLaG0eRTvOwK2WSKw+NvLReQYV
         0e0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4QVWBt78fjc/zXuQ5WSrvh+bVzw9oMxw1mvQFTNt5A=;
        b=M9MMF48gSWtMVUTkCkokMe/J/eVM/KehtXdpLLfco3n6DHmCYlFEZcuTCorgHh8zSv
         5NCGkHD6+PqI96GaBlxA42aON39P/Kz1/Uz8HYCrTa2jJFaUFl8hQ6TLhBp4/ohoLOwI
         poo71qwdaSNJt6gUOMkb/K3I5vvaZtbHLZfPzw5QgHq1i8HpvkuwxdIbhdn2kclHcRW8
         B5u0fN4rsCvYrPVg0GRMcqc+qjZPMNfQEQe5cSg4OrD6TNULmCdgJERmSf7wHD57W56K
         0qwN3l7Es6oKgIVUclVO6xFaYHsLC2eJbJa411flvm93zXkc141Pqmp0DCxIxaMT6X2x
         yaww==
X-Gm-Message-State: AOAM530jqQf/1ZEOWo6FAH/433nL0MbIXZTFTYo+bOItDVLULdM0LD3Y
        hGy1bboO2nWsEFny/qQv09T3Kw==
X-Google-Smtp-Source: ABdhPJyp48RXpvoyDA2gEGM2KF9GnBJlHMy5DHzF0QNr7HDDu6Tv7Xsp8Ip73vOozav0VKOAuIk7HA==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr15916307wme.45.1593439486087;
        Mon, 29 Jun 2020 07:04:46 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/20] Fix a bunch more W=1 warnings in Misc
Date:   Mon, 29 Jun 2020 15:04:22 +0100
Message-Id: <20200629140442.1043957-1-lee.jones@linaro.org>
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

Lee Jones (20):
  misc: pti: Repair kerneldoc formatting issues
  misc: pti: Remove unparsable empty line in function header
  misc: habanalabs: firmware_if: Add missing 'fw_name' and 'dst' entries
    to function header
  misc: habanalabs: pci: Fix a variety of kerneldoc issues
  misc: habanalabs: irq: Repair kerneldoc formatting issues
  misc: habanalabs: goya: Omit pointless check ensuring addr is >=0
  misc: habanalabs: pci: Scrub documentation for non-present function
    argument
  misc: habanalabs: goya: goya_coresight: Remove set but unused variable
    'val'
  misc: habanalabs: gaudi: Remove ill placed asterisk from kerneldoc
    header
  misc: habanalabs: gaudi: gaudi_security: Repair incorrectly named
    function arg
  misc: enclosure: Fix some kerneldoc anomalies
  misc: lattice-ecp3-config: Remove set but clearly unused variable
    'ret'
  misc: pch_phub: Provide descriptions for 'chip' argument
  misc: pch_phub: Remove superfluous descriptions to non-existent args
    'offset_address'
  misc: enclosure: Update enclosure_remove_device() documentation to
    match reality
  misc: genwqe: card_base: Remove set but unused variable 'rc'
  misc: genwqe: card_base: Do not	pass unused argument 'fatal_err'
  misc: genwqe: card_base: Whole host of kerneldoc fixes
  misc: genwqe: card_dev: Whole host of kerneldoc fixes
  misc: genwqe: card_utils: Whole a plethora of documentation issues

 drivers/misc/enclosure.c                      |  8 ++--
 drivers/misc/genwqe/card_base.c               | 46 ++++++++++---------
 drivers/misc/genwqe/card_dev.c                | 24 +++++++---
 drivers/misc/genwqe/card_utils.c              | 30 ++++++++++--
 drivers/misc/habanalabs/firmware_if.c         |  3 ++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +-
 .../misc/habanalabs/gaudi/gaudi_security.c    |  3 +-
 drivers/misc/habanalabs/goya/goya.c           | 16 +++----
 drivers/misc/habanalabs/goya/goya_coresight.c |  3 +-
 drivers/misc/habanalabs/irq.c                 | 22 ++++-----
 drivers/misc/habanalabs/pci.c                 | 13 ++++--
 drivers/misc/lattice-ecp3-config.c            | 19 ++++----
 drivers/misc/pch_phub.c                       |  9 +++-
 drivers/misc/pti.c                            | 11 ++---
 14 files changed, 126 insertions(+), 83 deletions(-)

-- 
2.25.1

