Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C38EC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CD21741
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G8rYXbYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHUHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:11:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50486 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgHUHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:11:29 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200821071127epoutp02fcfed8b42b3879bdb4de3522a9c265b2~tNvlakmeV0919509195epoutp02B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200821071127epoutp02fcfed8b42b3879bdb4de3522a9c265b2~tNvlakmeV0919509195epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597993887;
        bh=iHQfb3qtW7lSUWGtt4riwSXRHVNT71MHvCk8OlOASjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8rYXbYtE4CWgnQloz6ZfiEkxseHgOfis4LTh0yCMeDbv+cjv2pUzFg2EJEUTseB/
         U9DJE4lZsZvvTybZY6FyhSRbIGIXWLndprlD/07jty8jet5omcL3dXTqxmNbJVSuyb
         qwJz1jNJkbTddKNCFUQ2xmwHVfIMYvHOkOH2ob3g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821071126epcas1p26f66164557f6b3b1e472aaa003fb1eca~tNvknmX-M2805528055epcas1p2Q;
        Fri, 21 Aug 2020 07:11:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BXt3Z4gGKzMqYkZ; Fri, 21 Aug
        2020 07:11:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.8D.18978.A937F3F5; Fri, 21 Aug 2020 16:11:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821071122epcas1p1069b0f2dd06ddff3bd5474dbec227684~tNvgeHvCf1342713427epcas1p1S;
        Fri, 21 Aug 2020 07:11:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821071122epsmtrp2501dfcf38a3ec4ac5c6aef1cc1b1bad7~tNvgdPfsV2513725137epsmtrp2O;
        Fri, 21 Aug 2020 07:11:22 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-62-5f3f739a58d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.C1.08382.9937F3F5; Fri, 21 Aug 2020 16:11:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200821071121epsmtip2af7047736c5b2832c065fb8aaa705105~tNvgLrnl82425024250epsmtip2g;
        Fri, 21 Aug 2020 07:11:21 +0000 (GMT)
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
To:     nsaenzjulienne@suse.de, eric@anholt.net, maxime@cerno.tech
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        dave.stevenson@raspberrypi.com, sboyd@kernel.org,
        mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, hoegeun.kwon@samsung.com
