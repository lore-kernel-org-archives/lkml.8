Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F620C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2752071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GO6bxpmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgAYBVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:21:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35071 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYBVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:21:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1496199plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02ovYAmlgmSL1qFH8GmgwW5v7fv5Fn6zNb3okRXRqVw=;
        b=GO6bxpmpwFxfZB1HMfOsrNhMwnSTCOJUtK8xRckuj6K9L+LNJAGjFe6ajXAN8wwTnB
         1bFZOxDME9Vi/xE0OZmoYiC4V/FHb7I+1ZjSMQIFpDkKbnTwcx7El3UeiRR0UynKo0Jc
         BL9M3pCoMZXHriaJ25e4zKkgyRWJXT7eYDhAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02ovYAmlgmSL1qFH8GmgwW5v7fv5Fn6zNb3okRXRqVw=;
        b=PYGIyxT1h56hSSy3t9A96R74Tje8zLmuu1WcfUl+iv+RGpSgnrSdvDEZKUk6tb47eY
         k7hOGlpgUWaCrzlvLR3HBlWEkFYra5ILz2ewk1CC2JSw2lUtNgG9as4MQtvTYdGejVQJ
         W2f6JSTimbtHOtOWQm7fo4Ji7T7u4HaKgIuAFUg0CNTIA/eR7MsdDPi6lhHqRbNxXZLn
         hT4wfBG3VWyQsuN0tvJeez9OpOOyo1X+joa8fhcWEuEsNRCPYqmGPLB1m/95dwmG6hV+
         7NeK6nmS3Xz4N/HeihqHvd83MuKUwTUos8PgPxIeHEodjgPm6GF55h9SJLDxURiRr1Ne
         reMg==
X-Gm-Message-State: APjAAAWaA5VZc+mZFxaQyLyFpLjx3T2CIbVKz+1vIgpqM4YhEZlNQ9m6
        whm+FVmj5A5SGikwRthrI0bejoKBNTE=
X-Google-Smtp-Source: APXvYqzrKBDHCE8fotdKl4mbnLQKMpjBO5nl2eGaEDVgWbadJqw1olHrh2As/JPrh5hGOOtnhcu82Q==
X-Received: by 2002:a17:902:b215:: with SMTP id t21mr6534821plr.190.1579915273241;
        Fri, 24 Jan 2020 17:21:13 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id n4sm7443337pgg.88.2020.01.24.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:21:12 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 0/4] Factor out cmd_xfer_status() setup code
Date:   Fri, 24 Jan 2020 17:21:01 -0800
Message-Id: <20200125012105.59903-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use similar setup and cleanup
code, including setting up the cros_ec_command message struct and
copying the received buffer.

This series introduces a wrapper function that performs this setup and
teardown, and then updates some places in platform/chrome to use the new
wrapper.

Prashant Malani (4):
  platform/chrome: Add EC command msg wrapper
  platform/chrome: Make chardev use send_cmd_msg
  platform/chrome: Use send_cmd_msg in debugfs
  platform/chrome: Make check_features() use wrapper

 drivers/platform/chrome/cros_ec_chardev.c   | 33 ++++------
 drivers/platform/chrome/cros_ec_debugfs.c   | 39 ++++-------
 drivers/platform/chrome/cros_ec_proto.c     | 73 ++++++++++++++++-----
 include/linux/platform_data/cros_ec_proto.h |  5 ++
 4 files changed, 86 insertions(+), 64 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

