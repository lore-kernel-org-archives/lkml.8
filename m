Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69205C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3118224671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqza2qpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBNCnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:43:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37294 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgBNCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:43:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so3143737plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=uhAnaYBibh71jLGyT/MAQHtwtB/q365HXNevkI1NHmw=;
        b=bqza2qpu0iMia0lDRZcLlw1hsj7t4HxHSBGtkrUkfecnRtXkQV9k9Hr+P3fXTdeYwG
         WIGaXJCtnBYGIvhfHG2pUPZuZW0jCLv5UTd5aIQk7vLOBWUsvdfPeteI55NNImnKObNd
         2+6JO7ErmbVY4W9L1QidUq0BRuc7LOtlUUygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=uhAnaYBibh71jLGyT/MAQHtwtB/q365HXNevkI1NHmw=;
        b=ucPst9Lm86W9u4kAnN0M/O/sUKRxoJEgYVAuM3nmVrny3dtk4e5EwA6IVMEp1pygLT
         K68diBLYBd22cRS49hwizplxGQF+7uIXgdgxYZFVU3NXi1TMsfotR3ZorRiQs75vkZMJ
         1dInzfeL6nhRiWJZoRw+ELD1CyEMGKWwaNsxLHabFbmouIWJOgtful0bQ/SPNry+7jyj
         q7oV21nlKgOpLBeWGoKM9vKhUm87U6jMQ8gFbMT+8dDF5lTNKLa+yUoq5au9fqRIGAUo
         VrI9TSQUebyosDbNIEQ2m+SXt6KerYWe8Z51XrWzLKhVyh7Soo0vPrF5axcXW3TE7vNP
         HAqw==
X-Gm-Message-State: APjAAAVGm1ilm2t6KFXf3+w2EL+c3S4jnRo2RDtczYN5HCgP3L5LIlW1
        jTk6TKjs2Sp6XJcGT3+VzjtH9A==
X-Google-Smtp-Source: APXvYqyieuX93wS+pYXvIYep4RXo0jartYxK5/w/PiWzurnNWGvHpO1ykyoIhsad7KiPH8fJQYxXTA==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr745812pjn.39.1581648185439;
        Thu, 13 Feb 2020 18:43:05 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t66sm4628079pgb.91.2020.02.13.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:43:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200211005059.1377279-9-bjorn.andersson@linaro.org>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org> <20200211005059.1377279-9-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 8/8] remoteproc: qcom: Introduce panic handler for PAS and ADSP
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Date:   Thu, 13 Feb 2020 18:43:04 -0800
Message-ID: <158164818421.184098.5580195556346218701@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-02-10 16:50:59)
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qco=
m_q6v5_adsp.c
> index 19f784adf91c..822881534d37 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -291,12 +291,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64=
 da, int len)
>         return adsp->mem_region + offset;
>  }
> =20
> +static unsigned int adsp_panic(struct rproc *rproc)
> +{
> +       struct qcom_adsp *adsp =3D (struct qcom_adsp *)rproc->priv;

We don't need to cast from void. Please drop the cast.

> +
> +       return qcom_q6v5_panic(&adsp->q6v5);
> +}
> +
>  static const struct rproc_ops adsp_ops =3D {
>         .start =3D adsp_start,
>         .stop =3D adsp_stop,
>         .da_to_va =3D adsp_da_to_va,
>         .parse_fw =3D qcom_register_dump_segments,
>         .load =3D adsp_load,
> +       .panic =3D adsp_panic,
>  };
> =20
>  static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom=
_q6v5_pas.c
> index d20ce3c62256..ac38624fb14d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -242,12 +242,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64=
 da, int len)
>         return adsp->mem_region + offset;
>  }
> =20
> +static unsigned int adsp_panic(struct rproc *rproc)
> +{
> +       struct qcom_adsp *adsp =3D (struct qcom_adsp *)rproc->priv;

Same.

> +
> +       return qcom_q6v5_panic(&adsp->q6v5);
> +}
