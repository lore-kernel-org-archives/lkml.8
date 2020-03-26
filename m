Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0536C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8F820714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voMoECkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCZJjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:39:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45448 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgCZJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:39:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so4192278lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eu3Uwa+VnU4xXATk5601RZo6ykANuBNgBtIg6vaHTbM=;
        b=voMoECkcgMjOgY6psiBZX8ON1srXi4PYuJOK09VphgLrshwDqbkyFrPdo/BH+iBKzz
         XlOpbhoD+dVShpVol0jM1QH4u2PhjMFt73vjUm0d/qfnAgH6FkNyV5M5ZTOwt9E1HZzY
         IlY9wfIedRLfC5HoIBYY82hihSxChb1xtkKTa7qtHtNGXSc1fbcqAG2S0cIGb8NKs8Sg
         s+jJs7Kp1lb9HHyznoUHEN/RJ9S3A0G2WwcMSEIf/mXJAHczOlYXBl6KO8/gDU+0zcvo
         b1tVz1pGsh/NfUw30/zEZ9zZjItmmbcbXUSxkL2yCdVQfVXOT4fQnEObMCiEjHyW9Bzv
         XTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eu3Uwa+VnU4xXATk5601RZo6ykANuBNgBtIg6vaHTbM=;
        b=U8zwyPg6hz9rrtxQrFQmPR4h2EhYhib6YZWmX3m0yw4+MWXNmmHSQW7fajBrQdeM7a
         eVasFMHOMq02o8tDFuAwhj4H13jsaIh7VpZsQD8Vr9dHGsdvYegiR3hoT5cVqBXBLmjm
         T4H0hRqYRcgQZzUM8pvK9QbZDOSyhBttnUJgxZwBGqM1tu/ZIsaFTU6Up6koLnuYuREE
         sk3tza1RHmsolLrAaKoOIbApGs06N/XCN3o1ujDlS0Ip2qjoSDTwWAhRJTh8F4Mi3zHd
         Jca6IIMcsF1C3lpDEax5/0BPK5AemsiIsnb6zraK1wJv59cJwCA10anYXRiuT5lITdC3
         A3fw==
X-Gm-Message-State: ANhLgQ3t/HjrDDTgniA2zARRy1o3NhWXvlqgutJTQOedPlx5Vdok1122
        WMuqCbgUMmW1qS2jvA57QYpoT3H/Fl/kAnxMiOlbfQ==
X-Google-Smtp-Source: ADFU+vsSvPo2C10ifHfhe5tp8ALaME4m7kaWGJ9P8fZb6SAS2n0Uv+vwm3zPj/yAwo8bfKbDcxWJra6P13eTPBp2+oo=
X-Received: by 2002:a19:3803:: with SMTP id f3mr5226139lfa.160.1585215559490;
 Thu, 26 Mar 2020 02:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
 <1585207429-10630-3-git-send-email-sumit.garg@linaro.org> <CAA-cTWZWPFtq-9MOrr6YDV4SGyo_JNaNsFJc=pjaWBrWHMid1A@mail.gmail.com>
 <CAFA6WYOvBNcGe+4ndq-YmM6haVoH4QiM7goYw5T40mR15muQKQ@mail.gmail.com> <b64c3ace-4558-deb5-7493-4837f48af188@forissier.org>
In-Reply-To: <b64c3ace-4558-deb5-7493-4837f48af188@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 26 Mar 2020 15:09:08 +0530
Message-ID: <CAFA6WYOGPNOyWU3Y+ipAo_FGioTnRkdmURc7H1FM1ENe_dfQXg@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCH v5 2/2] tee: add private login method for kernel clients
To:     Jerome Forissier <jerome@forissier.org>
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

