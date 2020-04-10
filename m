Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D096FC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64B20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACNJOI5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDJAIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:08:45 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39086 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:08:45 -0400
Received: by mail-pg1-f182.google.com with SMTP id g32so253083pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Tjv9zMJn2YHc3izqrZKgOj37Bk9MfHeVEZyetQC/ao=;
        b=ACNJOI5Ik2B/KlyI/tdVPSM/uzmXiNN+zk+UCQxAw7w1puIbxZkcbJhhIvdFHnac9n
         6JpBEOQLXi85DJUux9yqFxNj/F2W0K5xhYv/YYDxU/3MS2ffUd2tRvLZlgXv8AP+NsjL
         461vvzaoLBoXHGVRSjRN8RZ3FCcdfsan2m9j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Tjv9zMJn2YHc3izqrZKgOj37Bk9MfHeVEZyetQC/ao=;
        b=BpADla1P2rkzZkf7kDD8SMEyadjeNjG/gvUx8I2A+9SMYUItFPULdTQhXPPr/O18+v
         UsqRMb3s2F6dKoAOlDK0oIDuzF/YvzIzJY0BflnTkut9VLuRAkZkIdkknXX82hhxzqRF
         CRDo1A0bi+hHE+SJ9zGsLj4pKkzx5LElWBb65/kQh7ix9rT9rb9VNCuBQXxcgK8BvA8M
         A83NQ5Bbh8VPf7MKk28Gt5lCs+hW2QTtsc0HyEHv600aItVJfgpT0/PT9Xta0xxm4iiC
         E4jsXk2E5GUk8sYNmROXqy2ycdrp+iQnTZZDnXxZHeWOPDyafCeAiThLVHmOVV3rJS8C
         Nvug==
X-Gm-Message-State: AGi0PubdItL8gfIk0maZ5/XCr+zr5siqGsVU+1eI9Cx5ioceEUzrOhRY
        j8j71b6TW3HiDzb28KgQOdK7nNxqvTM=
X-Google-Smtp-Source: APiQypKBynsajAk2qIPPYaKTcXMN1fybKyeGpLtJa64wKshq7kxjAA6As0r7Lshm8/uyTNfssVUAHw==
X-Received: by 2002:a63:df0c:: with SMTP id u12mr212134pgg.387.1586477324308;
        Thu, 09 Apr 2020 17:08:44 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 6sm216421pgm.51.2020.04.09.17.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:08:43 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 0/3] platform/chrome: typec: Add port partner registration
Date:   Thu,  9 Apr 2020 17:08:17 -0700
Message-Id: <20200410000819.198668-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds port-partner registration when
connects/disconnects are detected. In order to do that, we also register
a listener for the cros-usbpd-notifier, which will inform the driver of
EC PD events. While we are here, separate out the Type C port data
objects into a separate struct.

v1: https://lkml.org/lkml/2020/4/6/1155

Changes in v2:
- Added Kconfig dependency.
- Fixed style comments.
- Removed unnecessary devm_kfree() call.
- Fixed incorrect error pointer return.

Prashant Malani (3):
  platform/chrome: typec: Use notifier for updates
  platform/chrome: typec: Add struct for port data
  platform/chrome: typec: Register port partner

 drivers/platform/chrome/Kconfig         |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
 2 files changed, 103 insertions(+), 17 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

