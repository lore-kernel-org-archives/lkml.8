Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F664C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0662620768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405290AbgDOJVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:21:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895288AbgDOJTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:19:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19217ADCC;
        Wed, 15 Apr 2020 09:19:38 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
To:     =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-2-james.tai@realtek.com>
 <bf55ccbe-cbdf-7ba7-d701-aa84c20204e3@suse.de>
 <a9685d4560a6445d81c4919b2a323f68@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <cb724434-bebf-2a23-fd90-8cd82078459d@suse.de>
Date:   Wed, 15 Apr 2020 11:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a9685d4560a6445d81c4919b2a323f68@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 15.04.20 um 10:58 schrieb James Tai [戴志峰]:
>>> diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml
>>> b/Documentation/devicetree/bindings/arm/realtek.yaml
>>> index 845f9c76d6f7..3b48ae71fdd8 100644
>>> --- a/Documentation/devicetree/bindings/arm/realtek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/realtek.yaml
>>> @@ -42,6 +42,12 @@ properties:
>>>                  - synology,ds418 # Synology DiskStation DS418
>>>              - const: realtek,rtd1296
>>>
>>> +      # RTD1319 SoC based boards
>>> +      - items:
>>> +          - enum:
>>> +              - realtek,pymparticle # Realtek PymParticle EVB
>>
>> The board seems labelled "PYM_PARTICLES".
>>
>> While Wikipedia has nothing on that, I found this explanation:
>> https://marvel.fandom.com/wiki/Pym_Particles
>>
>> So, are you sure it's PymParticle and not "Pym Particle" with space or "Pym
>> Particles" with space and plural S? The S would affect also the .dts filename.
>>
> I should change the string to "Pym Particles".

Okay, in that case I suggest rtd1319-pymparticles.dts for consistency. 
Unless you want to change rtd1395-lionskin.dts to rtd1395-lion-skin.dts.

>> For the compatible string the question is pymparticle or pym-particle.
>>
> The compatible string is "pym-particles".

Works for me. (always assuming we both imply the "realtek," prefix)

If you send a v4, please double-check the comments in patch 2/2.

>> By comparison, LION-SKIN was named lion-skin in the compatible and spelled
>> Lion Skin in textual form. If you believe that should be fixed, now would be the
>> time to revisit those patches that didn't make v5.7.
>>
> I'll check those relevant patches.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
