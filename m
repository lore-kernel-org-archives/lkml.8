Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596BC35DEC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EB3218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jc5CHOxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBYAAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:00:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52656 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBYAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:00:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so457919pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+8ngQIB3GNYZhQp96LbiuLKzGQX6teIB6tS+tcQAEI=;
        b=jc5CHOxAioIkjj1QZAS40yykoz02ZFZzTowxaz1evbUBDn+APB+dg5yi/CqMRUHBPO
         CaS+PgoTg7kAlqDJ6pxDt/OaBB5uOGPxArVMkdbJ3VqoIWjg1xF8GVZLATzkElJ/Loww
         bUDs0l+DbGjuRVS0AnyNkLI+IfFwSvxJeLnB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+8ngQIB3GNYZhQp96LbiuLKzGQX6teIB6tS+tcQAEI=;
        b=j75gNlerJqG4aMsreIYWE2wPFTPkf0OlKiaTjJv7L5zcR9i/xLS9F246fQ2Zv3aZy9
         s/5KNhVu67RAvPPycGOZen1Fd0/IQkviblocPZxJ+iB9ZMrQ4Xue2oDTLGrGkunW0749
         Pe7xpwreZ9jo17TS0aIxrBgxYAup0xnlbcuHsja7yV6VAKHNCBep8tZRgcwWpuWfmZ60
         YIJep6+s7RAsHqtBPXnO08hCPAPkmcvGcdXHfEAlj3zs+Atl5WJYs1v2YptyNTtMNQtm
         zOYlik8VSiShQgkOG5U2wet12mkOnXGrRPnqq4bqXsmJlo/NKAhKvLPu2NSEvnuElkN5
         +WFg==
X-Gm-Message-State: APjAAAX82fnF9nkfuA1IH/aeL1048SQgezgSGWki0EmPArTEi5u63htQ
        zddae3jARtiu+BgxsQNCdmpZ2Q==
X-Google-Smtp-Source: APXvYqzj/EmbtyPe0tewAX+jrs6CxwD84WnIm3mzFDz0oyXPS0y+ZDGcKiyEel+jbzhFqho5VvozQw==
X-Received: by 2002:a17:90a:330c:: with SMTP id m12mr1868860pjb.18.1582588847029;
        Mon, 24 Feb 2020 16:00:47 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id c188sm14477657pfb.151.2020.02.24.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 16:00:46 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v3 0/5] Bluetooth: Handle system suspend gracefully
Date:   Mon, 24 Feb 2020 16:00:31 -0800
Message-Id: <20200225000036.156250-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi linux-bluetooth,

This patch series prepares the Bluetooth controller for system suspend
by disconnecting all devices and preparing the event filter and LE
whitelist with devices that can wake the system from suspend.

The main motivation for doing this is so we can enable Bluetooth as
a wake up source during suspend without it being noisy. Bluetooth should
wake the system when a HID device receives user input but otherwise not
send any events to the host.

This patch series was tested on several Chromebooks with both btusb and
hci_serdev on kernel 4.19. The set of tests was basically the following:
* Reconnects after suspend succeed
* HID devices can wake the system from suspend (needs some related bluez
  changes to call the Set Wake Capable management command)
* System properly pauses and unpauses discovery + advertising around
  suspend
* System does not wake from any events from non wakeable devices

Series 2 has refactored the change into multiple smaller commits as
requested. I tried to simplify some of the whitelist filtering edge
cases but unfortunately it remains quite complex.

Series 3 has refactored it further and should have resolved the
whitelisting complexity in series 2.

Please review and provide any feedback.

Thanks
Abhishek


Changes in v3:
* Refactored to only handle BR/EDR devices
* Split LE changes into its own commit

Changes in v2:
* Moved pm notifier registration into its own patch and moved params out
  of separate suspend_state
* Refactored filters and whitelist settings to its own patch
* Refactored update_white_list to have clearer edge cases
* Add connected devices to whitelist (previously missing corner case)
* Refactored pause discovery + advertising into its own patch

Abhishek Pandit-Subedi (5):
  Bluetooth: Add mgmt op set_wake_capable
  Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND
  Bluetooth: Handle BR/EDR devices during suspend
  Bluetooth: Handle LE devices during suspend
  Bluetooth: Pause discovery and advertising during suspend

 include/net/bluetooth/hci.h      |  17 +-
 include/net/bluetooth/hci_core.h |  41 ++++
 include/net/bluetooth/mgmt.h     |   7 +
 net/bluetooth/hci_core.c         |  86 ++++++++
 net/bluetooth/hci_event.c        |  24 +++
 net/bluetooth/hci_request.c      | 327 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             |  92 +++++++++
 8 files changed, 536 insertions(+), 60 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

