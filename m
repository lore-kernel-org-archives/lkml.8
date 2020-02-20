Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF7C11D15
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E7D24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwmkCUco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgBTR7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:59:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40429 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgBTR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:59:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1202777pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b39p1eGP3nlw0aRiq/EeenwuRZud+ndWD/CEPqlUtnE=;
        b=qwmkCUcoVIMXBx/AwEt9MPwRTrkz2uyhf0NcAxdivTQjwX1XtVFIVwvizt7PTnm2A4
         +/uy0TnaN37yTB6RrkMkpdIbONbwniMinlv2RHduA2AOzqu5/QmYAR1BtJ9tf7xh07L3
         f6pFWAHnngs5stFC70RIfUeyOOiWQ8YNY5qxr6NT9f5gqVxktjseLYAeD7rSXFVEOlfW
         mtpwnIwTcI8XLpaD76ZhgOYOoumzeO3sUAZM8OyeoRSqeLi6YnCD0RGuMnIcTuQAcgrS
         TdIzRXquWA8RjNDjLf8WwV8bug0AkUrm1r9xKRAlK9lVkIDp/yFSKRcmfE59ga8oXMbH
         yZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b39p1eGP3nlw0aRiq/EeenwuRZud+ndWD/CEPqlUtnE=;
        b=InFHvD8jpCE9eoUJ1VCraQJOOsPxsxlSghcqkJJRtLmH+b1zykhQe8qysMj/mKrQ5R
         UBcLjkNbS6gPRzTgBnpZeGE9nl4x4AOO8FyAvdv0mfA+JGfCZKjFLNltCqPWnXU9hk3i
         bOxPe+4sK1nNVHM3s4DkPlSsFRO4XqTJmNPB18yfiXKGboejnUJVLreaid1zZlZs9lnc
         lHCgpIS3z1NyKfAQ021IeZGWW8i8DA3g9qx6cGV6D5jENxV27rX3vtVmv6S9NEwvpiYW
         WR+EnK0BjBpbP/Z1StFUfdtpWDuMoJEUAs2ZY4guj9H5YROVSMR+ZhyKvX0kDVQ2j3Jc
         kYLA==
X-Gm-Message-State: APjAAAUOkTnwhfVhToVrVRz5DM5/qJjigQCYa+KQ7DOF70ONhGPHyK/U
        sKU0iv5jJfs2qjID/sVtBbODXQ==
X-Google-Smtp-Source: APXvYqwD3zUPaAslcARdnI7JTUN/osi+pnuqbRLDxOFcEbVa3s64IJ6zWD8Jvh/qwLsyt7L2ySuVQQ==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr5009154pjb.4.1582221554028;
        Thu, 20 Feb 2020 09:59:14 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ev5sm112928pjb.4.2020.02.20.09.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:59:13 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:59:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info
 binding
Message-ID: <20200220175911.GA19352@xps15>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
 <20200211005059.1377279-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211005059.1377279-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:50:52PM -0800, Bjorn Andersson wrote:
> Add a devicetree binding for the Qualcomm periperal image loader

s/periperal/peripheral

> relocation info region found in the IMEM.

s/info/information

> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Replaced offset with reg to describe the region of IMEM used for the entries
> 
>  .../bindings/remoteproc/qcom,pil-info.yaml    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
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
> +  This document defines the binding for describing the Qualcomm peripheral
> +  image loader relocation memory region, in IMEM, which is used for post mortem
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
> +      compatible = "syscon", "simple-mfd";
> +      reg = <0 0x146bf000 0 0x1000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      pil-reloc {
> +        compatible ="qcom,pil-reloc-info";

s/="/= "

> +        reg = <0x94c 200>;
> +      };
> +    };
> +...
> -- 
> 2.24.0
> 
