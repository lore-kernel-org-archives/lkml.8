Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1305C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9999920722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="LhQ1aRbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCUAZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:25:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16481 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgCUAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:25:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584750355; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RFDAvUQyVdRVN+shAEUn6F8OxkZUxxHr+I+3F0JOpSo=; b=LhQ1aRbj2H7zOnl7J2y3mOmpKpbGuOKnuTsoBS7rul3HMFDCfH95dLLlIvbW75npAPbscgC6
 LuAADDjvvvcqOElDiGd2Egth+pxV5A9E4oBUy3tesIDY9kO3ltIkA61ttcuTMjTEFpfpcZWX
 tingjd2VzFXuBIclGDk/G5QTmDs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e755f04.7f4e12ba9768-smtp-out-n05;
 Sat, 21 Mar 2020 00:25:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6420C43636; Sat, 21 Mar 2020 00:25:38 +0000 (UTC)
Received: from [10.110.28.154] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1F87C433D2;
        Sat, 21 Mar 2020 00:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1F87C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc: Add USB3 PIPE clock and GDSC for
 SM8150
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1584478412-7798-1-git-send-email-wcheng@codeaurora.org>
 <1584478412-7798-2-git-send-email-wcheng@codeaurora.org>
 <158474728076.125146.11401827374115414324@swboyd.mtv.corp.google.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <83787def-4ea5-d38d-d745-ea30a914a05f@codeaurora.org>
Date:   Fri, 20 Mar 2020 17:25:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158474728076.125146.11401827374115414324@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/2020 4:34 PM, Stephen Boyd wrote:
> Quoting Wesley Cheng (2020-03-17 13:53:31)
>> diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
>> index 90d60ef..3e1a918 100644
>> --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
>> +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
>> @@ -240,4 +240,8 @@
>>  #define GCC_USB30_SEC_BCR                                      27
>>  #define GCC_USB_PHY_CFG_AHB2PHY_BCR                            28
>>  
>> +/* GCC GDSCRs */
>> +#define USB30_PRIM_GDSC                     4
>> +#define USB30_SEC_GDSC                                         5
> 
> BTW, should we expect more GDSCs at 0,1,2,3 here? Why wasn't that done
> initially?
> 

Hi Stephen,

Yes, I assume there should be more GDSCs being introduced, and I have
notified Taniya (our GCC POC) to upload the rest of the GDSC changes.  I
decided to keep it with values 4 and 5 in order to be consistent with
previous chipsets, but if you feel we should shuffle these values, then
I am OK with that as well.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
