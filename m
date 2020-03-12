Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B538C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D924F206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584047467;
	bh=IAMG84HZpyw2tpXzi5VZejrQM+Rn7EB22igvc2R8fME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RNrWOiMYUKOXaw5XHz+J1PCEsU4Z3LBH73gIseKjRREA8ApDtHuqakPKX6vmNtgc4
	 E3S4toFduPPDjpaeaQUSWojd29uqF5oW4NDEOH0ZXiWqgsb1OqMDLzY5IMYRXM+sqA
	 7fURwvmeSquMMjxpDm3NB+ITlsAowcuMCpv4FgGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCLVLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:11:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33709 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgCLVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:11:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id r7so7093192oij.0;
        Thu, 12 Mar 2020 14:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1C/O9m/TAKtgL9ZhokPb6QEAILTEFVK153CVUT28Ak=;
        b=scFdU+vHD1nyD2T+vMUD1p4+s6WIIwwleK8Bam7aZaqiGS8rVn6BLFNMo8YggiwFNZ
         dpR5/itVmnGNqFTULZfWuRvvG5K19VxhS8bQStChI6tLFGSl2CUYP/e2QKsGFzBgVu57
         yx6jOzlKS/wF173IyzhcnEkQYQaU4F2JuifHN0C0nmA7dkswCVkLvTR5kYDpUIlHVonj
         +oByM5AWkj4nWZ5gXR8sv54+Erj84S4aDJlomNgSZY8uWa4aW+RQFDK0watN4n4qF7Cd
         SxLxmO1dcwTgYV464h9bFZ+jsKPUf3FtSO1/rOazO8PQMJQM4T+jqu/7fyfI0bstnXMS
         kYrg==
X-Gm-Message-State: ANhLgQ0FWg8g/RQb9i33r+DBkTlkNT9IKm5/Y9Gik9AY+u8khRl64EMC
        DD7+P/w9JJrMvtnEecDmbw==
X-Google-Smtp-Source: ADFU+vsM8qWHegcdLt3Q2m7Gc6UyEn9KtddfGoHdlC/IxDspcPSBdxYiHo+WS7LgOCr6oVsfgRE3/w==
X-Received: by 2002:aca:5317:: with SMTP id h23mr3092365oib.33.1584047465378;
        Thu, 12 Mar 2020 14:11:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e1sm6848806oth.66.2020.03.12.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:11:03 -0700 (PDT)
Received: (nullmailer pid 15344 invoked by uid 1000);
        Thu, 12 Mar 2020 21:11:02 -0000
Date:   Thu, 12 Mar 2020 16:11:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: syscon: Add syscon endian properties
 support
Message-ID: <20200312211102.GA21647@bogus>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130356.D9FCD8030794@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130356.D9FCD8030794@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:03:38PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> In accordance with the syscon-driver (drivers/mfd/syscon.c) the syscon
> dts-nodes may accept endian properties of the boolean type: little-endian,
> big-endian, native-endian. Lets make sure that syscon bindings json-schema
> also supports them.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 39375e4313d2..9ee404991533 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -61,6 +61,11 @@ properties:
>      description:
>        Reference to a phandle of a hardware spinlock provider node.
>  
> +patternProperties:
> +  "^(big|little|native)-endian$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Bytes order of the system controller memory space.

Common properties should have a type definition in a common schema. For 
this one, I'd like it in the core schema in dtschema. 

I'd expect for any specific 'syscon', either none or only a subset of 
these are valid, so I don't think this should be added here.

Rob
