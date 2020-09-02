Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF7C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B3C20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hchu6LZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:42:45 -0400
Received: from forward501p.mail.yandex.net (forward501p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D0C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 01:42:44 -0700 (PDT)
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id CDFE63500850;
        Wed,  2 Sep 2020 11:42:34 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3o.mail.yandex.net (mxback/Yandex) with ESMTP id tfaQAmOB7l-gX7uZfml;
        Wed, 02 Sep 2020 11:42:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1599036154;
        bh=ieL5eBZSKw/yFnrrPl/MqoxzrUjdZ7Hy9Kkk8GjSLdc=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=hchu6LZ4iqmfYa3Xt2FP/q1hd8hoSTICzDNiwd1rHFphhQKGChGcM4HftcZ+vTL7S
         wXhPdK0lyLNrWyDeHq0A1IVzKKe0yYjTk2xl92dgwdmTCKRdqu1mj8dShXy/aOKfb0
         o3DFUJsdmExtBVa5eZREKydFxnihxTd/mvQBPQQo=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-ffdbcd5f1d77.qloud-c.yandex.net with HTTP;
        Wed, 02 Sep 2020 11:42:33 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
In-Reply-To: <20200901183912.GA5295@duo.ucw.cz>
References: <20200901150934.576210879@linuxfoundation.org>
         <20200901150936.857115610@linuxfoundation.org> <20200901183912.GA5295@duo.ucw.cz>
Subject: Re: [PATCH 4.19 047/125] media: davinci: vpif_capture: fix potential double free
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 02 Sep 2020 11:42:33 +0300
Message-Id: <1304121599035106@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Maybe I miss something, but it seems that in 4.19 vpif_probe() ignores
error codes from vpif_probe_complete() and returns 0 even if it fails.
That was fixed by commit 64f883cd98c6, but it was not backported to 4.19.
In addition, this commit contains a fix of one more bug.

Regarding your second note. I investigated other drivers that use the same
mechanism and did not find out any driver that performs clean up in the
complete handler. In particular, this is the case for very similar driver
vpif_display.c. I am not an expert in this subsystem, so, I can not reason
why this is so.

-- 
Best regards,
Evgeny Novikov



01.09.2020, 21:43, "Pavel Machek" <pavel@denx.de>:
> Hi!
>
>>  [ Upstream commit 602649eadaa0c977e362e641f51ec306bc1d365d ]
>>
>>  In case of errors vpif_probe_complete() releases memory for vpif_obj.sd
>>  and unregisters the V4L2 device. But then this is done again by
>>  vpif_probe() itself. The patch removes the cleaning from
>>  vpif_probe_complete().
>
>>  Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
>>  Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>  Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>  Signed-off-by: Sasha Levin <sashal@kernel.org>
>>  ---
>>   drivers/media/platform/davinci/vpif_capture.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>>  diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
>>  index a96f53ce80886..cf1d11e6dd8c4 100644
>>  --- a/drivers/media/platform/davinci/vpif_capture.c
>>  +++ b/drivers/media/platform/davinci/vpif_capture.c
>>  @@ -1489,8 +1489,6 @@ probe_out:
>>                   /* Unregister video device */
>>                   video_unregister_device(&ch->video_dev);
>>           }
>>  - kfree(vpif_obj.sd);
>>  - v4l2_device_unregister(&vpif_obj.v4l2_dev);
>>
>>           return err;
>>   }
>
> This one is wrong. Unlike mainline, 4.19 does check return value of
> vpif_probe_complete(), and thus it will lead to memory leak in 4.19.
>
> Furthermore, I believe mainline still has a problems after this
> patch. There is sync and async path where vpif_probe_complete(), and
> while this fixes the sync path in mainline, I believe it will cause
> memory leak on the async path.
>
> Best regards,
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
