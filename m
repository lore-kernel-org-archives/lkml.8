Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E76C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6432075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589928141;
	bh=Z+yhUkb54ncq98pdzZqCBEveIFtHrDMflLjR/7kU9Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jeL766Uj4ZeasbN2aGsbZBRafecigmzbm+vSHU5yVKNtPILf4RoaHXwNMjvnDyN9g
	 WBc36+Z9HSQxDgmAy0sCflxPiMIGHtq/T9zR+Za9Iu8BHuOZh8iFa4bkIpmGWRm1EX
	 hWZUBPEnAVbbwrJ8pp92fZOjEUsLz9MG+gdL17IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgESWmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46121 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgESWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:17 -0400
Received: by mail-io1-f66.google.com with SMTP id j8so970119iog.13;
        Tue, 19 May 2020 15:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgFe2xy8/2xQB5QWY3CO3CsIleZgaMC14NjFZj3FgiM=;
        b=ZQg9Ej2ED0oro1OcanCcmE3rxj800ia8KRPCyV0n3vmbcjTFy9U1CrlMweEfJlX3M4
         9EIu/j8+xy5xtNRX7ZiMyzaUuAl546eHTXs6M6fNQ6bDE3Qgk3ZeU2kXUnRUfz9zLNBe
         TBMONeSp+3oBVmtYmEkvSgbBNK76PruWbrX12JbDbjgUJMZ8KUkFg7/p17HcLhj/uJ79
         rO2R7IBZmXVmJQBrP8MEeKc+wO0cUHcCn9GD6DpwBd0E5a1ImPbqVtEU9Twet41a7vis
         5si3PWoZfQQTUMIlKu1r/Zh+DSDfe7bi+jbI2Cni++XWf5Ooy2rUgVLl3v4etmXtjC8U
         a61w==
X-Gm-Message-State: AOAM530rXFN94+KzILHEyznHRveeN/rojPTVJNmvMia8ugGPEr5LXIt4
        dPq4K+Ek3x+BgCkvL4viWA==
X-Google-Smtp-Source: ABdhPJytDRwoiZt9xLZNqCqKB1TxQKbXQJnN0x8nPz/zWntjyvp5bG6L19VYqss8zFDavc6WNxSe4Q==
X-Received: by 2002:a6b:700a:: with SMTP id l10mr1152861ioc.170.1589928136705;
        Tue, 19 May 2020 15:42:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q75sm398796ili.11.2020.05.19.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 15:42:16 -0700 (PDT)
Received: (nullmailer pid 824100 invoked by uid 1000);
        Tue, 19 May 2020 22:42:15 -0000
Date:   Tue, 19 May 2020 16:42:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bindings: sound: Add documentation for TI j721e
 EVM (CPB and IVI)
Message-ID: <20200519224215.GB488519@bogus>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
 <20200512131633.32668-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512131633.32668-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:16:32PM +0300, Peter Ujfalusi wrote:
> The audio support on the Common Processor Board board is using
> pcm3168a codec connected to McASP10 serializers in parallel setup.
> 
> The Infotainment board plugs into the Common Processor Board, the support
> of the extension board is extending the CPB audio support by adding
> the two codecs on the expansion board.
> 
> The audio support on the Infotainment Expansion Board consists of McASP0
> connected to two pcm3168a codecs with dedicated set of serializers to each.
> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.

Would the audio graph card work for you on this? 
