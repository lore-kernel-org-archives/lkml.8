Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FC82076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLoEnhny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgFAR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgFARzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:55:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9FC08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:55:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so3836986pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zACkuhg/77H3zeO+PGHNh+9yMlSwDDWi/x5X1ISMcog=;
        b=PLoEnhnypIxdDYglWjZWdbmVY9O/3d/FXn7/fOGLX1J0QDbcyq5yORuXvRPyf69GmH
         bPmuZpFDZjpxs3BNlZhAHlyAgGtEMEaGUOkeX2GeG6uWEGH6IiHYN5iv6fgkoia729ic
         ukbV9fvbH6EccxPGYp4IcT2N++qdipIqSfWyHPUiwWylioQAnUx6SmnS0U5wt9sn7I2r
         UgI/3DvCL6guNdStmxOeftLH3GgBU0iz+2AdiElVirEa8e3vyBspGCr1Bhs4voehcJiU
         uexyoOA9cpespFyQz8k1bf0tB1pWLksPQnbJGucIYnyTYj7SR+jT1oVyu66oYWuZi+iR
         NJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zACkuhg/77H3zeO+PGHNh+9yMlSwDDWi/x5X1ISMcog=;
        b=raJslVnIT1/V6Chu94/X2fRi1FA7bwX7wXTDC2P5z9SOez8IbK7Zo5y3vPnJvqcjmq
         2sQie47E+7hDtMEEraIsk2R2BS3CP1jal/6BIKaGQzrJIP5yeW+SaO3Erx/zuUMnIBNm
         PSfPqe9xfiQpcSbejTMuE+dV4sk0/hXrt5p+4i8I7q8FrWyNvHBNYrvfi18LOWCtTuic
         5y2KPMWW3PAb1qQKyZzxU9ZXbehu43YBTE5nR57DT5WmdNkLJtXbVOVKQFvEAxhTci7Q
         xWi6RGf+Mr8orp3/d37CmFTo57e0gBWuNygOJMEnnSyJNcqsK2qtZWf+NfY0zp5dLJKo
         cqBQ==
X-Gm-Message-State: AOAM5310ytODzyS58ZupuM14+7ZZihlNkr2Z3S/9TXPBinVpONIssYjS
        0L2NaNgKaAq0Yv0NCha0FUznIg==
X-Google-Smtp-Source: ABdhPJx7mm5a3eTp+VHkriv3BjsSxvd0F8RrxXaATmZINzJsX7X4HNjbdTel9tb4XVNDl4GzAM/86Q==
X-Received: by 2002:a62:1681:: with SMTP id 123mr20422249pfw.306.1591034154312;
        Mon, 01 Jun 2020 10:55:54 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:55:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/11] remoteproc: stm32: Add support for attaching to M4  
Date:   Mon,  1 Jun 2020 11:55:41 -0600
Message-Id: <20200601175552.22286-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set applies on top of [1] and refactors the STM32 platform code in
order to attach to the M4 remote processor when it has been started by the
boot loader.

It carries the same functionatlity as the previeous revision but account
for changes in the remoteproc core to support attaching scenarios.  More
specifically patches 6 to 10 should be given special consideration.

Note that I skipped over v3 and went directly to v4 in order to synchronise
with the remoterproc core patchset[1] that is set at v4.

Tested on ST's mp157c development board.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=296713

Mathieu Poirier (11):
  remoteproc: stm32: Decouple rproc from memory translation
  remoteproc: stm32: Request IRQ with platform device
  remoteproc: stm32: Decouple rproc from DT parsing
  remoteproc: stm32: Remove memory translation from DT parsing
  remoteproc: stm32: Parse syscon that will manage M4 synchronisation
  remoteproc: stm32: Properly set co-processor state when attaching
  remoteproc: Make function rproc_resource_cleanup() public
  remoteproc: stm32: Split function stm32_rproc_parse_fw()
  remoteproc: stm32: Properly handle the resource table when attaching
  remoteproc: stm32: Introduce new attach() operation
  remoteproc: stm32: Update M4 state in stm32_rproc_stop()

 drivers/remoteproc/remoteproc_core.c |   3 +-
 drivers/remoteproc/stm32_rproc.c     | 214 ++++++++++++++++++++++++---
 include/linux/remoteproc.h           |   1 +
 3 files changed, 198 insertions(+), 20 deletions(-)

-- 
2.20.1

