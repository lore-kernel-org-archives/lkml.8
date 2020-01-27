Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75547C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4281F24676
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580139523;
	bh=H5ecfObaOj39NYVk7bFX2pFmHEDTFae2ahQ1eA+TDDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C18GQEY9hpVug8iIqazkWQUJgTi5vsrp9ia2e5pYgFwJYOKKrPVLdhQHT7WY2NmxN
	 BDGhhXNeFUc5zXdClCeWmJqnzasxQCyNILVYkWgfyfcEW+G1ocW2R2BNY043g171I3
	 pWMYNaoKK3C4fdMOfimbBL+6gBozqR7UiQDYLO9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgA0Pim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:38:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41255 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0Pim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:38:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so7019547oie.8;
        Mon, 27 Jan 2020 07:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSCV1WjGl/2W1fWEr2TPCKxNJyQTI/EanIQPnOBPvO0=;
        b=c3+94B5KzDLH1TrOQJ2BA6p9leX21BZ0Yxbkrt4JbsEiVTmLY1Ti34Qpi8StQZuKOx
         TbNtZd6/ZJxTYdvvzC4LM/DznKeen7R9oeLrFnUxuR+l5i3O3wxEO6l6rH/AoMKKNLnm
         NDBEQl9cDVRjC+ZbWX7Y3BKsynvByke/WfTDJvkJnuc4+uT0TF3ymcf6but+ywtuexL7
         M3VIKZbyDIXBTtoGd48XNoyaHkWjUgq+Z2S77m9YguhoRg8QSiGJBwJTXCdF9CYl9JVu
         w7iRa6Jku4A4plBa+ceol40CzdVL1Jr82ivuJCGfjT8Ur7v7rOudPHDTqdPHWGN2+ned
         O9Tw==
X-Gm-Message-State: APjAAAUVqHtX/qBctgtEtEZNKPijd5V4wV0DIDfcxXCzvyW6iCVAI7hX
        Vt8BUMeqK8wBUe7TIJMdUlsepK0=
X-Google-Smtp-Source: APXvYqxCxHVqds2nhytw8FvqFrpimnc1pe7m+Oyedj20WiRGfk+AjmrAJ39D/dEMmNs4RK+V7gKv6Q==
X-Received: by 2002:aca:4ad8:: with SMTP id x207mr4060086oia.55.1580139521816;
        Mon, 27 Jan 2020 07:38:41 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm1327774oih.23.2020.01.27.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:38:41 -0800 (PST)
Received: (nullmailer pid 3123 invoked by uid 1000);
        Mon, 27 Jan 2020 15:38:40 -0000
Date:   Mon, 27 Jan 2020 09:38:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20200127153840.GA2987@bogus>
References: <20200123215338.11109-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123215338.11109-1-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 22:53:38 +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
> 
> Notes:
>     Changes on v9 :
>       - fixed error reported by dt_binding_check
>          "pmic@69: regulators:mps,switch-freq: missing size tag in [[1]]"
>     
>     Changes on v8 :
>       - fixed error reported by dt_binding_check
>     
>     Changes on v7 :
>       - added regualtors child-node under patternProperties, added required
>       - mps,buck-ovp-disable is not common property, regulator subsystem provides
>         only over current protection support.
> 
>  .../bindings/regulator/mps,mpq7920.yaml       | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
