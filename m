Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AEAC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173772070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofKmE5yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:07:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42284 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCZJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:07:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so5524569ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tqgBaV78PQqZolZo5QZFRoALvirH5iBLVW/jfhHSDg0=;
        b=ofKmE5yb4X6lGFHr4+7NTByDIQviSW04LED0VqqiFvXCwzmjKiY7GQpQao0jRWQNkx
         Lfyzm426ubs3FeKnP5V7Vv98m3zzgrvnorCWiNySLc/umQt7dYv4NY10HY5omWaga6aj
         fbbS9j4A8lSKYBKcb0QnDA5VZy3vmAxFTXfDZa3SAIbAqp0Oll3TqmaDHWvjZRBWmxEW
         S49/7iu9RmwCjNII+Lhy8ObSP29e7obBMSVAXstwCDeRHVolYbGgi3vpA80hQa/u1Rzv
         gMYFzKcv0CI9hUfjIYWfqZq6Sr5MlF2VmuVo5UsIO0FSr7QSmjNvSgvYxtqT5fLfX2fD
         /LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqgBaV78PQqZolZo5QZFRoALvirH5iBLVW/jfhHSDg0=;
        b=LYaBJ62ojL72qO9UbI2jpEYgO8P/SzR4/zPsbivbmgBNG9SdAQyaJWTmZZqocJ551+
         b/u5pdj99sxijdzCeSaSfO6Hjn5iNbCwCpnLxqGQ038Cuj/YESoEkV04JM12N0VmR3qJ
         bbN5DibvWvFup1xHK6tAeeYLAO3wClffGqbk4gAyY/GsGD8MI/DQI2znLhQEdbweea5X
         tXLI0priRZQiITE1h42Iue9N3vaRsenisRO4bEeKh6mvikthP5sdvumfdY9weNw806zP
         UrkTOvRwmy+/+AfWpBYRgkZJQCN0yEp0e5Rn8atZOlwVrjdSHDYgbH80mpsoGHBvEdXO
         Li0w==
X-Gm-Message-State: AGi0Pua1Iyh1rJpHnlXbPT/dXmYKee4uFRBlnUZnMvyfdnN1FShErYZy
        ReNQ3zJqLgMVrFdvcR0ZN6rFXa1pVItuusMZteTDBgINpQ8=
X-Google-Smtp-Source: ADFU+vuY/mX+a6lOOhWP3ico6Dy3TmuugokwnEmRW9l6EChld/TLcCpOoPKX3/HSREhsR79pRO+mABA6GX5DKSuoAkU=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr4565066ljg.185.1585213661142;
 Thu, 26 Mar 2020 02:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
 <1585207429-10630-3-git-send-email-sumit.garg@linaro.org> <CAA-cTWZWPFtq-9MOrr6YDV4SGyo_JNaNsFJc=pjaWBrWHMid1A@mail.gmail.com>
In-Reply-To: <CAA-cTWZWPFtq-9MOrr6YDV4SGyo_JNaNsFJc=pjaWBrWHMid1A@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 26 Mar 2020 14:37:29 +0530
Message-ID: <CAFA6WYOvBNcGe+4ndq-YmM6haVoH4QiM7goYw5T40mR15muQKQ@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCH v5 2/2] tee: add private login method for kernel clients
To:     =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome@forissier.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 14:05, J=C3=A9r=C3=B4me Forissier <jerome@forissier.=
org> wrote:
>
> On Thu, Mar 26, 2020 at 8:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> There are use-cases where user-space shouldn't be allowed to communicate
>> directly with a TEE device which is dedicated to provide a specific
>> service for a kernel client. So add a private login method for kernel
>> clients
>
>
> OK
>
>> and disallow user-space to open-session using GP implementation
>> defined login method range: (0x80000000 - 0xFFFFFFFF).
>
>
> I'm not sure this is correct, because it would prevent the client library=
 or the TEE supplicant from using such values, although they are part of th=
e TEE implementation; and further, nothing mandates that an implementation-=
defined method should not be used directly by client applications.
>

Initial implementation of this patch only put restriction for single
implementation-defined login method (TEE_IOCTL_LOGIN_REE_KERNEL) only.
But after discussion with Jens here [1], I have changed that to
restrict complete implementation-defined range. If we think to further
partition this range considering API stability then I am open to that
too.

[1] https://lore.kernel.org/patchwork/patch/1088062/

-Sumit

> --
> Jerome
>
>>
>>
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/tee/tee_core.c   | 6 ++++++
>>  include/uapi/linux/tee.h | 8 ++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 37d22e3..533e7a8 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_contex=
t *ctx,
>>                         goto out;
>>         }
>>
>> +       if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
>> +               pr_debug("login method not allowed for user-space client=
\n");
>> +               rc =3D -EPERM;
>> +               goto out;
>> +       }
>> +
>>         rc =3D ctx->teedev->desc->ops->open_session(ctx, &arg, params);
>>         if (rc)
>>                 goto out;
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 6596f3a..19172a2 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -173,6 +173,14 @@ struct tee_ioctl_buf_data {
>>  #define TEE_IOCTL_LOGIN_APPLICATION            4
>>  #define TEE_IOCTL_LOGIN_USER_APPLICATION       5
>>  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION      6
>> +/*
>> + * Disallow user-space to use GP implementation specific login
>> + * method range (0x80000000 - 0xFFFFFFFF). This range is rather
>> + * being reserved for REE kernel clients or TEE implementation.
>> + */
>> +#define TEE_IOCTL_LOGIN_MASK                   0x80000000
>> +/* Private login method for REE kernel clients */
>> +#define TEE_IOCTL_LOGIN_REE_KERNEL             0x80000000
>>
>>  /**
>>   * struct tee_ioctl_param - parameter
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Tee-dev mailing list
>> Tee-dev@lists.linaro.org
>> https://lists.linaro.org/mailman/listinfo/tee-dev
