Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ACEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8D92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="rcLiuoZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2PH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:07:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192ECC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:07:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k4so11902814pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvGgX98SKjMQoRKZbI9936P9W5fZLljXNQDqIlMDpsY=;
        b=rcLiuoZqxJ6ISe9Emfs1RUJFobO4/R+4DnZzN1Ktn1g1L5KzsWiqjnvjGUUVZBeBeR
         n8sy3rlgfSBA7V7pyzH8RXWwEDxlqsEMdfE02ABJR/G7encbCkpolgT/sAxttxnQw9f0
         EKYgiwnWx2d54ochCwGuownPC34Gf9Um2pATE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvGgX98SKjMQoRKZbI9936P9W5fZLljXNQDqIlMDpsY=;
        b=rK12d71fK4FPYdWRVbesnp5eJ6UY74qenj0VB6bxEHSHqY1/LAGeZBIAOpvL6fFMnn
         UfJOt7bhU/ihcevIddV/HG+mwjJPmQNH9DHxWLTPD/V3pbxS6y37Y0p7JX0szs4UMbLU
         zkuz1U5yqXhIybC10VWQsr2cx4KNMkmmJsHD3e/9NHaNykQxf1k6cPf760OvIR6CKRkX
         nG6kUSyjw6cvYl+RBhhueRjnVMazxDol0V6AoQj3sNAt0b8xM5hZQFN/RZOYOVr6zPzZ
         MLQS5lxuBcAo0cKBXCDLPwEUhxzlcejInW0bFnIh9QeIW0vVzsIZiyp+SNBFDKT5GKPG
         fQMQ==
X-Gm-Message-State: AOAM532ILXPQMepgDwcaYC+YRDSqEvElKtxO8EFaSgbbj/6+0CA4/w/0
        0RrjK1t0WTxrTHWGTyQ1oG18sg==
X-Google-Smtp-Source: ABdhPJzSeksyXN2A1Ak2k+FQwIE0da2EnOih733fal/WJcLqupC20z8nSS4eICxDAH2EP3M+uMqFjQ==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr6301433plj.227.1596035276186;
        Wed, 29 Jul 2020 08:07:56 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id q11sm2688058pgr.69.2020.07.29.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:07:55 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: Fix compatible string for pmsleep
Date:   Thu, 30 Jul 2020 00:07:45 +0900
Message-Id: <20200729150748.1945589-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes up the compatible string for the pmsleep register
region based on Arnd and Rob's feedback:

- Add "mstar,msc313-pmsleep" to mfd/syscon.yaml
- Remove the unneeded binding description for "mstar,pmsleep"
- Use the new string in the MStar v7 base dtsi

Daniel Palmer (3):
  dt-bindings: mfd: syscon: add compatible string for
    mstar,msc313-pmsleep
  dt-bindings: arm: mstar: remove the binding description for
    mstar,pmsleep
  ARM: mstar: Correct the compatible string for pmsleep

 .../bindings/arm/mstar/mstar,pmsleep.yaml     | 43 -------------------
 .../devicetree/bindings/mfd/syscon.yaml       |  1 +
 arch/arm/boot/dts/mstar-v7.dtsi               |  2 +-
 3 files changed, 2 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml

-- 
2.27.0

