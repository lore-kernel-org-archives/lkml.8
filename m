Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771CC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB03206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVQbrFjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbgGVKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB6C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so1288304wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ro6SNV9RoLRZMwUVnPvL5fbb9jQlUACUXGTf1bZXpQ=;
        b=IVQbrFjmMPwQ3h5jlriZWZjn/t4s8IS47nt9oPYCNA7d8/P4yefnm68rB+i0rLAbz2
         4cAkVu95G+LE3negDmxTA08pNB29gCqZA/Fa3TBADmWp0wp+vbNFktXiMWUypwIjtLp+
         sp5K8qLvl+8QiRJiHUW5ktW3Zp74z3wKiuL3z7qoCugIQZhzkyNLPOeNlS1Itigh9XNR
         vSPlKRWym5jlsLgYfg7eaykTP8At26NZL5tzjZJ/xD++LQYfpAc/Bm3ywxGdOxPIN1qn
         06mGX2vwxE3QSzYMRWz42FM7YAsVRgGPNTELjCHl7qXnr1LmSMDBGnffYlvmdSS4molR
         6Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ro6SNV9RoLRZMwUVnPvL5fbb9jQlUACUXGTf1bZXpQ=;
        b=WL1tZ5UM4SYCrK9E9gD1vN0v6UR+zyinHFE2pMqxtRglixGWmud4ZVafIYxqwNbEag
         AYndDaySFeqXLBPCCB3z+e9C36NFE6GyuGm7kzEFXvfjCW1cEUmyjdrVpkNXfDU+DSD4
         /j8UWCXL92kssyCqYlGQgc4SGMHTq2Faz1wjHmCj3Lado+GOQd8xhfC2tOGP7pS0oJpo
         Vmdd6V8otyzzUUp/l/VAPQkRKcQo/t7X5T2nROQ5wUAKV0cLP7VQ0HAF5kSxUq0H6rP8
         vGznVmhLcXIBpT4sUZvq/kDqwDTB6IOlQba0MlI/71Sm4ASKh0NXFu35XnRAJlmnHOpm
         xzVQ==
X-Gm-Message-State: AOAM532tdGjggywmBsHo57Q7lPlxclxRCwFYrTcVNmZ2ew2WHACOE1ye
        YTbrqBWGeEUVeVFuUry0/18hVpUlmQ4=
X-Google-Smtp-Source: ABdhPJyyQfFz9wRLdHPRPzeyOYsUTH3Mwygtr/jM1+BV0935sSubEd3aaZu0NGm7w33dft9D8J/6mQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr18486845wru.372.1595412490458;
        Wed, 22 Jul 2020 03:08:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/14] nvmem: patches (set 1) for 5.9
Date:   Wed, 22 Jul 2020 11:06:51 +0100
Message-Id: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.9 which includes
- adding support to AUTO devid for providers which have multiple instances.
- add new nvmem_cell_read_u8()
- new sc27xx provider, add write support to qfprom.
- few trivial fixes.

Can you please queue them up for 5.9.

thanks for you help,
srini

Andreas Färber (2):
  nvmem: core: Grammar fixes for help text
  nvmem: core: Add nvmem_cell_read_u8()

Douglas Anderson (1):
  nvmem: Enforce nvmem stride in the sysfs interface

Freeman Liu (1):
  nvmem: sc27xx: add sc2730 efuse support

Guru Das Srinagesh (1):
  nvmem: qcom-spmi-sdam: Enable multiple devices

Matteo Croce (1):
  nvmem: update Kconfig description

Ravi Kumar Bokka (3):
  dt-bindings: nvmem: qfprom: Convert to yaml
  dt-bindings: nvmem: Add properties needed for blowing fuses
  nvmem: qfprom: Add fuse blowing support

Srinivas Kandagatla (2):
  nvmem: core: add support to auto devid
  nvmem: qfprom: use NVMEM_DEVID_AUTO for multiple instances

Tiezhu Yang (2):
  nvmem: sprd: Fix return value of sprd_efuse_probe()
  MAINTAINERS: Add git tree for NVMEM FRAMEWORK

Yangtao Li (1):
  dt-bindings: nvmem: SID: add binding for A100's SID controller

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |  19 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |  96 ++++++
 .../devicetree/bindings/nvmem/qfprom.txt      |  35 --
 MAINTAINERS                                   |   1 +
 drivers/nvmem/Kconfig                         |   3 -
 drivers/nvmem/core.c                          |  43 ++-
 drivers/nvmem/qcom-spmi-sdam.c                |   4 +-
 drivers/nvmem/qfprom.c                        | 315 +++++++++++++++++-
 drivers/nvmem/sc27xx-efuse.c                  |  27 +-
 drivers/nvmem/sprd-efuse.c                    |   4 +-
 include/linux/nvmem-consumer.h                |   1 +
 include/linux/nvmem-provider.h                |   3 +
 12 files changed, 479 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

-- 
2.21.0

