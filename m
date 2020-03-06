Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE51C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B042073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MFXsn+T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgCFGXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:23:18 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:54639 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgCFGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:23:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583475796; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=7+QmfuGc+bFF4cv41VQssSd9JveANSp9NopTrz1WeWc=;
 b=MFXsn+T2sP8ktxmSJ3k/a8VVeqs93F+Yj3eca7ICYtZlv0HZP2X6FDpLKWj9PzcnNLcbK9dX
 0+zVrHsuE4pjLgozb9qVMnFnzqP+XqR711n7E8u+799H+U6Y/PqwHekgtMVzCBEHkix2EKlm
 H7XlyjNUHlgtXa94VaGz8gMCMVQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61ec4b.7f80aa680110-smtp-out-n04;
 Fri, 06 Mar 2020 06:23:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A684C4479C; Fri,  6 Mar 2020 06:23:06 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8FD7C43383;
        Fri,  6 Mar 2020 06:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8FD7C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Introduce soc sleep stats bindings
 for Qualcomm SoCs
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org
References: <1582274986-17490-1-git-send-email-mkshah@codeaurora.org>
 <1582274986-17490-2-git-send-email-mkshah@codeaurora.org>
 <158290845710.4688.3557819013834887314@swboyd.mtv.corp.google.com>
Message-ID: <b2ec702c-67e9-2473-a5d4-1bb53d9907cd@codeaurora.org>
Date:   Fri, 6 Mar 2020 11:52:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158290845710.4688.3557819013834887314@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2020 10:17 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2020-02-21 00:49:43)
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
>> new file mode 100644
>> index 00000000..50352a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bindings/soc/qcom/soc-sleep-stats.yaml#
> Drop 'bindings' from above?
Done.
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
>> +
>> +maintainers:
>> +  - Maulik Shah <mkshah@codeaurora.org>
>> +  - Lina Iyer <ilina@codeaurora.org>
>> +
>> +description: |
>> +  Always On Processor/Resource Power Manager maintains statistics of the SoC
>> +  sleep modes involving powering down of the rails and oscillator clock.
>> +
>> +  Statistics includes SoC sleep mode type, number of times low power mode were
>> +  entered, time of last entry, time of last exit and accumulated sleep duration.
>> +  SoC sleep stats driver provides debugfs interface to show this information.
> Please remove this last line. It is a Linuxism that doesn't belong in DT
> bindings. And then make it one paragraph and drop the | because
> formatting doesn't need to be maintained.
Done.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,rpmh-sleep-stats
>> +      - qcom,rpm-sleep-stats
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  # Example of rpmh sleep stats
>> +  - |
>> +    rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
>> +      compatible = "qcom,rpmh-sleep-stats";
>> +      reg = <0 0xc3f0000 0 0x400>;
>> +    };
> I see that on sc7180 aoss-qmp is overlapping with this region.
>
>
> 	aoss_qmp: qmp@c300000 {
> 		compatible = "qcom,sc7180-aoss-qmp";
> 		reg = <0 0x0c300000 0 0x100000>;
>
> So is this register region really something more like a TCM or RAM area
> where rpmh combines multiple software concepts into one hardware memory
> region? The aoss-qmp driver talks about message RAM, so I think this
> sleep stats stuff is a carveout of the RPMh message RAM. It seems OK if
> we want to split that message RAM up into multiple DT nodes, but then
> we'll need to reduce the reg size for the aoss-qmp node.
Yes, i discussed this long back with bjorn, we will limit aoss_qmp size to 0x400.
Will include in next revision in DTSI change.
> Finally, the node name 'soc-sleep-stats' is generic, but I wonder why we
> couldn't name the node 'tcm' or 'memory' or 'msgram'. Similarly for the
> qmp node it fits better DT style to have the node be something generic.
following DTSI change in this series has comment to drop the label, since no one
references this node. if we drop label than just naming it msgram@c3f0000 will also
be too generic IMO.

To address both the comments i am planning to drop label and also soc-sleep-stats
and just keep rpmh_sleep_stats@c3f0000.

Thanks,
Maulik

>> +  # Example of rpm sleep stats
>> +  - |
>> +    rpm_sleep_stats: soc-sleep-stats@4690000 {
>> +      compatible = "qcom,rpm-sleep-stats";
>> +      reg = <0 0x04690000 0 0x400>;
>> +    };
>> +...

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
