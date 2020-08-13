Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD11C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17A42078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DjVFX12u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHMImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:42:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF580C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:42:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so2469309pgh.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+S61hbBUWnnIr1pACyWESONaaBAFPVTE7r0Hpph1Gy8=;
        b=DjVFX12upbN/1MoEtx0DJ4hrWuRWIvGCnoULuK4GMDwGU5lTCJphBanBCrloKdbF0B
         xwrai9Q1rPNKyUwaTAPvPsrLrBioD4hu6g3BKexmyMxpNATBLeP4sVA56ReqhznRbpo8
         vhAO9Qp6Cp4G3x3DMSmlMt8HqMrkVO2JY5fzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+S61hbBUWnnIr1pACyWESONaaBAFPVTE7r0Hpph1Gy8=;
        b=WwWXNy0KjYZbmUucLNDsVC2uDOLiD6GfwUyGQ1NjwlwmM3PBFeEUACPm5f6EmofVH9
         MTiaDLgp/Uq10JEIdy31AsgDgoatouNqjZuwA4SdBEyurTbuHn7fepqVpugkcBtuPF8v
         I0Di5IRUbOJg9rRvO4vp2eYft0rlKDJnSBv0Abtv32MCNqBB5BwY1U/e25Onx8eLWp/g
         Vcsx8WObbqe2aVAIjUQMiwn2lAEJiF2GrfjZGQNDINJPdfe+3oFA3ERPEtfy9MOjZ64V
         rmlknsnjoaIlCwHyN1H7XJ8sVpyVL+MrkbUGC3ltXlhTvEhwOHp16uNcMyfpbUw22bBN
         d0mg==
X-Gm-Message-State: AOAM533GFr+gejLvS2tSKEGTw2yfySw179IC3oKylu0vNeBS1DhvA1Rt
        D1rV3ig7yIx6WDh8+1JQ05sVe2M0384=
X-Google-Smtp-Source: ABdhPJx0RsR6ADUaGZ1eXG6LZOZfLxE+6htn34QhBtxpC7kCXbOsswRKnrgB+bAYO0kYBNQ2aBolmQ==
X-Received: by 2002:a63:dc4a:: with SMTP id f10mr2646729pgj.394.1597308140322;
        Thu, 13 Aug 2020 01:42:20 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id y29sm5032035pfr.11.2020.08.13.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:42:19 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: sco: expose WBS packet length in socket option
Date:   Thu, 13 Aug 2020 16:41:29 +0800
Message-Id: <20200813164059.v1.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200813084129.332730-1-josephsih@chromium.org>
References: <20200813084129.332730-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is desirable to expose the wideband speech packet length via
a socket option to the user space so that the user space can set
the value correctly in configuring the sco connection.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 include/net/bluetooth/bluetooth.h | 2 ++
 net/bluetooth/sco.c               | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf4483d..922cc03143def4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -153,6 +153,8 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
+#define BT_SCO_PKT_LEN         17
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index dcf7f96ff417e6..97e4e7c7b8cf62 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -67,6 +67,7 @@ struct sco_pinfo {
 	__u32		flags;
 	__u16		setting;
 	__u8		cmsg_mask;
+	__u32		pkt_len;
 	struct sco_conn	*conn;
 };
 
@@ -267,6 +268,8 @@ static int sco_connect(struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	sco_pi(sk)->pkt_len = hdev->sco_pkt_len;
+
 done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -1001,6 +1004,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_SCO_PKT_LEN:
+		if (put_user(sco_pi(sk)->pkt_len, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.28.0.236.gb10cc79966-goog

