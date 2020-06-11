Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA44C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E520760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pQnSBE/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFKMTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:19:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50122 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgFKMTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:19:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591877950; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6vvXLsTpi8eX/TgjYkKkVugmiw4GBm2oRpYR4vVFpmk=; b=pQnSBE/SMKlGKkEKAxDkmwSBah+0vfDeYMSviSuOXffHTZ1JfSD+J4CznKOCAOOCqk0TO/Fw
 d3ovEqejXHCEujjeH/jDDPIEzGHNMChxCoDenXi4JfnM29uTRGAin5aKfH1iiUS96jP8Lkgn
 w9MG5+Qj7cXCMjPn1y2QzM/nwWc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee2213a86de6ccd44cbb237 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 12:19:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79FDEC43387; Thu, 11 Jun 2020 12:19:05 +0000 (UTC)
Received: from [192.168.0.118] (unknown [49.207.58.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2455C433C8;
        Thu, 11 Jun 2020 12:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2455C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for
 qfprom-efuse
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, dhavalp@codeaurora.org,
        mturney@codeaurora.org, sparate@codeaurora.org,
        c_rbokka@codeaurora.org, mkurumel@codeaurora.org
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <8ef8c7c4-3560-274d-3043-ddf5b87e794a@codeaurora.org>
Date:   Thu, 11 Jun 2020 17:48:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/2020 3:18 PM, Ravi Kumar Bokka wrote:
> This patch adds dt-bindings document for qfprom-efuse controller.

there is an existing bindings doc (in .txt) which you should convert to yaml,
and then add another patch to extend it.

> 
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>   .../devicetree/bindings/nvmem/qfprom.yaml          | 52 ++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
> new file mode 100644
> index 0000000..7c8fc31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/qfprom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc, QFPROM Efuse bindings
> +
> +maintainers:
> +  - Ravi Kumar Bokka <rbokka@codeaurora.org>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qfprom
> +
> +  reg:
> +    maxItems: 3
> +
> +required:
> +   - compatible
> +   - reg
> +   - reg-names
> +   - clocks
> +   - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +
> +    qfprom@780000 {
> +	compatible = "qcom,qfprom";
> +	reg = <0 0x00780000 0 0x7a0>,
> +	      <0 0x00782000 0 0x100>,
> +	      <0 0x00784000 0 0x8ff>;
> +	reg-names = "raw", "conf", "corrected";
> +	clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
> +	clock-names = "secclk";
> +
> +	qusb2p_hstx_trim: hstx-trim-primary@25b {
> +		reg = <0x25b 0x1>;
> +		bits = <1 3>;
> +	};
> +    };
> +
> +    &qfprom {
> +        vcc-supply = <&vreg_l11a_1p8>;
> +    };
> +
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
