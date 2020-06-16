Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABAA206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZKwZ/ZSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgFPBHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:07:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21871 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:07:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200616010746epoutp0461502f2443a6c19f6cad6c9865740ba4~Y4NNWwa6_2254222542epoutp04v
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:07:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200616010746epoutp0461502f2443a6c19f6cad6c9865740ba4~Y4NNWwa6_2254222542epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592269666;
        bh=gnY88RXOssvH5Xww17ErLswdrAfp00DoI8np6JeQBP8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZKwZ/ZSUVspFfwwzAi713C12OqiW+Cgqz8oPM5CBTl9C31U6eAvosaqU5+X5LeNN3
         SNt0Mhs9W2vszvRpgfqXXsP+j+rrxivr70JUye0m4GNXjhq2wE5mlcKrAqyZDVCqee
         4fgwkR6tp1+ZgbkIPgpsrE+AzJt5yz2C9Ycbim3c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200616010745epcas1p4647c4e2c103bb2a0f75f04a7ebb33d5d~Y4NMGTenh1149011490epcas1p4B;
        Tue, 16 Jun 2020 01:07:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49m96R35ZHzMqYlt; Tue, 16 Jun
        2020 01:07:43 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.30.28581.F5B18EE5; Tue, 16 Jun 2020 10:07:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200616010742epcas1p2b477f89fb10453e26d1f66744cc3ff4e~Y4NJ9SDyA0868708687epcas1p24;
        Tue, 16 Jun 2020 01:07:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200616010742epsmtrp206a398268b6ee10f5a027e331d45f31d~Y4NJ7y7GB2348323483epsmtrp2d;
        Tue, 16 Jun 2020 01:07:42 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-29-5ee81b5f1d8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.91.08382.E5B18EE5; Tue, 16 Jun 2020 10:07:42 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200616010742epsmtip17295d77c48794ab76c150fbe260e959a~Y4NJmFhWK0736907369epsmtip1q;
        Tue, 16 Jun 2020 01:07:42 +0000 (GMT)
