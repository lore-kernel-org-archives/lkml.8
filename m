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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E6C2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n5mQLLI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIAEJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:09:13 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36730 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgIAEJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:09:05 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200901040902epoutp033f8e0fd1de0ad9f6ebe14ef55c2a9b49~wjWcvp4dv0505205052epoutp03h
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 04:09:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200901040902epoutp033f8e0fd1de0ad9f6ebe14ef55c2a9b49~wjWcvp4dv0505205052epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598933342;
        bh=iHQfb3qtW7lSUWGtt4riwSXRHVNT71MHvCk8OlOASjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5mQLLI+wnCrQWatFlpPSDeXonNntrm/EMWl5uBA5bT0LQaMZew4fisr5d5Fshi+e
         RuNHLtyKOf/+2KGQb4S0mOcEjYtdGGwHa3pQDe7hFbiOGZhli9LB9L6Ab0VAQp7zKJ
         gl2wefAPIJt4fsQM5Viq6z99CUlJUUI3EpMee2Z4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200901040901epcas1p3822797b9a8406a8e31fe85404521ee9c~wjWcIj8Ep1718217182epcas1p34;
        Tue,  1 Sep 2020 04:09:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BgYTw1wxYzMqYkk; Tue,  1 Sep
        2020 04:08:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.E0.28578.459CD4F5; Tue,  1 Sep 2020 13:08:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040851epcas1p18d6757ed06d19c7fd68cbcd439672183~wjWTLhEXz1138411384epcas1p1M;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200901040851epsmtrp1a6db328e3576dfcfbd5c9cb5e6fe4631~wjWTKtkJJ3200232002epsmtrp1A;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-02-5f4dc9546808
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.03.08382.359CD4F5; Tue,  1 Sep 2020 13:08:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040851epsmtip10befad98f02fa7a40afb06d9bf727306~wjWS0aXrp0442504425epsmtip16;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
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
Subject: [PATCH v2 4/4] ARM: dts: bcm2711: Add bvb clock for hdmi-pixel
Date:   Tue,  1 Sep 2020 13:07:59 +0900
Message-Id: <20200901040759.29992-5-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRzv2d69e9m57r2B8LjrEHflCXdDJmw9eG5kmr2FJll5V/2xXuBt
        cMC227t1CmXTGiEMdBmiICAngaFMfsU5TnOSaIJQyPhxSKHAKNFJghPPiBrbvPrv8/1+P5/v
        z+chuKJLuJjI1BoZg5bOluACrP3HaKn03es71HFVbj5qLO7CkKfyFIaqr/TxkMs7iyPn/gGA
        ZusLceRwNWKoZXKIhx5af+OhgY4TOLLdauKjY0+WAOrvfg21l9fjyD56D0eWi1f4aGmo2Sc4
        PYKjidJx8EoodWD2Kk7Njlj4VPl4L06N9f2MU47yX/nU96NyqqXhIE6NF13jUK21n1OWrqcY
        VdLWAKjWnjxqviUyRfhB1qYMhk5nDFGMNk2XnqnVKCXJ76i3qOWKOJlUlohelkRp6RxGKdm6
        PUW6LTPbN6Yk6hM62+RzpdAsK1mv2mTQmYxMVIaONSoljD49W5+oj2XpHNak1cSm6XI2yuLi
        Nsh9xI+yMqZOzvD1Zv6eCWs/MAM3rxCEEJBMgM2jZ7FCICBE5HkA/3AvgIAxB+DVwT48YDwG
        sOHMHPZM0vG3hx8IXATQ/tMFTsCYB3BgzAKWWTgphV7rMGcZh5F74A+/D/vzcslSLnSfqPMH
        QsnX4eDDIXwZY+RLsGDpPncZC0klXDw3Fiy3Gp5pcvr9IaQKDtd6/N1CcoSAx83TnABpK/zy
        YA03gEPhzLU2fgCL4d1D+UHMQtfxmaDYDOAhW0UwEA8vfXvEl4jwtRcNz3WsD7jXQMdflf5p
        uOTz8IHXylumQFIIC/JFAcpaOG12Bjf5Auwurg+2Q8GpxdLgVm0Anh3yYodBZPl/FU4C0ADC
        GT2bo2FYmV7+/6O1AP9Ljkk8D8o8f8Z2Ag4BOgEkuJIwobMjWS0SptN7cxmDTm0wZTNsJ5D7
        tmfjilem6XxfQWtUy+Qb4uPjUYJMIZfJJBHCO6NRahGpoY1MFsPoGcMzHYcIEZs5lyPcCtqV
        qpicnbwX8oa3qq7RUvi1UvXNztT+nsTBiLLND/Yp9yv0JWGGrBeHPCb66XO311b0VLML62xP
        JqrC247d6Pk0+b2NS3N5Sfib4prHfSmtisq7Ow4U2W+uej8rqbiwSJx5Ux/z4aq3az3gUcGI
        UdXbhxy36hQVt7vVqYlyUjOvaW2J9vASdtu6brS5DN5d9pIewz/C0N4vtM66UO82x6vf1aou
        TzTlCt5asTosqa7eK9tctjBVPJo/9lkVc1+w+077dtO+lY1cW/iRpKN5A2m7rGUXiMM1v2zJ
        Lf9qYcplr95LFEcOX2+r4j1as5gusLZOrzj68YBDMLkzovm0BGMzaFkM18DS/wIQCmWOUgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnG7wSd94g1u3NCzW9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFFcNimp
        OZllqUX6dglcGU8WvGIvaGCveNRzkbGB8SlrFyMnh4SAicSuv2/Zuxi5OIQEdjNK7D58nhki
        ISOxqn8LUBEHkC0scfhwMUTNR0aJN0vfMoLUsAnoSnztuc4EYosI1Ek86WhkAbGZBZYyS7RM
        UgCxhQXcJa5+vMYGYrMIqEp0/HsDNp9XwFbiz/o7LBC75CVWbzgAFucUsJO4vuQtWFwIqOb4
        mw1sExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4aLc0djNtXfdA7xMjE
        wXiIUYKDWUmE98Au73gh3pTEyqrUovz4otKc1OJDjNIcLErivDcKF8YJCaQnlqRmp6YWpBbB
        ZJk4OKUamKZ5nma82fcwe/bcnNmrlnxtTrwQcfvXRIfofsZT4otle/ULru+1FmjVWbTNOWKy
        /vb4w7Ifu5fN82uaLnVE+PTra9K1E89XX+m98pnT7dSqN5ddZduYDX2Wn+5l2WNy/vUi5hvl
        LT8WSqvO/JfscoDvc+2Kx9d4Lmbc2Ji88PWjH6lTObj1Q5sv7XlWlNP04yzbJOsmRtXeQwdm
        Pv/8QNkv65rJHyut2mqdTOND1yXUO36zawSkXrwUP9nvgaR4elSK/eGrs8v2fZrMuUb5oNGc
        t9Pu1U7e7Gwedpkt2tKy+UmS54o9NV3rq4+pvnWpK+a8Lvxlzmyl6wltsjP1D8nc+Pvsd7X1
        +2zrd3FX418osRRnJBpqMRcVJwIAZSIZbQkDAAA=
X-CMS-MailID: 20200901040851epcas1p18d6757ed06d19c7fd68cbcd439672183
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200901040851epcas1p18d6757ed06d19c7fd68cbcd439672183
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
        <CGME20200901040851epcas1p18d6757ed06d19c7fd68cbcd439672183@epcas1p1.samsung.com>
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

