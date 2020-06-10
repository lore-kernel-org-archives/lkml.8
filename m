Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEC620656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8JQPbsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgFJTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFJTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:53:48 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF585C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:53:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p20so3673533iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7/TXfQZ+QnJiUEUdXBEq+AyXg2ISr3BLixo9khgkNk=;
        b=h8JQPbsbyoHWB2WjYedvvxIu3PJTMuBU2jVyhL4S1VpuhuiyVsHrVa+hkbVVJ2dkCb
         84dUHwmLQ7+Lm2npW9DNjosCPg+h/syEzBmIA3pbXy478Oes03vPm3ylkhvG+vxjTcU2
         Z9sNOJzhP+FHSyndzewU/AhVy0+EnPnO709/Dvk80GSuCZdXaf/VkP8mmt991AKEpCP/
         vlfNJTjQqqzB8ORXCbHgSPN/kwXoP/KqGvvs9rh0IgRgh0TOdiFGujNE15my9X06/PV6
         Z1ZLCpAWbGKLtQweD4e29VFcQQOssH1S2gLtEITECZrkCyu7yQUPmleWbWbql01VahXK
         y0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7/TXfQZ+QnJiUEUdXBEq+AyXg2ISr3BLixo9khgkNk=;
        b=D0TE6HlglO3vkEYFOg6CAqNhV5sHzw8fkFoRUthrK8tQ7EMn2qDccWkvEwPpG8W5iQ
         ZcxOjCWewj9Fn+g0pH0E99v3eqIz0Jev7kC+6W4IDfI+3rqBYraj5V9vwCyOQIxRlLQp
         6gZvmITn7pAGh0ROhF/uumQuohaB78JaNUE6Q73E1FaQVZU3S5Fj/6khG7oRphwlWe+u
         8fBFkI28+0ZxwwefC06XjkSjZeSFkUXxA17zB3UZBX7kiB8hoN+OVBw0AGY72cpLNkIO
         IbaOp/C1vhlG+/fAdchSOFjMeZJawHheoYl4uytol3/feBAt/aMCz4Lyqv/lNjkg7QAu
         yIwg==
X-Gm-Message-State: AOAM5310VCHIrnvECMLHGCGuBUwxw4shV46Ui7q9l//zbS8H8gXulco9
        HicuDCsU12YFiRfqRe1Fc7+L5w==
X-Google-Smtp-Source: ABdhPJy6JWIFDBX/oG+bShtNLcHYuInCmW4DpTZXDTg/DHaZKUZGnJyPYPT79FJPZnUuQHFZQogh7A==
X-Received: by 2002:a5e:dd0a:: with SMTP id t10mr5148449iop.9.1591818827078;
        Wed, 10 Jun 2020 12:53:47 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r10sm408828ile.36.2020.06.10.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:53:46 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] net: ipa: endpoint configuration fixes
Date:   Wed, 10 Jun 2020 14:53:27 -0500
Message-Id: <20200610195332.2612233-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes four bugs in the configuration of IPA endpoints.
See the description of each for more information.  The last patch
changes a BUILD_BUG_ON() call into a runtime warning, because
violating the checked condition does not consitute a real bug.

					-Alex

Alex Elder (5):
  net: ipa: program metadata mask differently
  net: ipa: fix modem LAN RX endpoint id
  net: ipa: program upper nibbles of sequencer type
  net: ipa: header pad field only valid for AP->modem endpoint
  net: ipa: warn if gsi_trans structure is too big

 drivers/net/ipa/ipa_data-sc7180.c |  2 +-
 drivers/net/ipa/ipa_endpoint.c    | 97 ++++++++++++++++++-------------
 drivers/net/ipa/ipa_main.c        |  7 ++-
 drivers/net/ipa/ipa_reg.h         |  2 +
 4 files changed, 65 insertions(+), 43 deletions(-)

-- 
2.25.1

