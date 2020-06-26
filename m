Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D25C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E7920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JuHGdSRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFZHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgFZHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:42:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E33C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:42:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so4331383pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=OJIUC4k1mJAJPg8NhZJ50NxPEO+zBVx140Q/CxvWNvw=;
        b=JuHGdSRcBQGE3Lde78F313PsAZcPMsnhx/4TiHSLZEfd0kKmZO8VUORbl2ywLlLNYP
         SybuYbIXipyAqOoCEFVzfX+cyu1u//qdxZmUFkk1BZIbhZiDVvkT+r3ys2yo80bHbGon
         SsdxDCae+9fy02JYCpW6exl43BLdPHw76Jn1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=OJIUC4k1mJAJPg8NhZJ50NxPEO+zBVx140Q/CxvWNvw=;
        b=nRyYRDFDELi5ImQdQn0Mpd7lXcNYLizPjgBnmsX0vGmaKLN1ET6THM4ATbjN1avVMf
         xubh6MpafhkMthvbyFHalu8H7jyk6DwTFORaFINF6CI0jXqwSqHE0MIx30SUkzqcdYkr
         6gKhOUfPSnidpZIr6iRkgPt0fLmIft03aOL1FhAKVJG22/m9m3pV5MzqgJ6eOKGnhtQG
         nQOJoA49A5GNLw1TeDnLFySmPrVPf5koCGNiduNiZpAdEWtw5W0Pjzk4SjLgewMaZtfT
         oT9EDttuyYezXVABbTrToVjM1uFjhpINk8kUpo4S3aHCOM135nDx2SoaLJp4Qh6Vlpkk
         q+Gg==
X-Gm-Message-State: AOAM533uA40NTB0YAkwHelpI0uEhwPmkwnNyv076r+umdhPFH3e6N9tD
        lyOqS8b+eCtiD4Oewl0IcgnnHA==
X-Google-Smtp-Source: ABdhPJxJiBdKBJCg9hkKXPvaAZ1SMFSV7dxt8ZkrJwCH6KsPe6VyOeT252b+sGAmU5335uuNU45W2w==
X-Received: by 2002:a17:90a:1546:: with SMTP id y6mr2153667pja.92.1593157376534;
        Fri, 26 Jun 2020 00:42:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id jz23sm10479542pjb.2.2020.06.26.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:42:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200625001039.56174-4-john.stultz@linaro.org>
References: <20200625001039.56174-1-john.stultz@linaro.org> <20200625001039.56174-4-john.stultz@linaro.org>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a permanent module
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Jun 2020 00:42:55 -0700
Message-ID: <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Stultz (2020-06-24 17:10:37)
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 6ae9e1f0819d..3fee8b655da1 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -430,4 +432,33 @@ static int qcom_pdc_init(struct device_node *node, s=
truct device_node *parent)
>         return ret;
>  }
> =20
> +#ifdef MODULE
> +static int qcom_pdc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device_node *parent =3D of_irq_find_parent(np);
> +
> +       return qcom_pdc_init(np, parent);
> +}
> +
> +static const struct of_device_id qcom_pdc_match_table[] =3D {
> +       { .compatible =3D "qcom,pdc" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
> +
> +static struct platform_driver qcom_pdc_driver =3D {
> +       .probe =3D qcom_pdc_probe,
> +       .driver =3D {
> +               .name =3D "qcom-pdc",
> +               .of_match_table =3D qcom_pdc_match_table,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +module_platform_driver(qcom_pdc_driver);
> +#else
>  IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);

Is there any reason to use IRQCHIP_DECLARE if this can work as a
platform device driver?

> +#endif
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller"=
);
> +MODULE_LICENSE("GPL v2");
