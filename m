Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3680520708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TAkG511j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgA3WAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:00:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35086 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:00:40 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1933066pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NTp0RLA1RXBTz+ZB+3tKLNTGY97hmZ7tkxdDHBoFCQ=;
        b=TAkG511j4TP1FZYgOMlZ7Z1E7QdeNvgFJhnwqoYia0dY5zI8A++N5S51yylvqBW0D8
         N50xfoTu00Z6eD1Bz8KY3Osra5+rk1D5VUIyHuMYCXAqYAJJlBaw2zhAW7+UxyuBO/CH
         l6ocrI9bTp5M+wPD49E6RObDjAPKOhNh+XUBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NTp0RLA1RXBTz+ZB+3tKLNTGY97hmZ7tkxdDHBoFCQ=;
        b=FhmCwkzDs1z/e1Ws3j7KqWhkGfz5YAHE4KFvOrEDeqxwKHFLKRv1B9nxtVE9G11RZB
         GSK88amlpUTldCfodIoARIVWfM89Xsd8Kg2S2RMWr4LfTMXSBggazrSQ2mRjVZreKt0Q
         l3S5+xzcirHuXQOqc8eUyL/+RdzUD4uCng79dM55cKLPzMr42My4SYwKLhraBAFOHr/t
         aMXkELuwVrx/IoTLwAekZNAUUrENXXH3Bs8p0kklL8Uo3gDftulYg46w7Oeb8PKlkFfU
         n8Ee+q/j8pvHHqXdlVxWwOtYjOKRZ4MBjpXJJ2g/qHsZyzGgLgFBsNaElyF8wRiGg5vB
         hV7Q==
X-Gm-Message-State: APjAAAXQuBb3qO7IclTXGew8X5jEMUZeKQsNqyI1yPguatlAgNgDRJTT
        IV0rTy9CXizBqkY1mZMPHJgpxMKHXQAmrA==
X-Google-Smtp-Source: APXvYqykeXhetrAPmkiWSfEPwiT5qAKlz4MuefcyJ+bfEOKYbFImbYsz0cXmUTwRUPJoHrqs5X0n7A==
X-Received: by 2002:a17:902:b412:: with SMTP id x18mr6727472plr.292.1580421638749;
        Thu, 30 Jan 2020 14:00:38 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id g21sm8219849pfb.126.2020.01.30.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:00:38 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/3] platform/chrome: Add Type C connector class driver
Date:   Thu, 30 Jan 2020 14:00:27 -0800
Message-Id: <20200130220032.160855-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces a Type C port driver for Chrome OS devices
that have an EC (Embedded Controller). It derives port information from
ACPI or DT entries. This patch series adds basic support, including
registering ports, and setting certain basic attributes.

I thought I’d send it out as an RFC to get some comments on whether the
general approach is right. Subsequent iterations of the series will
include adding port partner information as well as integration with mux
agents. This might tie in with Heikki’s work here:

https://github.com/krohei/linux/commit/976378fbfe4a29b892d39ade07efce042640ff4c

Based on feedback, I can incorporate comments or adopt another approach altogether.

Prashant Malani (3):
  platform/chrome: Add Type C connector class driver
  platform/chrome: typec: Get PD_CONTORL version
  platform/chrome: Update Type C port info from EC

 drivers/platform/chrome/Kconfig         |  11 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 319 ++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

-- 
2.25.0.341.g760bfbb309-goog

