Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47890C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006BC206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lu7UARfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgCDAqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:46:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41938 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCDAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:46:52 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so451630ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gWULqsWkFFc3S8vtpoLm3M2Oc/ykoEB/9KBF47U9Qiw=;
        b=Lu7UARfSrsUvVpcCI6N1LYkVZzMNa0W7Xkuov69vKTfGM0AlqITcsTa5u4o91/42Rt
         1k7V8IBF62+wrmO//AAGkdYnmDBfvhhnHw3HPzCaiF3DBlaEGneyW6IZQd0GXsl3363z
         BuphrgYY0rC1i++Q6TNr3oRqOWxK2c82kzjMVECLt9O6E32N9fPkLHDRqFBmcVQmRvf8
         5p3XG6d+62Rkh1aArtDRhzuIWISBZf6hTODJmhMmDQCXsOAbG9aedZCWBlZqyVRhYJLi
         ebDp94saYd+CuIuvLBO34pUrn9T/PvtN8GwEPxYVEtkjmywFeCJhXMf2fZcZQVvy1Gas
         RasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gWULqsWkFFc3S8vtpoLm3M2Oc/ykoEB/9KBF47U9Qiw=;
        b=paD8uTytlEkUBrKRfHRyW9u79PFxJ8mGlu05aFsslfFM47RBa7a/Xvj1QOmH2kJUNK
         cEO1TKxSTDUPBIB85fQeW0XKhilPiAvD3zJtYAQDxJo9yk4FzrY19LDsTM2ZUPc+jvfu
         0RZMagRm8csEQWDNIro8g+FKvCYJ9pFAwAmu5ZTA2QGdcBUbBvXBw9KYAzCqUu0gkASz
         c20p7K+5MX7o1GrmJ6p/H2cHF0geV/jrKnuPa4ocdV+lVUb0JKy8RXfPeSrmnJxUSABS
         ImF+/sSJ9i3xfbHoymbqgsTrSsaIptgoW53RM4tcEcMHI4NTmsmX1c92dzgboaAVz4zB
         fJPg==
X-Gm-Message-State: ANhLgQ3gkMv09BItc+j9L39sB526XZK+jsK8uCav4T8lTw/AGa7c8etp
        MJY9/9yEdp+3LzdHUpP1OHngSEA0nU4vq+i1mV4ZNhRGIts=
X-Google-Smtp-Source: ADFU+vuHhu4NtaKzrAJMH0Y+xQoDpQZob8gI+PIvVcHltWP+r3WgXejOJD7aHpKlO0ahyaflJrOjmiZ+NzCPYzlxPD0=
X-Received: by 2002:a02:240c:: with SMTP id f12mr476874jaa.65.1583282811961;
 Tue, 03 Mar 2020 16:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20200303031725.14560-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200303031725.14560-1-tangbin@cmss.chinamobile.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 4 Mar 2020 08:46:41 +0800
Message-ID: <CABymUCMupAzJ00McXkBoApTT4NV_ZT1=hTyZA+YFdQfRoVSbyQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_ARM=3Amach=2Dzx=EF=BC=9Aremove_duplicate_debug_mes?=
        =?UTF-8?Q?sage?=
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tangbin <tangbin@cmss.chinamobile.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:18=E5=86=99=E9=81=93=EF=BC=9A
>
> remove duplicate dev_err message, because of
> devm_ioremap_resource, which has already contains.
>
> Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
> ---
>  arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Jun Nie <jun.nie@linaro.org>