Subject: Re: [PATCH v2] drm/exynos: fix ref count leak in mic_pre_enable
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <ece0b0bb-43d6-0e8e-3fcd-280dac6cd07f@samsung.com>
Date:   Tue, 16 Jun 2020 10:13:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615054928.55188-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzOe9deryTdjvr1Wpnisf0BC5RC6w7Hh4mEnOIS1Iw4k7UccKGM
        0nZtYTgxKzIY1iEUguOjTNhQsDLmmEMgMEJFWmSCDnECA9xgCJsTUwL7wLm1Hmb89/ye93ne
        3+95P3BU/CMmwdO1JtagZTQk5sNruxYoDVZtm1eG3mjcTBUPDSDUv21WlLqzvIhRc3mf8Kn5
        qds8qmTmN5RyfXpTQA0PXxZQN08+FFCtM3f51EinDaMqh79FKMsXhShVPNCOUpXlCxhVfD0P
        20PQN8x1GN29UsejO6onBXSr/RRGX125z6enTzsR+uuGD+gzV+yAHq0/KaCXWrcn+BzNiFSz
        TCpr8Ge1KbrUdG1aFBl/WLVXpdgVKguWRVCvkf5aJpONImMPJATHpWs8WUj/bEaT5aESGKOR
        lEZHGnRZJtZfrTOaokhWn6rRR+hDjEymMUubFpKiy9wtCw0NU3iESRnqqnoXph/Bc7rKQszA
        LLAAIQ4JOXR9NYpZgA8uJtoBtHQVoFzhBnC0dhThihUAf+q0os8tY/XjAm6hG8CRMdeaZRHA
        ttOFwAJwfANBwyZrnJffSLhQWDc0j3l5lNgHS8ck3o0w4hVobZrGvFhERMO+fCvfi3kefrVz
        HvXKNxFH4OAyw0l84UDVLM+LhUQM7KsoRLwYJbbA8dlza3gHzP+m5tk4kHiMw6GuKoQbOhYW
        OSb4HN4Af3VeWcsvgUuPujHOkA+gtXIQ4YoiACdnfuBxqnDYc74c4QIEwi87pRy9E3as1gKu
        8wvw0fLHfK8EEiJYVCjmJCTsv30PcBjCWw1WjMM0fHjNCUrBzup12arX5alel6f6/8Z1gGcH
        m1m9MTONNcr08vWX3QqePfMgqh3U/v44xAEQHDgAxFFyo8ix44FSLEpljr3PGnQqQ5aGNTqA
        wnPYVlSyKUXn+Sdak0qmCAsPD6fksl0KmYzcIhrYfUspJtIYE5vBsnrW8NyH4EKJGal4/dS0
        223r4JccTV+dK/9MWqaPnPW9jEuPm5VnzwUMKbJ9p2xPerfmZvf1y/8Oak65OFFxX9EQs3gx
        +sBCQO4Z0Phyc8KFooncnPP3TvxpGxk0Px2nhS5Gqc5x5jW1NB1yz02/uV2UxIjI9wjmSM9f
        5ruHWsylNWxWy5TToFK/8fNHmQVuYunOO2yeXECWJMe0fj9x1t9UOtofL8e6tj251Ft7nZCK
        0T3i5kuJlD0jYGtQTahwQS558dgffquHk37peSsq8WniP5P2Asl4cuN3yrer4l6yhxWX7bsa
        m3xw4PPjZSd6X1U21NYc/NAtjV951684cK8tgj9se2C6IPTbT/KMakYWhBqMzH/HoD6fbwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnG6c9Is4g95duha9504yWfzfNpHZ
        4srX92wWzxqns1q8uHeRxaL/8WtmixPzzrJbnD+/gd3ibNMbdotNj6+xWlzeNYfNYsb5fUwW
        XWvbmC16T+5gtpgx+SWbRe/RRjYHAY9TDQvYPPZ+W8DisXPWXXaPTas62Ty2f3vA6nG/+ziT
        x+Yl9R59W1Yxelxd2MTu8XmTXABXFJdNSmpOZllqkb5dAlfGzIUn2Aouc1TsmaTXwNjA3sXI
        ySEhYCJxc+EtMFtIYDejxNR39V2MHEBxCYktWzkgTGGJw4eLuxi5gCreMkrc+v+GDSQuLOAh
        sWKiG0hcROAUs8S27U+YQOLMAp4SE25KQdQfZ5TYuOY6E8h4NgFViYkr7rOB2LwCdhJHmiey
        gtgsQPHfu14wg9iiAhESz7ffYISoEZQ4OfMJC4jNKWAvcWRqG9gcZgF1iT/zLjFD2OISt57M
        h4rLSzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjODI1dLcwbh91Qe9Q4xMHIyHGCU4mJVEeA/JP48T4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znujcGGckEB6YklqdmpqQWoRTJaJg1Oqgelwc79WR0baCnadj6Hp6uee/+i7961m9qVwhbfM
        KTve777LdPjvt6InQd9+6C58LFXg8uHPJebweJ9k5WdNz/6fVL34LHfzj7Dlbg3y/It0z6T9
        v3LJw1FRbHmvScm7qQ8Tn24J4jRYHjpxMhdDjcj8xrsWfAt//ONrWVt+8KjKTc0ExvYatglK
        9l1fNxyvSN3+PVM8LE1zQu3lMvV0heM7ZZ9Nsdm/TfekgG7sV7uYNzM/Tb3WGunLdYwxOOTB
        aZVdh8Q4PF/w9v59ytu1xaidc+qNnlPLBFkPVm84oS7VYXxEqeuOnd0kDU6hG7s4F7zm2HVc
        /+Vt0d/79m76znsoyU/qrknhmh2fNhTH5r9RYinOSDTUYi4qTgQAArHWaEsDAAA=
X-CMS-MailID: 20200616010742epcas1p2b477f89fb10453e26d1f66744cc3ff4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200615054950epcas1p3f266ec99c3608f49f733644d8cd41c1a
References: <027d9eb5-a1c1-c329-72c3-a555b71f8677@samsung.com>
        <CGME20200615054950epcas1p3f266ec99c3608f49f733644d8cd41c1a@epcas1p3.samsung.com>
        <20200615054928.55188-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



20. 6. 15. 오후 2:49에 Navid Emamdoost 이(가) 쓴 글:
> in mic_pre_enable, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	- reuse the unlock label and call pm_runtime_put_noidle

Picked it up.

Thanks,
Inki Dae

> ---
> ---
>  drivers/gpu/drm/exynos/exynos_drm_mic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> index a86abc173605..3821ea76a703 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> @@ -269,8 +269,10 @@ static void mic_pre_enable(struct drm_bridge *bridge)
>  		goto unlock;
>  
>  	ret = pm_runtime_get_sync(mic->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(mic->dev);
>  		goto unlock;
> +	}
>  
>  	mic_set_path(mic, 1);
>  
> 
