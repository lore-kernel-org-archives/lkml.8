Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45106C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206EB206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QeOmKPAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD0Hs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:48:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41680 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgD0Hsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:48:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200427074843euoutp012385111b38011f9a60c642e3d40290dc~JnbBDhPAN0841208412euoutp01C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200427074843euoutp012385111b38011f9a60c642e3d40290dc~JnbBDhPAN0841208412euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587973724;
        bh=Jk8KR55ncQLtd1sMYYkwZP6VPLr+D89pm+J/YGxp7hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QeOmKPADgqBJsmETHKQ7kINIV5LjsZOo+qk7Iy8RSg04Z7lqsQ0ByPZqkfN7ctYkG
         +e08e/6ghFKch7vNTu6+29kwuyb86bXK9iflagkuE7ofGbTbX8F5+TEOLvl9qV1yMq
         Gj3qtlC5J6C+HiClhSY4uSVnAE7wGjU5CHd/+NH8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200427074843eucas1p2c6da8cc2a13539bab1759a84d64e981f~JnbAxujPh3203632036eucas1p2S;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 23.91.61286.B5E86AE5; Mon, 27
        Apr 2020 08:48:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794~JnbAX-qwJ0174601746eucas1p2Y;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200427074843eusmtrp113284b063e7a36afe361aedb0bab002b~JnbAXWKOc0061900619eusmtrp1R;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-76-5ea68e5b7820
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AD.7D.08375.B5E86AE5; Mon, 27
        Apr 2020 08:48:43 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074842eusmtip2ae1ad5e8b5313373f2cc7a04a4f3c0bc~Jna-5gTiu0962309623eusmtip2M;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/4] mfd: wm8994: Silence warning about supplies during
 deferred probe
Date:   Mon, 27 Apr 2020 09:48:31 +0200
Message-Id: <20200427074832.22134-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427074832.22134-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7rRfcviDFb3q1hcuXiIyWLqwyds
        FldaNzFa3P96lNHi25UOJovLu+awWaw9cpfd4vP7/awWh9+0szpwemz43MTmsXPWXXaPTas6
        2TzuXNvD5jF9zn9Gj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4Mp4t2QtY8EBtoo9HzexNjCu
        Ye1i5OSQEDCRaLi8AMjm4hASWMEo8binkR3C+cIosW7aKqjMZ0aJ6ZtnwLVsb9jECJFYzigx
        b8pbFriWO5eWMIJUsQkYSnS97WIDsUUE4iSWL17ABFLELPCLUeLzp01MIAlhgQiJFStawWwW
        AVWJqTt3sIDYvAK2Esve74VaJy+xesMB5i5GDg5OATuJhdPdQOZICPSzS3Sdv8oIEpcQcJFo
        m8ALUS4s8er4FnYIW0bi9OQeFoj6ZkaJh+fWskM4PYwSl5tmMEJUWUvcOfeLDWQQs4CmxPpd
        +hBhR4m7e/9CzeeTuPFWECTMDGRO2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xihrA9JFZc+sQG
        CZ+JjBKNTY9YJzDKz0JYtoCRcRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgOjn97/in
        HYxfLyUdYhTgYFTi4eXYvjROiDWxrLgy9xCjBAezkgjvo4xlcUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwSjqVGTM+PPi0yI1/xo9HjWpvThjVTBAz
        fOHw5nzLisIt2t6TFiv/zVyws9iK6cYj3rmb3/wO9bscyL5tRfBnjs7nf440vtm6tS9EbWvq
        C9/U6qUbYlZ8ZLDfVrfd+k/+mvoZJptmVars2RhuGHM69oHJvTcKyofVNxbZOxy2btlrIPnz
        lVHnTiWW4oxEQy3mouJEAIOk0D8jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xe7rRfcviDBb081hcuXiIyWLqwyds
        FldaNzFa3P96lNHi25UOJovLu+awWaw9cpfd4vP7/awWh9+0szpwemz43MTmsXPWXXaPTas6
        2TzuXNvD5jF9zn9Gj74tqxg9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mt4t2QtY8EBtoo9HzexNjCuYe1i5OSQEDCR2N6wibGLkYtD
        SGApo8Sn7fsZIRIyEienNUAVCUv8udbFBlH0iVHiXcsqdpAEm4ChRNdbkAQnh4hAgsSh5S3M
        IEXMAv+Aih7dZAZJCAuESSxcsw9sEouAqsTUnTtYQGxeAVuJZe/3Qm2Ql1i94QBQPQcHp4Cd
        xMLpbiBhIaCSj9/fMk9g5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMLi3Hfu5eQfj
        pY3BhxgFOBiVeHg5ti+NE2JNLCuuzD3EKMHBrCTC+yhjWZwQb0piZVVqUX58UWlOavEhRlOg
        myYyS4km5wMjL68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PF
        Tzb2bw5bK0vqBH7faWWwMmyw8GErOHqtp+XAxlROC08vB90rp3svSf6NmGS4/NPM9GnZ8rcT
        3VxkT36s2/vixWO1488kZPq2WSi2SXWxZypevGWm7ztL6N/lbWxb9op83Hj3gVfP+bTrrgtc
        zj85Fvb8f/gMFU6BNWVrT/sXqptdXrQvnVWJpTgj0VCLuag4EQChyMHkhAIAAA==
X-CMS-MailID: 20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
        <CGME20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't confuse user with meaningless warning about the failure in getting
supplies in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/wm8994-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 69d973ec42bf..3b2b93c5bbcb 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -393,7 +393,9 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	ret = regulator_bulk_get(wm8994->dev, wm8994->num_supplies,
 				 wm8994->supplies);
 	if (ret != 0) {
-		dev_err(wm8994->dev, "Failed to get supplies: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(wm8994->dev, "Failed to get supplies: %d\n",
+				ret);
 		goto err;
 	}
 
-- 
2.17.1

