Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AED620760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="srHQREj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgIERlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgIERkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:40:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA8C061246
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:40:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f2so9454680qkh.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQro0KvCecashCGNg/PcVjIspfzorn2YBuMdQvvHTl8=;
        b=srHQREj2hm0W+uI7LdTFJ9F0DKd0AlV6pwGNbUXc3rUIVL9GDEUrBmquCnRQyChgwF
         3MRZZ3A/sFDT28zANbCD5IT2BxHZKj0ZQjq7Xyy/mW+Zw/PITa0mTGo0oP8Xe0G/t5Qk
         Ne+RK35wEDCSnndnUkKNJM+zFe/FO7ucF6x/C5OgzSlolGLvvi4Gg4Bec3eO6jnG/Hn1
         ZzL2Xxmmm/0ghLM4wRRYA1pD1Xu+GkfX27BtMSNhMbu7zPamJYehmYXIYfFuXcVOyC9w
         Jim1mFqNRzrHwdbb5V4KYdm7gTEeF8SeQE86PCJupPPjIGmssG+2rg6Oliwa9O1cnEEm
         pwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQro0KvCecashCGNg/PcVjIspfzorn2YBuMdQvvHTl8=;
        b=D5sIjEMNrSB40TSCxcklj0mm3kYMQsNfzOY/Oll6IVBGqcsTJuVUe3fultvHmd8y7p
         2368kj4tK2XlCvsR75GsY7vJlqz8jZZOts4vSnQgdP+eBDzGpuPJfSv7E0s6CKFnQ+8d
         m8wfkMOce27a01YpCbsQPc3ACfdhzNzUVirWO2FasmCrvYuHfncoceuZGow16nCAqi4y
         oFV1tVDktZi9oloMFWyp+ftwi9rirZlzPJi0J6/qZ7fvCOcZqfC+Q++XhPgRIGamqLdM
         sv/cxpfnS8siBacxcBo7XCM9gaa11yEO6sLwhlG4mPoreZX0Sgq8pdMkv+ZmtFwHeXvY
         M4Gw==
X-Gm-Message-State: AOAM532M2iA4+KcsYmNa+l5QQEk7/RywBPcHWTEal+EfQGo3HJlJQ6k+
        LgmqiP3jaFvgX7hsYtbmAuhERDAYSJ5lsx9qHoM=
X-Google-Smtp-Source: ABdhPJz+AoKdk7U3xzEnEhwLVI+mA45wdHjbSYoaWKhRvxjshzsYjE8/yNT4RO4odN3yDb0/RtiSwQ==
X-Received: by 2002:a05:620a:1381:: with SMTP id k1mr13315111qki.140.1599327604804;
        Sat, 05 Sep 2020 10:40:04 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k22sm4612076qkk.13.2020.09.05.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:40:04 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     alsa-devel@alsa-project.org (moderated list:SOUNDWIRE SUBSYSTEM),
        Andy Gross <agross@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 0/4] soundwire: qcom: add support for mmio soundwire master
Date:   Sat,  5 Sep 2020 13:39:01 -0400
Message-Id: <20200905173905.16541-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for soundwire device on sm8250.

Tested with the "wsa" sdw device, which is simpler than the others.

v2 addresses some feedback, but I kept this series as simple as possible.
In particular, I didn't implement CMD_NACKED from FIFO_STATUS, because
the downstream driver doesn't define this bit, so I can't implement it.
Soundwire works without it and It shouldn't be difficult to implement later.

Jonathan Marek (4):
  soundwire: qcom: fix abh/ahb typo
  soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
  soundwire: qcom: add support for mmio soundwire master devices
  soundwire: qcom: add v1.5.1 compatible

 .../bindings/soundwire/qcom,sdw.txt           |  1 +
 drivers/soundwire/Kconfig                     |  2 +-
 drivers/soundwire/qcom.c                      | 38 +++++++++++++++++--
 3 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.26.1

