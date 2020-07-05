Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62DEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B0920702
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IsAEcUWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGEH3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:29:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49385 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGEH3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:29:41 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200705072938epoutp028a79d9b696ae5ac76dabe0190846481a~eyrC4Z-4P0063200632epoutp02h
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 07:29:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200705072938epoutp028a79d9b696ae5ac76dabe0190846481a~eyrC4Z-4P0063200632epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593934178;
        bh=jDNczQCxNdBrVrr3iyPMSiYmZT3ww0WjNBXjxKIN4jI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IsAEcUWsuxhUkbys4RwEdzu2D3gq7Vo6iJu3dEbLm5tYD3Ofyv2ooZnbOW0P+gSk8
         TAJHrLeTUsX2QMhfTiRCg8lSovT4se44A++w0ZwJmIiRyN6KDe9x6jsR7FIfTzvU9o
         TCJ3CFeL/XqdNcMwRcmAMUWjaPgWEGUDauyXd5aA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200705072938epcas5p1a1c45b7d71443f56e4d844e2b2bfad94~eyrCpRaI12994029940epcas5p1k;
        Sun,  5 Jul 2020 07:29:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.CA.09467.261810F5; Sun,  5 Jul 2020 16:29:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200705072937epcas5p1b6c9a25770451bcb9d8bc5b14b8a8b53~eyrCF44f-2994029940epcas5p1j;
        Sun,  5 Jul 2020 07:29:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200705072937epsmtrp2564429d6df2f25dee482697bdbc79a89~eyrCFPB8g1763917639epsmtrp2X;
        Sun,  5 Jul 2020 07:29:37 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-d3-5f018162c05a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.BA.08382.161810F5; Sun,  5 Jul 2020 16:29:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705072936epsmtip13979d91306b4480df60df6537ccf9aa8~eyrA_4CyI0341703417epsmtip1E;
        Sun,  5 Jul 2020 07:29:36 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v1 1/2] arm64: dts: exynos: Fix silent hang after boot
Date:   Sun,  5 Jul 2020 12:39:17 +0530
Message-Id: <20200705070918.63531-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmum5SI2O8wYlX3BYP5m1js5h/5Byr
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8fmJfUefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlbH38iK2gkaOigX725kaGO+xdTFyckgImEisftIIZHNxCAnsZpTYtHoeK4Tz
        iVHiad8zFgjnG6PEubmfWWBa/i5pZodI7GWU+H+6HaqlhUli3/rvzCBVbALaEnenb2ECsUUE
        hCXuLV0O1sEscIRRouH8C7CEsICbxOl508AuYRFQlXi9/RcriM0rYCPx6+gDVoh18hKrNxxg
        BmmWEFjELvH42AwmiISLxNENaxkhbGGJV8e3sEPYUhKf3+0FGsoBZGdL9OwyhgjXSCyddwzq
        BXuJA1fmsICUMAtoSqzfpQ8SZhbgk+j9/YQJopNXoqNNCKJaVaL53VWoTmmJid3dUJd5SHw/
        eAjsACGBWInezSvYJjDKzEIYuoCRcRWjZGpBcW56arFpgWFearlecWJucWleul5yfu4mRnBU
        a3nuYLz74IPeIUYmDsZDjBIczEoivL3ajPFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZV+nIkT
        EkhPLEnNTk0tSC2CyTJxcEo1MHELfpl6JkKxL0rl6t+1ezZkzv5rcOC39KuTrw5PyrS/tKbN
        wkbRTa5Kd7LnezbxZ+eKnBxddI6+7a3c6C4vG+/17752jap7xj5p7tX367W0FNdvz4kWydpo
        smfPrf+H/+4vPOjxtaXC4vLLA2f9L61ZY1FrnVYx5/Lq0zxn3/fXKIu/OdvEMU9j/8Kt+Wek
        tD3qPnFc5byQNNHjz4qj555w3fUW9k4VL33+j71JJGGDRGD+JqbeXx9UL2e/OLjbsmma8gPf
        3hw1IX7n9EORU+s1Vuev5BBjnjBHYPPmGxVWC6bsMX/160Dj8gvPl9/3uDHveceu1WlTK+zn
        uHt1pQlf3CM4R1R03y+Tqvmv/65WYinOSDTUYi4qTgQA1cBYCFkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsWy7bCSnG5iI2O8wZPpihYP5m1js5h/5Byr
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8fmJfUefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlbH38iK2gkaOigX725kaGO+xdTFyckgImEj8XdLM3sXIxSEksJtRYtOKPhaI
        hLTE9Y0T2CFsYYmV/55DFTUxSUy7dR4swSagLXF3+hYmEFsEqOje0uVgRcwCpxgl+rdvBisS
        FnCTOD1vGtg6FgFVidfbf7GC2LwCNhK/jj5ghdggL7F6wwHmCYw8CxgZVjFKphYU56bnFhsW
        GOallusVJ+YWl+al6yXn525iBAePluYOxu2rPugdYmTiYDzEKMHBrCTC26vNGC/Em5JYWZVa
        lB9fVJqTWnyIUZqDRUmc90bhwjghgfTEktTs1NSC1CKYLBMHp1QDk3aqsVX9qQsRPXlrNs35
        cGVe/mR3n+kp+Tn8c+P12JN9/3f2hWvocszN/s9jY5LAlrnbYtOqT6t8+335ui1f3+5/yzb5
        5zIZx9l1GrW8GQf1t02be+9KuvKGRM9dXDvznh6x3Vbw/0OFVrfa2U2JR9jOCE2r8vt0j8tz
        8hvftL8GM0x/vN3ra75GabvNYYnmNxypxy5zrLh6p22h2Y6iA8X6q668n+diZCrKIL9uZtWJ
        69qtDoF1MXlbbD75Vli+sfLrqdSPfH+rzyb5dWrF8gsu/X3O1xbctXy+6nturfOXt7v2H7n4
        aF1Durxk//OLRrt3T9pZmvemIiNdN1pLPmftgaUq3t6SAvkL/+z4qcRSnJFoqMVcVJwIANkS
        tHiNAgAA
X-CMS-MailID: 20200705072937epcas5p1b6c9a25770451bcb9d8bc5b14b8a8b53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705072937epcas5p1b6c9a25770451bcb9d8bc5b14b8a8b53
References: <CGME20200705072937epcas5p1b6c9a25770451bcb9d8bc5b14b8a8b53@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once regulators are disabled after kernel boot, on espresso
board silent hang observed because of LDO7 being disabled.
LDO7 actually provide power to CPU cores and non-cpu blocks
circuitries.
Keep this regulator always-on to fix this hang.

Fixes: 9589f7721e16 ("arm64: dts: Add S2MPS15 PMIC node on exynos7-espresso")
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 - 
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 790f12ca8981..bb86950032d3 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -157,6 +157,7 @@
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-enable-ramp-delay = <125>;
+				regulator-always-on;
 			};
 
 			ldo8_reg: LDO8 {

base-commit: 9e50b94b3eb0d859a2586b5a40d7fd6e5afd9210
-- 
2.17.1

