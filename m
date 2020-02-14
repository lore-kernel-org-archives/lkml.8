Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B49CC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D2E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKa4T1e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgBNE6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:58:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42952 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgBNE6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:58:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so3249714plt.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKVY1vLFLeMqrxzisPDGi9WSqjXkmoLHrmJtuhSeWpA=;
        b=MKa4T1e2BYLw/Ugb3oAmoOd2/+jxBGU41Nm0g2vInEcGYPpAVF4qjcghbG3fkw0HXN
         B8DztKpHj8V6pZpHQYtyOIIrsJjCaE41e1kJW6DZWot3yv33XpMaDhJJYgKnZiTeDeqX
         9lhaDMVq4ps4dz1y5d1jLUP4gervls7YSjpNd5WTZAWENA13FnBpMtV3n7mm2DtQPZJS
         E+KE9/BAMpJZm741V0hwE6uCsNJYKEByXbqrXPw1LSoSDMn8bdWu52TpIGL4csxp77Ub
         tHY9EzmdRmSEUhMeV6RKEX4BiRH4F+rJ6+bcxuVYAdVDe0iUA/S/rGGKUekxwRq7mZEk
         2vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKVY1vLFLeMqrxzisPDGi9WSqjXkmoLHrmJtuhSeWpA=;
        b=CfhIb7X1gq7GxqHEp/XMUtj57xP8cmnIuTuaUtmy6CGY2ku2GaYV7Ur/wRqipLVx6N
         AHZ/WbFFnjAoou7OhHD5tpbTmYvi6ecJaneUeBtG0TLZEYuId3yWs9dJ9q/+VZz46+Dm
         Yjv5LoTiqEppNTg78pSaSWFPG+C/kWCqUbKHbfXui0bs3rD8Wrjkf3/fiqCkdzN5V0kn
         8k4u+VY7x2c9aTlEI0JYv/e2XUYENEr53J0vDJmjfxpVzbAWLBfvIw4ipVp5x0YJqDTT
         b559bjb990+8fFeLIk73c9v0JSYUKJUhO/ECUx0nhM3BQJaJNwNuiTytsDoZcja05rsH
         qZhw==
X-Gm-Message-State: APjAAAXkDwdTlGZSfZys4Xo8sXH4HrCyhFQvM81H0LVa4ahtptIRdhtm
        zes475ffr1oYKRGt8ZKaYOtEiw==
X-Google-Smtp-Source: APXvYqxkZrLSarCDLnWJ9dsKIOTgEPrBqxnrfmJEwDBKM4wR5889OJKHFcPcKBnjFWQUIaFaaOLQog==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr1467333ple.302.1581656298355;
        Thu, 13 Feb 2020 20:58:18 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a21sm4992409pgd.12.2020.02.13.20.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 20:58:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:58:15 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info
 binding
Message-ID: <20200214045815.GU3948@builder>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
 <20200211005059.1377279-2-bjorn.andersson@linaro.org>
 <158164708228.184098.14137448846934888082@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158164708228.184098.14137448846934888082@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Feb 18:24 PST 2020, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2020-02-10 16:50:52)
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> > new file mode 100644
> > index 000000000000..8386a4da6030
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm peripheral image loader relocation info binding
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description:
> > +  This document defines the binding for describing the Qualcomm peripheral
> 
> Maybe drop "This document defines the binding for describing".
> 

Sounds reasonable.

> > +  image loader relocation memory region, in IMEM, which is used for post mortem
> > +  debugging of remoteprocs.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,pil-reloc-info
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    imem@146bf000 {
> > +      compatible = "syscon", "simple-mfd";
> > +      reg = <0 0x146bf000 0 0x1000>;
> > +
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +
> > +      pil-reloc {
> 
> Should that be pil-reloc@94c?
> 

Yes it should.

Thanks,
Bjorn

> > +        compatible ="qcom,pil-reloc-info";
> > +        reg = <0x94c 200>;
> > +      };
> > +    };
