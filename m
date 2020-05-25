Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740ABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E3020787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbgEYKl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:41:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYKl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:41:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45BB8AF0B;
        Mon, 25 May 2020 10:41:58 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: actions: Document Caninos Loucos
 Labrador
To:     Matheus Castello <matheus@castello.eng.br>,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20200525013008.108750-1-matheus@castello.eng.br>
 <20200525013008.108750-3-matheus@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <8fc7b0d0-6516-ecd4-ce9c-a63a3cba7e9a@suse.de>
Date:   Mon, 25 May 2020 12:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525013008.108750-3-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 25.05.20 um 03:30 schrieb Matheus Castello:
> Update the documentation to add the Caninos Loucos Labrador. Labrador
> project consists of a computer on module based on the Actions Semi S500
> processor and the Labrador base board.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> index ace3fdaa8396..2187e1c5bc73 100644
> --- a/Documentation/devicetree/bindings/arm/actions.yaml
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -19,6 +19,11 @@ properties:
>                 - allo,sparky # Allo.com Sparky
>                 - cubietech,cubieboard6 # Cubietech CubieBoard6
>             - const: actions,s500
> +      - items:
> +          - enum:
> +              - caninos,labrador-v2 # Labrador Core v2
> +              - caninos,labrador-base-m # Labrador Base Board M v1

This enum still strikes me as wrong, it means either-or. (Was planning 
to look into it myself, but no time yet...) caninos,labrador-v2 should 
be a const one level down: board, SoM, SoC from most specific to most 
generic. Compare Guitar below.

> +          - const: actions,s500
>         - items:
>             - enum:
>                 - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
