Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5ECC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50000246C7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc9ZJ1DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCBHEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:04:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38575 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCBHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:04:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id p7so3833346pli.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M9jM0oFamI1cSDzHh+fj7Bd6QrDeIt5TA9kTaFKmIk=;
        b=Oc9ZJ1DCGMymWi40UBVMVgLIKFegujZrTwU1vekyLOVgvi9ufi9lgicsHrFncgz57c
         WJBNuaWQDRRM2I74chmgH39ujFkAh0uD5TLr/WBdU7ToNJM6RJ8dBAYUOVS2/LH/RXeh
         f+DvS+lU1InV13FdPPvIo4qvuPQcHnDgdzQZk9NfeTtzIXsizMwHEDxRmA64pc9imvHw
         b9mBEIfRUC/6ju9c3oelDNVewofLzzo8pt7NKiPwrgkkIodLsN8qdtiFlOhaECnBnCXz
         uAxu4bJ1q4FfRx25Mabc51/W8Zi8Ej2Gl127396HT+IlweiY5AsWxdYCzWuOaGuPrSQJ
         ckMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M9jM0oFamI1cSDzHh+fj7Bd6QrDeIt5TA9kTaFKmIk=;
        b=ElUds0/x5G/bpIobK4P0ucM1Kl3OYHiqOzG6treTnLtN9NQWop6dvRHN+CXH9t2BhW
         WmjLgT3h9H5MnJZ3XWrYMOG2jX2KUGicF2wP+ATU+BZm745G4PgXU9NGO57cADN/JbOt
         bCxeBVji6revV51iXe6yQiXMKZIBr23aVHEC8yvPqE3f0Jejt2o1/Dq4Pz071YsEaIo+
         epP1BlDFwBWaCZ+6sRT3/sfpramGeNElzqEVivuC4mnGA58KyCrDD71AFExhiSVKdH/g
         qCJk3BGOu6OqMPFXeSUa9usH+bf+Ps7I4tGy3Hd0/xiGQpVOFSJB+4d2y1rG/k9MruFb
         nHKA==
X-Gm-Message-State: APjAAAX9qrpTjre9EU+rcrYjcoqszwtUXjCzG4IvOEHHy+T470rXjgMa
        z86sskJaO1wdmriqkBXMH63a2g==
X-Google-Smtp-Source: APXvYqyFZxrijhdE9RQs8BTA+6h7lNVQj7NlFFGdvJkgFm5Lj0WwNMhRAFLgXdw+jQk7zjcRynSakg==
X-Received: by 2002:a17:902:864c:: with SMTP id y12mr16539924plt.8.1583132673691;
        Sun, 01 Mar 2020 23:04:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b3sm19969551pft.73.2020.03.01.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:04:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] net: qrtr: Fix FIXME related to qrtr_ns_init()
Date:   Sun,  1 Mar 2020 23:03:05 -0800
Message-Id: <20200302070305.612067-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200302070305.612067-1-bjorn.andersson@linaro.org>
References: <20200302070305.612067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2 second delay before calling qrtr_ns_init() meant that the remote
processors would register as endpoints in qrtr and the say_hello() call
would therefor broadcast the outgoing HELLO to them. With the HELLO
handshake corrected this delay is no longer needed.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Cleaned up remaining work queue pieces
- Picked up Mani's r-b and t-b

 net/qrtr/ns.c   |  2 +-
 net/qrtr/qrtr.c | 10 +---------
 net/qrtr/qrtr.h |  2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e3f11052b5f6..cfd4bd07a62b 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -693,7 +693,7 @@ static void qrtr_ns_data_ready(struct sock *sk)
 	queue_work(qrtr_ns.workqueue, &qrtr_ns.work);
 }
 
-void qrtr_ns_init(struct work_struct *work)
+void qrtr_ns_init(void)
 {
 	struct sockaddr_qrtr sq;
 	int ret;
diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 423310896285..e22092e4a783 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -9,7 +9,6 @@
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
 
 #include <net/sock.h>
 
@@ -110,8 +109,6 @@ static DEFINE_MUTEX(qrtr_node_lock);
 static DEFINE_IDR(qrtr_ports);
 static DEFINE_MUTEX(qrtr_port_lock);
 
-static struct delayed_work qrtr_ns_work;
-
 /**
  * struct qrtr_node - endpoint node
  * @ep_lock: lock for endpoint management and callbacks
@@ -1263,11 +1260,7 @@ static int __init qrtr_proto_init(void)
 		return rc;
 	}
 
-	/* FIXME: Currently, this 2s delay is required to catch the NEW_SERVER
-	 * messages from routers. But the fix could be somewhere else.
-	 */
-	INIT_DELAYED_WORK(&qrtr_ns_work, qrtr_ns_init);
-	schedule_delayed_work(&qrtr_ns_work, msecs_to_jiffies(2000));
+	qrtr_ns_init();
 
 	return rc;
 }
@@ -1275,7 +1268,6 @@ postcore_initcall(qrtr_proto_init);
 
 static void __exit qrtr_proto_fini(void)
 {
-	cancel_delayed_work_sync(&qrtr_ns_work);
 	qrtr_ns_remove();
 	sock_unregister(qrtr_family.family);
 	proto_unregister(&qrtr_proto);
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index 53a237a28971..dc2b67f17927 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -29,7 +29,7 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep);
 
 int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len);
 
-void qrtr_ns_init(struct work_struct *work);
+void qrtr_ns_init(void);
 
 void qrtr_ns_remove(void);
 
-- 
2.24.0

