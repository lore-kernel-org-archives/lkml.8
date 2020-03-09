Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3088C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81483222C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1pDQIwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCIO4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:56:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32808 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCIO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:56:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay11so4081142plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7FHNY6Bbi9OnenKcPgyo/jmVSkbWzMI4bouMG2Uqo8=;
        b=i1pDQIwtLSnFTc1rMqSvmlFtRX9Q+SNwCdmQ3QOuy4qND0Gyr+6sHTiI3mKNSJM5SP
         +2c2oQHdadPavvbfXW2KHtpewSJK5ELMENtcuB7IAc1AzbhAXksQzT+YPUzUpJBb50TY
         XbYGOaVszuPBwzyP218/bkuDdQ/9CCXeI+65IEbrl5/pdysolFhttoXo0N2cWbKCq866
         yLld6vH0Y039fFtPGmeNGHXMzv2okXH2ld9h8lekDNmGV4SX8IY58QfzOVGJaOMC3b1x
         80itFzlckFh4Att+XfEkzgxB5yulxLW4JnNsikr5iPJUyLMCTO+BvFfDtYEMlPSaiuQE
         Vn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7FHNY6Bbi9OnenKcPgyo/jmVSkbWzMI4bouMG2Uqo8=;
        b=i1UT9C1GBDop9crhclY9hHg4C56L9B7RMqC7qkmarjFfPIS1IwXeRCUH/zuNq7D2Km
         RoVkalQztZF6k99mkwDkCeGp7333014nB7TXc/1xlUS7doNKCTOOD5QuzqgdTu59YcAG
         SfKXA+L5GSFZpK8idQ+fVNsvPCKVboWLr+fYN2JRWy6KpXoR7Jp9edaohLfit5iUTNd3
         jXP9bhroA+tWWjRZDhEjTTsh5263IuFfJcftHCGnPBr+uBUA2WS7CB8ckmwdJ8s4BuVW
         nmvA4hIEpnSpj5xCibZXmf36xU+0sHqIleG0WK39+YKSSzaIrTCGQg2oyX+AEHaZ+QwL
         bBkQ==
X-Gm-Message-State: ANhLgQ3LORE77HXVigUSEtgs82He9uQaB1hVoAZVV5tD+ChQv4bn3vkS
        zHobV41Fr8V6l83RxRLdZu0hIQ==
X-Google-Smtp-Source: ADFU+vufHk9XjSPHhPjvmBwO1flM6I5vCy5bZdtxyZynlplLAY6XaQzgS4SY6rq1r7dAatTXMKLdoA==
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr20016360pjs.58.1583765778307;
        Mon, 09 Mar 2020 07:56:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s125sm45074491pgc.53.2020.03.09.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:17 -0700 (PDT)
Date:   Mon, 9 Mar 2020 08:56:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: Add documentation for SPSS
 remoteproc
Message-ID: <20200309145615.GA24489@xps15>
References: <1583522467-3499-1-git-send-email-rishabhb@codeaurora.org>
 <1583522467-3499-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583522467-3499-3-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

On Fri, Mar 06, 2020 at 11:21:07AM -0800, Rishabh Bhatnagar wrote:
> Add devicetree binding for Secure Subsystem remote processor
> support in remoteproc framework. This describes all the resources
> needed by SPSS to boot and handle crash and shutdown scenarios.
>

Bindings in txt format are no longer accepted - everything needs to be in yaml
Also, this needs to be reviewed by the DT brigade.  As such you will
have to CC the device tree mailing list and Rob Herring.
 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,spss.txt   | 114 +++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt b/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
> new file mode 100644
> index 0000000..79d6258
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
> @@ -0,0 +1,114 @@
> +Qualcomm SPSS Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm Secure Peripheral Processor. This processor is booted in the
> +bootloader stage and it attaches itself to linux later on in the boot process.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,sm8250-spss-pas"
> +
> +- reg:
> +	Should contain an entry for each value in 'reg-names'. Each entry
> +	have memory region's start address and size of the region.
> +
> +- reg-names:
> +	Should contain strings with the following names each representing
> +	a specific region in memory.
> +	"sp2soc_irq_status", "sp2soc_irq_clr", "sp2soc_irq_mask", "rmb_err",
> +	"rmb_err_spare2"
> +
> +- interrupts:
> +	Should contain the generic interrupt assigned to remote processor.
> +	The values should follow the interrupt-specifier format as dictated
> +	by the 'interrupt-parent' node.
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: reference to the xo clock and optionally aggre2 clock to be
> +		    held on behalf of the booting Hexagon core
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "xo" and optionally include "aggre2"
> +
> +- cx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the regulator to be held on behalf of the
> +		    booting Hexagon core
> +
> +- px-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the px regulator to be held on behalf of the
> +		    booting Hexagon core
> +
> +- memory-region:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reserved-memory for the SPSS
> +
> +- qcom,spss-scsr-bits:
> +	Usage: required
> +	Value type: <array>
> +	Definition: Bits that are set by remote processor in the irq status
> +		    register region to represent different states during
> +		    boot process
> +
> += SUBNODES
> +The spss node may have an subnode named either "smd-edge" or "glink-edge" that
> +describes the communication edge, channels and devices related to the SPSS.
> +See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for details on how
> +to describe these.
> +
> += EXAMPLE
> +The following example describes the resources needed to boot the
> +Secure Processor, as it is found on SM8250 boards.
> +
> +	spss {
> +		compatible = "qcom,sm8250-spss-pil";
> +		reg = <0x188101c 0x4>,
> +                      <0x1881024 0x4>,
> +                      <0x1881028 0x4>,
> +                      <0x188103c 0x4>,
> +                      <0x1882014 0x4>;
> +                reg-names = "sp2soc_irq_status", "sp2soc_irq_clr",
> +                            "sp2soc_irq_mask", "rmb_err", "rmb_err_spare2";
> +                interrupts = <0 352 1>;
> +
> +                cx-supply = <&VDD_CX_LEVEL>;
> +                cx-uV-uA = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
> +                px-supply = <&VDD_MX_LEVEL>;
> +                px-uV = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
> +
> +                clocks = <&clock_rpmh RPMH_CXO_CLK>;
> +                clock-names = "xo";
> +                qcom,proxy-clock-names = "xo";
> +                status = "ok";
> +
> +                memory-region = <&pil_spss_mem>;
> +                qcom,spss-scsr-bits = <24 25>;
> +
> +                glink-edge {
> +                        qcom,remote-pid = <8>;
> +                        transport = "spss";
> +                        mboxes = <&sp_scsr 0>;
> +                        mbox-names = "spss_spss";
> +                        interrupt-parent = <&intsp>;
> +                        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                        reg = <0x1885008 0x8>,
> +                              <0x1885010 0x4>;
> +                        reg-names = "qcom,spss-addr",
> +                                    "qcom,spss-size";
> +
> +                        label = "spss";
> +                        qcom,glink-label = "spss";
> +                };
> +	};
> +
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
