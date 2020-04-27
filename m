Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193FAC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7282206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nSMCkTkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgD0Hsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:48:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47678 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgD0Hsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:48:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200427074843euoutp020e02824427d44d49bdd37549c09a69d3~JnbAVvyeX3002830028euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200427074843euoutp020e02824427d44d49bdd37549c09a69d3~JnbAVvyeX3002830028euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587973723;
        bh=BlPYhTkuuXU4W6a42ZfvT9Z3Mq0rbD+ikTxhs9HG92s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSMCkTkzQtZmvXbrn/G6oOM0rxcDX7tEQC1Sc1n2hMo07eHmfmWZw+Z/YJ5z/m3l/
         BWteAOFEwQZTmRZf2EgnfYrSuNQh/YoohSPBrTxCEf5T7ekaee6g0Lff2v0f24let+
         5jom3z45TS4w9GdydRUU+pm/sNMKG9JDKq31JOdY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200427074842eucas1p18e2d11e1a88a255d8a5bb2b512a77c16~JnbAB8qU92249322493eucas1p1a;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.91.61286.A5E86AE5; Mon, 27
        Apr 2020 08:48:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200427074842eucas1p1abfb9af74f0d898ba381700f37820318~Jna-joXJD2249322493eucas1p1Z;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200427074842eusmtrp270ef1508ddad3aed8dbc553636c99585~Jna-i8Qa00599405994eusmtrp2g;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-72-5ea68e5af15d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 46.1A.07950.A5E86AE5; Mon, 27
        Apr 2020 08:48:42 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074841eusmtip210ac6e5be1c4cc1e11973682146daa84~Jna-GsUfA0961909619eusmtip2K;
        Mon, 27 Apr 2020 07:48:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/4] mfd: wm8994: Fix driver operation if loaded as modules
Date:   Mon, 27 Apr 2020 09:48:29 +0200
Message-Id: <20200427074832.22134-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427074832.22134-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned2ovmVxBp9OG1tcuXiIyWLqwyds
        FldaNzFa3P96lNHi25UOJovLu+awWaw9cpfd4vP7/awWh9+0szpwemz43MTmsXPWXXaPTas6
        2TzuXNvD5jF9zn9Gj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4MpYP6GyYA1nxa1Jr9gbGLs4
        uhg5OSQETCTeHWpn6WLk4hASWMEoMf9XIxOE84VRYnvfAWaQKiGBz4wSnSvqYDq2f53IDFG0
        nFHi+YTLbHAd84/sYwepYhMwlOh628UGYosIxEksX7wAbCyzwC9Gic+fNjGBJIQFvCWOrTzE
        CGKzCKhKnOjoBIvzCthKzJo7hx1inbzE6g0gZ3BwcArYSSyc7gYyR0Kgn11i8d85rCBxCQEX
        if7r/hDlwhKvjm+BapWR+L9zPhNEfTOjxMNza9khnB5GictNMxghqqwl7pz7xQYyiFlAU2L9
        Ln2ImY4SnZOsIEw+iRtvBUGKmYHMSdumM0OEeSU62oQgZqhJzDq+Dm7rwQuXoEo8JA5cDoaE
        zkRGiVuPv7FNYJSfhbBqASPjKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMA0cvrf8U87
        GL9eSjrEKMDBqMTDy7F9aZwQa2JZcWXuIUYJDmYlEd5HGcvihHhTEiurUovy44tKc1KLDzFK
        c7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamDcqSDMf9EtR+ZRX5vmveVeJl4tZvv/Gpcs
        M1ZdX79i0Z3NKwysYsS7FfYvL+v482rb/k1rc1seGs7JtVvMd1mL+8n30KNNC8t+Lz84J/4D
        o8aWXRFLZ57ZuNsu8lxzkOZfNzET+btLj9ese/+cJ0ov/m//4lI7p+7PWuukQ50aume5egfN
        u+evxFKckWioxVxUnAgA6i009x8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xe7pRfcviDJpuCllcuXiIyWLqwyds
        FldaNzFa3P96lNHi25UOJovLu+awWaw9cpfd4vP7/awWh9+0szpwemz43MTmsXPWXXaPTas6
        2TzuXNvD5jF9zn9Gj74tqxg9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0MtYP6GyYA1nxa1Jr9gbGLs4uhg5OSQETCS2f53I3MXIxSEk
        sJRR4unquWwQCRmJk9MaWCFsYYk/17rYIIo+MUrcaTzMApJgEzCU6HrbBdYgIpAgcWh5C9gk
        ZoF/jBLvHt1kBkkIC3hLHFt5iBHEZhFQlTjR0ckEYvMK2ErMmjuHHWKDvMTqDQeA6jk4OAXs
        JBZOdwMJCwGVfPz+lnkCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgaG97djPLTsY
        u94FH2IU4GBU4uHl2L40Tog1say4MvcQowQHs5II76OMZXFCvCmJlVWpRfnxRaU5qcWHGE2B
        bprILCWanA+Mu7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYzz
        bou0WIhmHz/+6M7NWzatJbzmP6y7Njxedzq/+fbJTDex7R+DZPXT5eZE1bxfNls7783mGYva
        MpbumJB84JQPy8nuL//KTk95o3Egwph3S1vdpp3HSvYv0GVdMqnahTvaZumtm0I7pPk/2764
        sfPI7k3bKx2rxMX2H/1kzZbW61G6kjnZ56i/EktxRqKhFnNRcSIALGsBtIMCAAA=
X-CMS-MailID: 20200427074842eucas1p1abfb9af74f0d898ba381700f37820318
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074842eucas1p1abfb9af74f0d898ba381700f37820318
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074842eucas1p1abfb9af74f0d898ba381700f37820318
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
        <CGME20200427074842eucas1p1abfb9af74f0d898ba381700f37820318@eucas1p1.samsung.com>
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
never enabled. Fix this by annotating this driver with MODULE_SOFTDEP()
"pre" dependency to "wm8994_regulator" module.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm8994-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1e9fe7d92597..737dede4a95c 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -690,3 +690,4 @@ module_i2c_driver(wm8994_i2c_driver);
 MODULE_DESCRIPTION("Core support for the WM8994 audio CODEC");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_SOFTDEP("pre: wm8994_regulator");
-- 
2.17.1

