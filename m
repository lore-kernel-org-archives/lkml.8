Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F0420768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgF3I3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:29:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:39572 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgF3I3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:29:47 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jun 2020 17:29:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1E273180B3C;
        Tue, 30 Jun 2020 17:29:45 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 30 Jun 2020 17:29:45 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 8DADB40362;
        Tue, 30 Jun 2020 17:29:44 +0900 (JST)
Received: from [10.213.29.165] (unknown [10.213.29.165])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 23E46120415;
        Tue, 30 Jun 2020 17:29:44 +0900 (JST)
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add UniPhier AHCI PHY description
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1592534207-13550-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592534207-13550-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20200629215520.GA2998145@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <329e5fb4-7fad-3d67-a797-5f31cf7ab9d7@socionext.com>
Date:   Tue, 30 Jun 2020 17:29:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629215520.GA2998145@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2020/06/30 6:55, Rob Herring wrote:
> On Fri, 19 Jun 2020 11:36:46 +0900, Kunihiko Hayashi wrote:
>> Add DT bindings for PHY interface built into ahci controller implemented
>> in UniPhier SoCs.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml: properties:reset-names: [{'items': [{'const': 'link'}, {'const': 'phy'}]}] is not of type 'object', 'boolean'
> Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1347: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1312535
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

I made a mistake when creating the patch.
I've found where it is wrong, so fix it in v2.

Thank you,

---
Best Regards
Kunihiko Hayashi
