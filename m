Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0079C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F3E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LEA3mgsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBXNvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:51:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55258 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbgBXNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:51:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200224135133euoutp0266e5c94a23397217a6288ec48cc527c1~2Wu0FrnX62904829048euoutp02K
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:51:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200224135133euoutp0266e5c94a23397217a6288ec48cc527c1~2Wu0FrnX62904829048euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582552293;
        bh=EzeGv53Ui4L1MziFSWesdry8RRpPQMeyYmWPuFhfIA0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LEA3mgsis/be8V9IuHN5/2l5fTpTkoF6KnpTVldxVhFqBqkvLa+SbIc5ewOWXYMqp
         6xdcjV6rkx9+TyK1p3V/5EfkokYqzZEMsxURrwXeYJzmurMCHgh+DelliZy3/lV0Pc
         +NO9IT55lo3iP9//CzK1OZT0xEbAUf5so3BwMqvs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200224135132eucas1p27fc7695f55c0537660d0142c827ddff8~2Wuz2S5Ol2987629876eucas1p2u;
        Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.82.60679.4E4D35E5; Mon, 24
        Feb 2020 13:51:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3~2WuzfFB__2993529935eucas1p28;
        Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200224135132eusmtrp18acc57360217780c55163a2266331ebd~2WuzedBm23154231542eusmtrp1F;
        Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-80-5e53d4e45c8f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.6F.08375.4E4D35E5; Mon, 24
        Feb 2020 13:51:32 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200224135132eusmtip1c1375166c17b8ebafe9fa03189b1ca7e~2WuzHqWAT0548905489eusmtip1y;
        Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] mfd: wm8994: Fix driver operation if loaded as modules
Date:   Mon, 24 Feb 2020 14:51:22 +0100
Message-Id: <20200224135123.27301-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87pPrgTHGZxq0LW4cvEQk8XGGetZ
        LaY+fMJmcf/rUUaLy7vmsFmsPXKX3eLwm3ZWB3aPDZ+b2Dw2repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGXse36QreAiV8WeE/tZGxifcXQxcnJICJhIdEyfy9LFyMUhJLCC
        UWLHvXdsEM4XRomHJx6yQzifGSW2TlvKCtPybucpZojEckaJiw8bGOFaZu5fwQ5SxSZgKNH1
        tosNxBYRsJV4vaMBbAmzwE2gJXf6gBwODmEBb4mLlxRBTBYBVYmv61lAynmByn/92MoIsUxe
        YvWGA2DLJASus0lceXyaBSLhIjF7+wooW1ji1fEt7BC2jMTpyT0sEA3NQD+cW8sO4fQwSlxu
        mgE11lrizrlfbCCbmQU0Jdbv0ocIO0o0z/3PDhKWEOCTuPFWECTMDGRO2jadGSLMK9HRJgRR
        rSYx6/g6uLUHL1xihrA9JDq2PwAHlpBArETHuu9MExjlZiHsWsDIuIpRPLW0ODc9tdgoL7Vc
        rzgxt7g0L10vOT93EyMwGZz+d/zLDsZdf5IOMQpwMCrx8ErsDY4TYk0sK67MPcQowcGsJMLr
        zRgUJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANjxe41
        P5+p/eP/XfRxymy7J3M28aw0EfU/dcqj92rR9bSOhIAZzXYXLS2uH2HcszXKeWdnjLjVpB4p
        Xd57LgxHSg6lL6s69Cxpa6hX4osFSVmO5j38+W+/zmh7sqdmWu+j3H+l/feCEw27WW5/XL5Q
        ydczyq0gg/8zz2S12mnbP9RorqzbaCmsxFKckWioxVxUnAgAuhwRtwIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xu7pPrgTHGfTulLS4cvEQk8XGGetZ
        LaY+fMJmcf/rUUaLy7vmsFmsPXKX3eLwm3ZWB3aPDZ+b2Dw2repk87hzbQ+bR9+WVYwenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXs
        e36QreAiV8WeE/tZGxifcXQxcnJICJhIvNt5irmLkYtDSGApo8T7bwfZIRIyEienNbBC2MIS
        f651sUEUfWKUuHLvBSNIgk3AUKLrLUiCk0NEwF7iwa9/YDazwF2gotd+XYwcHMIC3hIXLymC
        mCwCqhJf17OAVPAK2Er8+rGVEWK8vMTqDQeYJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66X
        nJ+7iREYgNuO/dy8g/HSxuBDjAIcjEo8vBJ7g+OEWBPLiitzDzFKcDArifB6MwbFCfGmJFZW
        pRblxxeV5qQWH2I0Bdo9kVlKNDkfGB15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNT
        UwtSi2D6mDg4pRoYZXWi8vm938veWCzDWKvGPjdAa032zbmeUut3f/IIKJxQqVtwQ/LDvjmT
        r9a3X36hG/vlmf6sWayPj326V/1Z5mjj2Xfh9qUWq3YHb3qW5HjP8+D5+MYln+MsBHb6ym1p
        MLSpPPtIyMW4bIbSlnqu4iaVgFxf1obE8woeh0xPvyyY7SnPlCqvxFKckWioxVxUnAgA13rj
        AlYCAAA=
X-CMS-MailID: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
References: <CGME20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WM8994 chip has built-in regulators, which might be used for chip
operation. They are controlled by a separate wm8994-regulator driver,
which should be loaded before this driver calls regulator_get(), because
that driver also provides consumer-supply mapping for the them. If that
driver is not yet loaded, regulator core substitute them with dummy
regulator, what breaks chip operation, because the built-in regulators are
never enabled. Fix this by adding a comment and a call to module_request()
helper.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/wm8994-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1e9fe7d92597..f15f12d8bccc 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -321,6 +321,13 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	int ret, i, patch_regs = 0;
 	int pulls = 0;
 
+	/*
+	 * Request a driver for built-in regulators first, because they are
+	 * default supplies for "AVDD1" and "DCVDD". Otherwise, getting them
+	 * fails due to lack of consumer mapping defined by that driver.
+	 */
+	request_module("wm8994_regulator");
+
 	if (dev_get_platdata(wm8994->dev)) {
 		pdata = dev_get_platdata(wm8994->dev);
 		wm8994->pdata = *pdata;
-- 
2.17.1

