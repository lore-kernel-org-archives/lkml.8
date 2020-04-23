Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E7C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D744420776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SJhX+M+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgDWSQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:16:08 -0400
X-Greylist: delayed 4095 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Apr 2020 11:16:08 PDT
Received: from forward501p.mail.yandex.net (forward501p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB5C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:16:08 -0700 (PDT)
Received: from mxback10q.mail.yandex.net (mxback10q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:b6ef:cb3])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 9C71635003C4;
        Thu, 23 Apr 2020 21:16:04 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10q.mail.yandex.net (mxback/Yandex) with ESMTP id zCfXLDaPuq-G4JqQwcl;
        Thu, 23 Apr 2020 21:16:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1587665764;
        bh=UuuLfyUWwTDsumI8P6GkF3SCpNgR9mP3R2UCevVxbh8=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=SJhX+M+cXxzXdhIyhIa0F9U/TqAXJ/Vyd2+34EA0Ur5fijKcf1vAZhPUFxMdrPh/G
         0VF4tlyHNRODgz8U7rCgHBoUpCv9f5TslpudvfV6KlVWMIBZR/mEuUTIaRMx/O5StF
         kssc8NXSqDsm62Skvz+ZmrKd+slHRsqnterZESv0=
Authentication-Results: mxback10q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-a6eaa355d163.qloud-c.yandex.net with HTTP;
        Thu, 23 Apr 2020 21:16:03 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Akira shimahara <akira215corp@gmail.com>, Greg KH <greg@kroah.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <32dbb39debedabd6dbd1a8675760e171c180de9e.camel@gmail.com>
References: <20200414170248.299534-1-akira215corp@gmail.com>
         <20200423144116.GA7319@kroah.com> <307231587661588@mail.yandex.ru> <32dbb39debedabd6dbd1a8675760e171c180de9e.camel@gmail.com>
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 23 Apr 2020 21:16:03 +0300
Message-Id: <243121587665447@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

23.04.2020, 20:59, "Akira shimahara" <akira215corp@gmail.com>:
> Le jeudi 23 avril 2020 à 20:07 +0300, Evgeniy Polyakov a écrit :
>>  Looks like there are bigger isues with the patch that I've missed,
>>  and if I understood correctly, Akira asked to drop this patch
>
> Hi,
>
> Evgeniy, I don't asked to drop this patch, sorry for the
> misunderstanding. I will add entries to Documentation/ABI/testing/ by
> the end of the week and submit a new patch. Who should I add in the
> 'Contact' field ?

I think there should be your email

> To answer Greg's comments, we use the kernel subsystems as much as
> possible, but for timing and bus protocol reasons, we have to go a
> little deeper and control bus transaction as close as possible.
>
> Evgeniy, could you detail the issues you are talking about so I can
> adjust if required ?

I was referring to the mail where you said it was a mistake and I should delete that mail,
but apparently this is just a miscommuncation. I was surprised, because I didn't caught
any significant issues with the patch.

