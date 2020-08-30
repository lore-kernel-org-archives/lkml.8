Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBDFC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46D520738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="d1g8VLkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH3W4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:56:01 -0400
Received: from crapouillou.net ([89.234.176.41]:54556 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgH3Wz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 18:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598828157; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ed/EF0gPQmZhJFSMnr0/oT1EzF7WA3QTt0WC2jzwuE=;
        b=d1g8VLkvpKLDDxYfkUArJw9BAE9k2usXcMWxipgKQPolROWfUNZkjWBPRsWnVsrVkmt8Q8
        g/s9Fjivv/XHOIb/BeFS4yTSilcrfnbjX3WU7QOd5YHpzoThGptK80uJHoIE7UJuJc670Y
        WapRJk40NAJtnNwSD8j6WkEm8KyYHgE=
Date:   Mon, 31 Aug 2020 00:55:46 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] drm/ingenic: Fix leak of device_node pointer
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Message-Id: <YOFWFQ.M1IUN63RB1ZA1@crapouillou.net>
In-Reply-To: <20200829210727.GE796939@ravnborg.org>
References: <20200827114404.36748-1-paul@crapouillou.net>
        <20200829210727.GE796939@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le sam. 29 ao=FBt 2020 =E0 23:07, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> On Thu, Aug 27, 2020 at 01:44:03PM +0200, Paul Cercueil wrote:
>>  of_graph_get_remote_node() requires of_node_put() to be called on=20
>> the
>>  device_node pointer when it's no more in use.
>>=20
>>  Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks. Both patches pushed to drm-misc-fixes.

Cheers,
-Paul

>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index ada990a7f911..c1bcb93aed2d 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -978,6 +978,7 @@ static int ingenic_drm_probe(struct=20
>> platform_device *pdev)
>>   	}
>>=20
>>   	drm_of_component_match_add(dev, &match, compare_of, np);
>>  +	of_node_put(np);
>>=20
>>   	return component_master_add_with_match(dev, &ingenic_master_ops,=20
>> match);
>>   }
>>  --
>>  2.28.0


