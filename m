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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76ECC2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5EA208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="km9hurNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIAEJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:09:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31536 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgIAEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:08:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200901040856epoutp0278a9994c52517848adb97dcc7e589c79~wjWXld-CZ2374723747epoutp02G
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 04:08:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200901040856epoutp0278a9994c52517848adb97dcc7e589c79~wjWXld-CZ2374723747epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598933336;
        bh=2N0QNCg96aCPb/6zZVIxgmus5Y9FFsxp8i055e9pYFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=km9hurNka1oOLLVRGIwWtzH0MzVw0LlreDQKHL9moekbSwePAYfw9fsb44h4ZpOLA
         rNeaBtRkHctIyuBT4NlN4oRaOm8FuYvbKPYf2rc/+2dmhhNczE4OSAsOVhQZojAtGp
         eQFKsWTm2o5ybxjhgeuhj0/Rnj461DfiQd/D2niw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200901040855epcas1p3995571d0cff74022f0d9a54e30bbd6dd~wjWWfgl811751617516epcas1p3z;
        Tue,  1 Sep 2020 04:08:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BgYTw0KkRzMqYm5; Tue,  1 Sep
        2020 04:08:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.66.19033.359CD4F5; Tue,  1 Sep 2020 13:08:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040851epcas1p1456e8561c7a332811ec7ddc941ded2bd~wjWS-9G_F0326203262epcas1p1Y;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901040851epsmtrp26c8892f0f76af1ab210ffa107291ab90~wjWS_lXCx1885018850epsmtrp2i;
        Tue,  1 Sep 2020 04:08:51 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-f1-5f4dc953bf14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.03.08382.359CD4F5; Tue,  1 Sep 2020 13:08:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040851epsmtip17fb5c2606195ad4c2594584607623b84~wjWSkgwx70875308753epsmtip1n;
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
Subject: [PATCH v2 3/4] dt-bindings: display: vc4: hdmi: Add bvb clock-names
 property
Date:   Tue,  1 Sep 2020 13:07:58 +0900
Message-Id: <20200901040759.29992-4-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmnm7wSd94g2VbrS3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFHZNhmp
        iSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAbyoplCXmlAKF
        AhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjNezXnM
        WrCaq2LrnUtsDYxH2LsYOTkkBEwk/h05wdzFyMUhJLCDUeLV5LNsEM4nRomjzUdYQaqEBL4x
        SqzY5wDTMfHoHhaIor2MEpcnfGGEcD4zSjQcbWEGqWIT0JX42nOdCcQWEaiQ2Pf8OlgRs8BU
        Zomnc5aBJYQFwiX+H9zNCGKzCKhKPD7RCHQUBwevgK3EjmdQ2+QlVm84ADaTU8BO4vqSt2Cb
        JQSucEgc23iEDaLIRWLh5k9QtrDEq+NboJ6Tkvj8bi9UvFjiysxXUM0NjBL9E2dDFRlL7F86
        mQlkMbOApsT6XfoQYUWJnb/ngt3GLMAn8e5rDytIiYQAr0RHmxBEiZrEs4YDrBC2jMSp3uVM
        ELaHxPLJE6EhNJFRYm7bHNYJjHKzEDYsYGRcxSiWWlCcm55abFhghBxlmxjB6VjLbAfjpLcf
        9A4xMnEwHmKU4GBWEuE9sMs7Xog3JbGyKrUoP76oNCe1+BCjKTDwJjJLiSbnAzNCXkm8oamR
        sbGxhYmhmamhoZI478NbCvFCAumJJanZqakFqUUwfUwcnFINTK7OkdxeFW/jDbzkpNcVfNkh
        Ws5Q7ph9MrXcdafguzjjGs8vCyWThFklPof2zfL7xL8heLKo+xEBvzR/l1+neENtjvwsT7dR
        EtvddmNDruL7X9se35L/sd5r2v67n2Yt3qDzjLfv9avQ25Oc5/NJHDpu23r22FX3gvea9sFH
        uyZKHTGwz5nz77XOv8Tpe5ieSilsL42+oJJR1btEl/klU+Xbp3Ua4Tq1fLW1kfN7Du8XkH5n
        v9hbMNAorrm5muny9+vyE7dZaZ7ZeyEg4OCd5Gl3f0iKSPtNP3J4geaBlybP4tviBa8xfghP
        u/P3212uSSKLK5qu7lJg3jand2n1/w8mTk8CnurI/94m2vqDQ4mlOCPRUIu5qDgRAE0teoRQ
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnG7wSd94g6u/JSzW9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFFcNimp
        OZllqUX6dglcGa/mPGYtWM1VsfXOJbYGxiPsXYycHBICJhITj+5h6WLk4hAS2M0o0fB2PitE
        QkZiVf8WIJsDyBaWOHy4GKLmI6PEjm9L2EBq2AR0Jb72XGcCsUUE6iSedDSygNjMAkuZJVom
        KYDYwgKhEj82/wWbySKgKvH4RCM7yExeAVuJHc8cIFbJS6zecIAZxOYUsJO4vuQt2BghoJLj
        bzawTWDkW8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhmtDR3MG5f9UHvECMT
        B+MhRgkOZiUR3gO7vOOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ894oXBgnJJCeWJKanZpakFoE
        k2Xi4JRqYHLb8efqPNe5Kro3Q5yaPtnuSA5KratSWXj2UuyF68xLfz753+7HyJUtwB70a/qP
        /ivbP/7XiUlrqt5tcPnnfUumbsvDm+7aFX/517NZ+Sjj92UqW6QeWGx6Ehh7intJtlSeyxLz
        b+/2sHNWWzsoJjY/yTfQOrnx7hcHn6/2jupfBFqnslo2Om/h/PjYW/uiopNSfZmdyq2vBZ6B
        ftU6bmu3r82bMffCA9/7ege7M4ybo4Oy7bMsmr0Wa9xwTj98cmnSLGkGYyNRj71sVW13jcyl
        TFke7RbIn9bwhuWaYzfjXIG3szcXPO2fI1FuydfFd2SjxH2nz3m3nZZWmN4+lvX1U3ry2lmr
        p+tkyBYsUGIpzkg01GIuKk4EAA0VUUEIAwAA
X-CMS-MailID: 20200901040851epcas1p1456e8561c7a332811ec7ddc941ded2bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200901040851epcas1p1456e8561c7a332811ec7ddc941ded2bd
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
        <CGME20200901040851epcas1p1456e8561c7a332811ec7ddc941ded2bd@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a resolution exceeding FHD, bvb clock is required.
Add bvb clock-names property.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 .../bindings/display/brcm,bcm2711-hdmi.yaml          | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
index 6091fe3d315b..08cdcc579cf5 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -40,10 +40,14 @@ properties:
       - const: hd
 
   clocks:
-    description: The HDMI state machine clock
+    items:
+      - description: The HDMI state machine clock
+      - description: The bvb clock
 
   clock-names:
-    const: hdmi
+    items:
+      - const: hdmi
+      - const: bvb
 
   ddc:
     allOf:
@@ -100,8 +104,8 @@ examples:
                     "csc",
                     "cec",
                     "hd";
-        clocks = <&firmware_clocks 13>;
-        clock-names = "hdmi";
+        clocks = <&firmware_clocks 13>, <&firmware_clocks 14>;
+        clock-names = "hdmi", "bvb";
         resets = <&dvp 0>;
         ddc = <&ddc0>;
     };
-- 
2.17.1

