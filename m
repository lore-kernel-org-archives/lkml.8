Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C481FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADB420720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vj7XMOqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgGHNiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:38:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39547 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgGHNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:38:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200708133812euoutp01063530afb651364a0795eb1509e75864~fyosxV1By3273032730euoutp01M
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 13:38:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200708133812euoutp01063530afb651364a0795eb1509e75864~fyosxV1By3273032730euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594215492;
        bh=Spljwi04NPz7tPwQDU3ylhpMAcBmPOyA+LcLqOe48yU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Vj7XMOqi0NxcchXdWTsCeHfGhTFBmBTugLzD6EPfrdpDsIPUI6hYbucJf+auRAzZr
         2BlktYAI0O6akoR0FElXVBLbjy27eFFloXED8TIVvnH+inQkdppZpYNU3EwzHKVHVt
         IuxCtttYJ3dUFKDV26BF/QZ1PSdV8gMZ7tDKvjyY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200708133811eucas1p23859cf25cecf8fe7eac4bc597e5354ed~fyosfTTEW0379703797eucas1p2L;
        Wed,  8 Jul 2020 13:38:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.86.06456.34CC50F5; Wed,  8
        Jul 2020 14:38:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf~fyor-LiDI1425514255eucas1p1N;
        Wed,  8 Jul 2020 13:38:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200708133811eusmtrp1e04dd234da5007c86c0c63bcdfd07b28~fyor_lDj93178831788eusmtrp1v;
        Wed,  8 Jul 2020 13:38:11 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-55-5f05cc436e60
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.36.06314.34CC50F5; Wed,  8
        Jul 2020 14:38:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200708133810eusmtip182b79244efc0f0790829ab647ea4e761~fyorgZg7g1357913579eusmtip1d;
        Wed,  8 Jul 2020 13:38:10 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND] phy: exynos5-usbdrd: Calibrating makes sense only
 for USB2.0 PHY
Date:   Wed,  8 Jul 2020 15:38:00 +0200
Message-Id: <20200708133800.3336-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87rOZ1jjDSbONLTYOGM9q8WFpz1s
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67xc47J5gdODw2repk8+jbsorR4/iN7UwenzfJ
        BbBEcdmkpOZklqUW6dslcGVcOv+bsWAnR8Wzm9/ZGhhXsHcxcnJICJhIXDzQwdjFyMUhJLCC
        UWLezwY2kISQwBdGiW+LXSASnxkljk+ZAJTgAOu4/jYIIr6cUWLSoXMsEA5Qw48n01hAutkE
        DCW63naBTRIRcJBYsvQOG0gRs8B3RonuzgtMIAlhgSiJ5T+WgxWxCKhKzP1wkBHE5hWwkfjV
        c4IZ4j55idUbDjCDNEsI3GaTuPvpECtEwkXi1rGnLBC2sMSr41ugHpKROD25hwWioZlR4uG5
        tewQTg+jxOWmGYwQVdYSd879AnuIWUBTYv0ufYiwo8SBKUsYIf7kk7jxVhAkzAxkTto2nRki
        zCvR0SYEUa0mMev4Ori1By9cgrrZQ+J52y1GSDDGSuy/+ZR5AqPcLIRdCxgZVzGKp5YW56an
        FhvmpZbrFSfmFpfmpesl5+duYgQmg9P/jn/awfj1UtIhRgEORiUe3gkbWOOFWBPLiitzDzFK
        cDArifA6nT0dJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwen
        FDDqD602vLeQ99fMi7vyfcSl+zaF+d6yN936Y1v+6xNbX4jdDjts+qz+y42H3PnOl00+t82M
        UwyZ99Z4ad6WlUnBcbdjH07pm7Jyzomntv7Z/xsvRm0sFDov43w6IEipT+ZaWy7Llod57z/W
        Gc9S4nzZvLs08IU/i7j3jidXly8xzN33sPLF1xluSizFGYmGWsxFxYkA7pFAqAIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xu7rOZ1jjDZ5PkrTYOGM9q8WFpz1s
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67xc47J5gdODw2repk8+jbsorR4/iN7UwenzfJ
        BbBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVc
        Ov+bsWAnR8Wzm9/ZGhhXsHcxcnBICJhIXH8b1MXIxSEksJRR4uyXu2xdjJxAcRmJk9MaWCFs
        YYk/17rYIIo+MUpMv3SPHSTBJmAo0fW2C6xBRMBJonPtaTCbWeA3o8SBiYYgtrBAhMSnTcvB
        BrEIqErM/XCQEcTmFbCR+NVzghligbzE6g0HmCcw8ixgZFjFKJJaWpybnltsqFecmFtcmpeu
        l5yfu4kRGILbjv3cvIPx0sbgQ4wCHIxKPLwvNrHGC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWx
        siq1KD++qDQntfgQoynQ8onMUqLJ+cD4yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwKhcu/hV2OLtD48eNT/Vz/CjQ+dAwNxgl5nukgnlbS1TbmhVPfxeFH+E
        l+OPzmJvrzMqnz0PHb91i/P4heCjLWtcijZaGdi//VH/cVNmmuPMI+om99Y+L/k5Wfq3ztWV
        k1YyTp24al9zYrfr/kWsmxbc8pTZumJBqO0DLmEx5jDt8rP/XN3OLYhRYinOSDTUYi4qTgQA
        atmfnlcCAAA=
X-CMS-MailID: 20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf
References: <CGME20200708133811eucas1p1df7b92d7e0ba512c5a7ecdb948edbfcf@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 646259bee909..f07edd80d2f3 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -714,7 +714,9 @@ static int exynos5_usbdrd_phy_calibrate(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
+		return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	return 0;
 }
 
 static const struct phy_ops exynos5_usbdrd_phy_ops = {
-- 
2.17.1

