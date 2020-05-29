Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E9C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QzCT6Xl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgE2Qck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33798 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgE2Qc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163227euoutp0235449e8782e12a8efd3396d6a02d1335~TjNa2fnYg1716917169euoutp02K
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529163227euoutp0235449e8782e12a8efd3396d6a02d1335~TjNa2fnYg1716917169euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769947;
        bh=aOkXOEugUHwjOCVLx2Nrtt8w2k9Ic4QcV2hJ3HCE3tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzCT6Xl28JPgpyIgi2ldcaogHlrj0C0YSN1qpZVrjMOkax//hbbm1Z8VJJ0Ob8cbz
         F9v+uGBEVwsfLgRa7o3vDGr1bFdC/LWYEKa93Exgpow5dNkO3bfMStLuZrXAT5Wde8
         zLIg9fC+uq7nv5Oxpqr7CANFMI+cQvOR77fXo71g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529163226eucas1p24f7eae2628271288993939d46f242a77~TjNaoPgPU2034120341eucas1p2d;
        Fri, 29 May 2020 16:32:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.5D.61286.A1931DE5; Fri, 29
        May 2020 17:32:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9~TjNaXhaFB2234422344eucas1p19;
        Fri, 29 May 2020 16:32:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200529163226eusmtrp20b7c58a0710616ddbb4d667991b9a436~TjNaW6c4h0733307333eusmtrp2T;
        Fri, 29 May 2020 16:32:26 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-59-5ed1391a1013
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.EA.08375.A1931DE5; Fri, 29
        May 2020 17:32:26 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163225eusmtip1f1572a53cc7b48b492dbee6981a4b114~TjNZpb7hR1868718687eusmtip1O;
        Fri, 29 May 2020 16:32:25 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 4/6] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
Date:   Fri, 29 May 2020 18:31:58 +0200
Message-Id: <20200529163200.18031-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9s5xxHk9MUfJmVOArKUhODjijdlJh9yagMxNvUg0rblM15
        i8q75g0zwjlFV3SxiTnnBfOGl1REalmmgpeVWaFUlpcPmZecR9Fvz/u8v4f/+8CfxIS9PBEZ
        rYhjlAqpTIzzuU19f03OIo+h4JNFZg/aXJGJ6DpNLY8eXfrOo4eX53G6pN2I08XmIi5tMhkI
        2vhlhEd/aCnHaY2pg0PXvJ4k6PHUKpzu+ZHNozUPZvFz1hKj/h4umRhpwyXmvH6OpP7JXUlh
        gx5JFo2H/PAAvlcEI4uOZ5SuZ0L5URkPXxCxWkFidplDCprg5yIrEqhTcL++h5OL+KSQqkLQ
        MJlNsMMSgum6z4gdFhGkaVI4O5HVqcztyHMEhUupu5G1ucYtCqfcoKC3EFm0LeUDWV8ruBYI
        o9o40FH2i2tZ2FDhMKYzbaZJkksdgZe/3Sy2gPIEQ10dl33NAaoNnZhFW1FekLeqwVhmPwyU
        zmwx2CaT3liGsfwUAQbDJVb7QOajzu2rbWCuv4Fg9QHYeFW51QCodAT5reMEOxQhMPfrEEt5
        wsTbFdxyHEYdg9oWV9Y+D/mFrTyLDZQ1jP3cz95gDcVNJRhrCyAnS8jSh+GfvmT7BBHkzWxs
        15LAaLUJL0KO2j1ttHvaaHff1SFMj+wYtUoeyajcFEyCi0oqV6kVkS7hMXIj2vxcg+v9C81o
        +X1YN6JIJN4nSHQaChbypPGqJHk3AhIT2wouvBkMFgoipEnJjDImRKmWMapuZE9yxXYC98ez
        QUIqUhrH3GSYWEa5s+WQVqIUdHTSvqnUv0qdKFnMCAyb9vdG1aGfdEHqpI2Jyuvf+q46J9wY
        9qtZk+fILnoftL3d7jg/Xq4lGgOFC+5pw50zg4qI4NXulo2YE/oqQcHSujHh6TNRwEDQOxt6
        JctweersHU/ngWt/ZGFdybd8A5IcR/M/huC+DceJK2Fdp3N5xmYxVxUldXPClCrpf5Z4tshY
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7pSlhfjDPYdULW4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyWqSvZC2bxVrTPlm9g
        vMPVxcjJISFgIvHnXitTFyMXh5DAUkaJzq+LWLsYOYASUhLzW5QgaoQl/lzrYoOo+cQosfHW
        X0aQBJuAoUTv0T4wW0TAQ+JU61pWkCJmgRNMEk96N7KBJIQFEiUevF3JDDKURUBVYt0HQ5Aw
        r4C1xIaNG1kgFshLrN5wgBnE5hSwkej+MwPMFgKqaXs8ixWiXlDi5MwnLCBjmAXUJdbPEwIJ
        MwO1Nm+dzTyBUXAWkqpZCFWzkFQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERiL2479
        3LyD8dLG4EOMAhyMSjy8F3QuxgmxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4
        EKMp0GcTmaVEk/OBaSKvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwen
        VAOjR9czHpcaW4a1ySo+O6/uEZgzOdudzX/q6dDKR+0e2/ZJp8zNjf71LItH5f3JZyc8vRlc
        qi5fnL3qzu3nBn8CSl03qDXPZdpfI1AkodRpwW1S2qV9PbHY48Rs1zCrHS+kO29MT5TLDHv8
        b4FK0J3fPU4X8g883/fKYktMZow7i8GRsmMvtZKUWIozEg21mIuKEwGC+1hJ2wIAAA==
X-CMS-MailID: 20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163226eucas1p15bea74bed9cc5d22727c9ba732a5cbb9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the following properties for Exynos4412 interconnect
bus nodes:
 - samsung,interconnect-parent: to declare connections between
   nodes in order to guarantee PM QoS requirements between nodes;
 - #interconnect-cells: required by the interconnect framework.

Note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v5:
 - adjust to renamed exynos,interconnect-parent-node property,
 - add properties in common exynos4412.dtsi file rather than
   in Odroid specific odroid4412-odroid-common.dtsi.
---
 arch/arm/boot/dts/exynos4412.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 4886894..a7496d3 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -381,6 +381,7 @@
 			clocks = <&clock CLK_DIV_DMC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -450,6 +451,8 @@
 			clocks = <&clock CLK_DIV_GDL>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			samsung,interconnect-parent = <&bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -466,6 +469,8 @@
 			clocks = <&clock CLK_ACLK160>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_display_opp_table>;
+			samsung,interconnect-parent = <&bus_leftbus>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.7.4

