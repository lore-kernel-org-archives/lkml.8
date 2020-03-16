Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9259CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6243320674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hMQzotyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgCPI2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:28:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39063 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:28:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so3330159pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ80KbL34Fj0zFbobkxNdOA+6IrRnpVzTPRaQOdGo7E=;
        b=hMQzotyIy3ehMb9dpXd9WYohOfFqXT2V7u4komMlGx+36v+LCijtL8vrHP+ud6DeOl
         v3EFD55aQ8GFV0xd3vstc8Gmb8eJCYPouqlIBeQn5naIWUcDz6E/MCidUrvplCXI97ai
         CgHHk//WBGU5aqRinnfXRCchBpS6Z+dq7Rtho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ80KbL34Fj0zFbobkxNdOA+6IrRnpVzTPRaQOdGo7E=;
        b=OVIUFESsb3/XLMe+5avkftTWopY8KgNGtF9h9j6PwRRQkwC4kEr+DrUZ1/OdppSGh1
         bgHK+qpPXe1Z6bmuKVj7SZU3QJjO5b+KO0ahVCCJpN2WKlLla/xe2uNE95xVUPho0URi
         eiJuE7s5ByY/gBXeQ+irbrXYjOv0JrPDV2JWg2sbMWBRm74/JPGQxfNO9Ar2eK5oOwPa
         zv9itYOONbrf2SwlxN0z+8KUS59p4o7LnODt5zxFVAt4OnuKsf3wvQzs4Zoehi30N0+H
         6iAJs+NTTuIZLC1aqCNrP50J1H2mb7PTLz82h9MV/szl3Il+GpygJlAJeTFxgsG6XOah
         ahPg==
X-Gm-Message-State: ANhLgQ1Ym7CiwA86nichaPcP/M5yw+cYSZOIR9Z2eK7XEfcxGeSbhmsP
        65b5Nh4H4OrKls2FFDJrh7zaq6tMQAI=
X-Google-Smtp-Source: ADFU+vvp4YGhGWgQnTFFMJIOaR41DAcK2D65wY/gn3Wc9WYDqVCSxqvPBzj4sNsYWKbtxFad5Vp4cQ==
X-Received: by 2002:a63:7a5a:: with SMTP id j26mr26665293pgn.447.1584347319520;
        Mon, 16 Mar 2020 01:28:39 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p8sm7867846pff.26.2020.03.16.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:28:38 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 0/3] platform/chrome: notify: Use PD_HOST_EVENT_STATUS
Date:   Mon, 16 Mar 2020 01:28:28 -0700
Message-Id: <20200316082831.242516-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the PD notifier driver to get the
EC_CMD_PD_HOST_EVENT_STATUS bits from the Chrome EC, and send those to
the notifier listeners. Earlier, the "event" param of the notifier was
always being hard-coded to a single value (corresponding to PD_MCU
events on ACPI and DT platforms) which wasn't of much use to the
listeners.

Changes in v2:
- Fixed unnecessary error checks.
- Removed extraneous dev_info prints about device registration.
- Rixed pd_command() return codes to be standard Linux error codes.

v1: https://lkml.org/lkml/2020/3/12/287

Prashant Malani (3):
  platform/chrome: notify: Add driver data struct
  platform/chrome: notify: Amend ACPI driver to plat
  platform/chrome: notify: Pull PD_HOST_EVENT status

 drivers/platform/chrome/cros_usbpd_notify.c | 183 +++++++++++++++++---
 1 file changed, 160 insertions(+), 23 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

