Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A290C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA8A246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PIzata/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1KBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:01:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54858 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgB1KBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:01:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200228100115euoutp020445ab5ae3097588501ffef29071e450~3iK4IJWIK0064500645euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:01:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200228100115euoutp020445ab5ae3097588501ffef29071e450~3iK4IJWIK0064500645euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582884075;
        bh=r7iAjpDLPSMkIvQyWiR/gtZC7/Uvo9W8WiBUY3bIyxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIzata/sP4ssB420HUNMBxV8UovlTZ/bOsqBbDGF0D0Eluz4VkzaFP7ACpdVCPsC1
         F2aATp9RNdfDcMVKnrNTQSFUEaHzO493qrJG9112JzvkvtC3ruCCGtEiQ692qrIWV5
         P0EDQ6SnR1QdeT0arlG+eGJpiuYuD57VMU9j3uyY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200228100114eucas1p1cf7b49552dc788c951afde0977ae8c62~3iK337i5z0578605786eucas1p1A;
        Fri, 28 Feb 2020 10:01:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.C5.60679.AE4E85E5; Fri, 28
        Feb 2020 10:01:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200228100114eucas1p23f608fce62f751125d5107721744ce22~3iK3lkMDh1701517015eucas1p2C;
        Fri, 28 Feb 2020 10:01:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228100114eusmtrp14b1f1d52c6b219b563d9245797aed779~3iK3k73EN1359213592eusmtrp10;
        Fri, 28 Feb 2020 10:01:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-0a-5e58e4ea50f4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.53.08375.AE4E85E5; Fri, 28
        Feb 2020 10:01:14 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200228100113eusmtip1ab4804ebe72bd37332090963029f9851~3iK3GKNRQ2243522435eusmtip1b;
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
Subject: [PATCH 2/2] ASoC: wm8994: Silence warnings during deferred probe
Date:   Fri, 28 Feb 2020 11:00:38 +0100
Message-Id: <20200228100038.27748-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228100038.27748-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qvnkTEGXw6rmdx5eIhJoupD5+w
        WVxp3cRocf/rUUaLb1c6mCwu75rDZrH2yF12i8/v97NaHH7TzurA6bHhcxObx85Zd9k9Nq3q
        ZPO4c20Pm8f0Of8ZPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvjz4JHTAW72CoWNnxgamBc
        w9rFyMkhIWAiMWP7QTBbSGAFo8SE3pQuRi4g+wujxNL2j6wQzmdGiSn7trDAdKy/ewMqsZxR
        Yu6cfexwLRu3TmcEqWITMJToetvFBmKLCMRJLF+8gAmkiFngF6PE50+bmEASwgKeEivW3gVb
        ziKgKrH+yAuwOK+ArcShHx3sEOvkJVZvOMAMYnMK2EmcvP0MbJCEQDe7ROvRXiaIIheJ+Xc3
        QH0kLPHq+BaoZhmJ05N7WCAamhklHp5byw7h9DBKXG6awQhRZS1x59wvoFs5gO7TlFi/Sx8i
        7CjxbudCdpCwhACfxI23giBhZiBz0rbpzBBhXomONiGIajWJWcfXwa09eOESM4TtIXHjchs0
        hCYyStxfuo55AqP8LIRlCxgZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmlNP/jn/Z
        wbjrT9IhRgEORiUe3gU7wuOEWBPLiitzDzFKcDArifBu/BoaJ8SbklhZlVqUH19UmpNafIhR
        moNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANjzgar/XuNrnJpPV7uECf5Z84TddNFbJrr
        5R5v3fFkY3DEAtePmSt7H/xYyuH56s7qxStXCbaJ7ndlfXxF3ut3tY265IXYjMVlZ9OSLXMy
        l9jbe2X/lbg24VdAl1h8rE7E0RTePrFfv7xNb5Tulw1NOXfk5P3ccqlp4Zu7Mj2/h8zY5iY/
        JfC5EktxRqKhFnNRcSIAZubgjCQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7qvnkTEGSx6L2Vx5eIhJoupD5+w
        WVxp3cRocf/rUUaLb1c6mCwu75rDZrH2yF12i8/v97NaHH7TzurA6bHhcxObx85Zd9k9Nq3q
        ZPO4c20Pm8f0Of8ZPfq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS/jz4JHTAW72CoWNnxgamBcw9rFyMkhIWAisf7uDSCbi0NI
        YCmjRNPDt4wQCRmJk9MaoIqEJf5c62KDKPrEKHF07jSwBJuAoUTXW5AEJ4eIQILEoeUtzCBF
        zAL/GCXePbrJDJIQFvCUWLH2LlgDi4CqxPojL5hAbF4BW4lDPzrYITbIS6zecACsnlPATuLk
        7WdgNUJANUfnPGSewMi3gJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmB4bzv2c/MOxksb
        gw8xCnAwKvHwLtgRHifEmlhWXJl7iFGCg1lJhHfj19A4Id6UxMqq1KL8+KLSnNTiQ4ymQEdN
        ZJYSTc4Hxl5eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGbk7D
        ogiT60o1WW/Wfj10oF3LRX9r+f6zL09e665/r7z40+9E8Vwx9VOmSx5qHdvidj+tkv2l45fr
        560k9C1uL/XvM9j1I+L07jeeuU7T1LYs8z0Rx/7v+mR9paCaFwxmKxSmmLUunlkh3bgit2/C
        tXuawUn/dwk9O5Z0vI1hxh++LROeVnyarMRSnJFoqMVcVJwIAM1hzieFAgAA
X-CMS-MailID: 20200228100114eucas1p23f608fce62f751125d5107721744ce22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228100114eucas1p23f608fce62f751125d5107721744ce22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228100114eucas1p23f608fce62f751125d5107721744ce22
References: <20200228100038.27748-1-m.szyprowski@samsung.com>
        <CGME20200228100114eucas1p23f608fce62f751125d5107721744ce22@eucas1p2.samsung.com>
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
index 15ce64a48a87..b4d8da8eb479 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4601,7 +4601,8 @@ static int wm8994_probe(struct platform_device *pdev)
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

