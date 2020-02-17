Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6022C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDFA206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CzaK/pYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgBQKjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:39:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12376 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:39:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200217103933epoutp03b84196306de4fcca2b9d53a16309491a~0KmLV0RPu2024520245epoutp031
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:39:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200217103933epoutp03b84196306de4fcca2b9d53a16309491a~0KmLV0RPu2024520245epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581935973;
        bh=X5BX/mQfUTuZ/7wEkacBaeQSNSzJ/TGWyIHmtULhFnQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CzaK/pYNrUFBKFVy64tkU7V8/a4PXsHvO3RdhXjqxzJFt/oHeXCKYhRKn5VKRj9Tp
         IcfIYm/nGAUJOCqsCYdRfCwjkfY0aApJ4XXOgUV5jqBYp/aG3VVQfmiaDx0aBOWK37
         X2UYTWanoWGV3ypzv4nWQfytqdzBm78Y9BBiBlZY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200217103932epcas1p4c51dc1a36d0d8d00b0cd388ba1fdcbdc~0KmLHQ6yU0060100601epcas1p4p;
        Mon, 17 Feb 2020 10:39:32 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48LgTW3zMYzMqYkk; Mon, 17 Feb
        2020 10:39:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.8B.52419.F5D6A4E5; Mon, 17 Feb 2020 19:39:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd~0KmFwRFVG1226612266epcas1p2V;
        Mon, 17 Feb 2020 10:39:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200217103927epsmtrp11d5b938f980be8fde71ebe3bf353d2b3~0KmFvmju11096510965epsmtrp1c;
        Mon, 17 Feb 2020 10:39:27 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-3e-5e4a6d5f8f46
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.F5.10238.E5D6A4E5; Mon, 17 Feb 2020 19:39:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200217103926epsmtip1afc8cbeca342657b0e61216473f5b869~0KmFfOZVI1409014090epsmtip1H;
        Mon, 17 Feb 2020 10:39:26 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: Remove unneeded extern keyword from
 extcon-provider.h
Date:   Mon, 17 Feb 2020 19:47:28 +0900
Message-Id: <20200217104728.29330-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmrm58rlecwd7/ChYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsapJffYC57IVZxbu4ix
        gbFdqouRk0NCwETi8+KlLF2MXBxCAjsYJWZNWswM4XxilDje2s4I4XxjlNh96RcjTMvNq9PZ
        IRJ7GSUuvz8J5XxhlHj+eTkzSBWbgJbE/hc32EBsEQE5iSe3/4DFmQXSJX7/XgcWFxYIkJi2
        6hk7iM0ioCrx4tolFhCbV8BK4ua/ZWwQ2+QlVm84AHaThMBXVomFH1uhznCRWAT0EYQtLPHq
        +BYoW0riZX8blF0tsfLkETaI5g5GiS37L7BCJIwl9i+dzNTFyAF0kabE+l36EGFFiZ2/5zJC
        HMon8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sECUeEidfZYGEhQRiJfY9n8M+gVF2
        FsL8BYyMqxjFUguKc9NTiw0LjJFjaRMjOC1pme9g3HDO5xCjAAejEg/vi0DPOCHWxLLiytxD
        jBIczEoivN7iXnFCvCmJlVWpRfnxRaU5qcWHGE2BgTeRWUo0OR+YMvNK4g1NjYyNjS1MDM1M
        DQ2VxHkfRmrGCQmkJ5akZqemFqQWwfQxcXBKNTDyRRytU91h8G3Tzrt17TIHD+qrKuie9Pdf
        Mkni26GvbHnrlEpeMLS+j13/7uSHO2XTNn6MPiusXsek2Gy5tVtHllNx52xvth0LvFkZXi/g
        kkvveerx0VjhbUjXE+sfLzI/X2UUaijksDx/+M+FTH9/G8XOF5N0I888D1KSk54d/iu4+MWd
        lm4lluKMREMt5qLiRAAhWtWrYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsWy7bCSnG5crlecwfx3lhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xqkl99gLnshVnFu7iLGBsV2qi5GTQ0LAROLm1ensXYxcHEICuxklrjadYYdISEpMu3iUuYuR
        A8gWljh8uBii5hOjxJ7/KxhBatgEtCT2v7jBBmKLCMhJPLn9hxnEZhbIlpj8Zj0riC0s4Cex
        /dhysHoWAVWJF9cusYDYvAJWEjf/LWOD2CUvsXrDAeYJjDwLGBlWMUqmFhTnpucWGxYY5qWW
        6xUn5haX5qXrJefnbmIEh4mW5g7Gy0viDzEKcDAq8fC+CPSME2JNLCuuzD3EKMHBrCTC6y3u
        FSfEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDY9JmgXvB
        E5b1vDqaYXWh5EHwidLIBb27fQU/McsdlBc+rHzvebCB3PL7byV8Tjy46zfbWMVDYMnNXQ/T
        Mj81Tz60dWbbF6H052eVyzVqrLVeHP1xbOXjlU+T+284etz96Mn9T3M2+w3Ww3k2q2IEmdat
        nVH/V6dr7mSd5PSk1cmeD3klBSQ1XyuxFGckGmoxFxUnAgDcrS5SDwIAAA==
