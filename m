Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9247206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MGLDxavF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHEDdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:33:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32873 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHEDdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:33:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596598390; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=yvOK0+u7lVBiPDKYRJ21zelCk8/i+fOYdyMyODCybYU=; b=MGLDxavFfF+n2n2LCgdaCEJlF0uW/ht7fBviH3PA/8wng2jgK1sZdsZtBbWn6T7oDJmGNskx
 5gw83+1ZeoHwcJBN4d+Qqu9rPDANhiUJZFZmAys6pHjzbxSzoLj1Dj1N1AXKXa6471CyMlsE
 yK2RhZgcExC3BKlA0p7SXD7wXdA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f2a287376a940cda858a3cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 Aug 2020 03:33:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7BFDAC433CA; Wed,  5 Aug 2020 03:33:06 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D703FC433C6;
        Wed,  5 Aug 2020 03:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D703FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v4 12/12] dt-bindings: sound: lpass-cpu: Move to yaml
 format
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-13-git-send-email-rohitkr@codeaurora.org>
 <20200723171629.GA547775@bogus>
 <d00456e3-00e1-e373-760c-8292d6e7dd1b@codeaurora.org>
 <CAL_Jsq+DwA8=iRfMgUGM+H5_CrRRb7xa7DFdAWFOCATR9+=+Rw@mail.gmail.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <60076588-f340-ddf0-c0a8-36a95e3cdbae@codeaurora.org>
