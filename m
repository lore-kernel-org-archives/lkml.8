Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CDDC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRaRJW1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBFTIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:08:06 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40715 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgBFTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:08:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so377740pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:cc:to:from:user-agent:date;
        bh=Yu2QDav0lMyEABQNSAjZtJUdEYaLbzOvrURQHYilMW0=;
        b=VRaRJW1YHC6Yz1ba1KM+r2rAH78IAw4ECZ8uW10SXwNAHIWn7E+yTg0EHguOn/zRrt
         eMFPYSqUTeNMXsykpLoM4IV2tVHk0/uMr4OaXPJV8mcVbWOk0QE8XuGjrvBHau/XzuTz
         tHhIdvSd9A1QlCqSpwFwRf2PLIPuBTZQ+KwDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:cc:to:from
         :user-agent:date;
        bh=Yu2QDav0lMyEABQNSAjZtJUdEYaLbzOvrURQHYilMW0=;
        b=a9ZNWIq1Ylscg/tFAcyn417C2g9j+Go4no4XrAdZjeop4AolIs9zkor+evMM0weBNg
         BvL4jTlYHfcz++awG/LuSBxrxpGI767ku60F6lDbQPrdFknTOnERzsyz5Iopm3D2AZQ4
         ZYpEotowhqCLdQXkYaFlUoGQbon3g/2Tga5ISme9tmGEzUshPRes6D+ih2Fbn4L3XfuS
         8Lvgl9AINX8NMMJgJc4xDVXtuIKcpbKUie69tNGObmxvgomrkDlBdIYZrW4yGslnPwsG
         iAdGUSMb+g/E41RI5MC3rGWI071tGuKNzmgYQgNz3oVoHeepvkmrk8num8Ddh1hsWyrG
         5rNg==
X-Gm-Message-State: APjAAAUE4nZ/qvWOLAAo2SKHyKIHq3q62CgiU6Xl8eBeorvLjnZ+Obw/
        2mRnyHoqZsDtD7pF8bCc3abUyw==
X-Google-Smtp-Source: APXvYqw4FzuijgYSawjl5c7tObZjQNWODBQFdG4z93eiZtWw8Kfhehai1gG8W0VsIPSAuMTH3ojcqQ==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr5606416plp.304.1581016085712;
        Thu, 06 Feb 2020 11:08:05 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q28sm145590pfl.153.2020.02.06.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:08:05 -0800 (PST)
Message-ID: <5e3c6415.1c69fb81.11c79.08a6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580997328-16365-2-git-send-email-kgunda@codeaurora.org>
References: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org> <1580997328-16365-2-git-send-email-kgunda@codeaurora.org>
Subject: Re: [PATCH V3 2/2] mfd: qcom-spmi-pmic: Add support for pm6150 and pm6150l
Cc:     rnayak@codeaurora.org, Kiran Gunda <kgunda@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Feb 2020 11:08:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kiran Gunda (2020-02-06 05:55:27)
> Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
> found on SC7180 based platforms
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 ++
>  drivers/mfd/qcom-spmi-pmic.c                              | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index affc169..36f0795 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -46,6 +46,8 @@ properties:
>        - qcom,pm8998
>        - qcom,pmi8998
>        - qcom,pm8005
> +      - qcom,pm6150
> +      - qcom,pm6150l
>        - qcom,spmi-pmic

Maybe the yaml binding needs to say this is sorted in subtype id in a
comment.

	# Sorted based on subtype ID the device reports

Or we should sort this list in the binding and sort the compatible
string table in the driver with a comment that it's sorted based on
subtype id.

> =20
>    reg:
> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
> index 1df1a27..5bfeec8 100644
> --- a/drivers/mfd/qcom-spmi-pmic.c
> +++ b/drivers/mfd/qcom-spmi-pmic.c
> @@ -36,6 +36,8 @@
>  #define PM8998_SUBTYPE         0x14
>  #define PMI8998_SUBTYPE                0x15
>  #define PM8005_SUBTYPE         0x18
> +#define PM6150L_SUBTYPE                0x1F
> +#define PM6150_SUBTYPE         0x28
> =20
>  static const struct of_device_id pmic_spmi_id_table[] =3D {
>         { .compatible =3D "qcom,spmi-pmic", .data =3D (void *)COMMON_SUBT=
YPE },
> @@ -57,6 +59,8 @@ static const struct of_device_id pmic_spmi_id_table[] =
=3D {
>         { .compatible =3D "qcom,pm8998",    .data =3D (void *)PM8998_SUBT=
YPE },
>         { .compatible =3D "qcom,pmi8998",   .data =3D (void *)PMI8998_SUB=
TYPE },
>         { .compatible =3D "qcom,pm8005",    .data =3D (void *)PM8005_SUBT=
YPE },
> +       { .compatible =3D "qcom,pm6150l",   .data =3D (void *)PM6150L_SUB=
TYPE },
> +       { .compatible =3D "qcom,pm6150",    .data =3D (void *)PM6150_SUBT=
YPE },
>         { }
>  };
