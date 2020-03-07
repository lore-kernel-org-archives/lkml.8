Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B273DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF8206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCGMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 07:34:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:38562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGMeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 07:34:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E2AFADD7;
        Sat,  7 Mar 2020 12:34:13 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200229104358.GB19610@mani>
 <20200307002453.350430-1-matheus@castello.eng.br>
 <20200307002453.350430-2-matheus@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <62e115af-9d8c-572a-a400-91bdef9d9292@suse.de>
Date:   Sat, 7 Mar 2020 13:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307002453.350430-2-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

Am 07.03.20 um 01:24 schrieb Matheus Castello:
> The Caninos Loucos Program develops Single Board Computers with an open
> structure. The Program wants to form a community of developers to use
> the IoT technology and disseminate the learning of embedded systems in

I would suggest "IoT technologies" without "the".

> Brazil.
> 
> The boards are designed and manufactured by LSI-TEC NPO.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9e67944bec9c..3e974dd563cf 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -167,6 +167,8 @@ patternProperties:
>       description: Calxeda
>     "^capella,.*":
>       description: Capella Microsystems, Inc
> +  "^caninos,.*":
> +    description: Caninos Loucos LSI-TEC NPO

Alphabetical order: n goes before p.

I'm confused by the description... Either this Caninos Loucos is an 
independent vendor and gets its own prefix, or it's LSI-Tec and uses 
something like lsi-tec,caninosloucos-foo. Please clarify commit message 
and/or description line, at least by inserting something like "program 
by", "brand by" or the like rather than just concatenating names. Maybe 
compare UDOO by SECO. Is caninos,foo unique enough or should it be 
caninosloucos,foo? (crazy canines?)

Note that I usually attempt to CC the organizations I'm assigning a 
vendor prefix for. Do you represent them or coordinated with them?

Regards,
Andreas

>     "^cascoda,.*":
>       description: Cascoda, Ltd.
>     "^catalyst,.*":

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
