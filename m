Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBECC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F79206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Roo8z/H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGXQ4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:56:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41483 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGXQ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:56:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595609806; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=slIS97vKV63QCr6QxPvaBZfhezqga3Y61b7WNCJyBcs=;
 b=Roo8z/H8n984OqDmlf5lgMuXMBAHGfb+3AsYH+B7gZDAS/XY8xNYSAlkfIkp/mW+op+wCSMz
 UwAtiZOMJxRHTZ8wajTbKJWbjEap9sZkwVALtoJ0f0f6UBgUjJOfS/f3iqV+qQoUgg++z/55
 el3b3CgDv6RpnLqqwBgCPrPvk7A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f1b129e35f3e3d3162f0a41 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 16:55:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E1EEC43391; Fri, 24 Jul 2020 16:55:58 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35514C433C9;
        Fri, 24 Jul 2020 16:55:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 24 Jul 2020 22:25:57 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sm8250: add interconnect nodes
In-Reply-To: <2b77bdaf-0c9e-c054-77d1-3bc21e857773@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-8-jonathan@marek.ca>
 <630319740d3f06cfb0435cae025e0ca1@codeaurora.org>
 <2b77bdaf-0c9e-c054-77d1-3bc21e857773@marek.ca>
Message-ID: <4d984ecd68adc249f12eeb18bb7e5792@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-24 20:06, Jonathan Marek wrote:
> On 7/24/20 10:13 AM, Sibi Sankar wrote:
>> Hey Jonathan,
>> 
>> Thanks for the patch! Please use the
>> suggested register space definitions
>> instead.
>> 
> 
> Thanks for the suggestions, I was unsure what to use for the sizes.
> The reg field is unused by the upstream driver so it is hard to figure
> out.
> 
> However, I'm not sure about some of your suggestions for the base
> address. For example, for "mc_virt" you suggest 0x0163d000, and I have
> 0x09100000. In the downstream dts, "mc_virt-base" is 0x9100000 and
> qcom,base-offset for fab_mc_virt is 0. Do you have an explanation for
> why your suggestion is so different?

AFAIK for providers with virt suffix the
register space definition is just an
arbitrary choice and doesn't matter.
Since mc_virt was just re-using gem_noc
address space I suggested we stick to
how it was done on sc7180 i.e place it
between system_noc and aggre1_noc.

> 
>> On 2020-07-13 21:11, Jonathan Marek wrote:
>>> Add the interconnect dts nodes for sm8250.
>>> 
>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 82 
>>> ++++++++++++++++++++++++++++
>>>  1 file changed, 82 insertions(+)
>>> 
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> index 636e2196138c..dfc1b7fa7d85 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> @@ -11,6 +11,7 @@
>>>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/interconnect/qcom,sm8250.h>
>> 
>> please fix ^^ sort order
>> 
>>> 
>>>  / {
>>>      interrupt-parent = <&intc>;
>>> @@ -978,6 +979,55 @@ spi13: spi@a94000 {
>>>              };
>>>          };
>>> 
>>> +        config_noc: interconnect@1500000 {
>>> +            compatible = "qcom,sm8250-config-noc";
>>> +            reg = <0 0x01500000 0 0x1000>;
>> 
>> 0x01500000 0xa580
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        ipa_virt: interconnect@1620000 {
>>> +            compatible = "qcom,sm8250-ipa-virt";
>>> +            reg = <0 0x01620000 0 0x1000>;
>> 
>> 0x01e00000 0x1000
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        system_noc: interconnect@1632000 {
>>> +            compatible = "qcom,sm8250-system-noc";
>>> +            reg = <0 0x01632000 0 0x1000>;
>> 
>> 0x01620000 0x1C200
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        aggre1_noc: interconnect@16e2000 {
>>> +            compatible = "qcom,sm8250-aggre1-noc";
>>> +            reg = <0 0x016e2000 0 0x1000>;
>> 
>> 0x016e0000 0x1f180
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        aggre2_noc: interconnect@1703000 {
>>> +            compatible = "qcom,sm8250-aggre2-noc";
>>> +            reg = <0 0x01703000 0 0x1000>;
>> 
>> 0x01700000 0x33000
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        compute_noc: interconnect@1733000 {
>>> +            compatible = "qcom,sm8250-compute-noc";
>>> +            reg = <0 0x01733000 0 0x1000>;
>> 
>> 0x01733000 0xd180
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        mmss_noc: interconnect@174a000 {
>>> +            compatible = "qcom,sm8250-mmss-noc";
>>> +            reg = <0 0x0174a000 0 0x1000>;
>> 
>> 0x01740000 0x1f080
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>>          ufs_mem_hc: ufshc@1d84000 {
>>>              compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
>>>                       "jedec,ufs-2.0";
>>> @@ -1364,6 +1414,34 @@ usb_2_ssphy: lane@88eb200 {
>>>              };
>>>          };
>>> 
>>> +        dc_noc: interconnect@90c0000 {
>>> +            compatible = "qcom,sm8250-dc-noc";
>>> +            reg = <0 0x090c0000 0 0x1000>;
>> 
>> 0x090c0000 0x4200
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        mc_virt: interconnect@9100000 {
>>> +            compatible = "qcom,sm8250-mc-virt";
>>> +            reg = <0 0x09100000 0 0x1000>;
>> 
>> 0x0163d000 0x1000
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        gem_noc: interconnect@9121000 {
>>> +            compatible = "qcom,sm8250-gem-noc";
>>> +            reg = <0 0x09121000 0 0x1000>;
>> 
>> 0x09100000 0xb4000
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>> +        npu_noc: interconnect@9990000 {
>>> +            compatible = "qcom,sm8250-npu-noc";
>>> +            reg = <0 0x09990000 0 0x1000>;
>> 
>> 0x09990000 0x1600
>> 
>>> +            #interconnect-cells = <1>;
>>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>>> +        };
>>> +
>>>          usb_1: usb@a6f8800 {
>>>              compatible = "qcom,sm8250-dwc3", "qcom,dwc3";
>>>              reg = <0 0x0a6f8800 0 0x400>;
>>> @@ -2359,6 +2437,10 @@ rpmhpd_opp_turbo_l1: opp10 {
>>>                      };
>>>                  };
>>>              };
>>> +
>>> +            apps_bcm_voter: bcm_voter {
>>> +                compatible = "qcom,bcm-voter";
>>> +            };
>>>          };
>>>      };
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
