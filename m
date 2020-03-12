Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20FC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0A7206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ixp5BFMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCLW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:59:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35846 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgCLW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:59:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id c7so3818825pgw.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRNricm8Yj9j/ffl2iaO9/CyjzXWt5ewl0sNb73zbPc=;
        b=Ixp5BFMVHtYL3JWaVrufECSQRPl1VA9HVFcHUwsG6HSYnE3npmb4PKviTsu4qvV66x
         yxIoEfk4e/NoPgD/ULfr87hLnfRK9WtuA73yo0UFJp1Ke/6yDw6s+rGpz6iXS0I+uDhf
         AEOM3dZQmV4uuqCn5vq2ksmeSVw2YZWf7OMoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRNricm8Yj9j/ffl2iaO9/CyjzXWt5ewl0sNb73zbPc=;
        b=CFTIx32aRqqeRtIZGM0CKIOXGbWONYr2Dl3Ei+b+LjO/M9WanJsTTPMfDgj04uBQB1
         tKipnNyEIoWwSGndQ9zgSDM1Rd8Z1ypJ57Hl9rNjCPxbg2FPjMY8ypGcP86vUujKisH8
         GNk+jvGX3svLWHOudk7tfuVpGrFpr24yZt7WIMS+C3dIvnphsTdWp/T2UcS/vkhknw2N
         eHteR8kotb3T1YkTVzrF+61++fVrERlqjbttVraL34iRa4WyKI5blDoirsT50xq2QoX1
         cA5sVciCfxOAQLtCgUE1uh83QsgyGuGp48kuBcc/jTRjQbA8kda1NJ19jUYd54mcfjWP
         XZnw==
X-Gm-Message-State: ANhLgQ0BbFIWQDsFA9+IjDu2XL6NyVWGHT/cyt8XRDA+fijMh1IXHiZ+
        tyAKyYDUJaotu+6evr1Yuj1cgOM2xOk=
X-Google-Smtp-Source: ADFU+vvcfwnO9MhAic5AHub7xGPkerzsDLK//hgUjO+a84b4AKQGip+zXJpWTwv56Ki7FzR6OeFiUg==
X-Received: by 2002:a63:3d48:: with SMTP id k69mr9549198pga.395.1584053984180;
        Thu, 12 Mar 2020 15:59:44 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id v123sm28763161pfb.85.2020.03.12.15.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:59:43 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/4] platform/chrome: Add Type C connector class driver
Date:   Thu, 12 Mar 2020 15:57:10 -0700
Message-Id: <20200312225719.14753-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces a Type C port driver for Chrome OS
devices that have an EC (Embedded Controller). It derives port
information from ACPI or DT entries. This patch series adds basic
support, including registering ports, and setting certain basic
attributes.

v3: https://lkml.org/lkml/2020/2/19/1230
v2: https://lkml.org/lkml/2020/2/7/646
v1: https://lkml.org/lkml/2020/2/5/676

Changes in v4:
- Updated DT bindings to use the usb-connector.yaml DT bindings
- Updated initialization code to store port capabilities in the local
device data struct.

Prashant Malani (4):
  dt-bindings: Add cros-ec Type C port driver
  platform/chrome: Add Type C connector class driver
  platform/chrome: typec: Get PD_CONTROL cmd version
  platform/chrome: typec: Update port info from EC

 .../bindings/chrome/google,cros-ec-typec.yaml |  48 +++
 drivers/platform/chrome/Kconfig               |  11 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_typec.c       | 357 ++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

-- 
2.25.1.481.gfbce0eb801-goog

