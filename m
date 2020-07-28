Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87676C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BE820663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rpb34qUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgG1O3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgG1O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:29:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:29:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v22so4188666edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrWOINakE79TSeFmz4q9KUf5gSpXeKHpva0vEUvvoyQ=;
        b=Rpb34qUaaaKwqhQhMsi+NuNWWHNyUnFwpDjKF6qSFhVeZR5BdBhhtsEenxjDSqClWf
         CI/p6vOTPDWPAnWLA7pGDMg5cigfsDdkAINfRZzUVNnmxwhg8K0qbwKb1fVVp3McP5+k
         HO9P1EHFS+zDEkWKJvTy+TUwHRihI6Gbvr/2zKJT0CVl58nFeILW82F2YMQcKyJ/45Mi
         97Lxh2OES/G46kNCaNZyd5JQdvctwlNv5PMFnsuV+1n8LxDyV78WAR1ZshYR+1l9uKBY
         0SPnxcauu+YStrGk65qx6vT1WXlUTsXCVAcM8w9l2dBmlPRcKF648t7Y8VrpxZ5hJQIL
         ENuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrWOINakE79TSeFmz4q9KUf5gSpXeKHpva0vEUvvoyQ=;
        b=O+yzXQxhcgOyeCW4eT0j51G3Wv7kZgGDZSfOmuNw+zM+K6RFS0t6PEwQHkvHjZrBZ0
         FP//DICU4UZtRhpsfHFwupuDfeRut79uo+u+UbL7ZcfEiycwilkXBH7/Y6AWtg+HeCJm
         ZtnodCd8Zfpj7YDTVLip9w0DM3EjO140UHLHmv93sDzcSUn09CpkbHvb+uaMkhVLtD/s
         SZlA+xuC8hSbkG+vGkKV4Rw3mLiPkVRxzR32TdyvhEzwhuOyr5xWMIr+/KLBXuA837sU
         GrIwYt0URrI13ViyTNddqDROIzHmPNuJxwHOVDta4BdcCo0png4qOWbzJ6Ot8jQN3u/6
         QwoA==
X-Gm-Message-State: AOAM531TQ9cnXNyn/s5Z+13ljjS42q3zL4QiESJMTDInGWTv//y55EsM
        QoPa7e6Q9mHHjp3OLoo+F1fXTpI6WJmJh6FGLTTegoezkmk=
X-Google-Smtp-Source: ABdhPJxxsJeOMSaQmhMKXAHT34Cda6aFrrgQmQi8ma42bMBjYxSQPGDxCeA4K1jz7ouwDeMWjymCCLTaVvaO+GzKL38=
X-Received: by 2002:a50:d75e:: with SMTP id i30mr1849515edj.246.1595946583187;
 Tue, 28 Jul 2020 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200728022730.87399-1-miaoqinglang@huawei.com>
In-Reply-To: <20200728022730.87399-1-miaoqinglang@huawei.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 28 Jul 2020 22:29:32 +0800
Message-ID: <CABymUCOQpeSz2Z+F63txVzto5Pr1q00n0ieMFYE2YQx0XBSfqA@mail.gmail.com>
Subject: Re: [PATCH -next] ARM: zx: remove redundant dev_err call in zx296702_pd_probe()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:24=E5=86=99=E9=81=93=EF=BC=
=9A
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  arch/arm/mach-zx/zx296702-pm-domain.c | 1 -
>  1 file changed, 1 deletion(-)
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