X-CMS-MailID: 20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd
References: <CGME20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit tb7365587f513 ("extcon: Remove unneeded extern keyword
from extcon.h") removes the unneeded extern keyword from extcon header
file. But, The commit tb7365587f513 has missed that deletes 'extern'
keyword from extcon-provider.h. So that it deletes extern keyword
from extcon-provider.h.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Dear Greg,

When I removed the unneeded extern keyword from extcon hearder file for
v5.6-rc1, although I should remove 'extern' keyword on both extcon.h
and extcon-provider.h, I only removed them from extcon.h. It was my mistake.

So that I send this patch for v5.6-rc3 release.
Could you review and apply it to char-misc git repository directly?

 include/linux/extcon-provider.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
index 1c143d200caa..fa70945f4e6b 100644
--- a/include/linux/extcon-provider.h
+++ b/include/linux/extcon-provider.h
@@ -17,30 +17,30 @@ struct extcon_dev;
 #if IS_ENABLED(CONFIG_EXTCON)
 
 /* Following APIs register/unregister the extcon device. */
-extern int extcon_dev_register(struct extcon_dev *edev);
-extern void extcon_dev_unregister(struct extcon_dev *edev);
-extern int devm_extcon_dev_register(struct device *dev,
+int extcon_dev_register(struct extcon_dev *edev);
+void extcon_dev_unregister(struct extcon_dev *edev);
+int devm_extcon_dev_register(struct device *dev,
 				struct extcon_dev *edev);
-extern void devm_extcon_dev_unregister(struct device *dev,
+void devm_extcon_dev_unregister(struct device *dev,
 				struct extcon_dev *edev);
 
 /* Following APIs allocate/free the memory of the extcon device. */
-extern struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
-extern void extcon_dev_free(struct extcon_dev *edev);
-extern struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
+struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
+void extcon_dev_free(struct extcon_dev *edev);
+struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
 				const unsigned int *cable);
-extern void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
+void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
 
 /* Synchronize the state and property value for each external connector. */
-extern int extcon_sync(struct extcon_dev *edev, unsigned int id);
+int extcon_sync(struct extcon_dev *edev, unsigned int id);
 
 /*
  * Following APIs set the connected state of each external connector.
  * The 'id' argument indicates the defined external connector.
  */
-extern int extcon_set_state(struct extcon_dev *edev, unsigned int id,
+int extcon_set_state(struct extcon_dev *edev, unsigned int id,
 				bool state);
-extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
+int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
 				bool state);
 
 /*
@@ -52,13 +52,13 @@ extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
  * for each external connector. They are used to set the capability of the
  * property of each external connector based on the id and property.
  */
-extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
+int extcon_set_property(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value prop_val);
-extern int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
+int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value prop_val);
-extern int extcon_set_property_capability(struct extcon_dev *edev,
+int extcon_set_property_capability(struct extcon_dev *edev,
 				unsigned int id, unsigned int prop);
 
 #else /* CONFIG_EXTCON */
-- 
2.17.1

