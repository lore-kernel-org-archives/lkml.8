Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD31D206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVHgFUR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgD1J6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727096AbgD1J6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:58:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3482C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:58:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f8so16392358lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K2sBtRNx7PhSzPZ9iZVY4Qa3ve/fLU6E7fXk7zTXtP8=;
        b=mVHgFUR1ptdq+Ra8ChQLqF/rBEoIstE8ZBn5MRfdiJ14YLJ6cavaqDVU6z+YK01SxN
         9oSCd2xltXsQOw+tPEZsGRD8GYzQGPo1Ea1wLTII2u0YadLLZY0MXG/yJ6kRCVDL3vuW
         hfAP1AZTWzl9jOEHnzzQdL9pm2ue0k344DbUvhnI0zDXPTwdaMCeezeZtKVQACEAl6S/
         0daqPZV9EqIaH5rndilcywTc+NddK9HZCNH8sesUleOkWX8U+CSkZUJ4GcNHQEaIDvV8
         SejsV30Q/Wb93azr7u4zwHNknX/4kq9pPDrLjAqQT+bGtfLqT0VE/8dnE0NEmVwR8mBY
         sfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K2sBtRNx7PhSzPZ9iZVY4Qa3ve/fLU6E7fXk7zTXtP8=;
        b=poBiwEfNMfV+v3ayy51PqaqBHy+7gDoE368ELY26kmA17RHsLpi6kpN858LMx6uEe5
         uRPpR3gHzauqI9e4msDDwWO7GlKMsAiWtL2RgtwkDPJPVofzzyesCc5zeThTyTxqyIPW
         Aqfh2PmlH1F2YNr5zn5io+w7NYKYPbTIMP1TVrBGC2CvTUPU86jFRapu7Flv3NiHA32B
         rCjZTQTuhzcY6ZHLTQl/8uc1NnuKdNyfrmZyIu8Y3gi46G5RrNr9lnP9JEh9Htuh5+hL
         14fQ/dp8LtNX66RArYQQUcEkFsZpZPzI7VUCN9oIXzNH3Sjc6iE1ae7y5dskq5OR2olu
         TXzg==
X-Gm-Message-State: AGi0Pub4msSzzBvGd+c5KIoNU5cYKnrJSHcGGTmVF/ss4bcG+l5UXOAg
        VhAOtH2jNKLoQbdBa/jrdI0xu1umWRbMfqFV99vPmA==
X-Google-Smtp-Source: APiQypJgR9W6U13zcfDrGvlRdKXdtFC8wu0m0JoeHg9XV6mKnUUCD0eedTeCwViJJKUt9nBuCBxDv6Y3SnUETZJxBQs=
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr18862973lfp.77.1588067892086;
 Tue, 28 Apr 2020 02:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200417092112.12303-1-yanaijie@huawei.com>
In-Reply-To: <20200417092112.12303-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 11:58:01 +0200
Message-ID: <CACRpkdb5Ozz_MKAUDoyOxdnu_NkN72vRu=ZY7j_Lb5uMAiS3SA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: remove unused 'pwm37_pins'
To:     Jason Yan <yanaijie@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:54 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following gcc warning:
>
> drivers/pinctrl/pinctrl-bm1880.c:263:27: warning: =E2=80=98pwm37_pins=E2=
=80=99 defined
> but not used [-Wunused-const-variable=3D]
>  static const unsigned int pwm37_pins[] =3D { 110 };
>                            ^~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

I'm sceptic about this. I think PWM37 exists and just need to be
properly defined.

Mani will know the right solution to this.

Yours,
Linus Walleij