Subject: [PATCH 2/3] ARM: dts: bcm2711: Add bvb clock for hdmi-pixel
Date:   Fri, 21 Aug 2020 16:10:44 +0900
Message-Id: <20200821071045.24501-3-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821071045.24501-1-hoegeun.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmru6sYvt4g+nnxC3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20ji8WjqfcZHYQ8mt4fY/N4f6OV3WPW/bNsHnfOnWfz
        2DnrLrvHplWdbB73u48zeWxeUu/RevQXi0ffllWMHptPV3t83iQXwBOVbZORmpiSWqSQmpec
        n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9J2SQlliTilQKCCxuFhJ386m
        KL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvjyYJX7AUN7BWPei4y
        NjA+Ze1i5OSQEDCR+PDiLnMXIxeHkMAORolvy2cyQTifGCXOTt3ECOF8Y5SY+vQ0E0zLjFsT
        oVr2MkrsurGNBcL5zCjx5vE2RpAqNgFdia8918E6RATsJNp6DoKNYhbYzixxvb2bHSQhLOAi
        8XjTLrAiFgFViat9q8Gu4hWwlWhsuQW1Tl5i9YYDzCA2J9CgxXeWgm2TEDjDIbHpeTsbRJGL
        xO8jy5khbGGJV8e3sEPYUhKf3+2FqimWuDLzFVRzA6NE/8TZUEXGEvuXTgbaxgF0nqbE+l36
        EGFFiZ2/54J9wyzAJ/Huaw8rSImEAK9ER5sQRImaxLOGA9CQlJE41bsc6mYPiRM/NkADciKj
        xMINT5gnMMrNQtiwgJFxFaNYakFxbnpqsWGBIXKkbWIEJ2At0x2ME99+0DvEyMTBeIhRgoNZ
        SYS3d691vBBvSmJlVWpRfnxRaU5q8SFGU2DoTWSWEk3OB+aAvJJ4Q1MjY2NjCxNDM1NDQyVx
        3oe3FOKFBNITS1KzU1MLUotg+pg4OKUamOzermAqX99TfkP8+XSOLeaJ2fvjNRtnBP/3+5Ug
        /449lXVNhHen/R+P1nnWn7/GrCqbG7xAZ177vY3cq1i+fL8uIHJ3m+a/8gVlt/lib0l+9vxe
        3vFiQVDv8VVsF+epfmpLWXd52V2pGTtPer6KSCpssjZSjTN5erJkacTa6IT3pdccV3sp7/3E
        svzvxE/XdZ80Xjp4tmanfbCU/IFk/X75NKZVax6WeQbuuGIiLOWutl//cNWaU09Dgnn/RmVW
        /MmKXTJ7/t/LfAu8F+7klVvwpKlX/aDS+gNescxJGZ//Lmra9rNO8Et5uOh7Se+1CTnve/YL
        BhT8XnbThEHvX9tsS/Ws47s3ljxNZfx1o16JpTgj0VCLuag4EQCqt4k+SQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO7MYvt4gwOXbSzW9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20ji8WjqfcZHYQ8mt4fY/N4f6OV3WPW/bNsHnfOnWfz
        2DnrLrvHplWdbB73u48zeWxeUu/RevQXi0ffllWMHptPV3t83iQXwBPFZZOSmpNZllqkb5fA
        lfFkwSv2ggb2ikc9FxkbGJ+ydjFyckgImEjMuDWRuYuRi0NIYDejRNOsZ+wQCRmJVf1bgIo4
        gGxhicOHiyFqPjJKvPt1HKyGTUBX4mvPdSYQW0TASeLB331gg5gFjjNLTO8/ALZBWMBF4vGm
        XWBFLAKqElf7VoPFeQVsJRpbbjFBLJOXWL3hADOIzSlgJ7H4zlIWEFsIqOZUx0fmCYx8CxgZ
        VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeJluYOxu2rPugdYmTiYDzEKMHBrCTC
        27vXOl6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUwWSYOTqkGJlfT
        /+xLem96myedzeY5GBt35O5+gcrjTI9mFb/ZkysyvSFNmXu2benESQfbdI9cK3K59JZL31ii
        4vgVG67Q5aWaR0t/H31alxg6b1ndZ4OZil+LeVn+Ll48++qzpcKHl8V1qtjf0S8zLrjRMdlh
        232bQE3bf8Vz1Ksmq7w6d/P6zA/C3M58228uKnjZJae7v7pYe/6EhKOHf4V/8zp+VPnD7n15
        DHbiPG/eyevFfLjAcyZ2+WuvSNnnyx+t8rnje3xizQ5lGcHjwXZ/b98rDbOMKv7nY/OnUKx/
        3p7dBv0T5kVNvK7Afn67sP0y6fSOkDvMwvH3W2L+H1y4rbHSY7nowo2HOws+T9DoXDm74JsS
        S3FGoqEWc1FxIgDJSD/3AQMAAA==
X-CMS-MailID: 20200821071122epcas1p1069b0f2dd06ddff3bd5474dbec227684
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200821071122epcas1p1069b0f2dd06ddff3bd5474dbec227684
References: <20200821071045.24501-1-hoegeun.kwon@samsung.com>
        <CGME20200821071122epcas1p1069b0f2dd06ddff3bd5474dbec227684@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is necessary to control the hdmi pixel bvb clock. Add bvb clock.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index b93eb30e1ddb..90dee4cb38bc 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -172,12 +172,14 @@
 };
 
 &hdmi0 {
-	clocks = <&firmware_clocks 13>, <&dvp 0>;
+	clocks = <&firmware_clocks 13>, <&dvp 0>, <&firmware_clocks 14>;
+	clock-names = "hdmi", "clk-108M", "bvb";
 	status = "okay";
 };
 
 &hdmi1 {
-	clocks = <&firmware_clocks 13>, <&dvp 1>;
+	clocks = <&firmware_clocks 13>, <&dvp 1>, <&firmware_clocks 14>;
+	clock-names = "hdmi", "clk-108M", "bvb";
 	status = "okay";
 };
 
-- 
2.17.1

