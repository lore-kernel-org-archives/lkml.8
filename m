Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC08C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B622C20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584992644;
	bh=ybjCvacjEGd/Q6jtpvM6CKxHbtDZvPBosD9QOKBwDF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d02nICt0J8iQbSfFG5C4bsHdyWO/7tZsAPTW4daEc750qKMaV1CWYmAR1Rkz3IJb7
	 VJgXrF0wPPzscUXpXiLTXGo+lcAPWikZ4+WT9EoGV0SrUpSDVrgLArZ8bx4W3SjK6J
	 VekEoANIlIMyY1/xbLhwUHnDpu+BtRD44VJDUMbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCWToD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:44:03 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43089 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:44:03 -0400
Received: by mail-il1-f196.google.com with SMTP id g15so5374271ilj.10;
        Mon, 23 Mar 2020 12:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6kwnFs0niH7E9Kzv2VbHKH5UoBOgvaVsFLxKybIkRI=;
        b=ZYABjhIYNmMp5VOtv/owH/83m5HG4ILhBjgX+mX8I99XNdc7r0Mb7Vkq2CnC/beiqX
         3LIkpPKErnAu8GOIFACUleZqr0m2u2PIkXfx/OhyqWS16QLRt8bcs4NYvdub8zQMu4fR
         wr1BEdEX6VtSCc/GzBb5JNr7svHpez+ZjrH1tewkUgsNprEK1IIujewAwlxEKWdqV9Yg
         VkWRObMZTxJORyU7AszH0h5nGe5CaRMCFuh/NPxST+dog7hv2cd4xWCjYBNkeMXzrM9S
         NL0kujO//kTDQJu9mvd0phXcbFEg5zVyDTDti2HYQo1ZRSirF0gtemLU/4azGZnT7JLm
         clig==
X-Gm-Message-State: ANhLgQ2RJnDKuc+5oLcdTZ9mgup1LITXUPGMcOZHEPsAR5lyYvcvk4wH
        opfQs6/lrt28of5ZcMQmBw==
X-Google-Smtp-Source: ADFU+vut6tX/rjj5bh3lZRotPsHXc27nCWaaqY0ASQCB3Fp2ukLJeY95a9TfwnFEy1qAMy5Jtjs3LA==
X-Received: by 2002:a92:aa87:: with SMTP id p7mr21088780ill.63.1584992641642;
        Mon, 23 Mar 2020 12:44:01 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n26sm4568483ioo.9.2020.03.23.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:44:00 -0700 (PDT)
Received: (nullmailer pid 19776 invoked by uid 1000);
        Mon, 23 Mar 2020 19:43:58 -0000
Date:   Mon, 23 Mar 2020 13:43:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Peng Ma <peng.ma@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/2] dt-bindings: dma: fsl-edma: fix ls1028a-edma
 compatible
Message-ID: <20200323194358.GA19737@bogus>
References: <20200306205403.29881-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306205403.29881-1-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 21:54:02 +0100, Michael Walle wrote:
> The bootloader will fix up the IOMMU entries only on nodes with the
> compatible "fsl,vf610-edma". Thus make this compatible string mandatory
> for the ls1028a-edma.
> 
> While at it, fix the "fsl,fsl," typo.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Fixes: d8c1bdb5288d ("dt-bindings: dma: fsl-edma: add new fsl,fsl,ls1028a-edma")
> ---
>  Documentation/devicetree/bindings/dma/fsl-edma.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
