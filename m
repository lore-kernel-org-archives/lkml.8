Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D8C11D13
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC7124673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20150623.gappssmtp.com header.i=@thegoodpenguin-co-uk.20150623.gappssmtp.com header.b="0AO/dMDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgBTRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:31:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40056 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgBTRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:31:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so5545291wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0OEZb6ZbfxyZGgdO3oC5v/q0OGeZVw3eP9vYvQiG/U=;
        b=0AO/dMDS1M6O3Y1MAIlce7yX8iZStnkbe4FyCLeA2xCR158t3j4xoLga0nF5rgnqPg
         Yqjj5zlXqWS0D8fXu0a/+PZ/2rfBs0tDFvLqAfuUlCIlWOVCu5WG7SupP6am6Z5rGoTA
         jCj3zcSICrEASFhHK4YaAxnu3Aust4K9d5WhKM5mJwiPuNDu//O/EhcZSXwhb8ccxCyd
         7igtONy2I24pkPH+B3o0x4y/vYLnL77dwu8HqZOYZ/YKdX5eHh3uAdfKx+LJGkG1/G5I
         vr24oMKwrdCmqODcC3ENKCBPeMQX72lKc0KEiut+vq/sUCCazXRcZZVEltq2iE+RIhb9
         sCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0OEZb6ZbfxyZGgdO3oC5v/q0OGeZVw3eP9vYvQiG/U=;
        b=FtZ9y+/asTfq3+CUWv28tX9zNgB/Aze7i59Sbc5LigHtMihHLMiPnovMZTIn9hrrfj
         JhANYluhqXkKY7Ja74BSUQU0+nd9TVnlSwRGwu7e6FiN0bZpEjuBzmfmKnHW78GIV9r+
         pqyI7DKzPKPJ6ww7/OfqVqvk6GYGjCnhMHtJEActwDXTAnniuB4lWHcagQp6SuGBgdIE
         dikqwbahDGkMIKkQbUFygHsg2rH5BHD9+0NzEJYds6MpmMaTr0WZlrvAbuD7ibwCBVaH
         VCW0Vf2bbqtFmbv3pbRp7RxS86ZiVS6ey/bfiCJ3xk3OvzhBgNywa3RrfdIKbp66I4WA
         gPiQ==
X-Gm-Message-State: APjAAAVswpP1eLkjWNYHxXGr6sEUnhGYYCOPa93mg+tvXFcXE14VQ0lP
        egdq0kiEvngHOKNt7acot1rfAg==
X-Google-Smtp-Source: APXvYqyyzZXO5TSoVkK6w2z4UIzWud060LimIz9UfXnvzAZJj1Wld1YI6Wn1KKd/pHRwbYWs9NTRwg==
X-Received: by 2002:adf:f744:: with SMTP id z4mr38804520wrp.318.1582219877525;
        Thu, 20 Feb 2020 09:31:17 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id y8sm8190wma.10.2020.02.20.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:31:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:31:15 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 09/13] PCI: mobiveil: Add Header Type field check
Message-ID: <20200220173115.GJ19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-10-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-10-Zhiqiang.Hou@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:40PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Check the Header Type and exit from the host driver initialization if
> it is not in host mode.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> ---
> V10:
>  - New patch separated from #10 of v9.
> 
>  .../pci/controller/mobiveil/pcie-mobiveil-host.c    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 44dd641fede3..db7028788d91 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -554,6 +554,16 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
>  	return mobiveil_pcie_integrated_interrupt_init(pcie);
>  }
>  
> +static bool mobiveil_pcie_is_bridge(struct mobiveil_pcie *pcie)
> +{
> +	u32 header_type;
> +
> +	header_type = mobiveil_csr_readb(pcie, PCI_HEADER_TYPE);
> +	header_type &= 0x7f;
> +
> +	return header_type == PCI_HEADER_TYPE_BRIDGE;
> +}
> +
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
>  	struct mobiveil_root_port *rp = &pcie->rp;
> @@ -569,6 +579,9 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  		return ret;
>  	}
>  
> +	if (!mobiveil_pcie_is_bridge(pcie))
> +		return -ENODEV;
> +
>  	/* parse the host bridge base addresses from the device tree file */
>  	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
>  					      &bridge->dma_ranges, NULL);
> -- 
> 2.17.1
> 
