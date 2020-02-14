Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C2EC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420A322314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMhZXkRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBNCYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:24:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34932 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNCYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:24:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3130201plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=zyr5zP62gxcn2MAM+lzUD5xLGxMnttBVg2RA3RQEg8s=;
        b=QMhZXkRH4oIy65/M0l0BfR39ISgMZgR3qAmeoxWLhNzfYAUHeaGBO3BZUfNJruc1wf
         jkfc3m8Y47UwUuWq9OOJsyPSEzF934STkcLaakWYPovEWNA6/2VHTAvYHd5EqpRIjYPz
         +mktNyNpU67YqZt3TvUHClkKp04eKzPmfdChc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=zyr5zP62gxcn2MAM+lzUD5xLGxMnttBVg2RA3RQEg8s=;
        b=t+4VXw8qDA24Mq2ESg0KR2pZcAy4TtKgnfKqNtG/1LcHNC3RCMf4RwWSKGtcMRkHK3
         dfaAbtefh91kH4xzfP4dGF42Hrkuq56HZlPLCaaOkd79yLz43WmHG4g90B5w93aEhwP9
         v9PPAP8RTXWv3i59scy3keHe5uPfRACaCjJmFJtsg755DB1MMne7d15OdkAG0iZlJsMA
         FfMrCCZ/JyQYv5XwqE1VpyQh3qTrz3+J6v7xfk+bM2WCiDPkz5Q49zPvzPoVqve7gSq6
         pr7laFiHDBsY8qNZOvWD2ziPFmoFT8u0tBoUYylUhDojgnir4+cyJCINN7Cn5yVau6Iw
         JiPA==
X-Gm-Message-State: APjAAAXe5pOLrl5j8hS/UDDbK49pJdhVYyFj5gbMUEWdehll+kY4BIy7
        UynURV0a3dnvv5uam6Sl18EfYQ==
X-Google-Smtp-Source: APXvYqxC2SJX1aAT6Gi5b3eS3JrHpxTtQH2y3axskLceSfHZHxtwyCHLbO1LRBrAThMLQXULz2yjYA==
X-Received: by 2002:a17:90a:b010:: with SMTP id x16mr708199pjq.130.1581647083461;
        Thu, 13 Feb 2020 18:24:43 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q8sm3883284pje.2.2020.02.13.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:24:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200211005059.1377279-2-bjorn.andersson@linaro.org>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org> <20200211005059.1377279-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info binding
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Feb 2020 18:24:42 -0800
Message-ID: <158164708228.184098.14137448846934888082@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-02-10 16:50:52)
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.y=
aml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> new file mode 100644
> index 000000000000..8386a4da6030
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm peripheral image loader relocation info binding
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  This document defines the binding for describing the Qualcomm peripher=
al

Maybe drop "This document defines the binding for describing".

> +  image loader relocation memory region, in IMEM, which is used for post=
 mortem
> +  debugging of remoteprocs.
> +
> +properties:
> +  compatible:
> +    const: qcom,pil-reloc-info
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    imem@146bf000 {
> +      compatible =3D "syscon", "simple-mfd";
> +      reg =3D <0 0x146bf000 0 0x1000>;
> +
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +
> +      pil-reloc {

Should that be pil-reloc@94c?

> +        compatible =3D"qcom,pil-reloc-info";
> +        reg =3D <0x94c 200>;
> +      };
> +    };
