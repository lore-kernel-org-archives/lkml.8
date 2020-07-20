Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F8F21702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJ/gl9Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGTX0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:26:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57030 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:26:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KNQQUp126401;
        Mon, 20 Jul 2020 18:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595287586;
        bh=wF6WhftYpfnYBX0J8FroMAAxX2oGr5JH/Sy0gngDAQE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HJ/gl9WpBPKLP2N3e10x4sgs4qC19hCsqP5TkyS1yPl4i1u+BCf50ROad0S0312O/
         JZ6aUKG+GeUx+tb+vaBoBG2heRPSQG6TkNlnq8Fb3DLxZHFbDNFGWNXtvBKJUeaOka
         E3GJOpmAo2Qu+nqNaqCF8m4O2/6WFGN/gsNvUzOc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06KNQQ6c046734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 18:26:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 18:26:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 18:26:26 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KNQQZX006261;
        Mon, 20 Jul 2020 18:26:26 -0500
Subject: Re: [PATCH v4 3/6] dt-bindings: remoteproc: Add common TI SCI rproc
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <20200717234800.9423-1-s-anna@ti.com>
 <20200717234800.9423-4-s-anna@ti.com> <20200720221718.GA2899451@bogus>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4968835e-2ba5-dcd8-93b9-c3e33aabb0a9@ti.com>
Date:   Mon, 20 Jul 2020 18:26:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720221718.GA2899451@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 5:17 PM, Rob Herring wrote:
> On Fri, 17 Jul 2020 18:47:57 -0500, Suman Anna wrote:
>> Add a bindings document that lists the common TI SCI properties
>> used by the K3 R5F and DSP remoteproc devices.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> v4: Addressed both of Rob's review comments on ti,sci-proc-ids property
>> v3: https://patchwork.kernel.org/patch/11602317/
>>
>>   .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Rob,

You seem to have added your Reviewed-by tag by mistake on this 
particular patch [1], that's why I actually dropped it.

I do use pwclient, so the tags do get picked up automatically for my 
newer versions.

regards
Suman

[1] https://patchwork.kernel.org/comment/23484127/
