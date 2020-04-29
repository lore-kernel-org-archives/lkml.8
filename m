Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC37C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E212073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zHFWQgW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2INs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:13:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43412 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2INs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:13:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03T8DUwW007493;
        Wed, 29 Apr 2020 03:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588148010;
        bh=dIrVm1/0QLViLtaRRfuBbJNZneOip17ijlKOVSjVhIE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zHFWQgW4G0g/o/UPa18cLyEWT6fX8erJvXdQ9shIsSQD3OjN6AHmJrUAPuzYjyGqq
         Cw4rEacVXvIiKujfXiS3XPO6fwVSZhK78MzlKHqqDqSiTyHwI+d5pjr2EMaL2y5ky5
         WOKW6l1eMYGIwRIlfpUZqgEHtNrrks6IacCPg9W8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03T8DUkI011810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Apr 2020 03:13:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Apr 2020 03:13:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Apr 2020 03:13:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03T8DQeH056208;
        Wed, 29 Apr 2020 03:13:27 -0500
Subject: Re: [PATCH] drm/bridge: fix stack usage warning on old gcc
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200428215408.4111675-1-arnd@arndb.de>
 <22ee464b-f59a-69a3-b669-f821d567fbf5@ti.com>
 <CAK8P3a2YAe0KPQYQi_PhFvaYeA_4jHM8Y0qOR8oy-A07y-zeEQ@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <cd7c03e3-baba-73fd-f432-5ccc640a6f44@ti.com>
Date:   Wed, 29 Apr 2020 11:13:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2YAe0KPQYQi_PhFvaYeA_4jHM8Y0qOR8oy-A07y-zeEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2020 11:02, Arnd Bergmann wrote:
> On Wed, Apr 29, 2020 at 9:56 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>>> index 1b39e8d37834..6650fe4cfc20 100644
>>> --- a/drivers/gpu/drm/bridge/tc358768.c
>>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>>> @@ -178,6 +178,8 @@ static int tc358768_clear_error(struct tc358768_priv *priv)
>>>
>>>    static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
>>>    {
>>> +     /* work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
>>> +     int tmpval = val;
> 
>>
>> tc358768_write is not inline. What is the inline function here? Or is tc358768_write optimized to
>> inline by the compiler?
> 
> I missed the lack of an explicit inline tag when looking at the bug. gcc
> usually decides which functions to inline on its own, so there is little
> difference in practice. Let me know if I should clarify the changelog and
> resend it.

Ok. I think this is fine.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
