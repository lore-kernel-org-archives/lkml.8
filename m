Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC51C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED82073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbBpsQol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgDUIRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgDUIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB58C061A0F;
        Tue, 21 Apr 2020 01:17:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so10408028lfc.0;
        Tue, 21 Apr 2020 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0C61jUcYzQn93zpwZC/GTU8Q2LthE862yoEEDz8/6E=;
        b=MbBpsQolvKjyybvUGuhiKVlKnzflVP29nuKxPbQ4ziMFShOHPjLi9Z98eA5OYzrB0G
         uXQg0z2AFyDqcPVNlZLFvBLmt73yPz42AebnTpApkTszA7zfZEHotdtwNn6DgFmVQ7/r
         WHLdVoesOgtfiVJgIAB8u27NMSz4nSZNgjP84RJ5gWwHyo3Vm1R2siUP8Yo+uuBHfhYu
         mBuO5ROw6zCCU6TYRu+eMxUAm4QyMmUtCkyKzUXCR/C6gBScqHoEvV7/n29j+iaZmsYC
         Zl/wEygxdHLW1DfnxzEpC49fTS9k9WjUl4OCUQD1zKQIEhXTwDzDx5gyg7DMSGUCXwFz
         AacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0C61jUcYzQn93zpwZC/GTU8Q2LthE862yoEEDz8/6E=;
        b=dQina6sNeljpk4mm1VIxHRhDP8o6MpbbRzcVeakK4Bpw1Nu8lQWCqPbxSyFFWfnppx
         1fHA5K48TKGV+cS1gpbxSDIKlQ5Obx+x6X2xi5/zkZRfnpv7u85elGvyjePgf9niosNm
         TrtRX0mXUVpLXO/xr4kVIpO2MQqJBC54/Mjkyo/DkfUfJWuQUFhGxJK/sLfNAMBfFR1Q
         YrFRx4tWMmGB/H620F2/Am8acrs6wdUD9aThBcRoI/+3G/e5SzrbREP4TTzjwPCJbfWb
         lK5ONgySOXBL+sEyUBUpNLpb/M2CMZX7qhgzMeyBAuXDvCfWJ3d1X+BhPN/5NF9MwFh/
         67Bw==
X-Gm-Message-State: AGi0PuZYN5pyRUoXyPQDOamVY/yUX16Imz1TVi7BS1qB1TP2anPrlC84
        DX0RLeUhwie/pK8LCH9AOR4=
X-Google-Smtp-Source: APiQypL1aK9gbywBv82JBASBFzjKaiFmlC4rPz0Q9vs/PGDe+fvOlkd9nbRHXXJy4MRlg/Y/tJFHSw==
X-Received: by 2002:ac2:4573:: with SMTP id k19mr12705854lfm.144.1587457028042;
        Tue, 21 Apr 2020 01:17:08 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j13sm1472756lfb.19.2020.04.21.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:07 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH 2/3] Bluetooth: hci_qca: add compatible for QCA9377
Date:   Tue, 21 Apr 2020 08:16:55 +0000
Message-Id: <20200421081656.9067-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421081656.9067-1-christianshewitt@gmail.com>
References: <20200421081656.9067-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible so QCA9377 devices can be defined in device-tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 439392b1c043..6f0350fbdcd6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2046,6 +2046,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
 
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
+	{ .compatible = "qcom,qca9377-bt" },
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
-- 
2.17.1

