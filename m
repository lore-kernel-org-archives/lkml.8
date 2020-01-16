Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C301C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224912075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 04:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m+VmBaBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgAPEcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:32:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:60023 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgAPEcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 23:32:42 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200116043240epoutp035d4bd46835c5b5e265a2796f1e596913~qQ8tfvqNO0618406184epoutp03p
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 04:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200116043240epoutp035d4bd46835c5b5e265a2796f1e596913~qQ8tfvqNO0618406184epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579149160;
        bh=CWPW24OCUknxZ2lCY455bTwF3xNcH4PnzlBG80rCqlY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m+VmBaBuij+n8tC/YSFQ8bFA1DCJ6k7oXOu7DAu1WcmSMTCR7wr4AXeHLD73iwNkr
         TUscwWEnklGtvk012Rs2qHibBsfSkVjX0iER85pXuTLFpTuHPN/0c/9jjfc9w5z6i+
         x8icHfKySa0Ksg3OvMJqHuuWVVovb62NfekJjNNk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116043239epcas1p176bc440c314dcb086db9fdf3dbf52ce0~qQ8tO4SkO1553415534epcas1p1U;
        Thu, 16 Jan 2020 04:32:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47yrs12sHczMqYm8; Thu, 16 Jan
        2020 04:32:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.09.52419.D57EF1E5; Thu, 16 Jan 2020 13:32:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f~qQ8i6Gg4s1971019710epcas1p1F;
        Thu, 16 Jan 2020 04:32:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116043228epsmtrp10889d82a7824a3fb4d60216a3639c3e2~qQ8i5jBVZ3239732397epsmtrp1Y;
        Thu, 16 Jan 2020 04:32:28 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-95-5e1fe75d5236
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.BE.06569.C57EF1E5; Thu, 16 Jan 2020 13:32:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116043228epsmtip2c18749c49c055ce65676c657b5c1aef9~qQ8iyasE_2995729957epsmtip2g;
        Thu, 16 Jan 2020 04:32:28 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org, myungjoo.ham@samsung.com
Subject: [PATCH] extcon: Remove unneeded extern keyword from extcon.h
Date:   Thu, 16 Jan 2020 13:39:47 +0900
Message-Id: <20200116043947.12556-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmrm7sc/k4g813RC0m3rjCYnH9y3NW
        i8u75rBZ3G5cwebA4rFpVSebR9+WVYwenzfJBTBHZdtkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnbJy+kbmgQaHi9o9n7A2MLdJdjJwcEgIm
        Ere+XmMDsYUEdjBKLN2k0MXIBWR/YpRYtfw1I4TzjVFiyZT3bDAd70+th0rsZZQ4fGAvM0T7
        F0aJy79iQGw2AS2J/S9ugDWICChIbO59xgpiMwu4S3z40Q9WLyzgKnH7SSsLiM0ioCpxcNZU
        sDivgJXE3d3vWCCWyUus3nCAGWSZhMBDVolHK68xQSRcJD513maEsIUlXh3fwg5hS0m87G+D
        sqslVp48wgbR3MEosWX/BVaIhLHE/qWTgQZxAF2kKbF+lz5EWFFi5++5jBCH8km8+9rDClIi
        IcAr0dEmBFGiLHH5wV2oEyQlFrd3QgPFQ2Jv1xUmSDjESrx+Po99AqPsLIQFCxgZVzGKpRYU
        56anFhsWGCNH0iZGcALSMt/BuOGczyFGAQ5GJR7ejD9ycUKsiWXFlbmHGCU4mJVEeE/OkI0T
        4k1JrKxKLcqPLyrNSS0+xGgKDL2JzFKiyfnA5JhXEm9oamRsbGxhYmhmamioJM7rugBojkB6
        YklqdmpqQWoRTB8TB6dUA2Nb/nbxc4uetCVP00xx2OuxpaTuUOTD2ZtPv3/h4bmlojP44dtn
        ElOjBFge8rzh/1U+q++6z3lT7QS2wHUbXXLz3k9k1zPk35pveGT3zNJQ4xSR47ydHyJnZi54
        59MrNElZ6RDz1DJTV4Xua1vs44S2MUh8LuZMFPKtkZ7uo36upmBltIDRCyWW4oxEQy3mouJE
        AEaChVVWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSvG7Mc/k4g2UftSwm3rjCYnH9y3NW
        i8u75rBZ3G5cwebA4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGVsnL6RuaBBoeL2
        j2fsDYwt0l2MnBwSAiYS70+tZ+xi5OIQEtjNKHGq6yY7REJSYtrFo8xdjBxAtrDE4cPFEDWf
        GCX6nh1iA6lhE9CS2P/iBpgtIqAgsbn3GSuIzSzgLdG7+wnYHGEBV4nbT1pZQGwWAVWJg7Om
        MoPYvAJWEnd3v2OB2CUvsXrDAeYJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefn
        bmIEh4SW1g7GEyfiDzEKcDAq8fAe+CcXJ8SaWFZcmXuIUYKDWUmE9+QM2Tgh3pTEyqrUovz4
        otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjJWh1t9iJJ+d/z61J0DhdWrI
        mm6fpVJxH3rZXRz8Z965Wl4w0SpLj+/n6lqX9dU6Si2CC4RjlIV5cixipjNd283Ytc/JUHFG
        iVTvoeJm85bplczNgtv/xe/fYhUexfcyT7SoPsn/zdHWl5aGG44sPHZ/7ZOJguFVYWEPN9/V
        232Jw5ojV5hZiaU4I9FQi7moOBEAXpi7mAUCAAA=
