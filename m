Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A091EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3802084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vDpzS1lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGCSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:07:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43087 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:07:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200703180733euoutp01891db71a0c4362cf5f258b994ce10a7c~eUFdKLcVD0454004540euoutp01v
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 18:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200703180733euoutp01891db71a0c4362cf5f258b994ce10a7c~eUFdKLcVD0454004540euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593799654;
        bh=70bj60STKB80rOnkSFyQI/YuWqofuzC2wl3VVj689IQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vDpzS1lLZNs9JSpYd53FpWtfwN4+BZ6WDzyMxnKsntn/YqVTinkU3fYjVhhJH8cfo
         TtOj3lAR8ebFA5enPSET3bKWveGKd1LdOW3xQ5jznaMlXVIcausXBs7FBtPxZNDXRX
         0doPG9YlNClbeKlVHd/A99vP+ZIMUw2NRY/ejBTc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200703180733eucas1p2f008451ed38148d09c3be4fac6adaa55~eUFckRTwB2636026360eucas1p2Z;
        Fri,  3 Jul 2020 18:07:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.E3.06456.5E37FFE5; Fri,  3
        Jul 2020 19:07:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200703180732eucas1p2d892bde2008ef5b783a041ed194198b9~eUFcQJuqT1177511775eucas1p21;
        Fri,  3 Jul 2020 18:07:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703180732eusmtrp1827a4f6922fb396ce87071f27e726fd7~eUFcPh8bG0919209192eusmtrp1p;
        Fri,  3 Jul 2020 18:07:32 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-20-5eff73e5b7fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.FE.06314.4E37FFE5; Fri,  3
        Jul 2020 19:07:32 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200703180732eusmtip24b72fb42ea4bb4fbcf34697077c19ce1~eUFbk_jJb0813408134eusmtip22;
        Fri,  3 Jul 2020 18:07:32 +0000 (GMT)
Subject: Re: [PATCH 2/8] ASoC: samsung: spdif: fix kernel-doc
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <de4b95f5-72b8-fa22-e437-7740e5ce51f5@samsung.com>
Date:   Fri, 3 Jul 2020 20:07:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702165901.164100-3-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7pPi//HGez7zm9x5eIhJoupD5+w
        WZw/v4Hd4tuVDiaLy7vmsFl07upntfj1/xmTxcUVX5gsNnxfy2jxcvMbJgcujw2fm9g8ds66
        y+6xaVUnm8e8k4Ee+94uY/Po27KK0WP9lqssHptPV3t83iQXwBnFZZOSmpNZllqkb5fAldGw
        ag97wSfGirOPPjE1MF5k7GLk5JAQMJG4cPgUexcjF4eQwApGiRUti1ggnC+MEuem3GIBqRIS
        +MwocWirP0zHjWuLoDqWM0r83vWFCcL5yCjxZ+VCdpAqYQFbifZzi9hAbBGBOInlX86DdTAL
        tDFJHH7/ihkkwSZgKNF7tA/sEF4BO4mOm9+YQGwWARWJx09XgQ0SFYiV6Fu6gA2iRlDi5Mwn
        QCdxcHAKeEsceMMBEmYWEJe49WQ+E4QtL7H97RxmkF0SAi/ZJdon34Z61EVi9sJPzBC2sMSr
        41vYIWwZidOTe1ggGpoZJXp232aHcCYwStw/vgCq21rizrlfbCCbmQU0Jdbv0ocIO0p03djA
        DBKWEOCTuPFWEOIIPolJ26ZDhXklOtqEIKpVJH6vms4EYUtJdD/5zzKBUWkWks9mIXlnFpJ3
        ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwjZ3+d/zTDsavl5IOMQpwMCrx
        8L44+TdOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUS
        SE8sSc1OTS1ILYLJMnFwSjUwRn0Ks15nn7RUe3ej+QI+puT7mmkBX9n2b+Zy3fkrnMnJiPdf
        5dI264PiijW7D7NV+rS4imQdF/54qLlxfd2V3nb+W2IK84ytrP5sWRXVknni56M9ETXTm9kk
        Kufb2XI/ExXaKsxatEbnfm9Lf9/hF1KTpryPXvVineSTkOySd/qVJWVOCS1KLMUZiYZazEXF
        iQBaKrheXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7pPiv/HGTz+ZWFx5eIhJoupD5+w
        WZw/v4Hd4tuVDiaLy7vmsFl07upntfj1/xmTxcUVX5gsNnxfy2jxcvMbJgcujw2fm9g8ds66
        y+6xaVUnm8e8k4Ee+94uY/Po27KK0WP9lqssHptPV3t83iQXwBmlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9Gwag97wSfGirOPPjE1MF5k7GLk
        5JAQMJG4cW0RexcjF4eQwFJGiR3/j7J1MXIAJaQk5rcoQdQIS/y51sUGUfOeUaLnSi87SEJY
        wFai/dwiNhBbRCBOYvfCQywgRcwCbUwS31f1MEJ03GeUaFn7HayKTcBQovdoH9hqXgE7iY6b
        35hAbBYBFYnHT1eBTRUViJX4dm8LG0SNoMTJmU9YQC7iFPCWOPCGAyTMLKAu8WfeJWYIW1zi
        1pP5TBC2vMT2t3OYJzAKzULSPQtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGLfbjv3cvIPx0sbgQ4wCHIxKPLwTjv+NE2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVq
        UX58UWlOavEhRlOg3yYyS4km5wNTSl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTU
        gtQimD4mDk6pBsaafskfm+y6Pf0uRivUF38PerZwxkyu1Us4JjTb1b/f0nST09hVfFkkw2+P
        P0Klbg1bMg2mWYaXMOr4/3Vot4w5Fhu7VWJjjvR2madO9X28Sd0cvUxe2+KO5vBHnet9HRmZ
        /TJVw+Cnxbufny6t2LjkjnVE4fUExi6zp9k/U6wdGsJa4pfdU2Ipzkg01GIuKk4EAOhKcpLx
        AgAA
X-CMS-MailID: 20200703180732eucas1p2d892bde2008ef5b783a041ed194198b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702165920eucas1p1348effa5cbe7fb4682946525c3aeb31b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702165920eucas1p1348effa5cbe7fb4682946525c3aeb31b
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
        <CGME20200702165920eucas1p1348effa5cbe7fb4682946525c3aeb31b@eucas1p1.samsung.com>
        <20200702165901.164100-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2020 18:58, Pierre-Louis Bossart wrote:
> Fix W=1 warnings - typos with structure fields
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
