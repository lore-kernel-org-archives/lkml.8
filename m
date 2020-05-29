Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B119C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8032074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GwEU21DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgE2QcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33745 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163221euoutp02cc4f689f502c786cf75fe47977999db7~TjNVO7LZq1716917169euoutp02B
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529163221euoutp02cc4f689f502c786cf75fe47977999db7~TjNVO7LZq1716917169euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769941;
        bh=ei9TQt3JZw0Vz/vutdWoNfjAEdvVJ/C/2sBby6n9XKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwEU21DR8XVEvdl5zTovIZmKiaqHIKctu9I8lpE8/U+luLp942EI+YR4je47ewp8u
         sgtVdRbUTDAC3ympqfIYJwxFqaa4Pib+crNsxkrbYpvCYWE9vSF5zg8pJfSBjDZ+Pr
         fZFNdBm3iooQl3PYScNoiHSgKatV81d5SnWbjr+U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529163219eucas1p14fda733b31a5459c1fbe762a0ad4d8b0~TjNUGl2k30471904719eucas1p1I;
        Fri, 29 May 2020 16:32:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.5D.61286.31931DE5; Fri, 29
        May 2020 17:32:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e~TjNTwJf6B1986719867eucas1p2V;
        Fri, 29 May 2020 16:32:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200529163219eusmtrp2e5592a06f3652e558393e729fa4698ea~TjNTvdO-o0721307213eusmtrp2g;
        Fri, 29 May 2020 16:32:19 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-4a-5ed139138966
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.DA.08375.31931DE5; Fri, 29
        May 2020 17:32:19 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163218eusmtip1f49edc74db9f603abdadde71a0e8d11b~TjNTBHTL_1044210442eusmtip1A;
        Fri, 29 May 2020 16:32:18 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 1/6] dt-bindings: exynos-bus: Add documentation for
 interconnect properties
Date:   Fri, 29 May 2020 18:31:55 +0200
Message-Id: <20200529163200.18031-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7rClhfjDI6vNba4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQi
        fbsErozbE9oZC+6KVPQ8fc/UwLhSsIuRk0NCwERi9db9zF2MXBxCAisYJVZPvckE4XxhlGh6
        MIMFwvnMKHGpexMTTMv2Z7uhWpYzSmx5eIURruXTg2vMIFVsAoYSvUf7GEFsEQEXiban88BG
        MQvsYZLYN/sdkMPBISyQIvG6UwikhkVAVWLJwtNg9bwC1hKnrv9mhdgmL7F6wwGwmZwCNhLd
        f2YwQ9QISpyc+YQFxGYGqmneOhvsIgmBe+wSB06/Z4RodpG43j8X6mxhiVfHt7BD2DIS/3fO
        Z4JoaGaU6Nl9mx3CmcAocf/4Aqhua4k7536xgVzKLKApsX6XPkTYUeLJjXVMIGEJAT6JG28F
        IY7gk5i0bTozRJhXoqNNCKJaReL3qulQJ0hJdD/5zwJhe0g8eTSBfQKj4iwk78xC8s4shL0L
        GJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCav0/+Of9rB+PVS0iFGAQ5GJR7eCq2L
        cUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6Yklq
        dmpqQWoRTJaJg1OqgTF0zbn5zQWCHy24DzbP4Vwg86HnhZf89A9njqatM73QsPQXy/yLs128
        7L7fdrgt4vogyb9rb6TjibO3ftWsrtr/69hk/i/34hdtWJOyqVzxqvCH+KNCjTMaE8+cufXy
        32W9gIR7N1OUvff0HC6bybNgbs2JPPfn6Zf/CcXOan6uv+txmne2ZvE6JZbijERDLeai4kQA
        qYQo6loDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7rClhfjDBZ1K1jcn9fKaLFxxnpW
        i+tfnrNaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW9xuXMFm
        cfhNO6vFjMkv2Rz4PDat6mTzuHNtD5vH/e7jTB6bl9R79G1ZxejxeZNcAFuUnk1RfmlJqkJG
        fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbtCe2MBXdFKnqevmdq
        YFwp2MXIySEhYCKx/dlu5i5GLg4hgaWMEktbDrB0MXIAJaQk5rcoQdQIS/y51sUGUfOJUeJj
        50smkASbgKFE79E+RhBbRMBD4lTrWlaQImaBE0wST3o3soEkhAWSJNb3fmQGsVkEVCWWLDwN
        1sArYC1x6vpvVogN8hKrNxwAq+EUsJHo/jMDzBYCqml7PIsVol5Q4uTMJ2DHMQuoS6yfJwQS
        ZgZqbd46m3kCo+AsJFWzEKpmIalawMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAetx37
        uXkH46WNwYcYBTgYlXh4L+hcjBNiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrx
        IUZToNcmMkuJJucDU0VeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5O
        qQbGos0bLJgVpF5PvSGvPftO+PUyX51LQoyMUt3JDXcZa5/MdWb1uBcc4dz6szf/0PTIw77h
        L8TSZzEKu9449PbPocj30Ya1C4456KnWLTmg/4FJSetB+d1ofy/b3bFPtxSdXBSy56Xn1I2P
        MvMMjVfVyy+7vM3msdk9y/+mBvp3Kz6v+fxzx0N/JZbijERDLeai4kQA4JE/590CAAA=
X-CMS-MailID: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for new optional properties in the exynos bus nodes:
samsung,interconnect-parent, #interconnect-cells.
These properties allow to specify the SoC interconnect structure which
then allows the interconnect consumer devices to request specific
bandwidth requirements.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v5:
 - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index e71f752..e0d2daa 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -51,6 +51,11 @@ Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.

+Optional properties for interconnect functionality (QoS frequency constraints):
+- samsung,interconnect-parent: phandle to the parent interconnect node; for
+  passive devices should point to same node as the exynos,parent-bus property.
+- #interconnect-cells: should be 0
+
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
 	VDD_MIF |--- DMC
@@ -185,8 +190,9 @@ Example1:
 	----------------------------------------------------------

 Example2 :
-	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
-	is listed below:
+	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi is
+	listed below. An interconnect path "bus_lcd0 -- bus_leftbus -- bus_dmc"
+	is defined for demonstration purposes.

 	bus_dmc: bus_dmc {
 		compatible = "samsung,exynos-bus";
@@ -376,12 +382,15 @@ Example2 :
 	&bus_dmc {
 		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
+		#interconnect-cells = <0>;
 		status = "okay";
 	};

 	&bus_leftbus {
 		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 		vdd-supply = <&buck3_reg>;
+		samsung,interconnect-parent = <&bus_dmc>;
+		#interconnect-cells = <0>;
 		status = "okay";
 	};

@@ -392,6 +401,8 @@ Example2 :

 	&bus_lcd0 {
 		devfreq = <&bus_leftbus>;
+		samsung,interconnect-parent = <&bus_leftbus>;
+		#interconnect-cells = <0>;
 		status = "okay";
 	};

--
2.7.4