X-CMS-MailID: 20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f
References: <CGME20200116043228epcas1p11a74c5935b015ec85fc61da8cf12681f@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'extern' keyword is unneeded in extcon.h because public header file
of extcon defines the function prototype.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/extcon.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 2bdf643d8593..1b1d77ec2114 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -170,7 +170,7 @@ struct extcon_dev;
  * Following APIs get the connected state of each external connector.
  * The 'id' argument indicates the defined external connector.
  */
-extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
+int extcon_get_state(struct extcon_dev *edev, unsigned int id);
 
 /*
  * Following APIs get the property of each external connector.
@@ -181,10 +181,10 @@ extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
  * for each external connector. They are used to get the capability of the
  * property of each external connector based on the id and property.
  */
-extern int extcon_get_property(struct extcon_dev *edev, unsigned int id,
+int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value *prop_val);
-extern int extcon_get_property_capability(struct extcon_dev *edev,
+int extcon_get_property_capability(struct extcon_dev *edev,
 				unsigned int id, unsigned int prop);
 
 /*
@@ -196,38 +196,38 @@ extern int extcon_get_property_capability(struct extcon_dev *edev,
  * extcon_register_notifier_all(*edev, *nb) : Register a notifier block
  *			for all supported external connectors of the extcon.
  */
-extern int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
+int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb);
-extern int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
+int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb);
-extern int devm_extcon_register_notifier(struct device *dev,
+int devm_extcon_register_notifier(struct device *dev,
 				struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb);
-extern void devm_extcon_unregister_notifier(struct device *dev,
+void devm_extcon_unregister_notifier(struct device *dev,
 				struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb);
 
-extern int extcon_register_notifier_all(struct extcon_dev *edev,
+int extcon_register_notifier_all(struct extcon_dev *edev,
 				struct notifier_block *nb);
-extern int extcon_unregister_notifier_all(struct extcon_dev *edev,
+int extcon_unregister_notifier_all(struct extcon_dev *edev,
 				struct notifier_block *nb);
-extern int devm_extcon_register_notifier_all(struct device *dev,
+int devm_extcon_register_notifier_all(struct device *dev,
 				struct extcon_dev *edev,
 				struct notifier_block *nb);
-extern void devm_extcon_unregister_notifier_all(struct device *dev,
+void devm_extcon_unregister_notifier_all(struct device *dev,
 				struct extcon_dev *edev,
 				struct notifier_block *nb);
 
 /*
  * Following APIs get the extcon_dev from devicetree or by through extcon name.
  */
-extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
-extern struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
-extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
+struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
+struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
 /* Following API get the name of extcon device. */
-extern const char *extcon_get_edev_name(struct extcon_dev *edev);
+const char *extcon_get_edev_name(struct extcon_dev *edev);
 
 #else /* CONFIG_EXTCON */
 static inline int extcon_get_state(struct extcon_dev *edev, unsigned int id)
-- 
2.17.1

