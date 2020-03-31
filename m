Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B761AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C6206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585689862;
	bh=LATQqitUJLRhj8Wslni2KLWnRpLsDtab+KfvP66mF7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wq16/urYBALQx9Qair3w3qnpuo1YA3D3pWxvscrXKyzD+iQF7NxJbVAtPHwEkFqVn
	 zoz/xf+U+ltE0XljxJoVP1m3UJQ1adV6qWuHWeZRSEl+DUGfIzcHef4SFchIsWS0qi
	 HgOm979RC60onbSKCBHhOAI7QnRBhXf+xtuP/k+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgCaVYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:24:21 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44164 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:24:21 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so20923407ila.11;
        Tue, 31 Mar 2020 14:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQPidnaAiyZ7o4SgnKSWZ8j/vkRJpLp4DqCluBJWQDY=;
        b=GA62uMc3WRDoEHtf/VUojPKiBdFIBBq1zlsbfWLheV4SPh89a9BV9SfNlgTxQpiUEZ
         urtCTZ0uedpcydPdWnhwCVBbR4wRapZymgIW/wzqVuH1kox9CUpkJxPtEYMMuE0jPLtB
         Ajo0OLaWvAB+YBz7ro2pQHPXdE86yzsRu+4RuLb1/qV/ct7RKnLY+Wj8gesDJK87tlRM
         ZOUvhnZ9OoPO9A2G3p6uEhc0RXrwx7NG6WZO+hqUbCjk0RV8mqV8mBit2P7CKjrWyUJN
         O8mzlstjFwLw4p56ENoIk0UJCHvYDA1RV+yyeAu3h3pE2Rtasvo1MV+bPkJLIi5vZuCd
         p6oQ==
X-Gm-Message-State: ANhLgQ0HUp0SpcwKtKvQlVcj1NZkPmxelBVhP2H80ka05DmDcYnuxqC5
        0YfqDcdVIC61OB0RdrtDOA==
X-Google-Smtp-Source: ADFU+vsH2TwCkd82oNN8K6Xc6FCo1RF+Phb6Dt9e3GlimwlawmyUg5f7gQRVZqhfHihIvfoTRGgBEg==
X-Received: by 2002:a92:5f98:: with SMTP id i24mr18657910ill.73.1585689860343;
        Tue, 31 Mar 2020 14:24:20 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m129sm22186ioa.2.2020.03.31.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:24:19 -0700 (PDT)
Received: (nullmailer pid 21002 invoked by uid 1000);
        Tue, 31 Mar 2020 21:24:17 -0000
Date:   Tue, 31 Mar 2020 15:24:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: phy: Add YAML schemas for Intel
 ComboPhy
Message-ID: <20200331212417.GA20941@bogus>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
 <3278d5601ace94c91ff97adadab3ae67a0e3f010.1585103753.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3278d5601ace94c91ff97adadab3ae67a0e3f010.1585103753.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 16:59:39 +0800, Dilip Kota wrote:
> ComboPhy subsystem provides PHY support to various
> controllers, viz. PCIe, SATA and EMAC.
> Adding YAML schemas for the same.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v5:
>  Add changes as per Rob Herring inputs:
>   Use include/dt-bindings/phy/phy.h values to set intel,phy-mode.
>   Move children node properties to parent node and remove children
>    node completely.
> 
> Changes on v4:
>   No Change.
> 
> Changes on v3:
> 
>  Add include/dt-bindings/phy/phy-intel-combphy.h for phy modes.
>  Add SoC specific compatible "intel,combophy-lgm".
>  Correct the nodename pattern.
>  clocks description removed and add maxItems entry.
>  Remove "simple-bus" as it expects minimum one address
>   cell and size cell in the children node. Call devm_of_platform_populate()
>   in the driver to perform "simple-bus" functionality.
> 
> Changes on v2:
> 
>  Add custom 'select'
>  Pass hardware instance entries with phandles and
>    remove cell-index and bid entries
>  Clock, register address space, are same for the children.
>    So move them to parent node.
>  Two PHY instances cannot run in different modes,
>    so move the phy-mode entry to parent node.
>  Add second child entry in the DT example.
> 
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 +++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
