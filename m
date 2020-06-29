Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3DEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71EA206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EOOP1itO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391754AbgF2WAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:00:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58248 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgF2SfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200629112844euoutp01fb634957880abd4962c289c79192c156~dAEF9KV3P0097100971euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200629112844euoutp01fb634957880abd4962c289c79192c156~dAEF9KV3P0097100971euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593430124;
        bh=pFFs/lRck/tCRXFr6SqUvhPQKz67deqCJc8xoAztPTE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EOOP1itOvAfUaj6PCybOsUVX45DotywEx+vI3RxiNm+V/xN7NagSaCoFta4nZtyFs
         pFb0iX166uJi3pRugMu2PIEFtdf25e2PbCgcvsY1CodjHpawJjsaoZEErjoe6KEtu0
         YfOHPZA0M7SlH+56D4V9YtCd4BIAoxwOvu1HdVaw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629112844eucas1p2c7285c5db202aa4bf4ca244116c2e744~dAEFkL0kk0048900489eucas1p2C;
        Mon, 29 Jun 2020 11:28:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 71.69.06318.B60D9FE5; Mon, 29
        Jun 2020 12:28:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200629112843eucas1p2b0bd7618b6d35259693cef313326bff5~dAEFO70CU3176631766eucas1p2E;
        Mon, 29 Jun 2020 11:28:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200629112843eusmtrp17043a9c74d2d1fdb7b58238f85d49901~dAEFOManV0843508435eusmtrp1a;
        Mon, 29 Jun 2020 11:28:43 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-88-5ef9d06b2643
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.00.06314.B60D9FE5; Mon, 29
        Jun 2020 12:28:43 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629112842eusmtip231c1f9355ca9af6efe8c6bd2bbac5c0c~dAEEVIdva0594505945eusmtip2n;
        Mon, 29 Jun 2020 11:28:42 +0000 (GMT)
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7e3c924b-c025-a829-6868-78e2935c70eb@samsung.com>
Date:   Mon, 29 Jun 2020 13:28:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5f159e00-44fd-515b-dd8c-4db9845dc9e6@ti.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt3t3d12urtPww6R0EGSRFkrcVHoH98+I+kfRnHpR89mmvcto
        rZyVmCa5zYWpywfJbL4tTWb5TPHR1EKTUgbaQ6utWKjkdo3873znfI9z4CMx8W++F5mQks7K
        UqRJEkKIN3TaB3YlDtojd2dX7KNnczsQ/azQwKcLPs4Q9FvbPEErSg0EXfkAp82/ZzG654sZ
        p1X3ywS0cXqUT4+0FBG0qaAV0dWvJgW0KSec1lkLsIMbmZHRIYyZH1cKmGbNpIDRZqn5jLFK
        RTDducM85qXuqYCZutPFY2rLMpmcuirEtN/Lx5mu8UYe89O45bgoTBgayyYlnGNlAfujhPFz
        /XoirVxwQWkZRdeRishGLiRQQWBuL+BnIyEppioQfK8ZQ1xhRTCs12Fc8RPB4C89+jfS+P4+
        jxPKEfS9+LQ6P49AtfABd3S5U9EwWdfKd2APKgbsE8uEowmjGnCYePTcKRCUHyzVvnM6EVH7
        wTChXDlBkji1DZa6Ixz0JioCcvTFqy1u0KOece53oYKhdHLQyWPUVlDUazEOe8INa6XTEFB6
        EhStQzzO9lF4ONuNc9gd5rrqBBz2hr78u6t8JkxV3MS44SwE9TXNGCeEwMTAH8JhDlsxbWgJ
        cECgDoF+ei8HN8D4VzfOwgbIa3iIcbQIsm6JuR2+MNVfv7rPE/SDNiIXSTRrgmnWhNGsCaP5
        f7YY4VXIk82QJ8ex8sAU9ry/XJosz0iJ849JTTailXfsW+6yNaG2xWgTokgkcRVFDdgjxXzp
        OfnFZBMCEpN4iA7390WKRbHSi5dYWeppWUYSKzehzSQu8RQFlsxGiKk4aTqbyLJprOyfyiNd
        vK6j4ialz9lr/qpTn6vNwf0l8VbvEPLACE8de/L8yJhxZ4M1Tyz4ttlVSC2uf0McKbTn1wY9
        sSoM6qmOpJCDvdrLyk4/mTksxKdC2/L4hO51MaPMo8MtV7VzvQ+Wz9zeaolb0M3gtsbQjiO+
        Q4pvbWqbKfuKZfu64Pnpnh9FHccsElweL92zA5PJpX8BkyRJzooDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4Pd3sCz/jDA7PVLF4OeEwo8XGGetZ
        LaY+fMJmceXrezaL5sXr2SxWTmGxuPr9JbPFyTdXWSw6Jy5ht9j0+BqrxeVdc9gsDk3dy2ix
        9shddotDfdEWc79MZXbg97h87SKzx/sbreweO2fdZfeY3TGT1WPTqk42jxMTLjF57J+7ht3j
        fvdxJo/NS+o9+rasYvQ40DuZxeP4je1MHp83yQXwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlro
        GZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlvDq7lK1gOXtF67NrjA2MnWxdjJwcEgImEttv
        TWTqYuTiEBJYyihxu+skC0RCXGL3/LfMELawxJ9rXWwQRW8ZJb4sOgaWEBZIkri7ZS8riC0i
        kCzxpeMFC0gRs8AuFokTfxvYITpeM0r86P8PNpZNQFPi7+abYLt5Bewk1t9pZexi5OBgEVCV
        +HsiFiQsKhAr8e3eFqgSQYmTM5+AtXIKWEksvnsBLM4sYCYxb/NDZghbXqJ562woW1yi6ctK
        1gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBCaEbcd+bt7B
        eGlj8CFGAQ5GJR7ehHM/44RYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU
        6LeJzFKiyfnAZJVXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoEx
        4fJcZ/mbYpd+rVsx73rGCZkfye5VPwveVnVd2ur29SV/IOOWx6/eLy+S8/lp85W/Zq6bpdna
        C5Z9DyqZAreExT3XzzDYUXpwUfbPg7Wlz00NS70Lpe58epZmyMOoO90skk34mte7kldLuLd4
        Tz12WKgiW9r14AeWgo1P1nFtuxD1kf/xs4emSizFGYmGWsxFxYkA5y1lGh4DAAA=
X-CMS-MailID: 20200629112843eucas1p2b0bd7618b6d35259693cef313326bff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e
References: <20200626100103.18879-1-a.hajda@samsung.com>
        <CGME20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e@eucas1p2.samsung.com>
        <20200626100103.18879-3-a.hajda@samsung.com>
        <5f159e00-44fd-515b-dd8c-4db9845dc9e6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

(...)

>>   /*
>>    * deferred_devs_show() - Show the devices in the deferred probe 
>> pending list.
>>    */
>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s, 
>> void *data)
>>       mutex_lock(&deferred_probe_mutex);
>>         list_for_each_entry(curr, &deferred_probe_pending_list, 
>> deferred_probe)
>> -        seq_printf(s, "%s\n", dev_name(curr->device));
>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
>> +               curr->device->p->deferred_probe_reason ?: "\n");
>>         mutex_unlock(&deferred_probe_mutex);
>>
>
> Sry, may be i missing smth, but shouldn't it be optional
> (CONFIG_DEBUG_FS is probably too generic).
>

I am not sure what exactly are you referring to, but this patch does not 
add new property, it just extends functionality of existing one.


Regards

Andrzej


