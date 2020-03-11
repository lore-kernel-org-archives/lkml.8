Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC70C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D641920739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFnMjB8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgCKTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:02:34 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51446 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgCKTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:02:33 -0400
Received: by mail-pj1-f67.google.com with SMTP id y7so1418181pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KxbfSfMud1yoniFNSNDPHjvEdr8IQY+/lA6j8KGqYkE=;
        b=rFnMjB8O/yaXQWJTv31iPzLHmOkngTSkvsoCyQZDh9v9zGj3e/5juupSZZeBSzcy6X
         MeM2WQ1rQkbQmBnPdApv3lpAR3r6bgV+dwkiV+4hZnEQX+DmLYbOpcn3Lu2vhSnOm3Yv
         Bvms2t5ZxOgdFRDWvhlEU65pRwEQQnvVbjfRpGOZ9E4oaL4enK35RIdiopafaF2tX+CY
         hNAdcSl4kkimfAt8+xN5HKs1D8ae39ZVcO+FFIwZqhS93hFWLSbvEhoAHQX/jhjECYfe
         x7wHNQmdES0rdYb3vqYbn+GbfaaMv1tHGBb+S/QAcnLo0BkbMfAoMnN8HcSPp69KXM2k
         n74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KxbfSfMud1yoniFNSNDPHjvEdr8IQY+/lA6j8KGqYkE=;
        b=CQ0JvV/fWnZHqSkZ9GAf6xuM9x0NSlhVhvnt/nNss9ua4lRvCMXIh81BmFUAnULCzK
         rtz2Uep641eJ6YNjb069iS50+FVJydv6bxHAmrLBnKMePcy3ibbpbMW034MAmdO8HD1v
         TBf8iQFcliua3MMXNdZFta57J/itJRhMj6CZzHb01NidJRm3thJX6PiYLr5E1E/X2QqU
         k4XHcnczKas6kA/dXl7phoWucakRm8jaUsw2fcLcf60UPDm9aUI2IkHSoJYBxjLbMgPp
         fiS9TpFKic8I+xwXjcLPf6zAUypFWZMe7cjkqi8O4krFjQl7KZDq+oMsPqPrAUr5Crg1
         qS1Q==
X-Gm-Message-State: ANhLgQ2LuHaLe+Qmu8BjNJZe6GtYBpVyusvjB3PqiZIhsx0YnAxY+D8F
        xdW4wh2KvemnPErl7JTbkUD0ig==
X-Google-Smtp-Source: ADFU+vsgLQojMXRBdCCbQnephx0OvnBV71tIYUrd48OJ59EPglDf+HLuvIU4CMAcvoCh1tbzjD92xA==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr184860pjq.126.1583953350369;
        Wed, 11 Mar 2020 12:02:30 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i72sm24039102pgd.88.2020.03.11.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:02:29 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:02:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Miller <davem@davemloft.net>, Alex Elder <elder@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Andy Gross <agross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dcbw@redhat.com>,
        Evan Green <evgreen@google.com>,
        Eric Caruso <ejcaruso@google.com>,
        Susheel Yadav Yadagiri <syadagir@codeaurora.org>,
        Chaitanya Pratapa <cpratapa@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/17] arm64: dts: sdm845: add IPA information
Message-ID: <20200311190226.GY1214176@minitux>
References: <20200306042831.17827-1-elder@linaro.org>
 <20200306042831.17827-18-elder@linaro.org>
 <ec9776b3-ac79-8f9d-8c4d-012d62dc8f72@nvidia.com>
 <4decbc8a-b0a6-8f10-b439-ade9008a4cff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4decbc8a-b0a6-8f10-b439-ade9008a4cff@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Mar 07:39 PDT 2020, Alex Elder wrote:

> On 3/11/20 5:49 AM, Jon Hunter wrote:
> > 
> > On 06/03/2020 04:28, Alex Elder wrote:
> >> Add IPA-related nodes and definitions to "sdm845.dtsi".
> >>
> >> Signed-off-by: Alex Elder <elder@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ++++++++++++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> index d42302b8889b..58fd1c611849 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> @@ -675,6 +675,17 @@
> >>  			interrupt-controller;
> >>  			#interrupt-cells = <2>;
> >>  		};
> >> +
> >> +		ipa_smp2p_out: ipa-ap-to-modem {
> >> +			qcom,entry-name = "ipa";
> >> +			#qcom,smem-state-cells = <1>;
> >> +		};
> >> +
> >> +		ipa_smp2p_in: ipa-modem-to-ap {
> >> +			qcom,entry-name = "ipa";
> >> +			interrupt-controller;
> >> +			#interrupt-cells = <2>;
> >> +		};
> >>  	};
> >>  
> >>  	smp2p-slpi {
> >> @@ -1435,6 +1446,46 @@
> >>  			};
> >>  		};
> >>  
> >> +		ipa@1e40000 {
> >> +			compatible = "qcom,sdm845-ipa";
> >> +
> >> +			modem-init;
> >> +			modem-remoteproc = <&mss_pil>;
> >> +
> >> +			reg = <0 0x1e40000 0 0x7000>,
> >> +			      <0 0x1e47000 0 0x2000>,
> >> +			      <0 0x1e04000 0 0x2c000>;
> >> +			reg-names = "ipa-reg",
> >> +				    "ipa-shared",
> >> +				    "gsi";
> >> +
> >> +			interrupts-extended =
> >> +					<&intc 0 311 IRQ_TYPE_EDGE_RISING>,
> >> +					<&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
> >> +					<&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> >> +					<&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> >> +			interrupt-names = "ipa",
> >> +					  "gsi",
> >> +					  "ipa-clock-query",
> >> +					  "ipa-setup-ready";
> >> +
> >> +			clocks = <&rpmhcc RPMH_IPA_CLK>;
> >> +			clock-names = "core";
> >> +
> >> +			interconnects =
> >> +				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_EBI1>,
> >> +				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_IMEM>,
> >> +				<&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_IPA_CFG>;
> >> +			interconnect-names = "memory",
> >> +					     "imem",
> >> +					     "config";
> >> +
> >> +			qcom,smem-states = <&ipa_smp2p_out 0>,
> >> +					   <&ipa_smp2p_out 1>;
> >> +			qcom,smem-state-names = "ipa-clock-enabled-valid",
> >> +						"ipa-clock-enabled";
> >> +		};
> >> +
> >>  		tcsr_mutex_regs: syscon@1f40000 {
> >>  			compatible = "syscon";
> >>  			reg = <0 0x01f40000 0 0x40000>;
> >>
> > 
> > 
> > This change is causing the following build error on today's -next ...
> > 
> >  DTC     arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi:1710.15-1748.5: ERROR (phandle_references): /soc@0/ipa@1e40000: Reference to non-existent node or label "rsc_hlos"
> 
> This problem arises because a commit in the Qualcomm SoC tree affects
> "arch/arm64/boot/dts/qcom/sdm845.dtsi", changing the interconnect provider
> node(s) used by IPA:
>   b303f9f0050b arm64: dts: sdm845: Redefine interconnect provider DT nodes
> 
> I will send out a patch today that updates the IPA node in "sdm845.dtsi"
> to correct that.
> 
> In the mean time, David, perhaps you should revert this change in net-next:
>   9cc5ae125f0e arm64: dts: sdm845: add IPA information
> and let me work out fixing "sdm845.dtsi" with Andy and Bjorn in the
> Qualcomm tree.
> 

Reverting this in net-next and applying it in our tree sounds like the
easiest path forward, and avoids further conflicts down the road.

David, are you onboard with this?

Regards,
Bjorn
