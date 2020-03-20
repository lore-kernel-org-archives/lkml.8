Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B6C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B521320739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRAuHm70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCTQxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:53:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37214 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCTQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:53:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id h72so1333804pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of4yG/Vch/Qj/D9yPE0fo6j6XLR3095eAUqqs/YSOwY=;
        b=dRAuHm70s32jvPsyJvaRFXlgBM+OeovibGCvoxVlik+9h50MIPbUWkDSZ4a8aBzq1l
         GL5XNXRYj8NCKS1ZkuXYKkS6CpXCpF3ywncpFLeVlkJHeBJogxp+uD6jLjCMJaJRFPAZ
         qmu7zcqMPkRrzPjQz+o/5t+L+KQ+PNi3fln9tbMAjjAdrjc5iEpBg2tDB/6pvRxWBo66
         Zcrfit9iws2DBEOAKkY8SBbfUex7gkB592zgGvf7L39BfU7oHLKp/nOeJHXBieSeK1ne
         nwk4HHBpCgS5kfE9EegxZPTsz3OP494UsZafp4XgRRiiE2zJIVdc2nEOs/H9AHz47VRR
         wa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of4yG/Vch/Qj/D9yPE0fo6j6XLR3095eAUqqs/YSOwY=;
        b=f56iql5XP4QqMHAN6lAiWJyTLSLzbYdpecHypHg1YotHv8sjTKs8WZVEQCcfQrTckG
         NzHOAChY9W/bAzR7bXG98mbHIwfYeVn1FA1QQgqNWLe1tsalWk3Uw6c04qkjKpoOEuNv
         D2WTn/q6/M+FYC1HbtVmP/5IWdE5X4fI7Y8Z/dk2i00HcR0xQZT73yd8X1cB0/A+2WfN
         kmo2HODzq+tISKt/B4+uBV4G4A7d3ZdhDww1gbdkHywYaOz9noItPwplmqjLTFRTJx/i
         6GFbpg8G+zv7Hbbqgskw6ukozSDxI3H4Nj41SFMtqZqT1PrkGER2MSi6hK5KbZPM1SQZ
         eOqg==
X-Gm-Message-State: ANhLgQ3wqal3Lx4wT+ARNLz3G0/T/PBha1TiYgMGPp6jeG25Rrdhm3Uw
        P/MsWh9uySruDfhbls1OFP6oQDsn8ok=
X-Google-Smtp-Source: ADFU+vuk5fqfRt3pgssw0+gJH1iTPp67oYT5MsVGMC+R4pwtrHcwWn3Nrm0p3QhoOUq62L8YDzj6uQ==
X-Received: by 2002:a62:e409:: with SMTP id r9mr10332985pfh.119.1584723184948;
        Fri, 20 Mar 2020 09:53:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x17sm6064216pfn.16.2020.03.20.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:53:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/12] coresight: next v5.6-rc6 
Date:   Fri, 20 Mar 2020 10:52:51 -0600
Message-Id: <20200320165303.13681-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As requested here is another respin - the only thing that changed is
the replacement of scnprintf() and all sysfs output are now singular,
i.e don't need any parsing.  That triggered some modification to
sysfs entries, which have been taken into account in the documentation.

Applies and compile cleanly on your char-misc-next branch.

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

 .../testing/sysfs-bus-coresight-devices-cti   |  241 ++++
 .../bindings/arm/coresight-cti.yaml           |  336 +++++
 .../devicetree/bindings/arm/coresight.txt     |    7 +
 .../trace/coresight/coresight-ect.rst         |  222 +++
 Documentation/trace/coresight/coresight.rst   |   13 +
 MAINTAINERS                                   |    3 +
 drivers/hwtracing/coresight/Kconfig           |   21 +
 drivers/hwtracing/coresight/Makefile          |    3 +
 .../coresight/coresight-cti-platform.c        |  485 +++++++
 .../hwtracing/coresight/coresight-cti-sysfs.c | 1206 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-cti.c   |  745 ++++++++++
 drivers/hwtracing/coresight/coresight-cti.h   |  235 ++++
 .../hwtracing/coresight/coresight-platform.c  |   20 +
 drivers/hwtracing/coresight/coresight-priv.h  |   15 +
 drivers/hwtracing/coresight/coresight.c       |   86 +-
 include/dt-bindings/arm/coresight-cti-dt.h    |   37 +
 include/linux/coresight.h                     |   27 +
 17 files changed, 3688 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cti.yaml
 create mode 100644 Documentation/trace/coresight/coresight-ect.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-platform.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-sysfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.h
 create mode 100644 include/dt-bindings/arm/coresight-cti-dt.h

-- 
2.20.1

