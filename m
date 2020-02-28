Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97696C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9E6246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YfiJ3jOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgB1JS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:18:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38136 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:18:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200228091853euoutp0242b7362cce9a2fd19553d9254ceb5cb7~3hl4_l3Db0438304383euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:18:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200228091853euoutp0242b7362cce9a2fd19553d9254ceb5cb7~3hl4_l3Db0438304383euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582881533;
        bh=Cx/KisrZcE4N00t4ikLjmXXzqLLpj5BvenJ3Ar+A0ho=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YfiJ3jODmBVbgu/nB9FF35fIgO7sed2hA/s9uMGaSTA6C+VvBsJ/L6bBHfBKcZjti
         RKiC3CE9WDByH43DNC4tAC324ztUG1+taePAM1uNOZFrLTcGKXWGacL2Jt+D0zIvtq
         of0x0yuXiIetZt7rJqmyOTcTnZKytKU2w5klXuyw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200228091853eucas1p21dca5e87fa987dcaf3506827725c131e~3hl4qpMBL2979429794eucas1p21;
        Fri, 28 Feb 2020 09:18:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.A4.60698.CFAD85E5; Fri, 28
        Feb 2020 09:18:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200228091852eucas1p12830eef2696807dc130216293cab4899~3hl4N-jb83168731687eucas1p13;
        Fri, 28 Feb 2020 09:18:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228091852eusmtrp1dbee03c6b8bf008fcb87ec1a6e41ec00~3hl4NXpS71679016790eusmtrp1v;
        Fri, 28 Feb 2020 09:18:52 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-bf-5e58dafc03dc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.DC.08375.CFAD85E5; Fri, 28
        Feb 2020 09:18:52 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200228091852eusmtip1daa9176ef455ead56e6b011303518d1c~3hl3xQbYQ2822828228eusmtip1Z;
        Fri, 28 Feb 2020 09:18:52 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/panfrost: Silence warnings during deferred probe
Date:   Fri, 28 Feb 2020 10:18:42 +0100
Message-Id: <20200228091842.1417-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87p/bkXEGUw8aWlx7lI3q8X/bROZ
        La58fc9mcXnXHDaLtUfuslv837OD3aLxCFCsb+0lNgcOjzXz1jB67Li7hNFj77cFLB6bVnWy
        edzvPs7k0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk3l9xkLDgiUXHiyWrmBsa1Il2MnBwS
        AiYSJ15sZuti5OIQEljBKHFo7kIWCOcLo8SMO+ugnM+MEq0LbrHAtPS3v4ZKLGeU2LzzHCNc
        y9Tu32wgVWwChhJdb7vAbBEBR4n5z96AFTEL/GKUONxxlREkISzgKtEyfy5QEQcHi4CqxMyT
        XCBhXgEbif43O5ggtslLrN5wgBmkV0LgOZvEzSl7oc5wkVi1fQKULSzx6vgWdghbRuL05B4W
        iIZmRomH59ayQzg9jBKXm2YwQlRZS9w59wtsM7OApsT6XfoQYUeJpxNXMYKEJQT4JG68FQQJ
        MwOZk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCFsD4k917rBFgkJxEosafrMOoFRbhbCrgWM
        jKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk8Xpf8e/7mDc9yfpEKMAB6MSD++CHeFx
        QqyJZcWVuYcYJTiYlUR4N34NjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2
        ampBahFMlomDU6qB8STrxTebfmkdyNH4trG0RdJ51tqyxVvs5Deo8N49d/VmV7paa27605L7
        VR9/rRfQ/TzxalC5BwObd2Q1/5+3vqr7uyfV/Tq8IkrnZO62Rdlu/uo3Vn3uzprZc/i/7bTi
        cznPL7/ZzXVa+EmtPef07mkOjdI31ANSW05c8TDIv/WV7fIzl4dnXyqxFGckGmoxFxUnAgAM
        BHtxEgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xu7p/bkXEGZxtUrA4d6mb1eL/tonM
        Fle+vmezuLxrDpvF2iN32S3+79nBbtF4BCjWt/YSmwOHx5p5axg9dtxdwuix99sCFo9NqzrZ
        PO53H2fy6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYybS24yFhyRqDjxZDVzA+NakS5GTg4JAROJ/vbXLCC2kMBSRolD/5Mg
        4jISJ6c1sELYwhJ/rnWxdTFyAdV8YpRYfn83G0iCTcBQoustSIKDQ0TAWWLZ0hCQMLPAP0aJ
        fzejQWxhAVeJlvlzwUpYBFQlZp7kAgnzCthI9L/ZwQQxXl5i9YYDzBMYeRYwMqxiFEktLc5N
        zy021CtOzC0uzUvXS87P3cQIDM5tx35u3sF4aWPwIUYBDkYlHt4FO8LjhFgTy4orcw8xSnAw
        K4nwbvwaGifEm5JYWZValB9fVJqTWnyI0RRo90RmKdHkfGDk5JXEG5oamltYGpobmxubWSiJ
        83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYGRrzvp5uiFuI3/K6sv7zlyUO2bDkMRTVRxY0pPD
        aucte72eeVLrFRbV6S/3zBLY468T1JKpxDFHZ6PjUaWr349c8Lh/aVJ+UMP7sDm1B682TNkR
        26gUY36BR4O5TC/OblmQwErzQ4JzzbqiTL8UhShJPZPeaf7s3oQD7075nez8J//x431DOSWW
        4oxEQy3mouJEABrPMDRkAgAA
