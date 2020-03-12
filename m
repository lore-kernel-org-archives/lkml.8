Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F27C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B2D20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9EWbDux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCLSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:11:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40481 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCLSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:11:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id l184so3641421pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1r2hqBwaO/kXT5sadF+nxqNCtN3Dus3oicu3doTosoE=;
        b=j9EWbDuxdtPVrVMGo4g9ExD52Du4/T/igLgDcH42KRTjU6y75HsFQkhrQ/bwHZ3/O6
         7mkGbWdalaG0JS7k3bYNBIm66Z8Iml9+4mPN8AmEuunwcmVpaSYTdHXLemTTceKsBsU+
         plUohAf86OM+LkovQFpdDLktjvutMG0n3IurE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1r2hqBwaO/kXT5sadF+nxqNCtN3Dus3oicu3doTosoE=;
        b=RvyCblyMNHn+fJ6s1K4roHSwfGIMExlkjpaxqQgRb6NpR6YL6AgKcTZsZlYXRMZMtO
         70OfWXtrZYwdLdl38u73wt8+nyPBJNFIq3I8ZEQAyRgAhJbYN/jXVmenJTIQAVaatiFt
         BQj7BziZcP9RebjrRPiAHoVtpH73jIgavneaYt49kVZBCFW4A+BIzhKsQbTNCz3/x1GS
         ByfAIuelZ8hGEoeZbJXOb9ZercqmOtODdoJwLOi6FXeBCKeoaJPe2rMJa0JZUtnAxMkr
         7NRdYLRy526ZOQtvBqy0RIE7YQEuNePiOtVJXkaczH1yDpY/3UNr8Tt5tbqcAsDNTFt9
         9VxQ==
X-Gm-Message-State: ANhLgQ1zDdocQ00GHyECpCf49FVxdB3ENvUnP4dJNpFP/47p4x+evW7r
        +zYAspqLufvt6xPhaVv8+ynM8Q==
X-Google-Smtp-Source: ADFU+vu7HWZMs5iJFzE+oa997HRVSVS4ZUzn+3cxJq0K5Cw2fuo9QjichDhlzf8YgyHRaX8xraS3PQ==
X-Received: by 2002:a62:144c:: with SMTP id 73mr7218549pfu.265.1584036661706;
        Thu, 12 Mar 2020 11:11:01 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b18sm56787876pfd.63.2020.03.12.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:11:01 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/1] Bluetooth: Prioritize sco traffic on slow interfaces
Date:   Thu, 12 Mar 2020 11:10:54 -0700
Message-Id: <20200312181055.94038-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi linux-bluetooth,

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
a video conference page at the same time) while using an LE keyboard.
There were no discernible slowdowns caused by this change.

Thanks
Abhishek


Abhishek Pandit-Subedi (1):
  Bluetooth: Prioritize SCO traffic on slow interfaces

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 91 +++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 19 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

