Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5140C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DA320714
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4oyZDha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgEMCTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgEMCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:19:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:19:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so6216324pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqIDoib68FB2JDTnUdkS+sJ6c0KSJCfPM4XCGL9+wo=;
        b=i4oyZDhasB3BK4N58xBJKFV7wb9fn+1SGRZKwR34UdXB63m/A0ctudRtq27LnDuPzX
         TLoqbyusguNq5jwMxryJrk5tkyJWysGVxhcZ+27xGGZmOdC3T+RzhjNVrpG1o6ewhF9f
         MtCITc7U9pKFK3h0/jGDni3RSnjduO3gFObFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqIDoib68FB2JDTnUdkS+sJ6c0KSJCfPM4XCGL9+wo=;
        b=Q38ScrYHZbBvDa6pQycJurdaK2XXG+ItT760HKR8BzPlYK74TVlrZiPnNWSXwXYXrK
         CVBqZygPIATK7xMc1xciUCj9wTA6M/1Uj+4KAbc1gRwYXM1Uem6QbnDnqB+dK09VcZX4
         itr7rQMyD3b5F0igaamm4cD0oOTqvaL+sBWJWswayNdW5S5YISFLly3QPipeD9Yu7xqF
         RraXREUZERXCeUMpuyy9q0KnCfoanA6qwOcvkYZbhizIdCgwxgNAsMdCL3hIeg/S1Es0
         oZlaOeSVDpuXbOSBbFWbFBgg9RAvz84hVYhoMKlUKEehi2ytinikhzCBF9rZVH81TEQM
         2SRQ==
X-Gm-Message-State: AOAM531TcbQD2UPn3DPmqWvvkd/nzmKiFQfCgARKZOPAb3lUhRgMKY8w
        TvJzc8pwn6T50teVrxbKQvodpA==
X-Google-Smtp-Source: ABdhPJy1z/U/SgoeHL7kpt3JfXpLpI+JwdlQqILbEJfVHiYHPh4Qblisl0P/YTYl50n/NcdWbdpM8Q==
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr1122508plm.198.1589336372539;
        Tue, 12 May 2020 19:19:32 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm14170600pja.53.2020.05.12.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:19:32 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/3] Bluetooth: Prevent scanning when device is not configured for wakeup
Date:   Tue, 12 May 2020 19:19:24 -0700
Message-Id: <20200513021927.115700-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi linux-bluetooth,

This patch series adds a hook to prevent Bluetooth from scanning during
suspend if it is not configured to wake up. It's not always clear who
the wakeup owner is from looking at hdev->dev so we need the driver to
inform us whether to set up scanning.

By default, when no `prevent_wake` hook is implemented, we always
configure scanning for wake-up.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: Rename BT_SUSPEND_COMPLETE
  Bluetooth: Add hook for driver to prevent wake from suspend
  Bluetooth: btusb: Implement hdev->prevent_wake

 drivers/bluetooth/btusb.c        | 8 ++++++++
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_core.c         | 8 +++++---
 net/bluetooth/hci_request.c      | 2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.26.2.645.ge9eca65c58-goog

