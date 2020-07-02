Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA9AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D8D20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593723620;
	bh=N+X6/X27H/LWjqL+ft4VkAxUgWsLTCCQVIggwf2dB4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yF1H/gBaXv4a43gcpD0qSh8E4jJJsvf9pZc1fKnHPXtCn0mbQCJRd3S/10b2P2Kbd
	 8BpMBhSkhYO5TOlELECJMc2IbjcRCfsv7B3kmlZmhGwrYfx+Pa+DGZqfLI7syhbT2v
	 xhHMxLDMXV23IdruFMG3EiypwVT65XBv2j+3BqlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGBVAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:00:18 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45862 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:00:17 -0400
Received: by mail-il1-f196.google.com with SMTP id o3so8077643ilo.12;
        Thu, 02 Jul 2020 14:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7QtfLSG5iCWPjoGkb/dcO4GKpTdA5wfHStXRPpTbvZk=;
        b=cXipTB0LRZOzF1JnhvRqnl1LXNSQKvh3Rz0ADICmdduGvjkqAf98m+BmUlS7j3Qnxw
         VwASuUEmCoi6xi3xk7/swq+LljtUC7NZJlMXdKqytidnqnbhp27Bzxrmv8lmvpEYuPaF
         k+MUWZkVoJpOioFE6IhHmtZdfBzLsxFBtG265a6IC/kQ3chzMGrgjyFKR9jwp0l4rOLp
         uPZ2DNj3/tukseB9oFQPa5qsdDHsyo49D6Za0sThOK34If6J4FjsG8uAPLqO1ptfdeIF
         ijfCg+FutRaaZS/8ng/hyxYNfHpls6WbM5MNCLOoqOn3g+WItCmqf8QyTKxoB9JkAEC9
         AlWQ==
X-Gm-Message-State: AOAM533A6NWe06dlSfpqGFa/pODLjBB/i/iRw89In7T+Z193IEr707iY
        hjtjZUpJIp477pjpTCO+vw==
X-Google-Smtp-Source: ABdhPJx4JIDBC5UZXyrO0sUArTcLxJrGCbl1Te2M8TG8q68takA1sojfUFtwJPO7crhAeVasbkKPLg==
X-Received: by 2002:a05:6e02:1253:: with SMTP id j19mr14732392ilq.145.1593723616609;
        Thu, 02 Jul 2020 14:00:16 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v4sm5382970ilo.44.2020.07.02.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:00:16 -0700 (PDT)
Received: (nullmailer pid 1685550 invoked by uid 1000);
        Thu, 02 Jul 2020 21:00:14 -0000
Date:   Thu, 2 Jul 2020 15:00:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     linux-kernel@vger.kernel.org, afaerber@suse.de,
        andre.przywara@arm.com, cristian.ciocaltea@gmail.com,
        robh+dt@kernel.org, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 01/10] dt-bindings: dmaengine: convert Actions Semi
 Owl SoCs bindings to yaml
Message-ID: <20200702210014.GA1685248@bogus>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-2-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 20:22:47 +0530, Amit Singh Tomar wrote:
> Converts the device tree bindings for the Actions Semi Owl SoCs DMA
> Controller over to YAML schemas.
> 
> It also adds new compatible string "actions,s700-dma".
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v4:
> 	* Added Rob's Reviewed-by tag.
> 	* Re-order it from 05/10 to 01/10.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * Addressed Rob's comments:
>            - removed unnecessary description.
>            - added unevaluatedProperties
>            - added relevant information about
>              dma-channels and dma-request
>         * Added power-domain property.
> Change since v1:
>         * Updated the description field to reflect
>           only the necessary information.
>         * replaced the maxItems field with description for each
>           controller attribute(except interrupts).
>         * Replaced the clock macro with number to keep the example
>           as independent as possible.
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.txt  | 47 -------------
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/owl-dma.example.dt.yaml: example-0: dma-controller@e0260000:reg:0: [0, 3760586752, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1321538

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

