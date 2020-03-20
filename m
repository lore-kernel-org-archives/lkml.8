Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF2BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D075206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4pH9P4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCTAHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:07:35 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35460 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCTAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:07:33 -0400
Received: by mail-pj1-f67.google.com with SMTP id j20so1715993pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acxg8uMg4NFbDr08SQGvm9+PmwMFAk5ItZG8WlsBwhw=;
        b=U4pH9P4lw7V4TqqJGAC4rzIvCYDIBC4taKiNw5Voc2CjmHjW4dcSzroKQPrU/tO2eT
         qcpTnDOVDZ+oxU/PyLmsccmdzJ50qp5U6+KNCvmiv5I04k5+vqgG56i1XfP/o2zpDkn+
         tkv+FKCH6rSJiCeQj86PLhl5xNyh4cFBuN/zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acxg8uMg4NFbDr08SQGvm9+PmwMFAk5ItZG8WlsBwhw=;
        b=ibtIhFxoNXRzai4yVgBft4jL/N0gT8rukKSDrQAB8Cm5xVg+Qw/n9tZDmzCXulecOd
         yv/3kFp8/jdHVxYtyQKbTyYWpFs5XIMYulla4zCSmYkEsTMNV/u2D1JMhZlGnRPVeg+B
         309U+KaXDqz854gicKhH2kh0rJgWIb4DeTo9K5GIZDCOYJBHoM6Yaw8xqW4Vsa+6zKtX
         hDVJ14pnqlR/NWxs6uTybQKlsqN6kEiCTYVQmnVHD2qCC7DrEA7/qUL0hqUxFuhJWByi
         ct9vgD1BlH7Obc5ZJz1qunVsc/O+1QucO9o5JMEPQJ2Y5y9F6vqlp/UsuP6Hlj9Vm6bi
         RnyA==
X-Gm-Message-State: ANhLgQ0zqGqJwJEGS8s8SRifUE6xoI4PyVHb12P5yuHKdqpxVnOtK6M2
        q6EK3cHurYhkWVc22mulnI0zuw==
X-Google-Smtp-Source: ADFU+vv/toBfL9yTu+DqZU5VqPE3K2kICxRTYJk9CvoYTLtFLKPYYBMa9YYsnozfeUZtqI5h333lRg==
X-Received: by 2002:a17:90a:368f:: with SMTP id t15mr6699247pjb.23.1584662851250;
        Thu, 19 Mar 2020 17:07:31 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id m12sm2928292pjf.25.2020.03.19.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:07:30 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] Bluetooth: Fix incorrect branch in connection complete
Date:   Thu, 19 Mar 2020 17:07:13 -0700
Message-Id: <20200319170708.2.Ibcb4900b4d77c3f1df9e43e4c951bf230d65f12d@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320000713.32899-1-abhishekpandit@chromium.org>
References: <20200320000713.32899-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling auto-connected devices, we should execute the rest of the
connection complete when it was previously discovered and it is an ACL
connection.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 net/bluetooth/hci_event.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20408d386268..cd3d7d90029b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2539,16 +2539,17 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				bt_dev_err(hdev, "no memory for new conn");
 				goto unlock;
 			}
-		}
-
-		if (ev->link_type != SCO_LINK)
-			goto unlock;
+		} else {
+			if (ev->link_type != SCO_LINK)
+				goto unlock;
 
-		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
-		if (!conn)
-			goto unlock;
+			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
+						       &ev->bdaddr);
+			if (!conn)
+				goto unlock;
 
-		conn->type = SCO_LINK;
+			conn->type = SCO_LINK;
+		}
 	}
 
 	if (!ev->status) {
-- 
2.25.1.696.g5e7596f4ac-goog

