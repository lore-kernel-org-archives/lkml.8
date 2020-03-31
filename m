Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D64C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C2120838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691776;
	bh=I7g82WOn2+w62dXVYLDS5KJARvjoUM1nFMd8ENdLyAM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zWSRP9f4r6midYmM53g51HHsSt/ozbToGSff8WzIGRt6c19aSZWhmUnGl5liWYGs6
	 CSSKriq2DKsTi6H4UPF782UhA6FVLwVbTR8+tEaGf3D0Tj8XxW4Q6icgIMwwABtmEo
	 mV6FwaJlqPWq2A8m/NFUqBWHZ9YGN0JkQN8d2kL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgCaV4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgCaV4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:56:15 -0400
Received: from [192.168.1.31] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E505E2080C;
        Tue, 31 Mar 2020 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585691773;
        bh=I7g82WOn2+w62dXVYLDS5KJARvjoUM1nFMd8ENdLyAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rLVhJzgGct7D8QUiQUCK1fbc0Awb7iJWxjKn9+cY0GRUR9KYSdgx67iH8Mp1xJdKN
         T4NpYlYf+hIGlB5923i5gqpPxNFmXMRVmrcJbWMDCvgTX8RyW45oYyrKZQWfjuysgT
         9abL0Zllin7FiYYTuB+m4tiH1AIOhzVfs7KPVp6s=
Subject: Re: [PATCH 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, mark.rutland@arm.com
References: <20200320170212.21523-1-dinguyen@kernel.org>
 <20200320170212.21523-5-dinguyen@kernel.org> <20200331172356.GA17436@bogus>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1904132c-9211-6c23-028a-45788a55e420@kernel.org>
Date:   Tue, 31 Mar 2020 16:56:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331172356.GA17436@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/20 12:23 PM, Rob Herring wrote:
> On Fri, Mar 20, 2020 at 12:02:10PM -0500, Dinh Nguyen wrote:
>> Document the Agilex clock bindings, and add the clock header file. The
>> clock header is an enumeration of all the different clocks on the Agilex
>> platform.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v4: really fix build error(comment formatting was wrong)
>> v3: address comments from Stephen Boyd
>>     fix build error(tab removed in line 37)
>>     renamed to intel,agilex.yaml
>> v2: convert original document to YAML
>> ---
>>  .../bindings/clock/intel,agilex.yaml          | 36 ++++++++++
>>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
>>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/intel,agilex.yaml b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
>> new file mode 100644
>> index 000000000000..5cf2ee5d6fcc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings please:
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 

Okay...

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/intel,agilex.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel SoCFPGA Agilex platform clock controller binding
>> +
>> +maintainers:
>> +  - Dinh Nguyen <dinguyen@kernel.org>
>> +
>> +description:
>> +  The Intel Agilex Clock controller is an integrated clock controller, which
>> +  generates and supplies to all modules.
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,agilex-clkmgr
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#clock-cells'
> 
> Add:
> 
> additionalProperties: false
> 

Okay..

>> +
>> +examples:
>> +  # Clock controller node:
>> +  - |
>> +    clkmgr: clock-controller@ffd10000 {
>> +      compatible = "intel,agilex-clkmgr";
>> +      reg = <0xffd10000 0x1000>;
>> +      #clock-cells = <1>;
> 
> No clock inputs?
> 

The clock controller is fed the onboard OSC1. So yes, I'll update it.

Dinh
