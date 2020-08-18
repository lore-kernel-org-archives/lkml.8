Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD396C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A912053B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dLLXMFeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRDaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:30:52 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12239 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgHRDav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:30:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597721451; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=psmnIK96LVmzjgyxsy7KLyLKGPkuGV7CKjAoGhgNyVI=;
 b=dLLXMFeSrUrxNqhx2rbDuN+k8wts9EIhLgC9bgkw8yt6x3/hcr+kMG6ZQfxLcR+O4IcZHEYq
 ucRNJOcXbu16rH3Cef3i7Bi7bIcGWuumY+AJ5C1cgw0GNbeqGUWDCLYR4ZW5ijdOc0TSZ7YM
 eWLEUW+LE70Aqf2KHAi51Pkd4Bg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3b4b632b87d6604902d06a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 03:30:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EEEAC433CB; Tue, 18 Aug 2020 03:30:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B60EC433C6;
        Tue, 18 Aug 2020 03:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 20:30:41 -0700
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        robdclark@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org
Subject: Re: [PATCH v6] arm64: dts: qcom: sc7180: Add Display Port dt node
In-Reply-To: <159771027430.2423498.17739000479526174339@swboyd.mtv.corp.google.com>
References: <20200817225300.2209-1-tanmay@codeaurora.org>
 <159771027430.2423498.17739000479526174339@swboyd.mtv.corp.google.com>
Message-ID: <13f4d59cf655287632a281ab7538e5bd@codeaurora.org>
X-Sender: tanmay@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 17:24, Stephen Boyd wrote:
> Quoting Tanmay Shah (2020-08-17 15:53:00)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 31b9217bb5bf..bf2f2bb1aa79 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -2440,6 +2447,71 @@ dsi_phy: dsi-phy@ae94400 {
>> 
>>                                 status = "disabled";
>>                         };
>> +
>> +                       msm_dp: displayport-controller@ae90000 {
> 
> This should come before dsi-phy and dsi node. It should be sorted by 
> the
> address (0xae90000).
> 
>> +                               status = "disabled";
>> +                               compatible = "qcom,sc7180-dp";
>> +
>> +                               reg = <0 0x0ae90000 0 0x1400>;
>> +
>> +                               interrupt-parent = <&mdss>;
>> +                               interrupts = <12>;
>> +
> [...]
>>                 };
>> 
>>                 dispcc: clock-controller@af00000 {
>> @@ -2449,8 +2521,8 @@ dispcc: clock-controller@af00000 {
>>                                  <&gcc GCC_DISP_GPLL0_CLK_SRC>,
>>                                  <&dsi_phy 0>,
>>                                  <&dsi_phy 1>,
>> -                                <0>,
>> -                                <0>;
>> +                                <&msm_dp 0>,
>> +                                <&msm_dp 1>;
> 
> Don't think we should apply this still because the binding will change
> when the phy is split out to qmp node. Maybe just leave this part off
> for now?
Ok fine. But, that will break DP driver functionality.
