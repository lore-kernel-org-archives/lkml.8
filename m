Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953E2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F12B204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrmexfeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgIHUHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgIHUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:07:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C1C061573;
        Tue,  8 Sep 2020 13:07:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so61712pfa.10;
        Tue, 08 Sep 2020 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2k9xpa9l+tbRJ/+vvItQDXmC64/jEuH8zJsr0tf6oA=;
        b=CrmexfeQlkBwXK5cG+ePO2sdpsUPZnONXxWr/hg8KJjUjcaV7j/aXOa2NIQiuCONLC
         90PGOGuGJhs+tn/dOaOybPQI3hkDS9/DYthQ4whqkws8ZDBOxHCqgZ9XQE/r1QO1SGHt
         X3nIm8ttt4u91GG04u4UY4Bz9DZFr8zMg4JqV2Hd+WSMRI7t2FqSQW3pqmmHs0NvrUia
         zwRwSHSpIbU9SQm2gT3tA6M+scVRa1erkkve0Ylf9GJqUJJOxh5ecCoK+RqswTulVpFI
         bKRF/HqLkmb2i/japcvxpqX7E6ulyFgq1VRhJcXTzZ77FJH0PuByZFK1tQlTpc1PoKty
         IXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2k9xpa9l+tbRJ/+vvItQDXmC64/jEuH8zJsr0tf6oA=;
        b=efQAlW8HF63VCa6F4rU2vQT476JUqY63uTwkyTbsEnNT+TolPp3D8nblkpKEnokPcF
         E0HspIzVt4Dkbv8nbpLfTrB/4eOu78G+T/urfDKbmICNMMtYOfDg9fHiOiTDkYA0pikf
         jKEGFDmc3ViXgIFCzC1ksE/ztBqSAsDlNJFiwIqq/x9nWkdCsZKFo3jv3hcgT9vbcAi6
         VJdRAwuuv5sBR3j5h1ZlPCG8L1MmmhTWxZTZt3/pir9DgM0HnbLi61ElDCEO1Lk3RKNF
         XlZc3964Kec3swq6rwerFXFMGNP3E69OLpdqzUtguVgKRIYaZuhz3AkFkQyPEuUTt/Xr
         dDdg==
X-Gm-Message-State: AOAM530Xo81Rne4sQfcR2XX3hUHEu1Uiha+hY/76F2YZhXpJwDs1rOR8
        7YXWTioBLgPLQ9tdLBrp4g==
X-Google-Smtp-Source: ABdhPJxwCwMDHBJXt83pjdnBKyh00EzfcLx4+iauDRFDYP1OihfBxFjkVtwmkrQFVz2ZgIbAEjY48w==
X-Received: by 2002:a63:fd01:: with SMTP id d1mr319176pgh.350.1599595634182;
        Tue, 08 Sep 2020 13:07:14 -0700 (PDT)
Received: from localhost.localdomain (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id y24sm237023pfn.161.2020.09.08.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:07:13 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Subject: [Linux-kernel-mentees] [PATCH] Bluetooth: Fix memory leak in read_adv_mon_features()
Date:   Tue,  8 Sep 2020 16:06:35 -0400
Message-Id: <20200908200635.1099360-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <00000000000033913705acedbd6b@google.com>
References: <00000000000033913705acedbd6b@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_adv_mon_features() is leaking memory. Free `rp` before returning.

Fixes: e5e1e7fd470c ("Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES")
Reported-and-tested-by: syzbot+f7f6e564f4202d8601c6@syzkaller.appspotmail.com
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 net/bluetooth/mgmt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5bbe71002fb9..f96251f818fc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4157,7 +4157,7 @@ static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct adv_monitor *monitor = NULL;
 	struct mgmt_rp_read_adv_monitor_features *rp = NULL;
-	int handle;
+	int handle, err;
 	size_t rp_size = 0;
 	__u32 supported = 0;
 	__u16 num_handles = 0;
@@ -4192,9 +4192,13 @@ static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
 	if (num_handles)
 		memcpy(&rp->handles, &handles, (num_handles * sizeof(u16)));
 
-	return mgmt_cmd_complete(sk, hdev->id,
-				 MGMT_OP_READ_ADV_MONITOR_FEATURES,
-				 MGMT_STATUS_SUCCESS, rp, rp_size);
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_READ_ADV_MONITOR_FEATURES,
+				MGMT_STATUS_SUCCESS, rp, rp_size);
+
+	kfree(rp);
+
+	return err;
 }
 
 static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
-- 
2.25.1

