Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF691C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E16F207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dMEPsFop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgHYDWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:22:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44855 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgHYDWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:22:12 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200825032209epoutp02e812708731da3b5b6912aa5646044971~uZMhRam7t2422524225epoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:22:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200825032209epoutp02e812708731da3b5b6912aa5646044971~uZMhRam7t2422524225epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598325729;
        bh=2QBjtI9d28qnFlyqeG+eoDcXAA3qZO5ECOXtoNyq0DM=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=dMEPsFopuxpFzAywmv8/dCklkdXlgZ7lrddiUsBLCjDZCTB7XhT6DtHdc3RxW+J4W
         Ec1y7JHQYIkLx250I7LdgvR1x+a8pErdBGxunjirlsJIQ0m2euQJw8OA6RiVXgT/w0
         HJXjjweCshux5XRB4AlQuxoO1JGxVPm5S9vKBCYI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200825032208epcas1p39e457286f7592563973290da8cac8c76~uZMgq3Une1468714687epcas1p3f;
        Tue, 25 Aug 2020 03:22:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BbDnB2FjhzMqYkZ; Tue, 25 Aug
        2020 03:22:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.5B.28581.BD3844F5; Tue, 25 Aug 2020 12:22:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200825032203epcas1p1489f9a06a6a30d448cfd51f6291e0354~uZMbqmD-H1419714197epcas1p1c;
        Tue, 25 Aug 2020 03:22:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200825032203epsmtrp2d10fe2e0a33a92e6040c147fc762a438~uZMbp9z650760407604epsmtrp2q;
        Tue, 25 Aug 2020 03:22:03 +0000 (GMT)
X-AuditID: b6c32a38-85df1a8000006fa5-e4-5f4483db5b3d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.E3.08382.BD3844F5; Tue, 25 Aug 2020 12:22:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200825032203epsmtip2e75cf25d2e166bed662cea2ff1c6db6e~uZMbeyL5G1584815848epsmtip2w;
        Tue, 25 Aug 2020 03:22:03 +0000 (GMT)
