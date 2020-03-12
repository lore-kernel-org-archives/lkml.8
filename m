Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD6C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20F020736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TN0Hk9Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgCLCUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:20:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35854 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbgCLCUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:20:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id h125so2766759pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rcj6bBjC8eeTo0oFTOG03100dOPRd+sT+MeVFj1k6mA=;
        b=TN0Hk9Vlr9nUe66Kfks1oZvflGet0NTOh+FTOaukrvmsiQhyz1hkirVE+pcJxrjokZ
         tWHYqt2TtIzz6QyFRErqrCDZwcVWklLYXQZDzeVDAuhDgfxSOz+cAALYjVcLaf318zoq
         rYRp9b3Mr5gbqIBu20VCBrksnpjvymocYkKKwwqzWWzy6vCuxvYc7jRZ122sol6tkEG2
         JNxlRbJeYLeThZ2E8c/nXi5wrlyGbVPjq+WstnjMY3t5Fed27YW9+Thl1iVkflatHe0O
         HLpcY2gt0NQUocPF6a1eJLfZkrCYL8h/SStFxJXpeH74sZTNpuxv1c21ofZyHAWGZMfT
         iLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rcj6bBjC8eeTo0oFTOG03100dOPRd+sT+MeVFj1k6mA=;
        b=qY/sOB6T+nWg5eSOYY+UkT5AndW/uEnlYc/uRobCK+DgleR8p58TMA+YACAM8DJmYl
         m88pBxpLGc7S2VPia0eGc+zgCLZltsm5YBBuCy0+oUPqoQZl5voRUgeaD06OG4j5Zuhu
         UwSwJQ8sm7KIYR+zADZxhmVoPBEaN2vNC/QE7KsBypOr4XnsoT3+HqVsQROmA9Ujqtt8
         D5Gpwi8TrauCXevfsp/MVnAQkmwKkbiLw9XwJIkl/jZC95iLa7czM+TsZfN00DtMQOfE
         Yvs1kEUtmonun5Pcvo1RAiR+fij9ZcJfPkOq3U4jbC3TBP720VJq0RCMNeYJSW+B3uMH
         Rx5Q==
X-Gm-Message-State: ANhLgQ3DRE+8+hGLmAHG9GhJxjFjYnlxajubXNHVxgQHYYRg+owbbixp
        pStrKRPAtb+QSNMzqprn3/2nP48DpIg0ug==
X-Google-Smtp-Source: ADFU+vt1IpdsKjnyDHOBBFNJ/1UpXWbObj4AfBQQ8ULIYIUPaCwDt98YX8rrJ9mZbbobHSxkLh4ho/ykSS30ew==
X-Received: by 2002:a17:90a:cf0c:: with SMTP id h12mr1679625pju.164.1583979619855;
 Wed, 11 Mar 2020 19:20:19 -0700 (PDT)
Date:   Wed, 11 Mar 2020 19:20:14 -0700
Message-Id: <20200311191939.v2.1.I12c0712e93f74506385b67c6df287658c8fdad04@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2] Bluetooth: clean up connection in hci_cs_disconnect
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

In bluetooth core specification 4.2,
Vol 2, Part E, 7.8.9 LE Set Advertise Enable Command, it says

    The Controller shall continue advertising until ...
    or until a connection is created or ...
    In these cases, advertising is then disabled.

Hence, advertising would be disabled before a connection is
established. In current kernel implementation, advertising would
be re-enabled when all connections are terminated.

The correct disconnection flow looks like

  < HCI Command: Disconnect

  > HCI Event: Command Status
      Status: Success

  > HCI Event: Disconnect Complete
      Status: Success

Specifically, the last Disconnect Complete Event would trigger a
callback function hci_event.c:hci_disconn_complete_evt() to
cleanup the connection and re-enable advertising when proper.

However, sometimes, there might occur an exception in the controller
when disconnection is being executed. The disconnection flow might
then look like

  < HCI Command: Disconnect

  > HCI Event: Command Status
      Status: Unknown Connection Identifier

  Note that "> HCI Event: Disconnect Complete" is missing when such an
exception occurs. This would result in advertising staying disabled
forever since the connection in question is not cleaned up correctly.

To fix the controller exception issue, we need to do some connection
cleanup when the disconnect command status indicates an error.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- Moved "u8 type" declaration inside if block

 net/bluetooth/hci_event.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40ed31f6eb8f..a116114279107 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2202,10 +2202,22 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
+	if (conn) {
+		u8 type = conn->type;
+
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
+		/* If the disconnection failed for any reason, the upper layer
+		 * does not retry to disconnect in current implementation.
+		 * Hence, we need to do some basic cleanup here and re-enable
+		 * advertising if necessary.
+		 */
+		hci_conn_del(conn);
+		if (type == LE_LINK)
+			hci_req_reenable_advertising(hdev);
+	}
+
 	hci_dev_unlock(hdev);
 }
 
-- 
2.25.1.481.gfbce0eb801-goog