X-CMS-MailID: 20200228091852eucas1p12830eef2696807dc130216293cab4899
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228091852eucas1p12830eef2696807dc130216293cab4899
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228091852eucas1p12830eef2696807dc130216293cab4899
References: <CGME20200228091852eucas1p12830eef2696807dc130216293cab4899@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't confuse user with meaningless warnings about the failure in getting
resources in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 238fb6d54df4..1c3f2e656b53 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -21,7 +21,9 @@ static int panfrost_reset_init(struct panfrost_device *pfdev)
 
 	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
 	if (IS_ERR(pfdev->rstc)) {
-		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
+		if (PTR_ERR(pfdev->rstc) != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "get reset failed %ld\n",
+				PTR_ERR(pfdev->rstc));
 		return PTR_ERR(pfdev->rstc);
 	}
 
@@ -44,7 +46,9 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 
 	pfdev->clock = devm_clk_get(pfdev->dev, NULL);
 	if (IS_ERR(pfdev->clock)) {
-		dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(pfdev->clock));
+		if (PTR_ERR(pfdev->clock) != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "get clock failed %ld\n",
+				PTR_ERR(pfdev->clock));
 		return PTR_ERR(pfdev->clock);
 	}
 
@@ -57,8 +61,9 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 
 	pfdev->bus_clock = devm_clk_get_optional(pfdev->dev, "bus");
 	if (IS_ERR(pfdev->bus_clock)) {
-		dev_err(pfdev->dev, "get bus_clock failed %ld\n",
-			PTR_ERR(pfdev->bus_clock));
+		if (PTR_ERR(pfdev->bus_clock) != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "get bus_clock failed %ld\n",
+				PTR_ERR(pfdev->bus_clock));
 		return PTR_ERR(pfdev->bus_clock);
 	}
 
@@ -91,9 +96,10 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 
 	pfdev->regulator = devm_regulator_get(pfdev->dev, "mali");
 	if (IS_ERR(pfdev->regulator)) {
-		ret = PTR_ERR(pfdev->regulator);
-		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
-		return ret;
+		if (PTR_ERR(pfdev->regulator) != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "failed to get regulator: %d\n",
+				PTR_ERR(pfdev->regulator));
+		return PTR_ERR(pfdev->regulator);
 	}
 
 	ret = regulator_enable(pfdev->regulator);
@@ -124,19 +130,22 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 	err = panfrost_clk_init(pfdev);
 	if (err) {
-		dev_err(pfdev->dev, "clk init failed %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "clk init failed %d\n", err);
 		return err;
 	}
 
 	err = panfrost_regulator_init(pfdev);
 	if (err) {
-		dev_err(pfdev->dev, "regulator init failed %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "regulator init failed %d\n", err);
 		goto err_out0;
 	}
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
-		dev_err(pfdev->dev, "reset init failed %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "reset init failed %d\n", err);
 		goto err_out1;
 	}
 
-- 
2.17.1

