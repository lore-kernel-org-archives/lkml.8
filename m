Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263BBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D4920771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNAgtHPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHNLjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D92C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so7223471wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hP0+g3hzGLFq3eU/85gRdetBqlzSS17WzsjFbG7aymI=;
        b=YNAgtHPgPcTyIvU9nrHfyMyqVccvoQTMBvdeTuPHp1b9h3ZZSMDFR7cSOe+EgNlXtz
         R5tLNN+iyGDSoQcjB2pIv1TZyH59dRy+ReMKoAD37n/8yrmVCWtQ9fYJwfP6o8KGR/LE
         BisBGc9F+TxM4dKoRQ7HkBRPXIGi70XueC71jd0qSlyMPrIFRPBpnfe9PwncMrta4s+j
         EeO42rEtWBCemy0X6YEGFn1MOXcHEAFm8mVBxbtVmBil/xthUX1BAfhGSBrsNRCQOqzZ
         bcYTtVADdhai+9fss/tsmD0v/GWElOF4QLAAxs5BSuFsTQfiDmmbp0kjp2YbEEH7pITm
         6MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hP0+g3hzGLFq3eU/85gRdetBqlzSS17WzsjFbG7aymI=;
        b=uYPmGYSC51S6zUzxHxUpfuycaO68RdYJ9Pf2uHkGmUTfmHbeqow9B9oiqxPIjARwYs
         HtGb9yRkDy1gzyDol56+KsXacdt+tC3nhP9+UPv7CGRGH/yDv0dZAMdtx5lNyxccXPFi
         picyyXmbgAZW1ciTbfuFPsNIV2uW6JuwlnM5mVBDsOAUMGHvdt5GY3KVnusng9x9HBdM
         D/rpQcoF3/29zwgJ126F7BbXQID/oeDdMH0C+AXUdt234qlzwmu3uPeo4Ctzz9OjB8Ed
         E0VkidPINWI7Hz9AuM6ca95Ly5kT+uynDVm0vqmIjJMcHXcAISRO+m97bTTFBNuO/BVr
         YbOg==
X-Gm-Message-State: AOAM530Ek10wuhjNugjiFYSr0pOgcVqPBcAmXFVt6tudZ99bruon2XK+
        aNCKUoIfd2V9dBt8Hzt+XWyoyg==
X-Google-Smtp-Source: ABdhPJxe1U/K+xwNSBB5x0F2H8VUberthodPixZrpd/rPCPotPKsvqPYIVe7VwNr6BusmC8/Kn8Zxw==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr2165855wma.5.1597405179660;
        Fri, 14 Aug 2020 04:39:39 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] Rid W=1 warnings in Networking
Date:   Fri, 14 Aug 2020 12:39:03 +0100
Message-Id: <20200814113933.1903438-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

There are quite a few W=1 warnings in the Networking code.  My
plan is to work through all of them over the next few weeks.
Hopefully it won't be too long before drivers/net builds clean
with W=1 enabled.

Lee Jones (30):
  net: bonding: bond_3ad: Fix a bunch of kerneldoc parameter issues
  net: bonding: bond_main: Document 'proto' and rename 'new_active'
    parameters
  net: ethernet: 3com: 3c574_cs: Remove set but unused variables 'tx'
    and 'rx'
  net: bonding: bond_alb: Describe
    alb_handle_addr_collision_on_attach()'s 'bond' and 'addr' params
  net: wireless: atmel: atmel: Demote non-kerneldoc header to standard
    comment block
  net: ethernet: 8390: axnet_cs: Document unused parameter 'txqueue'
  net: wireless: broadcom: b43: main: Add braces around empty statements
  net: wireless: ath: carl9170: Mark 'ar9170_qmap' as __maybe_unused
  net: wireless: ath: ath5k: pcu: Add a description for 'band' remove
    one for 'mode'
  net: wan: dlci: Remove set but not used variable 'err'
  net: wireless: cisco: airo: Place brackets around empty statement
  net: wireless: cisco: airo: Fix a myriad of coding style issues
  net: wireless: ath: wil6210: cfg80211: Demote non-kerneldoc headers to
    standard comment blocks
  net: wireless: intel: iwlegacy: common: Remove set but not used
    variable 'len'
  net: wireless: intel: iwlegacy: common: Demote kerneldoc headers to
    standard comment blocks
  net: wireless: intel: ipw2200: Remove set but unused variables 'rc'
    and 'w'
  net: wireless: broadcom: b43legacy: main: Provide braces around empty
    'if' body
  net: fddi: skfp: hwmtm: Remove seemingly unused variable 'ID_sccs'
  net: fddi: skfp: fplustm: Remove seemingly unused variable 'ID_sccs'
  net: wireless: ath: ath5k: base: Fix kerneldoc formatting issue
  net: fddi: skfp: smt: Place definition of 'smt_pdef' under same
    stipulations as its use
  net: wireless: broadcom: brcm80211: brcmfmac: fweh: Remove set but
    unused variable 'err'
  net: wireless: broadcom: brcm80211: brcmfmac: fweh: Fix docrot related
    function documentation issues
  net: wireless: broadcom: brcm80211: brcmsmac: mac80211_if: Demote a
    few non-conformant kerneldoc headers
  net: wireless: intel: ipw2x00: ipw2200: Demote lots of nonconformant
    kerneldoc comments
  net: wireless: broadcom: b43: phy_common: Demote non-conformant
    kerneldoc header
  net: fddi: skfp: smt: Remove seemingly unused variable 'ID_sccs'
  net: fddi: skfp: cfm: Remove set but unused variable 'oldstate'
  net: fddi: skfp: cfm: Remove seemingly unused variable 'ID_sccs'
  net: wireless: broadcom: b43: phy_n: Add empty braces around empty
    statements

 drivers/net/bonding/bond_3ad.c                |  15 +-
 drivers/net/bonding/bond_alb.c                |   4 +-
 drivers/net/bonding/bond_main.c               |   4 +-
 drivers/net/ethernet/3com/3c574_cs.c          |   6 +-
 drivers/net/ethernet/8390/axnet_cs.c          |   1 +
 drivers/net/fddi/skfp/cfm.c                   |  17 +-
 drivers/net/fddi/skfp/fplustm.c               |   4 -
 drivers/net/fddi/skfp/hwmtm.c                 |   4 -
 drivers/net/fddi/skfp/smt.c                   |   7 +-
 drivers/net/wan/dlci.c                        |   3 +-
 drivers/net/wireless/ath/ath5k/base.c         |   2 +-
 drivers/net/wireless/ath/ath5k/pcu.c          |   2 +-
 drivers/net/wireless/ath/carl9170/carl9170.h  |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   4 +-
 drivers/net/wireless/atmel/atmel.c            |   2 +-
 drivers/net/wireless/broadcom/b43/main.c      |   6 +-
 .../net/wireless/broadcom/b43/phy_common.c    |   2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c     |  19 +-
 .../net/wireless/broadcom/b43legacy/main.c    |   3 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |  13 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  11 +-
 drivers/net/wireless/cisco/airo.c             | 898 +++++++++---------
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  45 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  72 +-
 24 files changed, 582 insertions(+), 564 deletions(-)

-- 
2.25.1

