Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D8C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D522070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MgU8A3bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGXUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgGXUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:00:10 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F467C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:00:10 -0700 (PDT)
Received: from mxback5q.mail.yandex.net (mxback5q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:b716:ad89])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id C307F33801CB;
        Fri, 24 Jul 2020 23:00:06 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback5q.mail.yandex.net (mxback/Yandex) with ESMTP id 5G8zRixIVZ-06OCbMfU;
        Fri, 24 Jul 2020 23:00:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1595620806;
        bh=f93LtYxJ50+Ck2fwWUZ066AeOsoEDLCakGsqNBbVsmc=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=MgU8A3bl60LibhWwfqSDep/IguW6d8QdhmcCphQmzUSjdnd27j4At9yE0l81yK40f
         fr8xEFwxpkY5IZwde85G+DgPN4QHnaxK8u3+dPnEjlaO6tR0Lkw0Cz3uNqmhyokK/8
         pZUvTgrVddFV7HLDKZW9ttxsyqLiT2V+jZwcyMTk=
Authentication-Results: mxback5q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-344e18ef0bef.qloud-c.yandex.net with HTTP;
        Fri, 24 Jul 2020 23:00:06 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
In-Reply-To: <CA+V-a8uNfscxiM1fMjfdvZstZkkzxW41p40jpBXT3NeyiS9-Qw@mail.gmail.com>
References: <20200723170453.432-1-novikov@ispras.ru> <CA+V-a8uNfscxiM1fMjfdvZstZkkzxW41p40jpBXT3NeyiS9-Qw@mail.gmail.com>
Subject: Re: [PATCH] media: davinci: vpif_capture: fix potential double free
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 24 Jul 2020 23:00:06 +0300
Message-Id: <20927111595619342@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Yet again I can not demonstrate you a nice error trace corresponding to the bug fixed by the patch. Indeed, there is a branch in vpif_probe() that explicitly invokes vpif_probe_complete() and the patch targets the possible issue that can happen during this. 

When I developed the patch I saw on vpif_display.ko. It looks very similar regarding things touched by the patch. In particular, it does not free vpif_obj.sd in its vpif_probe_complete(). But now I see that it does this in vpif_remove()!

Do you think that vpif_capture.ko should do the same? If so, I guess that I should fix the patch appropriately since likely it just replaces one (very rare) bug with another one (on a typical execution path).

-- 
Evgeny Novikov
Linux Verification Center, ISP RAS
http://linuxtesting.org



24.07.2020, 17:17, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>:
> Hi Evgeny,
>
> Thank you for the patch.
>
> On Thu, Jul 23, 2020 at 6:04 PM Evgeny Novikov <novikov@ispras.ru> wrote:
>>  In case of errors vpif_probe_complete() releases memory for vpif_obj.sd
>>  and unregisters the V4L2 device. But then this is done again by
>>  vpif_probe() itself. The patch removes the cleaning from
>>  vpif_probe_complete().
>>
>>  Found by Linux Driver Verification project (linuxtesting.org).
>>
>>  Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
>>  ---
>>   drivers/media/platform/davinci/vpif_capture.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>>  diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
>>  index d9ec439faefa..72a0e94e2e21 100644
>>  --- a/drivers/media/platform/davinci/vpif_capture.c
>>  +++ b/drivers/media/platform/davinci/vpif_capture.c
>>  @@ -1482,8 +1482,6 @@ static int vpif_probe_complete(void)
>>                  /* Unregister video device */
>>                  video_unregister_device(&ch->video_dev);
>>          }
>>  - kfree(vpif_obj.sd);
>>  - v4l2_device_unregister(&vpif_obj.v4l2_dev);
>
> vpif_probe_complete() is a async callback and probe() should have
> already completed by then.
>
> Cheers,
> --Prabhakar
>
>>          return err;
>>   }
>>  --
>>  2.16.4
