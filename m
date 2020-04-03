Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF1C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4032073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbgDCNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:00:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgDCNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:00:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id D2862297F04
Subject: Re: [PATCH 1/4] dt-bindings: phy: phy-rockchip-dphy-rx0: move
 rockchip dphy rx0 bindings out of staging
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        robh+dt@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        kernel@collabora.com, dafna.hirschfeld@collabora.com,
        mark.rutland@arm.com, karthik.poduval@gmail.com
References: <20200402000234.226466-1-helen.koike@collabora.com>
 <20200402000234.226466-2-helen.koike@collabora.com>
 <a86bfa69fef8eee428d7c89b1d4fe99728af2ab7.camel@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <be7f32a3-bd22-5a8e-6c2f-835bcb693d46@collabora.com>
Date:   Fri, 3 Apr 2020 10:00:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <a86bfa69fef8eee428d7c89b1d4fe99728af2ab7.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 1:17 PM, Ezequiel Garcia wrote:
> (+Kishon)
> 
> Hi Helen,
> 
> I was wondering if we couldn't also move the phy driver out of staging.

I think we can, let's move it.

Regards,
Helen

> 
> Thanks,
> Ezequiel
>  
> On Wed, 2020-04-01 at 21:02 -0300, Helen Koike wrote:
>> Move phy-rockchip-dphy-rx0 bindings to Documentation/devicetree/bindings/phy
>>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> ---
>>  .../devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml           | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  rename {drivers/staging/media/phy-rockchip-dphy-rx0/Documentation => Documentation}/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml (100%)
>>
>> diff --git a/drivers/staging/media/phy-rockchip-dphy-rx0/Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
>> b/Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
>> similarity index 100%
>> rename from drivers/staging/media/phy-rockchip-dphy-rx0/Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
>> rename to Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
> 
> 
> 