On Thu, 26 Mar 2020 at 14:53, Jerome Forissier <jerome@forissier.org> wrote=
:
>
> On 3/26/20 10:07 AM, Sumit Garg wrote:
> > On Thu, 26 Mar 2020 at 14:05, J=C3=A9r=C3=B4me Forissier <jerome@foriss=
ier.org> wrote:
> >>
> >> On Thu, Mar 26, 2020 at 8:24 AM Sumit Garg <sumit.garg@linaro.org> wro=
te:
> >>>
> >>> There are use-cases where user-space shouldn't be allowed to communic=
ate
> >>> directly with a TEE device which is dedicated to provide a specific
> >>> service for a kernel client. So add a private login method for kernel
> >>> clients
> >>
> >>
> >> OK
> >>
> >>> and disallow user-space to open-session using GP implementation
> >>> defined login method range: (0x80000000 - 0xFFFFFFFF).
> >>
> >>
> >> I'm not sure this is correct, because it would prevent the client libr=
ary or the TEE supplicant from using such values, although they are part of=
 the TEE implementation; and further, nothing mandates that an implementati=
on-defined method should not be used directly by client applications.
> >>
> >
> > Initial implementation of this patch only put restriction for single
> > implementation-defined login method (TEE_IOCTL_LOGIN_REE_KERNEL) only.
> > But after discussion with Jens here [1], I have changed that to
> > restrict complete implementation-defined range. If we think to further
> > partition this range considering API stability then I am open to that
> > too.
> >
> > [1] https://lore.kernel.org/patchwork/patch/1088062/
>
> In the end he proposed to reserve half the range for user space and half
> for kernel space.

It seems I probably misunderstood his proposal. So let me reserve
(0x80000000 - 0xBFFFFFFF) range for kernel space.

>
> (BTW sorry for my previous HTML reply)
>

No worries.

-Sumit

> --
> Jerome
> >
> > -Sumit
> >
> >> --
> >> Jerome
> >>
> >>>
> >>>
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>>  drivers/tee/tee_core.c   | 6 ++++++
> >>>  include/uapi/linux/tee.h | 8 ++++++++
> >>>  2 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> >>> index 37d22e3..533e7a8 100644
> >>> --- a/drivers/tee/tee_core.c
> >>> +++ b/drivers/tee/tee_core.c
> >>> @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_con=
text *ctx,
> >>>                         goto out;
> >>>         }
> >>>
> >>> +       if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
> >>> +               pr_debug("login method not allowed for user-space cli=
ent\n");
> >>> +               rc =3D -EPERM;
> >>> +               goto out;
> >>> +       }
> >>> +
> >>>         rc =3D ctx->teedev->desc->ops->open_session(ctx, &arg, params=
);
> >>>         if (rc)
> >>>                 goto out;
> >>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> >>> index 6596f3a..19172a2 100644
> >>> --- a/include/uapi/linux/tee.h
> >>> +++ b/include/uapi/linux/tee.h
> >>> @@ -173,6 +173,14 @@ struct tee_ioctl_buf_data {
> >>>  #define TEE_IOCTL_LOGIN_APPLICATION            4
> >>>  #define TEE_IOCTL_LOGIN_USER_APPLICATION       5
> >>>  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION      6
> >>> +/*
> >>> + * Disallow user-space to use GP implementation specific login
> >>> + * method range (0x80000000 - 0xFFFFFFFF). This range is rather
> >>> + * being reserved for REE kernel clients or TEE implementation.
> >>> + */
> >>> +#define TEE_IOCTL_LOGIN_MASK                   0x80000000
> >>> +/* Private login method for REE kernel clients */
> >>> +#define TEE_IOCTL_LOGIN_REE_KERNEL             0x80000000
> >>>
> >>>  /**
> >>>   * struct tee_ioctl_param - parameter
> >>> --
> >>> 2.7.4
> >>>
> >>> _______________________________________________
> >>> Tee-dev mailing list
> >>> Tee-dev@lists.linaro.org
> >>> https://lists.linaro.org/mailman/listinfo/tee-dev
