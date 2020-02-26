Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB7FC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F9524688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BC9afpeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBZLR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:17:28 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:32938 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbgBZLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:17:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582715846; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=JeLBIZJhvP42B2sTx6JhqGirHZU0I0l6TtJa1fPw4Ic=; b=BC9afpeSdEfzfHR5GIeu0WYfP25RDUaPur6RMLpTldFAzewxDNE6RO5PCSNnmIt4c6Kx7ZRB
 4/VY74dI5+uOL4Xb7axwYW9wSTGZbU/zzlIbwV+VvI8Ikc4VfkX4j6ok5qdCOmZx1U3oIjA1
 p1shlMgSsA2Sr9S7ihl8HWbEa6I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5653bb.7f8d2db86ca8-smtp-out-n02;
 Wed, 26 Feb 2020 11:17:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1618EC447A2; Wed, 26 Feb 2020 11:17:14 +0000 (UTC)
Received: from [10.204.67.17] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C585C43383;
        Wed, 26 Feb 2020 11:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C585C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: update the list of clocks
To:     Rob Herring <robh@kernel.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mka@chromium.org, dri-devel@freedesktop.org
References: <1582186342-3484-1-git-send-email-smasetty@codeaurora.org>
 <1582186342-3484-2-git-send-email-smasetty@codeaurora.org>
 <20200220203509.GA14697@bogus>
From:   Sharat Masetty <smasetty@codeaurora.org>
Message-ID: <6a7c1f39-a85f-4a99-fed3-71001bdb6128@codeaurora.org>
Date:   Wed, 26 Feb 2020 16:47:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220203509.GA14697@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/2020 2:05 AM, Rob Herring wrote:
> On Thu, 20 Feb 2020 13:42:22 +0530, Sharat Masetty wrote:
>> This patch adds a clock definition needed for powering on the GPU TBUs
>> and the GPU TCU.
>>
>> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu.example.dt.yaml: iommu@d00000: clock-names: ['bus', 'iface'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu.example.dt.yaml: iommu@d00000: clocks: [[4294967295, 123], [4294967295, 124]] is too short
>
> See https://patchwork.ozlabs.org/patch/1241297
> Please check and re-submit.
Hi Rob, These issues seem to be from the original code and not related 
to my patch. Are these going to be blocking errors?
