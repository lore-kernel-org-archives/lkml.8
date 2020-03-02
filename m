Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F507C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377BF217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JkXpl/Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCBPl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:41:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55535 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCBPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:41:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154153euoutp01d3e67720750db424d58653aa64aba50a~4hwKFQqAp1219112191euoutp01T
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302154153euoutp01d3e67720750db424d58653aa64aba50a~4hwKFQqAp1219112191euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163713;
        bh=T+Qagezjk3GYC6IUfr1MpSBM/7xUpvBGzVFpeZNM0w0=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=JkXpl/Eu5lZj+OYEtH2ku1U5JNLDx0A/JEpbFYZ1iDOoUdyHvFRfivTAmv8hbQMGL
         wEWX1VkPAFonqVYqFunbOyqjc/nEmJlAMXvgLaj0qBeY6wMmozU4cgjfla1WYMW+/S
         JzHfyc2DtxXJ/MuE7pwiNlgE+/9lwCPdMpnK5wq4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154153eucas1p28485feaccb7dd7009abd29877092a216~4hwJ-aznj2199521995eucas1p22;
        Mon,  2 Mar 2020 15:41:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.7D.61286.1492D5E5; Mon,  2
        Mar 2020 15:41:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154153eucas1p2db854c0f1a1b25e5b4c260379d7b6260~4hwJpbpvU1937719377eucas1p29;
        Mon,  2 Mar 2020 15:41:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154153eusmtrp1cb5af2209331c6ae657320d037d5eec5~4hwJo89K22862728627eusmtrp1i;
        Mon,  2 Mar 2020 15:41:53 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-80-5e5d2941bc52
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.00.08375.1492D5E5; Mon,  2
        Mar 2020 15:41:53 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154153eusmtip2ecca85bcdc5c3287a022639fe2d18d62~4hwJO003y2174521745eusmtip2b;
        Mon,  2 Mar 2020 15:41:52 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] video: fbdev: w100fb: fix sparse warnings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <41d71487-4479-2d7d-7fad-e25f01c939ec@samsung.com>
Date:   Mon, 2 Mar 2020 16:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117185737.GB24508@ravnborg.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7qOmrFxBh0LdC2ufH3PZnGi7wOr
        xeVdc9gsVvzcyujA4nG/+ziTx5JpV9k8Pm+SC2CO4rJJSc3JLEst0rdL4Mro2rGTpWAxS0X7
        tHfMDYwnmLsYOTkkBEwklkx9y9rFyMUhJLCCUeL0tRVQzhdGifUvr7NAOJ8ZJZb+u8UK0/Li
        wRN2iMRyRonzs/5AVb1llHh8txNsMJuAlcTE9lWMILawgJPEtyuTwbpFBJQljp+/BmYzCyRI
        fLn5GayeV8BO4tCsu2BxFgEViRuT9rOB2KICERKfHhxmhagRlDg58wkLiM0pYCTxa909Jog5
        4hK3nsyHsuUltr+dwwxykIRAN7tEc18jG8TZLhJfW/ewQ9jCEq+Ob4GyZSROT+5hgWhYxyjx
        t+MFVPd2Ronlk/9BdVtL3Dn3C8jmAFqhKbF+lz5E2FFiTu9aFpCwhACfxI23ghBH8ElM2jad
        GSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LVZSN6ZheSdWQh7FzCyrGIUTy0tzk1PLTbM
        Sy3XK07MLS7NS9dLzs/dxAhMKqf/Hf+0g/HrpaRDjAIcjEo8vAHMsXFCrIllxZW5hxglOJiV
        RHh9OaPjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamBc
        3RfXfdayVFJIgy/n6+knc4Xz0pu97EIP5Kk/MSufJjtFKX7NJZNfVic5W3PSHuzVnDFxT4hk
        B/dz/tt1jyRZ1dVOr+3kfbov67Jw6s6IL7cZX+2tP3pUZuX9tF99Ru4clqWnHNc8V39R3Rh5
        61DzjvCvr39WRMfKKxta3dJeXld1RudahYESS3FGoqEWc1FxIgBy1G3nJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7qOmrFxBp9viFpc+fqezeJE3wdW
        i8u75rBZrPi5ldGBxeN+93EmjyXTrrJ5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRtWMnS8Filor2ae+YGxhPMHcxcnJICJhIvHjw
        hB3EFhJYyijRfj+5i5EDKC4jcXx9GUSJsMSfa11sXYxcQCWvGSUmfT/NApJgE7CSmNi+ihHE
        FhZwkvh2ZTIriC0ioCxx/Pw1MJtZIEFi0/2pUM27GCUObl7IBJLgFbCTODTrLlgRi4CKxI1J
        +9lAbFGBCInDO2YxQtQISpyc+QRsGaeAkcSvdfeYIIaqS/yZd4kZwhaXuPVkPlRcXmL72znM
        ExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjKBtx35u3sF4
        aWPwIUYBDkYlHt4A5tg4IdbEsuLK3EOMEhzMSiK8vpzRcUK8KYmVValF+fFFpTmpxYcYTYGe
        m8gsJZqcD4zuvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjALc
        zMd934S4n5/m/mNzkodqu9buwrJjVVbBLM5nRJcJN0tk3/x16E9kvdWLpbHd7p4Z1/ma2Vnb
        9L5mW3rdTygoZLtQV1zjZb62cv39A5NWlZX1bTzEvkJ7w1nL/y7TLV9z9sd1HguXc33JXnMo
        kakmram+7x5f9ZtXFm9Ome45clurz+6/EktxRqKhFnNRcSIAeL93OrYCAAA=
X-CMS-MailID: 20200302154153eucas1p2db854c0f1a1b25e5b4c260379d7b6260
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8
References: <CGME20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8@eucas1p1.samsung.com>
        <d438108a-e569-a14a-a9b1-3fefd88fcadc@samsung.com>
        <20200117185737.GB24508@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/20 7:57 PM, Sam Ravnborg wrote:
> On Thu, Jan 16, 2020 at 03:53:20PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * Add missing __iomem annotations where needed.
>> * Make w100fb_probe() static.
>> * Return NULL pointer (instead of using plain integer) in
>>   w100_get_xtal_tabl().
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
