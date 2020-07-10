Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D0BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386C620725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="faBGbYI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGJQgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:36:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59722 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbgGJQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:36:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594398966; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/bmwIOUQ2PyZm9JbERBXuu+04sU6dnptUO3MObAQrMQ=;
 b=faBGbYI81/z99GUj5tDxWXaRTaShmg1EuFONooWns1Kx75/TpbGiWGfpcmJ/t58nTlM1k94m
 cdn2PNdVEuZqZnZE+81/p/jOEb7UpmZjP/hOLT7UKwhvH5zG7GBn246JosYuGh9jx/QwnXT+
 YK3FRrOLXVx4lUalzLgOizHDqno=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f08984ed3d650842235c64a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 16:33:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEF06C43387; Fri, 10 Jul 2020 16:33:17 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B44AC433C6;
        Fri, 10 Jul 2020 16:33:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Jul 2020 09:33:16 -0700
From:   rishabhb@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info
 binding
In-Reply-To: <20200622191942.255460-2-bjorn.andersson@linaro.org>
References: <20200622191942.255460-1-bjorn.andersson@linaro.org>
 <20200622191942.255460-2-bjorn.andersson@linaro.org>
Message-ID: <f4ee9ee95ad8f9154ab02aaf85a16307@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 12:19, Bjorn Andersson wrote:
> Add a devicetree binding for the Qualcomm peripheral image loader
> relocation information region found in the IMEM.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v6:
> - None
> 
>  .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> new file mode 100644
> index 000000000000..87c52316ddbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> @@ -0,0 +1,44 @@
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
> +  The Qualcomm peripheral image loader relocation memory region, in 
> IMEM, is
> +  used for communicating remoteproc relocation information to post 
> mortem
> +  debugging tools.
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
> +      reg = <0x146bf000 0x1000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      ranges = <0 0x146bf000 0x1000>;
> +
> +      pil-reloc@94c {
> +        compatible = "qcom,pil-reloc-info";
> +        reg = <0x94c 0xc8>;
> +      };
> +    };
> +...
Reviewed-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
