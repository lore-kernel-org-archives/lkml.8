Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D607206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uJwbz9XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgD0Hs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:48:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41689 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgD0Hsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:48:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200427074844euoutp0124d1987075d3a25ceef2eb09db280bad~JnbBmDUbc0841708417euoutp018
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:48:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200427074844euoutp0124d1987075d3a25ceef2eb09db280bad~JnbBmDUbc0841708417euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587973724;
        bh=16c85UL1fH0B0UINKqjhEjmvKTup4PQjtl3nu9iR4gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJwbz9XH0NT6euuoozLt4Dcs4V3dR/lDByWmmaSTMT6U0FhxUtVHBC7ktHoZ3RpjF
         2TNvR293uiqlsEBOXHXEYwBvT6nez9Lq2JXibsLzsgBmtEfizay2dAzkX/+wQOpdaN
         6WDBOzKyofBrxwOZd7ywJxB5OTUPPpK6YJWpenSs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200427074844eucas1p2981455a070a5aef8fc15b3eb848297a3~JnbBIjM0x0183601836eucas1p2I;
        Mon, 27 Apr 2020 07:48:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.1D.60679.B5E86AE5; Mon, 27
        Apr 2020 08:48:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606~JnbA3Z4u90341903419eucas1p1w;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200427074843eusmtrp156023f0b462c0cae30620ccbf6e281a7~JnbA2Rm4C0061900619eusmtrp1U;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-4e-5ea68e5b3882
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.1A.07950.B5E86AE5; Mon, 27
        Apr 2020 08:48:43 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074843eusmtip2032e3d382bbc91c2a1b6d85dc80f4046~JnbAVdxcK0786807868eusmtip2S;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Date:   Mon, 27 Apr 2020 09:48:32 +0200
Message-Id: <20200427074832.22134-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427074832.22134-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned2YvmVxBsdYLK5cPMRkMfXhEzaL
        K62bGC3ufz3KaPHtSgeTxeVdc9gs1h65y27x+f1+VovDb9pZHTg9NnxuYvPYOesuu8emVZ1s
        Hneu7WHzmD7nP6NH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZSy+e5m1YBdbxZ6bJ5gaGNew
        djFyckgImEi8f/OPvYuRi0NIYAWjxK85DWwQzhdGiUnb+hkhnM+MEt9fzgRq4QBrefDDGyK+
        nFFiz7ZFrHAdp/8fZwSZyyZgKNH1tosNxBYRiJNYvngBE0gRs8AvRonPnzYxgUwSFvCUWD43
        EaSGRUBV4lTrNhYQm1fAVuL+xXYmiPvkJVZvOMAMUs4pYCexcLobyBgJgX52iZcnpzNBHOQi
        8fJwCES5sMSr41vYIWwZidOTe1gg6psZJR6eW8sO4fQwSlxumsEIUWUtcefcLzaQQcwCmhLr
        d+lDhB0lNr/dxw4xn0/ixltBkDAzkDlp23RmiDCvREebEES1msSs4+vg1h68cAmqxENi+uxI
        kLCQwERGifl/iicwys9CWLWAkXEVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYBI5/e/4
        lx2Mu/4kHWIU4GBU4uHl2L40Tog1say4MvcQowQHs5II76OMZXFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MEYaXeUPldGVPpY09YaC75YeIR51xQ/K
        TWHhLJEetqeyZtz5xKXQZRx8Mp5x8a7uVXc+iDgXyR5u1Hm37J/4UkOdJBZrt2MnNi1vUJ14
        yCjKZX1CR1tLmb+XWk71c2YW+Z0p015b/rZlXXvomk6y6BJzobULz0XPTV9jvyFSN+Tnxuzu
        5OvXlViKMxINtZiLihMBFCEqlB4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xe7rRfcviDN5v07G4cvEQk8XUh0/Y
        LK60bmK0uP/1KKPFtysdTBaXd81hs1h75C67xef3+1ktDr9pZ3Xg9NjwuYnNY+esu+wem1Z1
        snncubaHzWP6nP+MHn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJex+O5l1oJdbBV7bp5gamBcw9rFyMEhIWAi8eCHdxcjF4eQ
        wFJGiX2PdrB1MXICxWUkTk5rYIWwhSX+XOsCiwsJfGKUOPxOGMRmEzCU6HoLERcRSJA4tLyF
        GWQQs8A/Rol3j24ygywQFvCUWD43EaSGRUBV4lTrNhYQm1fAVuL+xXYmiPnyEqs3HAAr5xSw
        k1g43Q1ila3Ex+9vmScw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGNbbjv3csoOx
        613wIUYBDkYlHl6O7UvjhFgTy4orcw8xSnAwK4nwPspYFifEm5JYWZValB9fVJqTWnyI0RTo
        ponMUqLJ+cCYyyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwJhm
        Xft1alvU5r0FH/JT7mwSu1CSuo+jZmnoxDUP5KXdZdOBfuDYkDAjm/WoaUu+1b9vzKn5ew6H
        rq9tU30U1aj9b26e5QPzz1X619f1Tc6VWBHx78dPm2ffF8R9aK6SenD0u9ur13v3aXvv3qv3
        c8W1k2qTP255k7rxEsc+vZSlb64s+F48XUGJpTgj0VCLuag4EQAAPcU/gQIAAA==
X-CMS-MailID: 20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
        <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't confuse user with meaningless warning about the failure in getting
clocks in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 sound/soc/codecs/wm8994.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 55d0b9be6ff0..7426df1f806c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4593,7 +4593,8 @@ static int wm8994_probe(struct platform_device *pdev)
 	ret = devm_clk_bulk_get_optional(pdev->dev.parent, ARRAY_SIZE(wm8994->mclk),
 					 wm8994->mclk);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