Subject: Re: [PATCH] extcon: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e174f7c8-1e5e-e282-464d-b35aa31f8afb@samsung.com>
Date:   Tue, 25 Aug 2020 12:34:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200713131953.34489-1-grandmaster@al2klimov.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmru7tZpd4g+4uPYtnrxoZLS7vmsNm
        cbtxBZsDs8eBU5tZPfq2rGL0+LxJLoA5KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB2iRkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        skCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y83jF6wFn8QrZhxawNLAuFC4i5GTQ0LAROJw51tm
        EFtIYAejxOLJmRD2J0aJRZP5uxi5gOxvjBKHe74ywzSs+jMRqmEvo8TMPjGIoveMEhN6drKA
        JIQF7CX6TtwBs0UE8iS6jn9iA7HZBLQk9r+4AWbzCyhKXP3xmBHE5hWwk7hycwUTiM0ioCrx
        vuU6WI2oQJjEyW0tUDWCEidnPgGbyQlUf3tpK1icWUBc4taT+UwQtrzE9rdzoA69xy7R+lYa
        wnaRWNmwiQnCFpZ4dXwLO4QtJfH53V42CLtaYuXJI2wgz0gIdDBKbNl/gRUiYSyxf+lkoGYO
        oAWaEut36UOEFSV2/p4LdQOfxLuvPawgJRICvBIdbUIQJcoSlx/chVorKbG4vRNqlYfE/E9b
        mSYwKs5C8tksJN/MQvLNLITFCxhZVjGKpRYU56anFhsWmCBH9SZGcArUstjBOPftB71DjEwc
        jIcYJTiYlUR4BS86xwvxpiRWVqUW5ccXleakFh9iNAWG9URmKdHkfGASziuJNzQ1MjY2tjAx
        NDM1NFQS5314SyFeSCA9sSQ1OzW1ILUIpo+Jg1OqgSl+dswatgT5dxovDj4P87zRF7ksKmL7
        soLQFZ9OzFX4En//bsp74SliLIFzVcL6eNQm3dx2QCRfjKGnbrHU47bpjqxH+5b1PZ/Nq+Em
        NWuz0vu+XNHdHKLS51WdTeZKZlxLVDl+oGTmlalK3p8Tjr9+8DH5meA55flmB277zQle/67l
        WuwB7uLrh4/+3vF0wrGDGwM/aPVc3cU0XWVJqijXFXdOwdJ3wr2+MjGVp2XSPolxfC7XaG9u
        edXnu+DR9Q8TfisWt6y5uU53nnyfodrKCfnXLyQHusTyO97svry679T9pyfbW5+v8/kqcHLO
        wpaIIr6mVY3afpwrrqw9qJuwbc67W0zuH4QD4nlq10srsRRnJBpqMRcVJwIAzi1nxAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO7tZpd4g/67nBbPXjUyWlzeNYfN
        4nbjCjYHZo8DpzazevRtWcXo8XmTXABzFJdNSmpOZllqkb5dAlfGmscvWAs+iVfMOLSApYFx
        oXAXIyeHhICJxKo/E5m7GLk4hAR2M0q86LnICpGQlJh28ShQggPIFpY4fLgYouYto8TNn3vZ
        QGqEBewl+k7cYQGxRQTyJD5N3MwIUTSRUeLXrWZ2kASbgJbE/hc3wBr4BRQlrv54zAhi8wrY
        SVy5uYIJxGYRUJV433IdrEZUIExi55LHTBA1ghInZz4BW8AJVH97aStYL7OAusSfeZeYIWxx
        iVtP5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5x
        aV66XnJ+7iZGcOhrae5g3L7qg94hRiYOxkOMEhzMSiK8ghed44V4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz3ihcGCckkJ5YkpqdmlqQWgSTZeLglGpgWn5OS1M4eHLESuYdqbsfrVOcU1nKPZ39
        oXBYf7O/r8SpJT8erbR5Uxcc88RUdBZDjZdg/fMYlVWXTmvqJRplCNgwep48f+HG/Uv7Nien
        nmJ8mmGtx7bv3Yp0E9H018EaHeE2781XpqxaM0c2rz18//cHWZHOsXNLVzZOnHIpZGLMpUtl
        7nOeqju2PI3i27v5/aV+Hq0J8SzbFrJMX3rvkOTlXVd4FLUyVNfPi2iv8ObcY8N0JiBbw6Xk
        dlzIMV+Gis3en6tr79Y6ir6KF7q01JJ5S5/9uv2zrD44ntc8c0e7Zl+w1PFSl5AJ5dME+D0M
        e1fl7S06pCCpEHrieOdsp26ByizLhkyd531u/jlKLMUZiYZazEXFiQBBa8S+7AIAAA==
X-CMS-MailID: 20200825032203epcas1p1489f9a06a6a30d448cfd51f6291e0354
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713132005epcas1p3fe3be48d136b3bec3582086c539f3a9e
References: <CGME20200713132005epcas1p3fe3be48d136b3bec3582086c539f3a9e@epcas1p3.samsung.com>
        <20200713131953.34489-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/20 10:19 PM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://protect2.fireeye.com/url?k=dd645f97-80b64932-dd65d4d8-0cc47a31bee8-e21cf64490b8937b&q=1&u=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F6%2F27%2F64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://protect2.fireeye.com/url?k=815617a2-dc840107-81579ced-0cc47a31bee8-f16575a44dddc110&q=1&u=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F6%2F26%2F837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  drivers/extcon/extcon-palmas.c   | 2 +-
>  drivers/extcon/extcon-usb-gpio.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index cea58d0cb457..e8e9eebe6b1d 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -2,7 +2,7 @@
>  /*
>   * Palmas USB transceiver driver
>   *
> - * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
>   * Author: Graeme Gregory <gg@slimlogic.co.uk>
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   * Based on twl6030_usb.c
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index 98b5afa5b615..f06be6d4e2a9 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -2,7 +2,7 @@
>  /**
>   * drivers/extcon/extcon-usb-gpio.c - USB GPIO extcon driver
>   *
> - * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
>   * Author: Roger Quadros <rogerq@ti.com>
>   */
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
