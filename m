Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848A1C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55855214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646463;
	bh=L7usoMfa+pEQiXXtn3sfbAzram5W8WNwR3FcHvNx+yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PciqNv1DLp/2oet4L6MgMmqC/g4QnffRc7H5R5NizsWbzJC6iBgFNJe7XW1/ee0Wv
	 4zvuX+kQo1wwJPDmV/pOtgdWxGL+SkPIEm/qu3dqab1DDn5PIO3SSTFgmkN/7wgQVk
	 qE1gAvKZZjD6tzdSNoY8PMvALK8SgNcxKtSB1Irc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDKXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgDKXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C39321835;
        Sat, 11 Apr 2020 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646456;
        bh=L7usoMfa+pEQiXXtn3sfbAzram5W8WNwR3FcHvNx+yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5IkkBc0XjHSR3jzMlEC/1qg5Ws5IqtbhQrbGOR88xQqKPi8QIUJy566Hn6gwhCpq
         Fkc4Ym4wzvHuRm6Vg6B8ZWlQc6fzac3c9p53gv6olEYjjWQZSRpvxkvaS/kZY13Fcy
         rtvq48HW7LzstHQCqwa8vOFo8w+cWP+i6JcXj/vI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Howard Chung <howardchung@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 025/121] Bluetooth: L2CAP: handle l2cap config request during open state
Date:   Sat, 11 Apr 2020 19:05:30 -0400
Message-Id: <20200411230706.23855-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Howard Chung <howardchung@google.com>

[ Upstream commit 96298f640104e4cd9a913a6e50b0b981829b94ff ]

According to Core Spec Version 5.2 | Vol 3, Part A 6.1.5,
the incoming L2CAP_ConfigReq should be handled during
OPEN state.

The section below shows the btmon trace when running
L2CAP/COS/CFD/BV-12-C before and after this change.

=== Before ===
...
> ACL Data RX: Handle 256 flags 0x02 dlen 12                #22
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 1 (0x0001)
        Source CID: 65
< ACL Data TX: Handle 256 flags 0x00 dlen 16                #23
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 256 flags 0x00 dlen 12                #24
      L2CAP: Configure Request (0x04) ident 2 len 4
        Destination CID: 65
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5      #25
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5      #26
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16                #27
      L2CAP: Configure Request (0x04) ident 3 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        01 00                                            ..
< ACL Data TX: Handle 256 flags 0x00 dlen 18                #28
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5      #29
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 14                #30
      L2CAP: Configure Response (0x05) ident 2 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> ACL Data RX: Handle 256 flags 0x02 dlen 20                #31
      L2CAP: Configure Request (0x04) ident 3 len 12
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        01 00 91 02 11 11                                ......
< ACL Data TX: Handle 256 flags 0x00 dlen 14                #32
      L2CAP: Command Reject (0x01) ident 3 len 6
        Reason: Invalid CID in request (0x0002)
        Destination CID: 64
        Source CID: 65
> HCI Event: Number of Completed Packets (0x13) plen 5      #33
        Num handles: 1
        Handle: 256
        Count: 1
...
=== After ===
...
> ACL Data RX: Handle 256 flags 0x02 dlen 12               #22
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 1 (0x0001)
        Source CID: 65
< ACL Data TX: Handle 256 flags 0x00 dlen 16               #23
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 256 flags 0x00 dlen 12               #24
      L2CAP: Configure Request (0x04) ident 2 len 4
        Destination CID: 65
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5     #25
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5     #26
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16               #27
      L2CAP: Configure Request (0x04) ident 3 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        01 00                                            ..
< ACL Data TX: Handle 256 flags 0x00 dlen 18               #28
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5     #29
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 14               #30
      L2CAP: Configure Response (0x05) ident 2 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> ACL Data RX: Handle 256 flags 0x02 dlen 20               #31
      L2CAP: Configure Request (0x04) ident 3 len 12
        Destination CID: 64
        Flags: 0x0000
        Option: Unknown (0x10) [hint]
        01 00 91 02 11 11                                .....
< ACL Data TX: Handle 256 flags 0x00 dlen 18               #32
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
< ACL Data TX: Handle 256 flags 0x00 dlen 12               #33
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 65
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5     #34
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5     #35
        Num handles: 1
        Handle: 256
        Count: 1
...

Signed-off-by: Howard Chung <howardchung@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a845786258a0b..2f3e437faedbc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4131,7 +4131,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
+	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
-- 
2.20.1

