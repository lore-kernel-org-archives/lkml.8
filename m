Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758C5C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4288C2076E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVIRgwnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgCUWTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:19:53 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:54052 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:19:53 -0400
Received: by mail-pj1-f45.google.com with SMTP id l36so4210307pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dcdv1o2OE9Dbud7mtcZE4La5oxeElzOfy/RpqBkNU70=;
        b=hVIRgwnpxdr69DeKdBTp+lmem0I+J1Srk0P5SlKdjskRkccRYyn8T7kWO43uveerfa
         /WlC//EaoG9P0xkUdAwMo1JOIcLFg3lZyM+OGAt06kQ2yF/kOlQHem+JTJzu2WEi45FV
         XqSUPnIvP/rAarBMKEySjJeyj9N6nShXt8DnGBpxbPED23J8HkBTgJaO85TlIyPlYzZn
         fllkCvtu3NwYUWgz0murvQmzEsdLr5peCBPXACC/ntu7On6jLl48TbtGjSnr8okcm8Iw
         gHxcR4NPlgVlcmLLMovEnYoYI32eQm4N07BMhtlmNqmJ5WQOTKDKYbgJpqyt3YMBeEDs
         xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dcdv1o2OE9Dbud7mtcZE4La5oxeElzOfy/RpqBkNU70=;
        b=pAHFVOU6IScOQCf/F4t53ILhnLcXzrJIjWcNHGsRqknDnE4VldjLyKCxHyaGNPSQ0s
         Egbdo5jWVaHfk3djMqrLzPV3BphGY8YfRsP9FTZG2rGS4H5KL6YH7m9q5OFbXiMP/BGz
         bgxV7f3Hs4J9uaoLHwM2BN0lJ/8hsyIg9mSHHOfU6OJB4j+ntQY3wMoP/++yFns5kpiw
         JmlNKXIBE2YFxKVunOsPEEJwFFaa5+B4ocNN0nk8Ne19Z9h4vuHBUJqtH+Er++JoRe3H
         PYWFiOkGEVyRhIPXpUGgffbKyVebkvFWMC9kT2NWA/2CecWtkm3b3cNgGE5nkNa3HNO2
         h/Kw==
X-Gm-Message-State: ANhLgQ08aw1KTX2kR3R6w2U118PTHuceOK+4i9yBjeeYXjkMw44YiwD2
        /+cBgWcBO5aOmNOWikMExdw=
X-Google-Smtp-Source: ADFU+vuGPpk2Oxq+TQ4+Lj0h3nCJ6Fdi7q+CLewZzExJF1znZyHMmVwkSjIPJmHvHmfMENT1DC2hVA==
X-Received: by 2002:a17:90a:cc01:: with SMTP id b1mr10480287pju.121.1584829191777;
        Sat, 21 Mar 2020 15:19:51 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id k24sm8227389pgf.59.2020.03.21.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:19:51 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 00/11] Staging: rtl8188eu: hal: Add space around operators
Date:   Sun, 22 Mar 2020 03:49:43 +0530
Message-Id: <cover.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds space around operators and removes
all the checkpatch warnings for the same from the files
present under drivers/staging/rtl8188eu/hal/ directory.

Shreeya Patel (11):
  Staging: rtl8188eu: hal_com: Add space around operators
  Staging: rtl8188eu: odm: Add space around operators
  Staging: rtl8188eu: odm_hwconfig: Add space around operators
  Staging: rtl8188eu: phy: Add space around operators
  Staging: rtl8188eu: pwrseqcmd: Add space around operators
  Staging: rtl8188eu: rf: Add space around operators
  Staging: rtl8188eu: rf_cfg: Add space around operators
  Staging: rtl8188eu: rtl8188e_cmd: Add space around operators
  Staging: rtl8188eu: rtl8188e_hal_init: Add space around operators
  Staging: rtl8188eu: rtl8188e_rxdesc: Add space around operators
  Staging: rtl8188eu: rtl8188eu_xmit: Add space around operators

 drivers/staging/rtl8188eu/hal/hal_com.c       |  22 +--
 drivers/staging/rtl8188eu/hal/odm.c           |  48 +++---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c  |  54 +++----
 drivers/staging/rtl8188eu/hal/phy.c           | 138 +++++++++---------
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c     |   2 +-
 drivers/staging/rtl8188eu/hal/rf.c            |  60 ++++----
 drivers/staging/rtl8188eu/hal/rf_cfg.c        |   4 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |  42 +++---
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c |  44 +++---
 .../staging/rtl8188eu/hal/rtl8188e_rxdesc.c   |   2 +-
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |  32 ++--
 11 files changed, 224 insertions(+), 224 deletions(-)

-- 
2.17.1

