Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70703208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590702344;
	bh=ceTbiGE1fdlUmzqWFyaVLSeRy2q/YYakbraJd1Sf+e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oufGd9eopNIf7atVSAHSnhJCvgO/VeKGRAhsqObLxbUsXkrAvgYgyVvN37rV1iw9P
	 3JWHiYyWTYSMB6tLtrGutdnt4ci+1VrcusfmtIQujzOr1kcOH68tLHzGWirGqvvd08
	 MGVhV3Fyx1wjTIFe6ZJoY6O2RKMe6wb34ySWkUgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436735AbgE1Vpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:45:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46539 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436644AbgE1Vpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:45:34 -0400
Received: by mail-io1-f67.google.com with SMTP id j8so86222iog.13;
        Thu, 28 May 2020 14:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzcr+mjHsM24aLkHoAOHak6nDxRWVx38hpQtHZNedBU=;
        b=r8i7CHWxOLpKQHiwUZmuPBZyM1mZIeoW05mqZyr+Edjwdskh2YshLRulZBuv1CWQ9i
         jpZftkM5+HtLIGUsnLPEfkedmxW5mCNuPbgnZPK+IzV7awpEPbd277kOWfh0pL2EOBZJ
         yJwFQhgoizAivBe+osPLSQDq9CX2ZvaeAg4lMGxwUM+TIhsJneLKAVklm3kHye4wHrCF
         C2MMuyqw4Gx6rPk+bVXEP0kykehhlwqy2OAQTao3IwAc6KP2zlw/4i3dcf5dKUU/TotP
         sWAbxCCwPvz+oc+ttgmjXmAxkBioZvDhMSKdjMpYdtC/uGMPEUZd1dLoqqlqyzvYPupS
         pG5A==
X-Gm-Message-State: AOAM532U3zZ8WFU2W4I2ARHVz32zzjiaTSlXwgXHtUy2h0kcfqUNEcm/
        3AHf8oytdDboPvFVkNkNw1m+/CE=
X-Google-Smtp-Source: ABdhPJwC1uAdK3xHvNfrdgLrzQBAEO/Oap6NIueFHuSo9LjSPNqIav0iLMI2MKVwHl/FBhzeFZpwYw==
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr4521911jaq.136.1590702333103;
        Thu, 28 May 2020 14:45:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u1sm2998555iol.42.2020.05.28.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:45:32 -0700 (PDT)
Received: (nullmailer pid 738875 invoked by uid 1000);
        Thu, 28 May 2020 21:45:31 -0000
Date:   Thu, 28 May 2020 15:45:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: memory: Convert
 ingenic,jz4780-nemc.txt to YAML
Message-ID: <20200528214531.GA738825@bogus>
References: <20200520002234.418025-1-paul@crapouillou.net>
 <20200520002234.418025-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520002234.418025-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 02:22:33 +0200, Paul Cercueil wrote:
> Convert the ingenic,jz4780-nemc.txt doc file to ingenic,nemc.yaml.
> 
> The ingenic,jz4725b-nemc compatible string was added in the process,
> with a fallback to ingenic,jz4740-nemc.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: - Inline content of ingenic,nemc-client.yaml inside ingenic,nemc.yaml
>     	- Add missing 'reg' property to sub-nodes and mark it as required
>     	- Use a more generic wildcard to match all sub-nodes.
> 
>  .../ingenic,jz4780-nemc.txt                   |  76 -----------
>  .../memory-controllers/ingenic,nemc.yaml      | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 76 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
> 

Applied, thanks!
