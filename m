Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB2EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E5246BE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HoPwK4+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgB1KBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:01:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54849 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1KBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:01:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200228100114euoutp0240151014777242484779087c8721b99a~3iK3q_K-C3158831588euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200228100114euoutp0240151014777242484779087c8721b99a~3iK3q_K-C3158831588euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582884074;
        bh=hRJ3MYQboR7HKJUsUn0rBsOQmcUWW+EA/19lIqK9+5E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HoPwK4+AXClM/ZLG0zytwAN5THtEwLHwiAKyoUTDoujLy+gvixjBRspLOlYqpKMEb
         mUh96svibA2cvEXuFnGzwGHOGDMJCF4BeW85kDeVTAoOwfa/YbpexEt7b05075h+X6
         O55D6fyw3DCqvT28oFF6LuEkmL0xIvdsfXTQV7SI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200228100114eucas1p1ab3ab5ea55735ba5411f400718e63354~3iK3aIrmE0576705767eucas1p1N;
        Fri, 28 Feb 2020 10:01:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 16.C5.60679.AE4E85E5; Fri, 28
        Feb 2020 10:01:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200228100113eucas1p26b8a378be47794225f5d75fb9583d43c~3iK3Gmryk3053730537eucas1p2Q;
        Fri, 28 Feb 2020 10:01:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228100113eusmtrp1e5251aed83458584d21c4cc6c2801664~3iK3F6pAx1359213592eusmtrp1x;
        Fri, 28 Feb 2020 10:01:13 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-07-5e58e4eaa0ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.53.08375.9E4E85E5; Fri, 28
        Feb 2020 10:01:13 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200228100113eusmtip11fa26a027dff2fd3262a75c23cb3599d~3iK2qsHe52262722627eusmtip1T;
        Fri, 28 Feb 2020 10:01:13 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/2] mfd: wm8994: Silence warning about supplies during
 deferred probe
Date:   Fri, 28 Feb 2020 11:00:37 +0100
Message-Id: <20200228100038.27748-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOd1XTyLiDA6c5ra4cvEQk8XUh0/Y
        LK60bmK0uP/1KKPFtysdTBaXd81hs1h75C67xef3+1ktDr9pZ3Xg9NjwuYnNY+esu+wem1Z1
        snncubaHzWP6nP+MHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVxfOlHpoIDbBUvZi5lamBc
        w9rFyMkhIWAi0fz2CnMXIxeHkMAKRombp6awQThfGCV23bzLCuF8ZpT49uo/E0zL56VrmCAS
        yxkltmyZzgzX0vpvJjtIFZuAoUTX2y42EFtEIE5i+eIFYB3MAr8YJT5/2gTkcHAIC0RIfH6m
        CVLDIqAqsXrNRLCjeAVsJa6dncQOsU1eYvWGA8wQ9mc2ia7pghC2i8TdkxsYIWxhiVfHt0DV
        y0icntzDArJLQqCZUeLhubXsEE4Po8TlphlQHdYSd879YgM5gllAU2L9Ln2IsKPE8tsTwG6T
        EOCTuPEWbBczkDlpG8iTIGFeiY42IYhqNYlZx9fBrT144RLUmR4SP34vZgcpFxKIlVh81WwC
        o9wshFULGBlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaM0/+Of9nBuOtP0iFGAQ5G
        JR7eBTvC44RYE8uKK3MPMUpwMCuJ8G78GhonxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctY
        IYH0xJLU7NTUgtQimCwTB6dUAyPz0Z+Xt33f905O1+T52SBzk2qeVw8+Fmj3Kv1K/Ljku0ht
        YI+L5ZYfAdEFqjIrvFmYvVuPG/j2t77elMOaKMO15vaztzsPMJm+tVizPKdGUffRmi2d1mfu
        2Za+3s4jbTTntG9r66XV3y8uv3Yy/oxpqEy3PKtS/6rTG28tv18RveiroNikGGYlluKMREMt
        5qLiRAAW90ZoFQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7ovn0TEGcw/YGVx5eIhJoupD5+w
        WVxp3cRocf/rUUaLb1c6mCwu75rDZrH2yF12i8/v97NaHH7TzurA6bHhcxObx85Zd9k9Nq3q
        ZPO4c20Pm8f0Of8ZPfq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS/j+NKPTAUH2CpezFzK1MC4hrWLkZNDQsBE4vPSNUxdjFwc
        QgJLGSVe35/GDpGQkTg5rQGqSFjiz7UuNoiiT4wSTYfnM4Ek2AQMJbregiQ4OUQEEiQOLW9h
        BiliFvjHKPHu0U1mkISwQJjEmqbHjCA2i4CqxOo1E8Gm8grYSlw7Owlqm7zE6g0HmCcw8ixg
        ZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGK7bjv3cvIPx0sbgQ4wCHIxKPLwLdoTHCbEm
        lhVX5h5ilOBgVhLh3fg1NE6INyWxsiq1KD++qDQntfgQoynQ8onMUqLJ+cBYyiuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwGgVXc/yvmjp7jsyGp8dvN68N7mv
        IZ6pW+R32Nq6MCorVU/VyHnaswbV3Xvyrrdb3AnqPC+o8Hca43a35f3HD70XsDBy4v3n1Rnb
        E3ejvj3svuzOOcYcFW3LuQ7USgm1n7E94nlGY43b/mN7l7X8UTnKVddfeWe3zIOT3w+9O/9q
        i8d75zzONiWW4oxEQy3mouJEAD97ahxtAgAA
X-CMS-MailID: 20200228100113eucas1p26b8a378be47794225f5d75fb9583d43c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228100113eucas1p26b8a378be47794225f5d75fb9583d43c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228100113eucas1p26b8a378be47794225f5d75fb9583d43c
References: <CGME20200228100113eucas1p26b8a378be47794225f5d75fb9583d43c@eucas1p2.samsung.com>
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
index 1e9fe7d92597..bfee2f8ba17f 100644
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

