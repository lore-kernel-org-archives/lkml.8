Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA460C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF2C2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CYHEf/2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgAQV1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:27:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53706 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAQV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:35 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so3696257pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1l3obKwRCGQ8frlt+kT/Fwgd/74cacl1ClW7zB9H/o=;
        b=CYHEf/2Cn6TJeeZKMkiqa5bNKoh9HBjN2YlyR5SrXNyPtSogq9fsIX8WlZlhoP9xBI
         kUuFDVSg1b3/6VFpjCZKPOzOFZaFrWYvpEztWhQRjrDeDeig3MJprxaKPanOi9CzgY41
         GjMkeexGflv2Z9YfniznQcGAokcOlZb99+4xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1l3obKwRCGQ8frlt+kT/Fwgd/74cacl1ClW7zB9H/o=;
        b=j9ogkIFAB7LKN7v4t/7u0G/GrJqXmlx9Zvk+n6on7SUPetPTqvnyJUkj3LsfhyEllD
         D/sQQuMx7GqPs5IjHBEplQCenSK1ddGeyLnbF8iden7ZmL7QNWujVJecOG6fPNNLcY+n
         4ae1imvm8lim0EeDy2q0qMt20LU2It8sZZ9/d8GUkf7lcndmyqCFC7Mqq0woyYnp6yQR
         6f5UzvkNiQ6w90yG5Zsa6Jd1g0eweI4NdPDpQg1QnJw7C6ZLK2TJLe1kyE2kSSj17lkQ
         6imSdA+rMb1bRuji1Le204JMdF/T2r+qGdllCAlzdk3a6z2bYzxvrl1EuDnnHpCdIoYK
         mk3A==
X-Gm-Message-State: APjAAAVlyyNebeozm88xlMhgjX1PN2+atHLQ69hV7M1lVFLNp4vjXGNn
        KMruUdcG0Zh9hzUiQEEtQLE7EA==
X-Google-Smtp-Source: APXvYqxVIeRLkgGU2AYw+K1fB38PoJYs1C0RKehuSzanbrmAgoDINfQJ8oQXlOnlVXne+BFVhg9fyA==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr1384059plv.194.1579296454733;
        Fri, 17 Jan 2020 13:27:34 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k5sm6999655pju.29.2020.01.17.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:34 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Bluetooth: Handle system suspend gracefully
Date:   Fri, 17 Jan 2020 13:27:03 -0800
Message-Id: <20200117212705.57436-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
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

Please review and provide any feedback.

Thanks
Abhishek



Abhishek Pandit-Subedi (2):
  Bluetooth: Add mgmt op set_wake_capable
  Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND

 include/net/bluetooth/hci.h      |  30 +++-
 include/net/bluetooth/hci_core.h |  46 +++++
 include/net/bluetooth/mgmt.h     |   7 +
 net/bluetooth/hci_core.c         |  71 ++++++++
 net/bluetooth/hci_event.c        |  24 ++-
 net/bluetooth/hci_request.c      | 297 ++++++++++++++++++++++++++++---
 net/bluetooth/hci_request.h      |   4 +-
 net/bluetooth/mgmt.c             |  94 +++++++++-
 8 files changed, 537 insertions(+), 36 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

