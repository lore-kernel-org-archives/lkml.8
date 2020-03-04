Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910F20828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idcee3dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgCDBG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:06:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDBG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:06:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so162137pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqvCXfGj808uPbmqG51quPJGXzE0v6hUvwSV24GKnh8=;
        b=idcee3dYDzfJ0CM6iZp7JlkpSNl01PCMsrR59GXa9oGRh3kMhgsjo3eUALsnKzraqb
         G9rvT7THOdySxd+am6A1csXQjcAhL9RnC26h0PcC2Cvc4MZDoYqveFHur8Gl2/Rq2NCY
         UPAvwQeJA1mdMZGUgyS6vepHyX0sAut2v9iWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqvCXfGj808uPbmqG51quPJGXzE0v6hUvwSV24GKnh8=;
        b=YP6EByrDvl/We+QPHWFw7STipy01aFLmE4NM9w+29mHId7ASrjwssBXzWJCzgY56vP
         99L+R0ASBWdG0fcgHyZtCkk/fRQ/56482QpOaQ6gAy3SZvrxB4Vus8p5Id/B85Z7Kg6w
         Kl71E9dd4vauICeJJeR+Pj2+DaM1RGbO5f7eS+00kSQqX0u2clCHfRI8ONV3uyZiL31c
         NaO511U/IC/UcapbpiaHq8J/UGwZ/LBGcYqiEiKbwt8II3O0kA7L7P0zLCQbRQ70ef20
         vA1nQ7qZI+UPj8GAaDSbSvQgylQYCpaWASRaLXK4V+fMThYb+Io7RwiPHJge+RqQoEUb
         OA2g==
X-Gm-Message-State: ANhLgQ0TMLMJAogBkVOwjbiG6AMu49FNiCUHWkxKjVWjAcr8c9P4+nde
        nfBr6sOgNSxS7yyiKROBnzUqDA==
X-Google-Smtp-Source: ADFU+vsGQTSwoJb3y/+ZlTFhvGwFZteRTnNGGWRPGDowZg5D2IRUAQ1n5i+nma6Hky2Hn42qDBInbQ==
X-Received: by 2002:a63:155c:: with SMTP id 28mr217571pgv.176.1583284017531;
        Tue, 03 Mar 2020 17:06:57 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm17780889pfb.138.2020.03.03.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:06:56 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v4 0/5] Bluetooth: Handle system suspend gracefully
Date:   Tue,  3 Mar 2020 17:06:45 -0800
Message-Id: <20200304010650.259961-1-abhishekpandit@chromium.org>
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

Series 4 adds a fix to check for powered down and powering down adapters.

Please review and provide any feedback.

Thanks
Abhishek


Changes in v4:
* Added check for mgmt_powering_down and hdev_is_powered in notifier

Changes in v3:
* Added wakeable property to le_conn_param
* Use wakeable list for BR/EDR and wakeable property for LE
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
 include/net/bluetooth/hci_core.h |  43 ++++
 include/net/bluetooth/mgmt.h     |   7 +
 net/bluetooth/hci_core.c         | 102 ++++++++++
 net/bluetooth/hci_event.c        |  24 +++
 net/bluetooth/hci_request.c      | 327 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             |  92 +++++++++
 8 files changed, 554 insertions(+), 60 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

