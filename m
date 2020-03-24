Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B100EC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626420714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BW1dTaZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCXFQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:16:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:28303 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgCXFQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:16:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585027014; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HJVvgeexErEjlhM7G8ecIrzeSjkVY0caLFRfY64utGo=; b=BW1dTaZpQf8cScHMgUPBasZzIV1KShv3qVM+bqAAPCv3lx9G4LnnTelkyUwLEYQAlJDYqJ23
 meUHTHzPXPpXkfmx1bMFpwZ5fIMOJifqzUTSM+dh6T2l+ShVogZb73l5E/bTPfBrcRRpLl1r
 M4AVoxYQNU7S2BUuN6ISFzIOrWs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7997bf.7ff25d1ba928-smtp-out-n01;
 Tue, 24 Mar 2020 05:16:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84445C43636; Tue, 24 Mar 2020 05:16:47 +0000 (UTC)
Received: from [192.168.0.13] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A65DAC433D2;
        Tue, 24 Mar 2020 05:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A65DAC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V5 3/3] dt-bindings: geni-se: Add binding for UART pin
 swap
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>, rojay@codeaurora.org,
        c_skakit@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>
References: <1584095350-841-1-git-send-email-akashast@codeaurora.org>
 <1584095350-841-4-git-send-email-akashast@codeaurora.org>
 <CAL_JsqKLoiPUhiJDuYX+bSQwoCLTXOvtNyEB8ti__xMfEDyxNQ@mail.gmail.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <ee34573a-e4ff-ad43-64ed-53439206d534@codeaurora.org>
Date:   Tue, 24 Mar 2020 10:46:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKLoiPUhiJDuYX+bSQwoCLTXOvtNyEB8ti__xMfEDyxNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/20/2020 11:37 PM, Rob Herring wrote:
> On Fri, Mar 13, 2020 at 4:29 AM Akash Asthana <akashast@codeaurora.org> wrote:
>> Add documentation to support RX/TX/CTS/RTS pin swap in HW.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>> Changes in V5:
>>   -  As per Matthias's comment, remove rx-tx-cts-rts-swap property from UART
>>      child node.
>>
>>   Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
> STM32 folks need something similar. Can you move this to a common
> location. That's serial.txt, but that is being converted to DT schema.
>
> Rob

Okay, once serial.txt is converted to DT schema, I will move it there.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
