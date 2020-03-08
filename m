Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB4C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BD3206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsR7I29s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCHVXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:23:52 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53761 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgCHVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:23:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so681657pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tzW7HssZBtY3SvxCb22E4ke3jvHNoIbFs14WY4NcNA=;
        b=bsR7I29sZ7HfQSRCAWI51eV06TbZfLHVY993eC6fVQqxIVQt1NptdMVXm/LrxLBCbl
         Tlz0S0zWxgO+UynwKVdIWh9nCHZxu74LqYXv2XWjUiTkt1XmFmUl9JG4kgka3YKjBTqL
         bzm6pFJdujJETyNaI9EGQk1oSgV0oqBlguB9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tzW7HssZBtY3SvxCb22E4ke3jvHNoIbFs14WY4NcNA=;
        b=c4NUSUS3JwLerkpu+S6+rHPPLMO8CGFa3XE9zs7nd5V66u/8QE8IlyXfQ7FxsPm6bY
         gCU5x7nI+lpc1TGQ8PDGGxe+Rw16rUevYSW6lAQlU7WuF5dK2IcJpW95zjDaf9/KlVVl
         4QJ6BK7aQvNhlcPZbFaLksHgJ6AA7S9tY8t8M5P0bfpjNTneGULYqV7nEdlVGkg62fPU
         f48jVTIfiPGEitJS69yyLgqxGiUiBOXRxA/xfgVkxx//cC4Gtr0126IcgCZySy2ghlcP
         5iMAbpqqO/wbakZeQPK1Fo/cvxFADxfYxYw7ZFW+JihFAy2AERDZe5NASCJaRHl0sN6T
         7eEg==
X-Gm-Message-State: ANhLgQ2jz6jZEVp3PD/uQCEqINipE+zCtaaysgGLlCz2913ixMu/K5mk
        1wjRz1OWFK6Us6/1DBEy1uEbZA==
X-Google-Smtp-Source: ADFU+vvelZvzMJOKHIDQCA76OpDS1N/lyb9dlkT4CLYv3R+PMp59C7h2DOAkY1Yx0ZU74tx7JibdGQ==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr12825346plt.149.1583702630315;
        Sun, 08 Mar 2020 14:23:50 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k1sm39509228pgt.70.2020.03.08.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 14:23:49 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v5 0/5] Bluetooth: Handle system suspend gracefully
Date:   Sun,  8 Mar 2020 14:23:29 -0700
Message-Id: <20200308212334.213841-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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

Series 5 moves set_wake_capable to the last patch in the series and
changes BT_DBG to bt_dev_dbg.

Please review and provide any feedback.

Thanks
Abhishek


Changes in v5:
* Convert BT_DBG to bt_dev_dbg
* Added wakeable list and changed BT_DBG to bt_dev_dbg
* Add wakeable to hci_conn_params and change BT_DBG to bt_dev_dbg
* Changed BT_DBG to bt_dev_dbg
* Wakeable entries moved to other commits
* Patch moved to end of series

Changes in v4:
* Added check for mgmt_powering_down and hdev_is_powered in notifier

Changes in v3:
* Refactored to only handle BR/EDR devices
* Split LE changes into its own commit
* Added wakeable property to le_conn_param
* Use wakeable list for BR/EDR and wakeable property for LE

Changes in v2:
* Moved pm notifier registration into its own patch and moved params out
  of separate suspend_state
* Refactored filters and whitelist settings to its own patch
* Refactored update_white_list to have clearer edge cases
* Add connected devices to whitelist (previously missing corner case)
* Refactored pause discovery + advertising into its own patch

Abhishek Pandit-Subedi (5):
  Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND
  Bluetooth: Handle BR/EDR devices during suspend
  Bluetooth: Handle LE devices during suspend
  Bluetooth: Pause discovery and advertising during suspend
  Bluetooth: Add mgmt op set_wake_capable

 include/net/bluetooth/hci.h      |  17 +-
 include/net/bluetooth/hci_core.h |  43 ++++
 include/net/bluetooth/mgmt.h     |   7 +
 net/bluetooth/hci_core.c         | 102 ++++++++++
 net/bluetooth/hci_event.c        |  24 +++
 net/bluetooth/hci_request.c      | 331 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             |  92 +++++++++
 8 files changed, 558 insertions(+), 60 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

