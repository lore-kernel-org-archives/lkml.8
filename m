Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38963 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:47:26 -0400
Subject: Re: [PATCH v2 00/12] dt-bindings: arm: bcm: Convert boards to YAML
To: Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
        <linux-rpi-kernel@lists.infradead.org>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
 <20200206192437.GB30325@bogus>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ba965c62-164c-673a-7260-c330242e0b92@gmail.com>
Date: Tue, 10 Mar 2020 12:47:11 -0700
MIME-Version: 1.0
In-Reply-To: <20200206192437.GB30325@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200310194711.L3v9aoU0ATrTnMon31x0IlK1OserGvHkZ6DV80T3NQs@z>

On 2/6/20 11:24 AM, Rob Herring wrote:
> On Tue, Feb 04, 2020 at 03:55:40PM -0800, Florian Fainelli wrote:
>> Hi Rob, Maxime,
>>
>> This patch series converts most files under D/dt-bindings/arm/bcm/ with
>> the exception of bcm63138 and brcmstb to the YAML format. Those two may
>> be split accordingly later on since document not just the root node.
>>
>> Changes in v2:
>>
>> - fixed typo in Vulcan binding
>> - simplified how SoC compatible strings are specified
>> - fixed filename in bcm2835 firmware binding
>> - added 'secondary-boot-reg' constraint
>>
>>
>> Florian Fainelli (12):
>>   dt-bindings: arm: bcm: Convert Cygnus to YAML
>>   dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
>>   dt-bindings: arm: bcm: Convert Northstar Plus to YAML
>>   dt-bindings: arm: bcm: Convert Northstar 2 to YAML
>>   dt-bindings: arm: bcm: Convert Stingray to YAML
>>   dt-bindings: arm: bcm: Convert BCM21664 to YAML
>>   dt-bindings: arm: bcm: Convert BCM23550 to YAML
>>   dt-bindings: arm: bcm: Convert BCM4708 to YAML
>>   dt-bindings: arm: bcm: Convert BCM11351 to YAML
>>   dt-bindings: arm: bcm: Convert Vulcan to YAML
>>   dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'
> 
> For all the above,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied 1-11 to devicetree/next, I will resubmit the last one later this
week.
-- 
Florian

