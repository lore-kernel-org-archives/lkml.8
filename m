Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C912072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MyRqMeCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgDGPJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:09:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33364 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:09:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200407150921euoutp01bf0ea6ba0bc64b75ab3abfb098b40d7f~DkiBbiipe2841728417euoutp01-
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 15:09:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200407150921euoutp01bf0ea6ba0bc64b75ab3abfb098b40d7f~DkiBbiipe2841728417euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586272161;
        bh=idauTFWK3EpGoGdyTuPSIRfG1qiQ4QuCWlsIf0lCvis=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MyRqMeCmRZgtvN/qXVsScBSpE/PX6ZLkI/A+UaVKf3VL2VAqviKfrJjgxYegcukLS
         snMrnK3MM0LzeAZqzyCe71VL1HGY3cjnlYeFg9MJYkkwv9zr+R34esAj/OiXtnt3l7
         JdGfyQcDhclZEvyC+TCPdEqKJpbg6jfDKXX4LhWs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200407150921eucas1p1d6e08cb14ebc93275b56ef404cc3e9bc~DkiBL3Ieq1502615026eucas1p1z;
        Tue,  7 Apr 2020 15:09:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.D8.60698.1A79C8E5; Tue,  7
        Apr 2020 16:09:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200407150920eucas1p2cb21da18247e3a715521cced7445e593~DkiA2imxC3080030800eucas1p2C;
        Tue,  7 Apr 2020 15:09:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200407150920eusmtrp1ed47ecce65e10c1249762595dba836db~DkiA10Ics2164321643eusmtrp16;
        Tue,  7 Apr 2020 15:09:20 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ec-5e8c97a13edf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.59.07950.0A79C8E5; Tue,  7
        Apr 2020 16:09:20 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200407150920eusmtip1cf6a74c9b9d6b9dd2d26ab4440874a57~DkiAXVC2E2577125771eusmtip1X;
        Tue,  7 Apr 2020 15:09:20 +0000 (GMT)
