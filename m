Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A49C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB52075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593723673;
	bh=HOKLh1kvOiLd6N3FEcD4fsrcJUgdCZlq2q4qET2N92I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ew7SwNIhl9CZYxYXYsgfe9fPkK1pT9JjcpxHA2zcoUI93fEdankjzjesrfa6s93NC
	 9c27C9BrDgf1kTFmSGY9d+v539XpIZa7uGsvOLcjnblf2tY5/A9urd7Mf4HJd5YOyF
	 waE0DELKGsXgqhAbgORYxB6RGYywNfo2oTG946Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgGBVBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:01:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37639 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:01:11 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so18254962ilh.4;
        Thu, 02 Jul 2020 14:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pscTNcsjG1XyDNybUCclf+10YKpfbDpJLW+4tpO0I0g=;
        b=DscBjMpD5Esl9EJdSnGB+jxWPVxUupU/DRz/J7S4i4zrlgVnHykRrkVbK4lRO0se79
         YWzS41bQ3PNw2s1BqlerVl7QjqfpPCajAaAvefQpYcyx9pkMSwRW0K8ixousiD542EuO
         6qpeHBgcDNkkUwiBPhUKhQQ5dxVkjF9KxIxV1D/1+tR5fDLih+uYI20JjJ+DqM1QScfR
         q9NSu3mGbitNGtEcRhzQtM+wD3GIsK+BkiuIsrDHF6CH7fBe5BstWW+3ZPm9nDTw/i3C
         and4x7nfY5nEFhA9aJ+qMq1KumI4YgE/mNGwHERdJPUQjl4NV0iMociAkt0tWhzbVyq9
         0m4g==
X-Gm-Message-State: AOAM531cc+JpmZwbYUUgWVFjWhZA1UNpBjDiIxyhE15US+fi/YZ11ECs
        ZEHrIySGT7ryG76vRglTLw==
X-Google-Smtp-Source: ABdhPJx8jwlcMouahR/BuXTgcuLkyDO9yZTlxRTMKgJ5NjIwLEuwuuawN9mS4qRzGHIaU+GVKuFSmg==
X-Received: by 2002:a05:6e02:1043:: with SMTP id p3mr13788707ilj.245.1593723670409;
        Thu, 02 Jul 2020 14:01:10 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q15sm5487720ilt.60.2020.07.02.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:01:09 -0700 (PDT)
Received: (nullmailer pid 1687042 invoked by uid 1000);
        Thu, 02 Jul 2020 21:01:07 -0000
Date:   Thu, 2 Jul 2020 15:01:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     will@kernel.org, festevam@gmail.com, vkoul@kernel.org,
        dan.j.williams@intel.com, kernel@pengutronix.de,
        catalin.marinas@arm.com, robh+dt@kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, angelo@sysam.it, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 6/9] dt-bindings: dma: add fsl-edma3 yaml
Message-ID: <20200702210107.GA1686199@bogus>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
 <1593702489-21648-7-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593702489-21648-7-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 23:08:06 +0800, Robin Gong wrote:
> Add device binding doc for fsl-edma3 driver.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: 'power-domain-names' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: interrupt-names:1: 'edma2-chan9-tx' does not match '^edma[0-2]-chan[0-31]-tx|rx+$'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: interrupt-names:3: 'edma2-chan11-tx' does not match '^edma[0-2]-chan[0-31]-tx|rx+$'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: interrupt-names:5: 'edma2-chan13-tx' does not match '^edma[0-2]-chan[0-31]-tx|rx+$'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: interrupt-names:7: 'edma2-chan15-tx' does not match '^edma[0-2]-chan[0-31]-tx|rx+$'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.example.dt.yaml: dma-controller@5a1f0000: reg: [[1512570880, 65536], [1512636416, 65536], [1512701952, 65536], [1512767488, 65536], [1512833024, 65536], [1512898560, 65536], [1512964096, 65536], [1513029632, 65536]] is too long


See https://patchwork.ozlabs.org/patch/1321003

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

