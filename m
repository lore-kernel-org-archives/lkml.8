Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC0D20719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PoPI/6xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIAEJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:09:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36643 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIAEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:08:57 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200901040854epoutp03c2ae96427817a5ec27f43c4402a5c857~wjWV_WFV50505205052epoutp03W
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 04:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200901040854epoutp03c2ae96427817a5ec27f43c4402a5c857~wjWV_WFV50505205052epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598933334;
        bh=4HNiRPvHIxvIrfu+Vr7XKCEWbAFVY5lm4GOrgQszxFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoPI/6xm5dN8RhNtiHwT8Ol3tUIH/TFWZUywtf1s9drJSyxjFeedas6f8/bCaZ1YG
         9js5a6K2ItUD0VqeQouzLdktxJiFgjYwJpjzygJu8NCsQKqlDYWrS/PpCnjOnQo+gr
         2HCKvk62LvWIMBiPyT2WAzd7GE4aJ2wHlfRvqtNA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200901040853epcas1p412aa2ed62c0564f8bcdc4f734528433d~wjWVOQd9_2818028180epcas1p4z;
        Tue,  1 Sep 2020 04:08:53 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BgYTv3bmGzMqYkb; Tue,  1 Sep
        2020 04:08:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.75.18978.359CD4F5; Tue,  1 Sep 2020 13:08:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901040851epcas1p28f443c0e819bea756ebf9296491b32da~wjWSf0De60064000640epcas1p2-;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901040851epsmtrp213eeca8988fba7dd2254108c7aa753ed~wjWSe0f6K1885018850epsmtrp2h;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-a7-5f4dc953d2cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.03.08382.259CD4F5; Tue,  1 Sep 2020 13:08:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040850epsmtip1818c6a833fa9c5d5fb87a78f54c27d6d~wjWSHNKlw0650806508epsmtip1F;
        Tue,  1 Sep 2020 04:08:50 +0000 (GMT)
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
To:     nsaenzjulienne@suse.de, eric@anholt.net, maxime@cerno.tech,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        sboyd@kernel.org, mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, hoegeun.kwon@samsung.com
Subject: [PATCH v2 1/4] clk: bcm: rpi: Add register to control pixel bvb clk
Date:   Tue,  1 Sep 2020 13:07:56 +0900
Message-Id: <20200901040759.29992-2-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmnm7wSd94gwkTJCzW9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFHZNhmp
        iSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAbyoplCXmlAKF
        AhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjPe3ulg
        K1jIVrF02UumBsZ5rF2MnBwSAiYSk3+uYwGxhQR2MErcfMzRxcgFZH9ilLh+vIcZwvnGKLHt
        zDugDg6wjm9tsRDxvYwS78+tYYFwPjNKLG9dwQgyik1AV+Jrz3UmEFtEoEJi3/PrjCBFzAJT
        mSWezlkGlhAW8JH4/u4/G4jNIqAq8elwL9gdvAK2EsvOf2OEuE9eYvWGA8wgNqeAncT1JW/B
        tkkI3OCQ+LluERvESS4Sl4/KQtQLS7w6voUdwpaS+PxuLxuEXSxxZeYrqN4GRon+ibOhiowl
        9i+dzAQyh1lAU2L9Ln2IsKLEzt9zwW5gFuCTePe1B+p7XomONiGIEjWJZw0HoMEoI3GqdzkT
        hO0hcWbBTmigTGSU2PzmGdMERrlZCBsWMDKuYhRLLSjOTU8tNiwwRI6xTYzgZKxluoNx4tsP
        eocYmTgYDzFKcDArifAe2OUdL8SbklhZlVqUH19UmpNafIjRFBh4E5mlRJPzgfkgryTe0NTI
        2NjYwsTQzNTQUEmc9+EthXghgfTEktTs1NSC1CKYPiYOTqkGpoa79mmbNRvnbPh5vUDrloNI
        FtvVJRrRco+8V9xYuf30ZM8Nhm93MKd3d35MVtQ/JxH0RXhJ0hRlDZfQz5ddJCRKTFYIJIX7
        T26aca/twatSLf3EI3fmtHuzzHjSveHybBVfYYP0qCnn53jVcX89H5Obt1vtqEbsZvXJgUdv
        LTLuz0rrKK3i/iEY+dzvpOVab8ZPjO7ZZ2TnyLwxPH/ljmzrpNdr7n75Kvk0+qXQRQPPo2cD
        GvjeOzXu2/UqWvG5I4PBN4ZzqZP/fStd6TNx4av8ff/qLrkJZrB/+HVO1U59r7/YEbGIXo4T
        WqevG7pqf/hhaXy5dr7auTdHFW1bj1ye4qY/RYNPe5KV+qLYNiWW4oxEQy3mouJEAD66xSNP
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnG7QSd94g11LzC3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFFcNimp
        OZllqUX6dglcGW/vdLAVLGSrWLrsJVMD4zzWLkYODgkBE4lvbbFdjFwcQgK7GSVe9rSwdTFy
        AsVlJFb1b4GqEZY4fLgYouYjo8TFS78YQWrYBHQlvvZcZwKxRQTqJJ50NLKA2MwCS5klWiYp
        gNjCAj4S39/9B5vJIqAq8elwL1gNr4CtxLLz3xghdslLrN5wgBnE5hSwk7i+5C1YjRBQzfE3
        G9gmMPItYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHDNamjsYt6/6oHeIkYmD
        8RCjBAezkgjvgV3e8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJ
        MnFwSjUwHbq2UEvRd81Z9Z5GyQddRV0nWmafZjuo+XXyroYHr6o7Et//Zzpy+rjGy+MerJs+
        7oz3/WC4zbKi41borwaJFIWXtXnLWSV9JI7f4mneY6tUq1Fg+NFlrderkKU7lsza4fgrYNJt
        wdfHZj6YP1NqwYn8K/c67nXUu0+5dSbWNU3KSGjZndOWuwIVVNMX3b1mo7uon/GDR/qW9DN3
        N64Id/gxa5l4xfPzm6M7XkzU/vWv6GlZ3udKGd1toq/kX78PW8rPtu1nMEvF30+NvF02n/ft
        M7/Um7PEfHXUg6IfzqWe5iJfHk7anRL7S/KwUPTfsA2M2vPWX5kpz5j07daFkpauR7vNXKJS
        msxKWL5zzlFiKc5INNRiLipOBAB9W2lYCAMAAA==
X-CMS-MailID: 20200901040851epcas1p28f443c0e819bea756ebf9296491b32da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200901040851epcas1p28f443c0e819bea756ebf9296491b32da
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
        <CGME20200901040851epcas1p28f443c0e819bea756ebf9296491b32da@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use QHD or higher, we need to modify the pixel_bvb_clk value. So
add register to control this clock.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5cc82954e1ce..f89b9cfc4309 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -271,6 +271,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		case RPI_FIRMWARE_CORE_CLK_ID:
 		case RPI_FIRMWARE_M2MC_CLK_ID:
 		case RPI_FIRMWARE_V3D_CLK_ID:
+		case RPI_FIRMWARE_PIXEL_BVB_CLK_ID:
 			hw = raspberrypi_clk_register(rpi, clks->parent,
 						      clks->id);
 			if (IS_ERR(hw))
-- 
2.17.1