Subject: Re: [RESEND 2/2] drm: bridge: adv7511: Extend list of audio sample
 rates
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     jernej.skrabec@siol.net, jonas@kwiboo.se, airlied@linux.ie,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        alexios.zavras@intel.com, Laurent.pinchart@ideasonboard.com,
        tglx@linutronix.de
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6ecea2a4-ba7a-929e-3536-22bbb1a39f40@samsung.com>
Date:   Tue, 7 Apr 2020 17:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224120155.15510-2-bogdan.togorean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH/e3M7o5bK+Oq+LIoWoIwPBL9YyIThYghIoIgSsscdTzKix3X
        K0o7rFV3Q10P1NIuSyTIPNYrRdbIezVT8GwrpFjRtGxNMyXXUfK/z3vv+973PXgEJhsUOhGR
        MfGsIoaJkoskuO7dssH1caE68HBlmpjSGLoEVOtkq5i6lZ6HUUPmORE1/NuEUV0zwziVkfNM
        TH1oeiCi9PcDqJrqfMxXQk8P+9FzI+liukRVJKSfvjEJ6M7sQQH93WAQ0/WLn4S0MatDQLdp
        tDi9UL33jMRf4h3KRkUmsAp3nyBJxGpLA4ozSpKWNRMoDemITGRNAOkFbWV5wkwkIWRkBYI0
        sw7jg18IVLWlm8ECgq7Rb4KtFnPB2mbhBYLKr4uID2YRtPe/3VDZkWdBM6kSWdh+nc0/tLhF
        hJG9CIytlrnWhIh0htWa0Q2RlPSBrAI9sjBOHoBaQ+eGxoE8DwX1a4jX2EJX0RRuYWvSF/KK
        OjYYI/fB7boSjGdHGJsqE1jMgJwVw3xtKeL3Pg5Z5f2bbAfTHbVinvdAj1aN85wKxoo7GN+s
        QlBX1YjxhaMwYfizvimx7uAMr5rc+bQfVH1pE1jSQNrAyKwtv4MN5OoKMT4tBdVdGa/eD8a+
        us2BjlA+YBZlI3nxtsuKt11TvO2a4v++jxBeiRxZJRcdznKeMWyiG8dEc8qYcLeQ2OhqtP5p
        PWsd5gbU+jdYj0gCyXdKPzHqQJmQSeCSo/UICExuL3XSZATKpKFMcgqriL2sUEaxnB7tJnC5
        o9TziemSjAxn4tmrLBvHKraqAsLaKQ2Nty0N+LHpZVkJO5KQ97HsqOBQL8pV34sP4FKD1YWV
        19e6T42dSF85Ms5l5qq1zS8jGhpvzGqbl/sYj9NB5/JbcuqsSnd5liqVBytmQn76P6xaGrIP
        SIhMVHemOM/nd3/se+5iCiv5bIy9/t5FedOrxqr9ioMu7CSMZaRelN9bkONcBONxCFNwzD/R
        xwZPZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7oLpvfEGWydpm3Re+4kk8W+u/vY
        LZpapzBbXPn6ns3i6veXzBYn31xlseicuITd4vKuOWwWh/qiLTZvmsrswOXx6qqjx/sbrewe
        sztmsnos3vOSyePEhEtMHu/OnWP32P7tAavH/e7jTB4HeiezeHzeJBfAFaVnU5RfWpKqkJFf
        XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XfvDsaC+1wVP3vvMDYw
        buPoYuTkkBAwkfg67R9zFyMXh5DAUkaJtc1LGSES4hK7579lhrCFJf5c62KDKHrNKPH/1lwm
        kISwQLBE790ONhBbBMj++PcGO0gRs8AZRondqxcyQXScZJS4P3UxWBWbgKbE3803wWxeATuJ
        7mmHwNaxCKhIbDl3AmydqECExOOJ7YwQNYISJ2c+YQGxOQUcJKbMPA5mMwuoS/yZd4kZwpaX
        aN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNz
        NzECo3jbsZ9bdjB2vQs+xCjAwajEw/sgsSdOiDWxrLgy9xCjBAezkgivVG9nnBBvSmJlVWpR
        fnxRaU5q8SFGU6DnJjJLiSbnAxNMXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC
        1CKYPiYOTqkGRsVX7VrMTN891j5mEnL61LIzfteBPaxLrmbtehxQf/C1gFWQHet9a7513I+F
        69P/d0oe2M/1SOnUgcaWuQ8PuGZW/3Y5F73VqNJpiuuhBIvyvPvSznP0Q257Ot07/+bbpI7b
        Tx9dZzjxynr/5BrJgJXXVbXqHx4qfX4sdK+dhqj5v5drBKKuOCqxFGckGmoxFxUnAgAUZZlv
        +AIAAA==
X-CMS-MailID: 20200407150920eucas1p2cb21da18247e3a715521cced7445e593
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200224165503eucas1p2a8aea2390c4b0421e99641e0d4183167
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200224165503eucas1p2a8aea2390c4b0421e99641e0d4183167
References: <20200224120155.15510-1-bogdan.togorean@analog.com>
        <CGME20200224165503eucas1p2a8aea2390c4b0421e99641e0d4183167@eucas1p2.samsung.com>
        <20200224120155.15510-2-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.2020 13:01, Bogdan Togorean wrote:
> ADV7511 support sample rates up to 192kHz. CTS and N parameters should
> be computed accordingly so this commit extend the list up to maximum
> supported sample rate.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 1e9b128d229b..13e8cee6e827 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -27,6 +27,18 @@ static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
>  	case 48000:
>  		*n = 6144;
>  		break;
> +	case 88200:
> +		*n = 12544;
> +		break;
> +	case 96000:
> +		*n = 12288;
> +		break;
> +	case 176400:
> +		*n = 25088;
> +		break;
> +	case 192000:
> +		*n = 24576;
> +		break;


I would put:

case 32000:
case 48000:
case 96000:
case 192000:
    *n = fs * 128 / 1000;
    break;
case 44100:
case 88200:
case 176400:
    *n = fs * 128 / 900;
    break;

To uncover the magic. Up to you.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Regards
Andrzej
>  	}
>  
>  	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;


