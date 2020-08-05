Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F43C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E0422CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkEWqptL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgHESVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgHESLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CCC06138D;
        Wed,  5 Aug 2020 11:10:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s15so16744045qvv.7;
        Wed, 05 Aug 2020 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSOoq3zhF6z2fZ+X97MfanJIRrTuyK8BNIkdVGDMQEQ=;
        b=WkEWqptLDy3R6ioOulhs9LCTz33DYC1YwZpUJavPXOLVGV2Oh1GCAetOfpDiAicnfC
         bnnTTBfinXKPD8zwEhxTo3jAr1u6b1KivySeOrU9BiBn/I6UQAqhjBJCNsMKvG0hkImf
         ALAyJ0TBul74xRJlxBK0ORqfKLnd46HXDgh18AjaR8DPqu0fHH8ldssbfQi1trX6tRB7
         5UW7Vc1V2K2qydneRegNu1wCNbnVqa8s8SaDMEMPNS65YHhlNkvARMGJz77FYBEcMec3
         v1SU3F9ISIdfIyZiYpIFsVgMAzZcO+5s6AMfJZRSIANi/QySkiAvuVZebvBhIVj14HNN
         KJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSOoq3zhF6z2fZ+X97MfanJIRrTuyK8BNIkdVGDMQEQ=;
        b=a4Plm0h/9rXTD4DSDFG67hE/2D5IY1EAldWANby4cPctLkiqPo4Ped9khm/Z1iUGuX
         soLEHmcfXVsL2O3zVZSsvIzjZGDrzdeJfP7kAo5cjj1UTD3u+GxwICQgQW5Ffvisjqc1
         WMc/mS1lTjSmN7w3GcdzWX2R/14/TPkHIsuSZMj3OeCew7e96gBJCVGz9diRbEBL+I9r
         seAheRMgxGkRCxnFvXscmqKwnljpGc83bQSouqJdjkMq/xtk7nG4wPlKZ5Vx1jYpjR/y
         UCl/re5o8+CpdaWuAoWv4Bvs5oYxW053tWhI3oNqceyFn1dYBfAwKBLXoiaOPPnym312
         OT4w==
X-Gm-Message-State: AOAM530BDCfwX1T4ctGYQKfWyNjVotXgZnz12wqWqp4YweWjpH8dQfH6
        ibluYCAoc+ODEW6S1UTe+Q==
X-Google-Smtp-Source: ABdhPJybD0CTplQH9PaqhvAh94r4pvrJHLy/2Cb1rWWuo+HcvlxTLUJMXYleqq82a0Jy8907RV108g==
X-Received: by 2002:ad4:438f:: with SMTP id s15mr5142142qvr.164.1596651031728;
        Wed, 05 Aug 2020 11:10:31 -0700 (PDT)
Received: from localhost.localdomain (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id i7sm2571560qtb.27.2020.08.05.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:10:31 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH net] Bluetooth: Fix slab-out-of-bounds read in hci_le_direct_adv_report_evt()
Date:   Wed,  5 Aug 2020 14:09:02 -0400
Message-Id: <20200805180902.684024-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`num_reports` is not being properly checked. A malformed event packet with
a large `num_reports` number makes hci_le_direct_adv_report_evt() read out
of bounds. Fix it.

Reported-and-tested-by: syzbot+24ebd650e20bd263ca01@syzkaller.appspotmail.com
Fixes: 2f010b55884e ("Bluetooth: Add support for handling LE Direct Advertising Report events")
Link: https://syzkaller.appspot.com/bug?extid=24ebd650e20bd263ca01
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
I moved the initialization of `ev` out of the loop and restructured the
function a bit, since otherwise the check would look like:

	if (!num_reports || skb->len < num_reports * sizeof(struct hci_ev_le_direct_adv_info) + 1)
		return;

Therefore I used the similar structure with hci_inquiry_result_evt() etc.

hci_le_adv_report_evt() and hci_le_ext_adv_report_evt() also have the
same issue with `num_reports`, but I'm not sure how to perform the check
for them, since they use variable-length reports. Should we do something
like this? (take hci_le_adv_report_evt() as example:)

	if (!num_reports ||
	    skb->len < num_reports * (sizeof(*ev) + HCI_MAX_AD_LENGTH + 1) + 1)
		return;

Then how about hci_le_ext_adv_report_evt()? There is no such
`HCI_MAX_AD_LENGTH` restrictions on `ev->length` for it, I assume?

Would like to hear your opinion. Thank you!

 net/bluetooth/hci_event.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4b7fc430793c..aec43ae488d1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5863,21 +5863,19 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
 
-	hci_dev_lock(hdev);
+	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
+		return;
 
-	while (num_reports--) {
-		struct hci_ev_le_direct_adv_info *ev = ptr;
+	hci_dev_lock(hdev);
 
+	for (; num_reports; num_reports--, ev++)
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, &ev->direct_addr,
 				   ev->direct_addr_type, ev->rssi, NULL, 0,
 				   false);
 
-		ptr += sizeof(*ev);
-	}
-
 	hci_dev_unlock(hdev);
 }
 
-- 
2.25.1

