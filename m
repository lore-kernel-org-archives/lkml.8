Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C592072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kC2u4h6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCTXTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:19:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37188 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:19:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so3142915pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlj4H6PNTWeANW8zGP3DY9GXf41GKsAbZW2FrRkC5dU=;
        b=kC2u4h6UKOQRE0wpk1ph+jQDfvMfBZNVQX2ORwMdLx6nIsHZvK7XxtazYyl5kxCo44
         JQRUcB3J4cgo9GGYUDku2TzGo1lgY//USauc1eSub8Y6WEOUCK8Tjoou7qCt3C1u9khG
         WnroqIH4FVghQ1+4D+GrAtp/JFBVvYHMLOUsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zlj4H6PNTWeANW8zGP3DY9GXf41GKsAbZW2FrRkC5dU=;
        b=ayb6oXKaRJJ49GDet7W3uLnUUxSF1woYfOWOKwdcmjEXPRFWgmJbFjn0/ePcdjSr+n
         4BOuLxCKiv/0ZCE2i9Qkj4/Ij4Hrm5aMweh+axKcJBvo5/dmlQEYHRcvQZI0xxFA3rVS
         Z/3suTw4HFJMIbEulnyCvfl1r8ulJyezEZJgyzZmltfivEJwwMCC9zvZXs+L6ENv3N03
         XjUVAAeuKYJXM4kaWrJ9YnGirQNZ0SBImk4ehrCYjlnjTL2WQHiGIa5S9z/H/qK3JO2j
         zsYGvpKdyFPwtP+PajrzN9+3oisvXJaPr2DWanKaJdndir0R1i7OSCgInt1nAtoc36w3
         HCPg==
X-Gm-Message-State: ANhLgQ0gVb0iTcY+lu+kIEOUPGVJ6AA2HZn29/+yDjuyo9lbG40roBTV
        iHnfnIi7AXS6E5Q296Y/5IByXA==
X-Google-Smtp-Source: ADFU+vtqlO03MAwFL0RA6W0l8wZiylq3Hvg6xJBLX6zYxNiF2ITbkvPBELRZAqmbNDtArlCiLm4fFA==
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr10727044pll.67.1584746374565;
        Fri, 20 Mar 2020 16:19:34 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id q26sm6530773pff.63.2020.03.20.16.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 16:19:34 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 0/1] Bluetooth: Prioritize sco traffic on slow interfaces
Date:   Fri, 20 Mar 2020 16:19:27 -0700
Message-Id: <20200320231928.137720-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

While investigating supporting Voice over HCI/UART, we discovered that
it is possible for SCO packet deadlines to be missed in some conditions
where large ACL packets are being transferred. For UART, at a baudrate
of 3000000, a single 1024 byte packet will take ~3.4ms to transfer.
Sending two ACL packets of max size would cause us to miss the timing
for SCO (which is 3.75ms) in the worst case.

To mitigate this, we change hci_tx_work to prefer scheduling SCO/eSCO
over ACL/LE and modify the hci_sched_{acl,le} routines so that they will
only send one packet before checking whether a SCO packet is queued. ACL
packets should still get sent at a similar rate (depending on number of
ACL packets supported by controller) since the loop will continue until
there is no more quota left for ACL and LE packets.

To test this patch, I played some music over SCO (open youtube and
a video conference page at the same time) while using an LE keyboard and
mouse.  There were no discernible slowdowns caused by this change.

Thanks
Abhishek

Changes in v2:
* Refactor to check for SCO/eSCO after each ACL/LE packet sent
* Enabled SCO priority all the time and removed the sched_limit variable

Abhishek Pandit-Subedi (1):
  Bluetooth: Prioritize SCO traffic

 net/bluetooth/hci_core.c | 111 +++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 50 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

