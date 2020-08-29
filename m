Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A99320825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598707447;
	bh=qgbRr1D/arlnfoTrQnkUBuso7pgSb3HiLe64ZclBGLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=La2uwCBDs7ThjUjUqI4R2yPw51jlAN8xU8QNdIUzNE0oSmUVLIlWq8x12NuXULmxK
	 ipFOu+w1FHWOhENZfsnUBWyBlljZLnjjrFh3u/2efSgmR+DPYrPpnMglrtpjtd+jJs
	 6EeWOW7vooKxoTPzSDdK4V0mq9nVlKH54Zs+zLqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgH2NYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgH2NLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:11:05 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB33207DA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706664;
        bh=qgbRr1D/arlnfoTrQnkUBuso7pgSb3HiLe64ZclBGLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DEcvNkMsPXQhAGgKmfecBXGW4VpE7h0XPCy81/q35ylDDai3M/nQAZhNGt7CyuHte
         krmcQhTVlbo47xxaZGApBHjwGkA3PGraaRwjIUR6ntxlDgzx/0V5lvDOZXghxVxoED
         QrLMLQZPEZnFZ/ZydGg8TLxLWYjlBvvb/xm6rqp8=
Received: by mail-lj1-f170.google.com with SMTP id r13so1873202ljm.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 06:11:04 -0700 (PDT)
X-Gm-Message-State: AOAM530yRrjnSYIudupcubpCoAMeMLgV8pr/fc5AjHHfUcvwJ7zcMCL9
        4pVmrYshE3aWcEtH0KeWBPOmC9N/S5U+LwG8W/c=
X-Google-Smtp-Source: ABdhPJwTWAeIhviKA519oDIUazQORCwTze4Opr2w2Mvhy5ACrmd4T2gDsNMdipEkMtRD28GZYBkI85Q15k4K/AfXUks=
X-Received: by 2002:a2e:8144:: with SMTP id t4mr1681835ljg.100.1598706662774;
 Sat, 29 Aug 2020 06:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200829124356.18148-1-krzk@kernel.org>
In-Reply-To: <20200829124356.18148-1-krzk@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 22:10:26 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0o1-_mgpiLxnmhtV3-yrybr9uDDQAV_eE3oFEdd4nz8g@mail.gmail.com>
Message-ID: <CAGTfZH0o1-_mgpiLxnmhtV3-yrybr9uDDQAV_eE3oFEdd4nz8g@mail.gmail.com>
Subject: Re: [PATCH 1/4] extcon: max14577: Return error code of extcon_dev_allocate()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 9:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> devm_extcon_dev_allocate() can fail of multiple reasons.  The call
> returns proper error code on failure so pass it instead of fixed ENOMEM.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-max14577.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index cc47d626095c..ace523924e58 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -713,7 +713,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
>                                               max14577_extcon_cable);
>         if (IS_ERR(info->edev)) {
>                 dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
> -               return -ENOMEM;
> +               return PTR_ERR(info->edev);
>         }
>
>         ret = devm_extcon_dev_register(&pdev->dev, info->edev);
> --
> 2.17.1
>

Applied them for patch1-4. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
