Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0058D2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLi4SKjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCIQRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:17:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38795 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCIQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:17:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so4175545plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+EuGboWkCGYso9gYjOWNAC83ZosPayQVPNA4G1V2eE=;
        b=fLi4SKjsIboh6FDxhRljAQDXqB1dkqX+IsIyNLHh/4K2bD9f+SBcWvXFTzMP5M3AqZ
         XS+DzBWbQGgXHcvjS0ahGDiP6Q8cKtCHrVCu0QBEXxSmrKzxHEBZuma8cSAFUtFXJ4ss
         ivIi0GLoRmSnBoacfZuQdZhny81HACm3E67PRZc9Xt+j/8ZrBfzFTpFKmtfGuQbpYBBH
         mYvpLehxS4IMdnyQngUhbSJOhNd38mzs/w5Hz8b1LLTFqZ8aufQaQ8sKbScI0rA6wHBP
         xe4cQmbH0NooTY2B/tN3hfK/bINqy621esvagi0jZaVs0e0Pzx4MVwYURASZMQmYg+3s
         PN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+EuGboWkCGYso9gYjOWNAC83ZosPayQVPNA4G1V2eE=;
        b=WBwLhVomkBf0bi8gAk3pRd4ZwDBT5nMKTdsR+8nNKTAPAqIMD+e8eNPyiKoY/Vx6Pb
         mzyPiUG70lTWmgCx8+MJaELSaN1oN9q5/fc6kYWHh4Q3yJLHXVbQmS0GaXDgrSRiQnoZ
         WFo9lx7E5tkRnp3TEqDbEZh4FJGA8oysYjApdVymOFyLH1COOrfVUaKaY3J3Z4hxzK/A
         HqH1uKZ4UpOqCMNoUVqy/LFbw+Su6k7E3u1IKLe588Ev08xMo7szfy2MvsAaY8YMs6y/
         0FoSofPX9r9cKGEnQihqhK6ogKY22B/gqCgvZ/cZTE++fa9mU/FDSxqVzPRl7a3QCDXM
         rfTQ==
X-Gm-Message-State: ANhLgQ31pZN0fubkBnkLeEtoYU8SkHv2BM0r2RGEVgSYnfcVKknTop/U
        gZfTJK4LXJx1owOwExoN0Iduig==
X-Google-Smtp-Source: ADFU+vsoKb6i1cv2d1tEoqVfgMygCD6mwEdH8szR01q3S3bkhYzxH7T3qc276Ckf2pR4Evp0OfUvCA==
X-Received: by 2002:a17:90a:c251:: with SMTP id d17mr28053pjx.179.1583770669475;
        Mon, 09 Mar 2020 09:17:49 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m11sm38403pjl.18.2020.03.09.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:17:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] coresight: next v5.6-rc5 
Date:   Mon,  9 Mar 2020 10:17:35 -0600
Message-Id: <20200309161748.31975-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is what I have for inclusion in the v5.7 cycle.  As usual it applies to
your char-misc branch.  Please have a look when time permits.

Thanks,
Mathieu

Mike Leach (12):
  coresight: cti: Initial CoreSight CTI Driver
  coresight: cti: Add sysfs coresight mgmt register access
  coresight: cti: Add sysfs access to program function registers
  coresight: cti: Add sysfs trigger / channel programming API
  dt-bindings: arm: Adds CoreSight CTI hardware definitions
  coresight: cti: Add device tree support for v8 arch CTI
  coresight: cti: Add device tree support for custom CTI
  coresight: cti: Enable CTI associated with devices
  coresight: cti: Add connection information to sysfs
  docs: coresight: Update documentation for CoreSight to cover CTI
  docs: sysfs: coresight: Add sysfs ABI documentation for CTI
  Update MAINTAINERS to add reviewer for CoreSight

Nathan Chancellor (1):
  coresight: cti: Remove unnecessary NULL check in cti_sig_type_name

 .../testing/sysfs-bus-coresight-devices-cti   |  221 ++++
 .../bindings/arm/coresight-cti.yaml           |  336 +++++
 .../devicetree/bindings/arm/coresight.txt     |    7 +
 .../trace/coresight/coresight-ect.rst         |  211 +++
 Documentation/trace/coresight/coresight.rst   |   13 +
 MAINTAINERS                                   |    3 +
 drivers/hwtracing/coresight/Kconfig           |   21 +
 drivers/hwtracing/coresight/Makefile          |    3 +
 .../coresight/coresight-cti-platform.c        |  485 +++++++
 .../hwtracing/coresight/coresight-cti-sysfs.c | 1173 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-cti.c   |  745 +++++++++++
 drivers/hwtracing/coresight/coresight-cti.h   |  235 ++++
 .../hwtracing/coresight/coresight-platform.c  |   20 +
 drivers/hwtracing/coresight/coresight-priv.h  |   15 +
 drivers/hwtracing/coresight/coresight.c       |   86 +-
 include/dt-bindings/arm/coresight-cti-dt.h    |   37 +
 include/linux/coresight.h                     |   27 +
 17 files changed, 3624 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cti.yaml
 create mode 100644 Documentation/trace/coresight/coresight-ect.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-platform.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-sysfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.h
 create mode 100644 include/dt-bindings/arm/coresight-cti-dt.h


base-commit: bb3a151dd42765acc8f469ff994de3ab31f15a95
-- 
2.20.1

