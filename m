Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECDEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EDD20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="YOqLeyRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXOiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGXOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:38:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69394C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:38:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so1109746qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOK7eAgZJ3t7dQkZKNcxeqBq/iG/Skq4gZfTI03mDPM=;
        b=YOqLeyRMdwqgU18zVS/+N6TLsH9gI63rm9VIeN/epQyBzEW9i5ywuSAdqJbHLmHdad
         /MQnCuvp7fEnW4nrMTruFWDGhfmvMODXjt4QBoYwZtty84j5U1CUjAC50/lJfnz0HFD/
         KSWqe8l+ecOd8S7OdU7qh0hAC9DQd5zRs2zPk2CmVRNR6AYPuzs8FU8FO+kDOzqc6v6e
         vZonBwMR0Q/H4WhyVWJS9oT6W+NzFLdtDt3AZ6rxd1ekOxw1jkp/aohptqGjc4nijzRd
         J6aRNPM1HdeGjcBVxJQvUL6ryiucAgeDzP1Bun6BIuZd68AE3mIxTeaHdPxvLJ2DoyeT
         Pkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOK7eAgZJ3t7dQkZKNcxeqBq/iG/Skq4gZfTI03mDPM=;
        b=cozujuBNLqmmJkLDupGdmYZYUh1/4ioAbjWj5uSWkyrNx2NjTg7/KyB2vqVRHOHm/b
         FrjNYRa0Kwr5JKms/fsFhKMPvdAvqUQis1xOuzTLFwvUcJnpyyGLodCGuRS9V5GznKd2
         u1pSrfNw0u8wj45N9Kv8cry/Nq2v482hmS2Ymi+OKXWFHCYTvwJzvgDUeY9MraDpC9kG
         8JY2VG9TNF8hkLw9WHZYWUlQEh6OqypzTbmlhDKX26lti/WFWNpQDrzmAdRsdN13wfuY
         cubrQ2JyvHZkWia/zLjAGA3wBPRX7dTwWvGRG8xgEixfBkwk8VAkogvs8o+dtCQMsKqG
         SFig==
X-Gm-Message-State: AOAM531DhmRPgTb5mtsh9KpEpmVKLDENTkOggcf2AHtER7aOalMHdyN6
        Lg+ZS+63r5TY8DKQa17r/vCgWw==
X-Google-Smtp-Source: ABdhPJxswmfpAyOetAIYg885jgQlQudsWTetNor8KGf5GHaVE6siL0yymRtSfn2lOGY9/sOQY7g7mQ==
X-Received: by 2002:ac8:1a14:: with SMTP id v20mr9702060qtj.269.1595601491494;
        Fri, 24 Jul 2020 07:38:11 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d15sm132156qka.91.2020.07.24.07.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:38:10 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sm8250: add interconnect nodes
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-8-jonathan@marek.ca>
 <630319740d3f06cfb0435cae025e0ca1@codeaurora.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <2b77bdaf-0c9e-c054-77d1-3bc21e857773@marek.ca>
Date:   Fri, 24 Jul 2020 10:36:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <630319740d3f06cfb0435cae025e0ca1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 10:13 AM, Sibi Sankar wrote:
> Hey Jonathan,
> 
> Thanks for the patch! Please use the
> suggested register space definitions
> instead.
> 

Thanks for the suggestions, I was unsure what to use for the sizes. The 
reg field is unused by the upstream driver so it is hard to figure out.

However, I'm not sure about some of your suggestions for the base 
address. For example, for "mc_virt" you suggest 0x0163d000, and I have 
0x09100000. In the downstream dts, "mc_virt-base" is 0x9100000 and 
qcom,base-offset for fab_mc_virt is 0. Do you have an explanation for 
why your suggestion is so different?

> On 2020-07-13 21:11, Jonathan Marek wrote:
>> Add the interconnect dts nodes for sm8250.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 82 ++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 636e2196138c..dfc1b7fa7d85 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -11,6 +11,7 @@
>>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/interconnect/qcom,sm8250.h>
> 
> please fix ^^ sort order
> 
>>
>>  / {
>>      interrupt-parent = <&intc>;
>> @@ -978,6 +979,55 @@ spi13: spi@a94000 {
>>              };
>>          };
>>
>> +        config_noc: interconnect@1500000 {
>> +            compatible = "qcom,sm8250-config-noc";
>> +            reg = <0 0x01500000 0 0x1000>;
> 
> 0x01500000 0xa580
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        ipa_virt: interconnect@1620000 {
>> +            compatible = "qcom,sm8250-ipa-virt";
>> +            reg = <0 0x01620000 0 0x1000>;
> 
> 0x01e00000 0x1000
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        system_noc: interconnect@1632000 {
>> +            compatible = "qcom,sm8250-system-noc";
>> +            reg = <0 0x01632000 0 0x1000>;
> 
> 0x01620000 0x1C200
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        aggre1_noc: interconnect@16e2000 {
>> +            compatible = "qcom,sm8250-aggre1-noc";
>> +            reg = <0 0x016e2000 0 0x1000>;
> 
> 0x016e0000 0x1f180
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        aggre2_noc: interconnect@1703000 {
>> +            compatible = "qcom,sm8250-aggre2-noc";
>> +            reg = <0 0x01703000 0 0x1000>;
> 
> 0x01700000 0x33000
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        compute_noc: interconnect@1733000 {
>> +            compatible = "qcom,sm8250-compute-noc";
>> +            reg = <0 0x01733000 0 0x1000>;
> 
> 0x01733000 0xd180
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        mmss_noc: interconnect@174a000 {
>> +            compatible = "qcom,sm8250-mmss-noc";
>> +            reg = <0 0x0174a000 0 0x1000>;
> 
> 0x01740000 0x1f080
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>>          ufs_mem_hc: ufshc@1d84000 {
>>              compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
>>                       "jedec,ufs-2.0";
>> @@ -1364,6 +1414,34 @@ usb_2_ssphy: lane@88eb200 {
>>              };
>>          };
>>
>> +        dc_noc: interconnect@90c0000 {
>> +            compatible = "qcom,sm8250-dc-noc";
>> +            reg = <0 0x090c0000 0 0x1000>;
> 
> 0x090c0000 0x4200
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        mc_virt: interconnect@9100000 {
>> +            compatible = "qcom,sm8250-mc-virt";
>> +            reg = <0 0x09100000 0 0x1000>;
> 
> 0x0163d000 0x1000
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        gem_noc: interconnect@9121000 {
>> +            compatible = "qcom,sm8250-gem-noc";
>> +            reg = <0 0x09121000 0 0x1000>;
> 
> 0x09100000 0xb4000
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>> +        npu_noc: interconnect@9990000 {
>> +            compatible = "qcom,sm8250-npu-noc";
>> +            reg = <0 0x09990000 0 0x1000>;
> 
> 0x09990000 0x1600
> 
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +        };
>> +
>>          usb_1: usb@a6f8800 {
>>              compatible = "qcom,sm8250-dwc3", "qcom,dwc3";
>>              reg = <0 0x0a6f8800 0 0x400>;
>> @@ -2359,6 +2437,10 @@ rpmhpd_opp_turbo_l1: opp10 {
>>                      };
>>                  };
>>              };
>> +
>> +            apps_bcm_voter: bcm_voter {
>> +                compatible = "qcom,bcm-voter";
>> +            };
>>          };
>>      };
> 
