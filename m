Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CFCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2044D207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZbyBUTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHQIKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:09:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605AAC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:09:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so7116189plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EojiRZ5+4e1OiKZvQRD8rgmqPXQOnvlyW/BPDKlZsTU=;
        b=cZbyBUTiXCBC9eNlYLxDdYHv38L/LCNlTa5Isf7D//qmjXpcpY68wjeZoLSVgkGSXc
         DJjY2i2Hw8Tg66vPO15GMNfMyWxHhg0W7UrFs3E87jglSZYLT6XH/Dj/5tgqXB7YnWG2
         yE0I9pl53Hi4OSgCPn5ZZTd5bdkkR7/FJpM6nUpuKGglowi+kte1Cy3u9nJn77prwhH/
         WAkg4pW4CxjK+vAn+OqtW+p4FwkCmLTRS8E8sfEDtIWLAnxK1mmDcrMvLmZXCe1lzd4g
         a8zmcrDPfQ/na4G10ngvmmArdlR9bWvCT6Bi51Tud7922+yCZATbQ/fO2P4FQTehqOgP
         yCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EojiRZ5+4e1OiKZvQRD8rgmqPXQOnvlyW/BPDKlZsTU=;
        b=eE9rq9yyD0w6aZZNM8ptpNpquEOkPUhH8GS8Ot/DsW97DxKJTkKae/9ZV+yrwOv7ls
         CD7UQC4hIS6rfr9diPliV0qbenRY/+yEkBURLlaw/DVPIHdIgTD9h0ZRyrajBPR6YGab
         +0CJQyXjnPiBybX/sE+QujNiZGCbaRyxG+lDMycgKAtwRWu9yM+bZ/WxDYoqdxvs+WW9
         PfFv7dk+/Si1bH5deu8ezppNxvJ+ytluPZbeltS/JmXEPS8tBOaBMAPRM9tbKJDWYmOF
         3Hzvp1q39ta3QDbp/hw6320ccE/P3reMnvi/8e45K/Ob2AZ8vDIxWDFmcWzOgujo95D8
         xARg==
X-Gm-Message-State: AOAM530gIlI/SWxVoO2Z0IS3ty/e7tCP5ElJPrnYjcNQzcW+AWeezVHC
        f/cvhO5OJRsIlU2HQ7XG6Z0=
X-Google-Smtp-Source: ABdhPJzb1eOL7XxY4hQRviqeJAVUmK7Vet9UOM7DsTcG5epb+w06wW64GaVl1K39Y0V+l8Gzgdh6lw==
X-Received: by 2002:a17:90a:cc14:: with SMTP id b20mr11136070pju.1.1597651798829;
        Mon, 17 Aug 2020 01:09:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:09:58 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 00/19] crypto: convert tasklets to use new tasklet_setup()
Date:   Mon, 17 Aug 2020 13:39:22 +0530
Message-Id: <20200817080941.19227-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the crypto modules to use the new tasklet_setup() API


Allen Pais (19):
  crypto: amcc: convert tasklets to use new tasklet_setup() API
  crypto: atmel: convert tasklets to use new tasklet_setup() API
  crypto: axis: convert tasklets to use new tasklet_setup() API
  crypto: caam: convert tasklets to use new tasklet_setup() API
  crypto: cavium: convert tasklets to use new tasklet_setup() API
  crypto: ccp: convert tasklets to use new tasklet_setup() API
  crypto: ccree: convert tasklets to use new tasklet_setup() API
  crypto: hifn_795x: convert tasklets to use new tasklet_setup() API
  crypto: img-hash: convert tasklets to use new tasklet_setup() API
  crypto: ixp4xx: convert tasklets to use new tasklet_setup() API
  crypto: mediatek: convert tasklets to use new tasklet_setup() API
  crypto: omap: convert tasklets to use new tasklet_setup() API
  crypto: picoxcell: convert tasklets to use new tasklet_setup() API
  crypto: qat: convert tasklets to use new tasklet_setup() API
  crypto: qce: convert tasklets to use new tasklet_setup() API
  crypto: rockchip: convert tasklets to use new tasklet_setup() API
  crypto: s5p: convert tasklets to use new tasklet_setup() API
  crypto: talitos: convert tasklets to use new tasklet_setup() API
  crypto: octeontx: convert tasklets to use new tasklet_setup() API

 drivers/crypto/amcc/crypto4xx_core.c          |  7 ++--
 drivers/crypto/atmel-aes.c                    | 14 +++----
 drivers/crypto/atmel-sha.c                    | 14 +++----
 drivers/crypto/atmel-tdes.c                   | 14 +++----
 drivers/crypto/axis/artpec6_crypto.c          |  7 ++--
 drivers/crypto/caam/jr.c                      |  7 ++--
 drivers/crypto/cavium/cpt/cptvf_main.c        |  9 ++--
 drivers/crypto/cavium/nitrox/nitrox_common.h  |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.c     | 13 +++---
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c  |  4 +-
 drivers/crypto/ccp/ccp-dev-v3.c               |  9 ++--
 drivers/crypto/ccp/ccp-dev-v5.c               |  9 ++--
 drivers/crypto/ccp/ccp-dmaengine.c            |  7 ++--
 drivers/crypto/ccree/cc_fips.c                |  6 +--
 drivers/crypto/ccree/cc_request_mgr.c         | 12 +++---
 drivers/crypto/hifn_795x.c                    |  6 +--
 drivers/crypto/img-hash.c                     | 12 +++---
 drivers/crypto/ixp4xx_crypto.c                |  4 +-
 .../crypto/marvell/octeontx/otx_cptvf_main.c  | 12 +++---
 drivers/crypto/mediatek/mtk-aes.c             | 14 +++----
 drivers/crypto/mediatek/mtk-sha.c             | 14 +++----
 drivers/crypto/omap-aes.c                     |  6 +--
 drivers/crypto/omap-des.c                     |  6 +--
 drivers/crypto/omap-sham.c                    |  6 +--
 drivers/crypto/picoxcell_crypto.c             |  7 ++--
 drivers/crypto/qat/qat_common/adf_isr.c       |  5 +--
 drivers/crypto/qat/qat_common/adf_sriov.c     | 10 ++---
 drivers/crypto/qat/qat_common/adf_transport.c |  4 +-
 .../qat/qat_common/adf_transport_internal.h   |  2 +-
 drivers/crypto/qat/qat_common/adf_vf_isr.c    | 11 +++--
 drivers/crypto/qce/core.c                     |  7 ++--
 drivers/crypto/rockchip/rk3288_crypto.c       | 14 +++----
 drivers/crypto/s5p-sss.c                      | 13 +++---
 drivers/crypto/talitos.c                      | 42 +++++++++----------
 34 files changed, 149 insertions(+), 180 deletions(-)

-- 
2.17.1

