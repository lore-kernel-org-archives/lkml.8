Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77687C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A4A24672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FGFpiXGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgB1Jkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:40:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46622 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Jkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:40:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200228094034euoutp021bc8068bf923797ea62348eadb984756~3h40vuBpK1921719217euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:40:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200228094034euoutp021bc8068bf923797ea62348eadb984756~3h40vuBpK1921719217euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582882834;
        bh=GJDkwr6scZCKsoNv4vj4+3w9fWMzh/qi3tA0cUWtFA0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FGFpiXGoeoNciTDyUxpU3cMB1p/ZOdO9mGnwCrgn56kDrqACnn8s5tOiM/lbMa+KY
         r8O6xJaT7+kqxq+p5VBa6Cu0aexxkRaJUHw0fCEsEFd++PaMJgyrUUJXd6U5bIZSsS
         xjeCUKYMKrvdmxQF204i+zcSaITKND0pF9rBgM+c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200228094034eucas1p1a4378f8dd1bdfecfe66ad0f8fa563288~3h40bnf9T0597105971eucas1p1l;
        Fri, 28 Feb 2020 09:40:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.42.60679.210E85E5; Fri, 28
        Feb 2020 09:40:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed~3h40D2ARh1645516455eucas1p2d;
        Fri, 28 Feb 2020 09:40:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200228094033eusmtrp2aaffc1b9a078d0ea504757e822c270fb~3h40DM_hH1033410334eusmtrp2X;
        Fri, 28 Feb 2020 09:40:33 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-aa-5e58e012b1c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.10.08375.110E85E5; Fri, 28
        Feb 2020 09:40:33 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200228094033eusmtip200f9c1a6c7c6961f0be43c630737ff3f~3h4zqM8T40483404834eusmtip2j;
        Fri, 28 Feb 2020 09:40:33 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] drm: panfrost: Silence warnings during deferred probe
Date:   Fri, 28 Feb 2020 10:40:26 +0100
Message-Id: <20200228094026.26983-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87pCDyLiDA5847A4d6mb1eL/tonM
        Fle+vmezuLxrDpvF2iN32S3+79nBbtF4BCjWt/YSmwOHx5p5axg9dtxdwuix99sCFo9NqzrZ
        PO53H2fy6NuyitHj8ya5APYoLpuU1JzMstQifbsErowHK36xF7wTq7jxbD1rA+N7oS5GTg4J
        AROJZ68XsHcxcnEICaxglJh0ZgMThPOFUeLggi1Qmc+MEh+XbGOBaXnxYBpUYjmjxJkLb9nh
        WjrfH2cDqWITMJToetsFZosIOErMf/aGEaSIWeAXo8ThjqtADgeHsICnxPotCiA1LAKqEvMP
        3WAGsXkFbCUOfvzADrFNXmL1hgPMIL0SAq/ZJH7f+cgGkXCR+POnkxXCFpZ4dXwLVIOMxP+d
        85kgGpoZJR6eW8sO4fQwSlxumsEIUWUtcefcLzaQK5gFNCXW79KHCDtKNN76xwISlhDgk7jx
        VhAkzAxkTto2nRkizCvR0QYNPDWJWcfXwa09eOESM4TtIbH2x2+wRUICsRIXV3xim8AoNwth
        1wJGxlWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiByeL0v+NfdjDu+pN0iFGAg1GJh3fB
        jvA4IdbEsuLK3EOMEhzMSiK8G7+GxgnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2x
        JDU7NbUgtQgmy8TBKdXAaHJi0hOjGSmv/LQ+PbkZ2PR6kvzqtCK92aX7DFrm6Miea5zWnDy/
        V/wku+D6m1/MXYuOWvPwm56uPcjsdF70+gG/8Hi5zYKzL7Wt/DTF2aM8Y+udE50r+Ha+/tra
        8HjHtENhFhsVC5zNYz8cYNM02vzKyqfhmOFMpsKkINuHxxea66dkNkysV2Ipzkg01GIuKk4E
        AJ9AQukSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xe7qCDyLiDNY817Y4d6mb1eL/tonM
        Fle+vmezuLxrDpvF2iN32S3+79nBbtF4BCjWt/YSmwOHx5p5axg9dtxdwuix99sCFo9NqzrZ
        PO53H2fy6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwHK36xF7wTq7jxbD1rA+N7oS5GTg4JAROJFw+msXcxcnEICSxllLh+
        bDILREJG4uS0BlYIW1jiz7UuNhBbSOATo8TXE+kgNpuAoUTXW5A4B4eIgLPEsqUhIGFmgX+M
        Ev9uRoOEhQU8JdZvUQAJswioSsw/dIMZxOYVsJU4+PEDO8R0eYnVGw4wT2DkWcDIsIpRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwOLcd+7l5B+OljcGHGAU4GJV4eBfsCI8TYk0sK67MPcQo
        wcGsJMK78WtonBBvSmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPzgZGTVxJvaGpobmFpaG5sbmxm
        oSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0fhiosL/6csFftiViy3+vy7oT9Ou3ydU9gX6
        G/kzrpLYuXiadJOa5947+u/MxB8xFMW8MJjD+veL7/IAozNiOnWHzZ5YTW5zrlz7aoFqvNz/
        H2wZm69fbfGoTd+fULzwZTPj5mMvZvw0ypvdZ/UsrW9t+9SzsxUCqySmFr/Qibh4vSllafIv
        WSWW4oxEQy3mouJEAImthNNkAgAA
X-CMS-MailID: 20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed
References: <CGME20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- fixed build warning
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 26 +++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 238fb6d54df4..2c4ada3041b1 100644
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
 
@@ -92,7 +97,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 	pfdev->regulator = devm_regulator_get(pfdev->dev, "mali");
 	if (IS_ERR(pfdev->regulator)) {
 		ret = PTR_ERR(pfdev->regulator);
-		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "failed to get regulator: %d\n",
+				ret);
 		return ret;
 	}
 
@@ -124,19 +131,22 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
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

