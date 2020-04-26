Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B1C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB8C206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDZLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:34706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgDZLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 000ABAB64;
        Sun, 26 Apr 2020 11:50:24 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: actions: Document Caninos Loucos
 Labrador
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-3-matheus@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <99c5fa14-cc2d-3692-fc6e-8e3fa77c5ab0@suse.de>
Date:   Sun, 26 Apr 2020 13:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200320035104.26139-3-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-actions

Am 20.03.20 um 04:51 schrieb Matheus Castello:
> Update the documentation to add the Caninos Loucos Labrador. Labrador
> project consists of a computer on module based on the Actions Semi S500
> processor and the Labrador base board.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>   Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> index ace3fdaa8396..1b131ceb884a 100644
> --- a/Documentation/devicetree/bindings/arm/actions.yaml
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -24,6 +24,11 @@ properties:
>                 - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
>             - const: lemaker,guitar
>             - const: actions,s500
> +      - items:
> +          - enum:
> +              - caninos,labrador-bb # Caninos Loucos Labrador Base Board
> +          - const: caninos,labrador
> +          - const: actions,s500
> 
>         # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
>         - items:

Now that you chose to stick with caninos rather than lsi prefix, the 
sort order compared to lemaker remains wrong.

Looking at https://caninosloucos.org/en/labrador-en/ there's a "CORE 
BOARD V2.0" and a "BASE BOARD M V1.0".

Assuming the v2 is not software-relevant, shouldn't the M be reflected 
in the compatible string? For example, "caninos,labrador-core" and 
"caninos,labrador-m"? You're free to use -bb-m of course, but no need to 
copy LeMaker -bb naming for your board. What does your PCB say?

Also note that other recent bindings have been using a description 
attribute - not sure whether we can apply that a) to the SoM and b) to 
the base board here. Please compare other in-tree bindings.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
