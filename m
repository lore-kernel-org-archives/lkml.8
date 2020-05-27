Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A39EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5315620663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590601650;
	bh=8NVr7Py6YdjSCFM0EKZqJ7Ko1khyIJSlTazCrKjoBO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MJyDO0Py3bPrCH0axPGzr1qbDYpa/JZIxmTyuvLvijuPAUhqBKftnw9BAvrB8ZsPO
	 BVFwy0/dYtXRJRwTvPFYddaWlFPzS+30fS0OTVKmsQWzPQK974fSL1mnr912zlExih
	 Q/vSGOQtjOMs0vqbWPtTRM8zOj2SevRE+yC4XbI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbgE0Rr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:47:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37648 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391538AbgE0Rr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:47:27 -0400
Received: by mail-il1-f196.google.com with SMTP id r2so13760870ila.4;
        Wed, 27 May 2020 10:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNGRyhqOOsEWMx6xQcjhtwryScxVn7tW/e6vBtcK+Ig=;
        b=tJSGbepk/8HngrcgE3TZoz1sxmFPZVfeRcPXv4p27rSRguLOx7/+S352xd98+CFtCb
         C/Tv4Zs4AKzOlZBPVzGdg6cR1z6VPOWWbD+fw+l6TyPAjxd+6SlWrANcB3HS95lHqeNn
         /NuFkIGbD2Rwm4MRp0bJH4p5Fz4kuGPo26tOAkITSgdHrvTcPfxsQMtC/y0S6JQC1D79
         EAu+I+af2NcSftGLOUCwRiJgegAOBPJmrX8R7Dmq7oB0HeJ9L88qX9yo/JIOvBmj7HlM
         WNIwewFiF+7p/ycmOWOvgGOSyuavPlk0WfWLGVN3jmEL6WX0yhJa2YLRdNLEI+CcVqy7
         zT8A==
X-Gm-Message-State: AOAM530IuIyy+ZcG2mjTHOEjt0tP7dco1ecG2L/kqpJGWDIF9Rafh7YC
        fa5CDQUfsm6XDZiWEJnkyQ==
X-Google-Smtp-Source: ABdhPJyz283E//TFljqx1jX1J/m1App4wUHuJZC0pO8zxAsfdaplunHspikVYoIIj0JlNBk70uiiEw==
X-Received: by 2002:a92:8c17:: with SMTP id o23mr7064059ild.79.1590601646742;
        Wed, 27 May 2020 10:47:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r10sm4843ile.36.2020.05.27.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:47:26 -0700 (PDT)
Received: (nullmailer pid 2442566 invoked by uid 1000);
        Wed, 27 May 2020 17:47:25 -0000
Date:   Wed, 27 May 2020 11:47:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     sboyd@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        patches@opensource.cirrus.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        mturquette@baylibre.com
Subject: Re: [PATCH v3 4/5] clk: lochnagar: Move binding over to dtschema
Message-ID: <20200527174725.GA2442420@bogus>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
 <20200512152359.11839-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152359.11839-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:23:57 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/clock/cirrus,lochnagar.txt | 94 ----------------------
>  .../bindings/clock/cirrus,lochnagar.yaml           | 78 ++++++++++++++++++
>  2 files changed, 78 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
> 

Applied, thanks!
