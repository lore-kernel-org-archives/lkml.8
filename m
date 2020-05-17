Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C3C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783B4206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ajVUsohL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEQKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 06:30:21 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31093 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727869AbgEQKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 06:30:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589711420; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6PIuSsNbD8hw04pw8fracZRJByhUaKvyReaG3Vjdcqc=;
 b=ajVUsohLnMDOZlUjfRu+91FVyu+ZQOoBVvi3PPIS85/Cz4Mcng4BzJJCfO2yq7nFRde3GAyp
 mobIJym1TJ27q3MaTkLZsh91CGgOywP8kPEA++IVccTpdUGivib5hrOlKohTlpeigAKM/tSw
 pbD7e4mjOHMak/NFcyK0yO+MSFs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec1122f.7fa1bcbcdd88-smtp-out-n05;
 Sun, 17 May 2020 10:30:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA525C432C2; Sun, 17 May 2020 10:30:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E705C433D2;
        Sun, 17 May 2020 10:30:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 May 2020 16:00:06 +0530
From:   manafm@codeaurora.org
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt
 support in yaml
In-Reply-To: <CAP245DX2=bY4kCERgnm_L26o9mY7CoOZRScXmXwfe-bAYczOnQ@mail.gmail.com>
References: <20200505111204.963-1-manafm@codeaurora.org>
 <20200505111204.963-3-manafm@codeaurora.org>
 <CAP245DX2=bY4kCERgnm_L26o9mY7CoOZRScXmXwfe-bAYczOnQ@mail.gmail.com>
Message-ID: <b73b01f67b65402f81ee20ef2844c675@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-05 17:41, Amit Kucheria wrote:
> On Tue, May 5, 2020 at 4:43 PM Manaf Meethalavalappu Pallikunhi
> <manafm@codeaurora.org> wrote:
>> 
>> Add 0C (zeroc) interrupt support for tsens in yaml.
>> 
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <manafm@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml 
>> b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 2ddd39d96766..8a0893f77d20 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -52,12 +52,14 @@ properties:
>>      items:
>>        - description: Combined interrupt if upper or lower threshold 
>> crossed
>>        - description: Interrupt if critical threshold crossed
>> +      - description: Interrupt if zeroC threshold is crossed
>> 
>>    interrupt-names:
>>      minItems: 1
>>      items:
>>        - const: uplow
>>        - const: critical
>> +      - const: zeroc
>> 
>>    nvmem-cells:
>>      minItems: 1
>> @@ -168,8 +170,9 @@ examples:
>>                   <0xc222000 0x1ff>;
>> 
>>             interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
>> -                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
>> -           interrupt-names = "uplow", "critical";
>> +                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <GIC_SPI 510 IRQ_TYPE_EDGE_RISING>;
>> +           interrupt-names = "uplow", "critical", "zeroc";
> 
> 
> Add a new example for v2 with 0C interrupt here instead of reusing the 
> old one.
Done
> 
>>             #qcom,sensors = <13>;
>>             #thermal-sensor-cells = <1>;
>> --
>> 2.26.2
