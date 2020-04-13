Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC36C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D3320739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 00:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D3320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgDMARH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDMARH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 20:17:07 -0400
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4AC0A3BE0;
        Sun, 12 Apr 2020 17:17:07 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6812EAC12;
        Mon, 13 Apr 2020 00:17:05 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-2-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <bf55ccbe-cbdf-7ba7-d701-aa84c20204e3@suse.de>
Date:   Mon, 13 Apr 2020 02:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200204145207.28622-2-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 04.02.20 um 15:52 schrieb James Tai:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>   v2 -> v3: Unchanged
> 
>   v1 -> v2:
>   * Put string in alphabetical order
> 
>   Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
> index 845f9c76d6f7..3b48ae71fdd8 100644
> --- a/Documentation/devicetree/bindings/arm/realtek.yaml
> +++ b/Documentation/devicetree/bindings/arm/realtek.yaml
> @@ -42,6 +42,12 @@ properties:
>                 - synology,ds418 # Synology DiskStation DS418
>             - const: realtek,rtd1296
>   
> +      # RTD1319 SoC based boards
> +      - items:
> +          - enum:
> +              - realtek,pymparticle # Realtek PymParticle EVB

The board seems labelled "PYM_PARTICLES".

While Wikipedia has nothing on that, I found this explanation:
https://marvel.fandom.com/wiki/Pym_Particles

So, are you sure it's PymParticle and not "Pym Particle" with space or 
"Pym Particles" with space and plural S? The S would affect also the 
.dts filename. For the compatible string the question is pymparticle or 
pym-particle.

By comparison, LION-SKIN was named lion-skin in the compatible and 
spelled Lion Skin in textual form. If you believe that should be fixed, 
now would be the time to revisit those patches that didn't make v5.7.

Thanks,
Andreas

> +          - const: realtek,rtd1319
> +
>         # RTD1395 SoC based boards
>         - items:
>             - enum:

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
