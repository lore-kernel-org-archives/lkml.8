Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194CCC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6B22070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDZKxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:53:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgDZKxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:53:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED4C7AD71;
        Sun, 26 Apr 2020 10:53:34 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
To:     Matheus Castello <matheus@castello.eng.br>,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-2-matheus@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <c805072b-17ec-d02b-20ad-548a372341f9@suse.de>
Date:   Sun, 26 Apr 2020 12:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200320035104.26139-2-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.03.20 um 04:51 schrieb Matheus Castello:
> The Caninos Loucos Program develops Single Board Computers with an open
> structure. The Program wants to form a community of developers to use
> IoT technologies and disseminate the learning of embedded systems in
> Brazil.
> 
> It is an initiative of the Technological Integrated Systems Laboratory
> (LSI-TEC) with the support of Polytechnic School of the University of
> São Paulo (Poli-USP) and Jon "Maddog" Hall.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9e67944bec9c..16ee382dc6b2 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -165,6 +165,8 @@ patternProperties:
>       description: CALAO Systems SAS
>     "^calxeda,.*":
>       description: Calxeda
> +  "^caninos,.*":
> +    description: Caninos Loucos Program
>     "^capella,.*":
>       description: Capella Microsystems, Inc
>     "^cascoda,.*":

Reviewed-by: Andreas Färber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
