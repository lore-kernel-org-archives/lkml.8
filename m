Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A02720665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598365353;
	bh=PFqTPZ7+kqIQ95wte02CjiUGr0lEF6Mq2Dd9uibHOYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fx0VrxeK0W+raNOwsCRisCtYiAbwmOhM7CQT3YZiuXAXcyKli6tMpUtCfkXK/Pqa1
	 NwI6Mq9Kc9lU01AXSqzXc03FV/Cjy4p6ffcGQBp0xkhz84ti057ZcLmo9/jiT20Yi6
	 bxqhk/f2+gygEXp34GRbZfYEQ30lTSMYmhLdRTfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHYOWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYOWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:22:30 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0B020706
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598365350;
        bh=PFqTPZ7+kqIQ95wte02CjiUGr0lEF6Mq2Dd9uibHOYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MReNAjAJq/DXYU/qJAuV++2/Yx+8Y+eEjwq7thTqNRgMPQB2+uw8EkrAHcecsJ59z
         ulWrszeEAU+DtwLmaHilzLEcHFByKQ7hps0hGyk5HmgIcCQjRVISXYUT/y9MhzcIF4
         MzSNNsM04fR73I7uZZUTe2iPO8iFc7OS1np9EgO8=
Received: by mail-oi1-f182.google.com with SMTP id j7so11722789oij.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:22:30 -0700 (PDT)
X-Gm-Message-State: AOAM533lBusezzWaC5vOh/bNZJIYlfaByyditaMKXxf8Inn0RbS0c0Tp
        RMHViHtOUCHQnxaEhnjaf4GG1ZIC2UnjPKUARw==
X-Google-Smtp-Source: ABdhPJyZpWUlV3MKhJIoXcYZAcO2llj1np/I/MwuwpeH+XE0KEhZe+4RiILNwfUzaFkgH2GRspE0sifZo+giD4b589A=
X-Received: by 2002:aca:90a:: with SMTP id 10mr1178278oij.106.1598365349451;
 Tue, 25 Aug 2020 07:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200825101250.9485-1-broonie@kernel.org>
In-Reply-To: <20200825101250.9485-1-broonie@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Aug 2020 08:22:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8cX15T+M3RU9W4w==3saZCuYo4C8CvUMU3yomR1wKDQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8cX15T+M3RU9W4w==3saZCuYo4C8CvUMU3yomR1wKDQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt4801: Specify additionalProperties: false
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:13 AM Mark Brown <broonie@kernel.org> wrote:
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  .../devicetree/bindings/regulator/richtek,rt4801-regulator.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Thanks.

Reviewed-by: Rob Herring <robh@kernel.org>
