Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5803DC3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8A62082E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdZbQ2ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBBEnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 23:43:12 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:33009 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgBBEnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 23:43:11 -0500
Received: by mail-pl1-f170.google.com with SMTP id ay11so4474447plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 20:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:subject:to:cc:user-agent:date;
        bh=WVYttVnSjhlDMR2gVja4CMRjqdc6hYD+bYx+dfA+kjA=;
        b=GdZbQ2ee09Zy+6IaQ8V2DWdqd1AQreSrjhMPEJd35jiz2k8OxaN4ljeBLU8fQuGHxK
         IJDPkykmOkL7wT66wQsI6n/3uHumV5ZW0DtIQa0swlmLB1zoZab6S746WzH0XV6uPJVx
         D1fhGZQtOTcyeTAnFj+RfEv3E/a6pehVTN2NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:subject:to:cc
         :user-agent:date;
        bh=WVYttVnSjhlDMR2gVja4CMRjqdc6hYD+bYx+dfA+kjA=;
        b=tTV9VOdjzv4jm2FxaRzClO82HgXSUovFUODxQ71gqpYvdWxPn6JKiBfIdLc4uj+Ttz
         LSBnYk8RMJd2YZG7ap33wPsB5pnLtA+KTRlKYViHD477gJHkQMlcrDk/BkDvstmnFyeh
         LMi/jfuWRKZG/aaAG70BD02k/IEoitM1zUflt5zGfeCYX9FW1l3v1D0ZjeDkTJOyIh4x
         nX0dkbhpb3Unf7HYVfQOPTwb9OGshhUq1BSTGNqtG3KWqTts02QKOgFQnRR14JabiKXU
         nR3d8UkAolyv03J17muR9pLuVxEExW6jJNybX7z7eFGf+JBc584hzYdbTXzqP4UhLSyb
         Lt+g==
X-Gm-Message-State: APjAAAX68GpnELUiBAL7WwGtCH/XaB0zMaGQvJ8CIcwmdnMVT+td1gzN
        rVS4DS/qZ/CrOz6Bn7kXA0d+jQ==
X-Google-Smtp-Source: APXvYqwE1x9wfemYAznSfOFcQB/dTrqmq3F5ol77Z/XC3KlmQ+tkCkE9qZ2lFR0WuNyX7+LykqGJVw==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr17891671plm.212.1580618591163;
        Sat, 01 Feb 2020 20:43:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e17sm16176605pfm.12.2020.02.01.20.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 20:43:10 -0800 (PST)
Message-ID: <5e36535e.1c69fb81.510f6.ba36@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2edca4b54ee6b33493e0427c17de983d3ce3012f.1580570160.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1580570160.git.saiprakash.ranjan@codeaurora.org> <2edca4b54ee6b33493e0427c17de983d3ce3012f.1580570160.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv2 1/2] dt-bindings: watchdog: Convert QCOM watchdog timer bindings to YAML
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Sat, 01 Feb 2020 20:43:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-02-01 07:29:48)
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/D=
ocumentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> new file mode 100644
> index 000000000000..5448cc537a03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/qcom-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
> +
> +maintainers:
> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kpss-timer
> +      - qcom,kpss-wdt
> +      - qcom,kpss-wdt-apq8064
> +      - qcom,kpss-wdt-ipq4019
> +      - qcom,kpss-wdt-ipq8064
> +      - qcom,kpss-wdt-msm8960
> +      - qcom,scss-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

By the way, I would expect the watchdog to have an interrupt property.
Not sure why it isn't described in the existing binding.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
