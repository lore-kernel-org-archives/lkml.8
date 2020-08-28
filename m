Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E422C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BB3208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fTcGk0n4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgH1Ium (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:50:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40575 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1Iui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:50:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200828085036euoutp02f4f6e3dfd7d71581d656a48d4860e12c~vYnJqm4o60498204982euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:50:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200828085036euoutp02f4f6e3dfd7d71581d656a48d4860e12c~vYnJqm4o60498204982euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598604636;
        bh=ng2ZrvHugmfDMgFT5tZW1Dbq7iv+B8wq4z3cYKG++1w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fTcGk0n4riIeSXhvZ7gQFoLa/zFv7AvfFasRszfHae/HdNt+wTc4V9rfCLPnC8jLG
         JUvw1hnoZslWUDpkDXOpANIV1EtjIihra8poi0CWLVEGIrLaWkS3LGO0dJcjotFFHz
         SiQhbiO8Zsald7WlO8Wn1JlTAkz9ohuWTXy2wy8k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200828085035eucas1p1b07d729a34a85daf5d5070cded54cd2d~vYnJPYa330769907699eucas1p1b;
        Fri, 28 Aug 2020 08:50:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.4F.06456.B55C84F5; Fri, 28
        Aug 2020 09:50:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200828085034eucas1p23b2146e334c637d8cbd3ef8cf51767c7~vYnIWSAv11291212912eucas1p2m;
        Fri, 28 Aug 2020 08:50:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200828085034eusmtrp2800cba779c7f6c18711c8dc6af3a36ae~vYnIU4zWG0572505725eusmtrp2Y;
        Fri, 28 Aug 2020 08:50:34 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-40-5f48c55bc5d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.86.06314.A55C84F5; Fri, 28
        Aug 2020 09:50:34 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200828085034eusmtip141aa86d1b9bbf174458b66c85d972174~vYnHxPiC71631916319eusmtip1Q;
        Fri, 28 Aug 2020 08:50:34 +0000 (GMT)
Subject: Re: [PATCH 2/2] ASoC: wm8994: Ensure the device is resumed in
 wm89xx_mic_detect functions
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <28723053-c305-d359-3862-656ade11bf74@samsung.com>
Date:   Fri, 28 Aug 2020 10:50:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828064812.GE17406@pi3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXa3e+/Myd2c7KilMYoyUBsaXCjETHRFUBBkJLpWXlTyjV01
        9UumGGpqKuRsKL58KJNsJr5OUBrqEN9SF0mmYkwhZUrOlGZl266S337nnP85538eHhKTGAQ+
        ZHJaJqNJU6fIcTd+98ivycDYYaXq/HhPIG2eNvLo97V6Af1i2YLT5qIORE9NtRP0jrmYR88a
        6nC6bWiBoG2bg4JwobLdVoAr+3QLhLKjtQRXauv2kbKisxUpbR1+N/G7bpcSmJTkbEYTHHbP
        LWm1pInIaBHmvDX0EvloiihFQhKoUDA3VfFKkRspoVoQdFeaCS7YRrBYoHWpJJQNwbudC4cd
        4zNrB6LXCCa7ejAu+IHArq3FnCpPKgFsTVUCJ0upAPj8Z1fgFGHUIoLhN1bcWcApBZQPVyAn
        i6gwsPatuPJ86jTMlhtc7EXFQ5fpE4/TiGH0pYXvZKFj6Ijd4GKMksEXSwOPY3/osda5HAE1
        QkD9xiiP8x0JtsISnGNPWDN1HrzAcdjva+BxDYUIyvrnCS6oRLBkakSc6iJ8nbQ7uknHigDQ
        G4KdCNRl2C734tAD5qxizoMHVHdrMS4tguKnEm7GKdhr1R648YFnln1+JZLrjlymO3KN7sg1
        uv9rGxG/FcmYLDY1kWEVacyjIFadymalJQY9SE/tQI4fNfbXtNWLfs7cNyKKRHJ3Ue9AtEoi
        UGezualGBCQml4oiJsbiJaIEdW4eo0lXabJSGNaIfEm+XCYKaf4eJ6ES1ZnMQ4bJYDSHVR4p
        9MlHKRu39wbOWhW/mx/XbKyLa2La7Kr55+Ji41UcRX+8pogLiT+5Z7KUhQZdn1BFrN/wuiPe
        t/imC3qPeQuT9WfQzDd3vQwN6mNii1av7Jo2m6eHlqX9/h8WT2wtz02ErGZ53fLOiVqpX90p
        dg+EpVd+J6UrkTHhmomF/uqoPJ8ncj6bpFacwzSs+h/QZYFkTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7pRRz3iDX6sN7S4cvEQk8XGGetZ
        LaY+fMJmcaV1E6PF+fMb2C2+Xelgsri8aw6bxdojd9ktPr/fz+rA6bHhcxObx85Zd9k9Nq3q
        ZPOYPuc/o0ffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlPOtcyF6wgrNiza4d7A2M59m7GDk5JARMJM5cegVkc3EICSxllPj3
        7htrFyMHUEJKYn6LEkSNsMSfa11sEDXvGSU+TbvBBJIQFkiR+LxwIiuILSKgKXH973cwm1ng
        HqPE3R6wZiEQu/l8DIjNJmAo0Xu0jxHE5hWwk3i78ykbiM0ioCpxuXcXmC0qECfxuPc/M0SN
        oMTJmU9YQGxOoPnHfu1igZivLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs1C0j4LScssJC2z
        kLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERiR24793LyD8dLG4EOMAhyMSjy8O/a5
        xwuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBySKvJN7Q
        1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjk56czoO6R6ZNqZJL3lZa
        JuyrSvu4pUMzICD968T/vinV8vLlk8+fWDL3CWuRoT1v+MQpZj09O1e1T5L3Oe61VkPwyJWt
        xw7rLzBMvf+sqcTx74T1exgkLTOe3LEyOnSl8ENXh8BqhbcZZ2XmNW9Ze95lIdP9ysXP3BM/
        PLJ4Pv1oW6TO4bxeJZbijERDLeai4kQAqnTLat4CAAA=
X-CMS-MailID: 20200828085034eucas1p23b2146e334c637d8cbd3ef8cf51767c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf
References: <20200827173357.31891-1-s.nawrocki@samsung.com>
        <CGME20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf@eucas1p1.samsung.com>
        <20200827173357.31891-2-s.nawrocki@samsung.com> <20200828064812.GE17406@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2020 08:48, Krzysztof Kozlowski wrote:
>> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
>> index b3ba053..fc9ea19 100644
>> --- a/sound/soc/codecs/wm8994.c
>> +++ b/sound/soc/codecs/wm8994.c
>> @@ -3514,6 +3514,8 @@ int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
>>  		return -EINVAL;
>>  	}
>>  
>> +	pm_runtime_get_sync(component->dev);

> The driver enables PM runtime unconditionally so you should probably
> handle the error code here. I know that driver does not do it in other
> cases but it should not be a reason to multiple this pattern... unless
> it really does not matter as there are no runtime PM ops?

The regmap is provided by the parent MFD device (drivers/mfd/wm8994-core.c)
and that is where those runtime PM calls get propagated, we could possibly
get en error if there is something wrong with resuming the parent device.

If you don't mind I would prefer to omit the return value tests in that
fix patch. Existing callers of the wm89*_mic_detect() functions are 
ignoring the return value anyway. Probably the checks could be added 
in a separate patch. 

-- 
Thanks,
Sylwester