Date:   Wed, 5 Aug 2020 09:02:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+DwA8=iRfMgUGM+H5_CrRRb7xa7DFdAWFOCATR9+=+Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/2020 11:52 PM, Rob Herring wrote:
> On Mon, Aug 3, 2020 at 2:28 AM Rohit Kumar <rohitkr@codeaurora.org> wrote:
>> Thanks Rob for reviewing
>>
>> On 7/23/2020 10:46 PM, Rob Herring wrote:
>>> On Wed, Jul 22, 2020 at 04:01:55PM +0530, Rohit kumar wrote:
>>>> Update lpass-cpu binding with yaml formats.
>>>>
>>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>>> ---
>>>>    .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 130 ---------------
>>>>    .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 185 +++++++++++++++++++++
>>>>    2 files changed, 185 insertions(+), 130 deletions(-)
>>>>    delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>>    create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>> deleted file mode 100644
>>>> index c21392e..00000000
>>>> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>> +++ /dev/null
>>>> @@ -1,130 +0,0 @@
>>>> -* Qualcomm Technologies LPASS CPU DAI
>>>> -
>>>> -This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
>>>> -
>>>> -Required properties:
>>>> -
>>>> -- compatible                : "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu" or
>>>> -                      "qcom,lpass-cpu-sc7180"
>>>> -- clocks            : Must contain an entry for each entry in clock-names.
>>>> -- clock-names               : A list which must include the following entries:
>>>> -                            * "ahbix-clk"
>>>> -                            * "mi2s-osr-clk"
>>>> -                            * "mi2s-bit-clk"
>>>> -                    : required clocks for "qcom,lpass-cpu-apq8016"
>>>> -                            * "ahbix-clk"
>>>> -                            * "mi2s-bit-clk0"
>>>> -                            * "mi2s-bit-clk1"
>>>> -                            * "mi2s-bit-clk2"
>>>> -                            * "mi2s-bit-clk3"
>>>> -                            * "pcnoc-mport-clk"
>>>> -                            * "pcnoc-sway-clk"
>>>> -                    : required clocks for "qcom,lpass-cpu-sc7180"
>>>> -                            * "audio-core"
>>>> -                            * "mclk0"
>>>> -                            * "mi2s-bit-clk0"
>>>> -                            * "mi2s-bit-clk1"
>>>> -                            * "pcnoc-sway-clk"
>>>> -                            * "pcnoc-mport-clk"
>>>> -
>>>> -- interrupts                : Must contain an entry for each entry in
>>>> -                      interrupt-names.
>>>> -- interrupt-names   : A list which must include the following entries:
>>>> -                            * "lpass-irq-lpaif"
>>>> -- pinctrl-N         : One property must exist for each entry in
>>>> -                      pinctrl-names.  See ../pinctrl/pinctrl-bindings.txt
>>>> -                      for details of the property values.
>>>> -- pinctrl-names             : Must contain a "default" entry.
>>>> -- reg                       : Must contain an address for each entry in reg-names.
>>>> -- reg-names         : A list which must include the following entries:
>>>> -                            * "lpass-lpaif"
>>>> -- #address-cells    : Must be 1
>>>> -- #size-cells               : Must be 0
>>>> -
>>>> -
>>>> -
>>>> -Optional properties:
>>>> -
>>>> -- qcom,adsp         : Phandle for the audio DSP node
>>>> -
>>>> -By default, the driver uses up to 4 MI2S SD lines, for a total of 8 channels.
>>>> -The SD lines to use can be configured by adding subnodes for each of the DAIs.
>>>> -
>>>> -Required properties for each DAI (represented by a subnode):
>>>> -- reg                       : Must be one of the DAI IDs
>>>> -                      (usually part of dt-bindings header)
>>>> -- qcom,playback-sd-lines: List of serial data lines to use for playback
>>>> -                      Each SD line should be represented by a number from 0-3.
>>>> -- qcom,capture-sd-lines     : List of serial data lines to use for capture
>>>> -                      Each SD line should be represented by a number from 0-3.
>>>> -
>>>> -Note that adding a subnode changes the default to "no lines configured",
>>>> -so both playback and capture lines should be configured when a subnode is added.
>>>> -
>>>> -Examples:
>>>> -1)
>>>> -
>>>> -lpass@28100000 {
>>>> -    compatible = "qcom,lpass-cpu";
>>>> -    clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
>>>> -    clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
>>>> -    interrupts = <0 85 1>;
>>>> -    interrupt-names = "lpass-irq-lpaif";
>>>> -    pinctrl-names = "default", "idle";
>>>> -    pinctrl-0 = <&mi2s_default>;
>>>> -    pinctrl-1 = <&mi2s_idle>;
>>>> -    reg = <0x28100000 0x10000>;
>>>> -    reg-names = "lpass-lpaif";
>>>> -    qcom,adsp = <&adsp>;
>>>> -
>>>> -    #address-cells = <1>;
>>>> -    #size-cells = <0>;
>>>> -
>>>> -    /* Optional to set different MI2S SD lines */
>>>> -    dai@3 {
>>>> -            reg = <MI2S_QUATERNARY>;
>>>> -            qcom,playback-sd-lines = <0 1>;
>>>> -    };
>>>> -};
>>>> -
>>>> -2)
>>>> -
>>>> -#include <dt-bindings/sound/sc7180-lpass.h>
>>>> -
>>>> -lpass_cpu: lpass {
>>>> -    compatible = "qcom,lpass-cpu-sc7180";
>>>> -
>>>> -    reg = <0 0x62F00000 0 0x29000>;
>>>> -
>>>> -    iommus = <&apps_smmu 0x1020 0>;
>>>> -
>>>> -    power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>>>> -    clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
>>>> -            <&lpasscorecc LPASS_AUDIO_CORE_CORE_CLK>,
>>>> -            <&lpasscorecc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
>>>> -            <&lpasscorecc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
>>>> -            <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
>>>> -            <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
>>>> -    clock-names = "pcnoc-sway-clk", "audio-core",
>>>> -                    "mclk0", "pcnoc-mport-clk",
>>>> -                    "mi2s-bit-clk0", "mi2s-bit-clk1";
>>>> -    interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
>>>> -    interrupt-names = "lpass-irq-lpaif";
>>>> -
>>>> -
>>>> -    #sound-dai-cells = <1>;
>>>> -
>>>> -    #address-cells = <1>;
>>>> -    #size-cells = <0>;
>>>> -
>>>> -    mi2s-primary@0 {
>>>> -            reg = <MI2S_PRIMARY>;
>>>> -            qcom,playback-sd-lines = <1>;
>>>> -            qcom,capture-sd-lines = <0>;
>>>> -    };
>>>> -
>>>> -    mi2s-secondary@1 {
>>>> -            reg = <MI2S_SECONDARY>;
>>>> -            qcom,playback-sd-lines = <0>;
>>>> -    };
>>>> -};
>>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>>>> new file mode 100644
>>>> index 00000000..03c598f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>>>> @@ -0,0 +1,185 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> If all the authors are QCom or Linaro please dual license.
>> Ok
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/sound/qcom,lpass-cpu.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm LPASS CPU dai driver bindings
>>>> +
>>>> +maintainers:
>>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> +  - Rohit kumar <rohitkr@codeaurora.org>
>>>> +
>>>> +description: |
>>>> +  Qualcomm SOC Low-Power Audio SubSystem (LPASS) that consist of MI2S interface
>>>> +  for audio data transfer on external codecs. LPASS cpu driver is a module to
>>>> +  configure Low-Power Audio Interface(LPAIF) core registers across different
>>>> +  IP versions.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - const: qcom,lpass-cpu
>>>> +        description: For IPQ806x
>>>> +
>>>> +      - const: qcom,apq8016-lpass-cpu
>>>> +        description: For APQ8016
>>>> +
>>>> +      - const: qcom,lpass-cpu-sc7180
>>>> +        description: For SC7180
>>> Use enum rather than oneOf+const
>> Sure
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description: LPAIF core registers
>>>> +
>>>> +  clocks:
>>>> +    minItems: 3
>>>> +    maxItems: 6
>>>> +
>>>> +  clock-names:
>>>> +    minItems: 3
>>>> +    maxItems: 6
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +    description: LPAIF DMA buffer interrupt
>>>> +
>>>> +  qcom,adsp:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: Phandle for the audio DSP node
>>>> +
>>>> +  iommus:
>>>> +    maxItems: 1
>>>> +    description: Phandle to apps_smmu node with sid mask
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  '#sound-dai-cells':
>>>> +    const: 1
>>>> +
>>>> +patternProperties:
>>>> +  "(^mi2s-[0-9a-f]$|mi2s)":
>>>> +    type: object
>>>> +    description: Required properties for each DAI
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +        description: Must be one of the DAI ID
>>>> +
>>>> +    required:
>>>> +      - reg
>>>> +
>>>> +
>>> Extra blank line.
>> Ok
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - interrupts
>>>> +  - '#sound-dai-cells'
>>> Add:
>>>
>>> additionalProperties: false
>> If I am adding this, I am getting below error:
>>
>> Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml:
>> lpass@62f00000: '#address-cells', '#size-cells' do not match any of the
>> regexes: '(^mi2s-[0-9a-f]$|mi2s)', 'pinctrl-[0-9]+'
>>
>>
>> I think  this is coming because we have not mentioned mi2s-primary@0 in
>> required fields.
>> The field name is variable based on the interface to which peripheral is
>> connected to.
>> It can be either of primary/secondary/tertiary/quaternary. Can you
>> please suggest how to
>> avoid this error?
> No, the error is because you didn't list '#address-cells' and
> '#size-cells' as properties.
Thanks Rob for the input. Posted v5 patches with the change.
>
> Rob

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

