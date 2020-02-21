Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E578C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753AC20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RitZVUUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBUHdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:33:50 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:11089 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgBUHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:33:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582270429; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=d4VE87C/C9dUcBVYFX5ltQjt9xhMzllUxIW7lmp48ls=;
 b=RitZVUUgHnc35VpGkCEi7mVCUpp2jVCa75Ho1qyQWciu+NI1f2AgTZstQcgf/YIHzAbCbwzc
 6hjG3YELn0jab0yYK4wTAD2ew1G2G5KoD+5RVuNuWqUEJIdW4aZwankpPoBQOMM8tJVGLKOy
 /eMEjlJ8fpyFLf/PurVLu/wXZ04=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f87d4.7fafa2534148-smtp-out-n01;
 Fri, 21 Feb 2020 07:33:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC408C4479C; Fri, 21 Feb 2020 07:33:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10BD1C43383;
        Fri, 21 Feb 2020 07:33:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 13:03:39 +0530
From:   okukatla@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V2, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
In-Reply-To: <20200104220142.GA28701@bogus>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
 <20200104220142.GA28701@bogus>
Message-ID: <76ae2a4d67fe26ec67b41c4726594f84@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-05 03:31, Rob Herring wrote:
> On Tue, Dec 31, 2019 at 02:28:55PM +0530, Odelu Kukatla wrote:
>> The Qualcomm SC7180 platform has several bus fabrics that could be
>> controlled and tuned dynamically according to the bandwidth demand.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
>>  .../bindings/interconnect/qcom,sc7180.yaml         | 155 
>> ++++++++++++++++++++
>>  include/dt-bindings/interconnect/qcom,sc7180.h     | 161 
>> +++++++++++++++++++++
>>  3 files changed, 317 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml 
>> b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> index 74f0715..55c9f34 100644
>> --- 
>> a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> @@ -19,6 +19,7 @@ description: |
>>  properties:
>>    compatible:
>>      enum:
>> +      - qcom,sc7180-bcm-voter
>>        - qcom,sdm845-bcm-voter
>> 
>>  required:
>> diff --git 
>> a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml 
>> b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>> new file mode 100644
>> index 0000000..487da5e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>> @@ -0,0 +1,155 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings:
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 
Thanks Rob!
I will update it.
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
