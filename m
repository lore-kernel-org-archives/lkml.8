Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5758DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3278122574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594746958;
	bh=6dk0fQui4ZKups3uBkoflh2avaOC3v852OaUAdu3KHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lmdoluaNgdpvQKglpjkpQYYLKLZcLnGuJEaBIrznBXLCcyhzYi02+oKWLfA3wvBdv
	 Jf/a3lMYd5UIBddrtvBodJVQV6nG8F4ot6JnCXlfxw68oZ0hn7s8g0aquaKE/G+sox
	 vbfvV2DJs/Lzf0K9of/a7si9NjeIRbe7EO1NUzio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGNRP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:15:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34145 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:15:56 -0400
Received: by mail-io1-f68.google.com with SMTP id q74so18135501iod.1;
        Tue, 14 Jul 2020 10:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anDElTHK8FTg74ug9cz0yo5gvG9pTxsEpYnEOXS2E10=;
        b=DExxrJr02dzL7W8WPCJQsG5LKLjoV42eCM9mVUJ94ozZc8g+bSG0Qq19atnLi+0+LW
         6itrKv2rVzutSJIaP3B5+I97qc0zhT7xzopGvZtCVn6zs8/7Ehn9TaJtIp+Fdo9mvzMI
         zhQkIwIJxree4R5ix0wjGyIO3IiHGLpAdDZ8wffVtGjVOEbDoMPaDxgNd1tzKpRt7mcb
         axlzsUtGaY/dhCyjBJ4/2bsa8U0+IQsYCt8BZIgxYjR3ZzQvygvq3fb29PvwNSF1GZBE
         3/RZof2u8bBnjl+Y/u+pUTTbM3oIMkw4LVM+y2758rGQNqcsEcONzxio5HN5G+3TBgIR
         zTLw==
X-Gm-Message-State: AOAM531OiFE8onTIaaiDgDVdi/sZaZ47XXw2onVmUD/fXt9k+AUFUBZc
        5Dyk42SktdeUHhNjwXoQnsRCwA56Wh6p
X-Google-Smtp-Source: ABdhPJxg7GVfzF4j6Shx1sDsnZ5fsOOV6Zz3xfMPgpIhRO2lCTzggqQ1Gg8GirNOzqCU+9eZgyhk6A==
X-Received: by 2002:a02:694c:: with SMTP id e73mr7033232jac.17.1594746955212;
        Tue, 14 Jul 2020 10:15:55 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m5sm10149810ilg.18.2020.07.14.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:15:54 -0700 (PDT)
Received: (nullmailer pid 2550226 invoked by uid 1000);
        Tue, 14 Jul 2020 17:15:53 -0000
Date:   Tue, 14 Jul 2020 11:15:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
Message-ID: <20200714171553.GA2522956@bogus>
References: <20200630024922.32491-1-s-anna@ti.com>
 <20200630024922.32491-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630024922.32491-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:19PM -0500, Suman Anna wrote:
> The Texas Instruments K3 family of SoCs have one or more dual-core
> Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
> can be split between multiple voltage domains as well. Add the device
> tree bindings document for these R5F subsystem devices. These R5F
> processors do not have an MMU, and so require fixed memory carveout
> regions matching the firmware image addresses. The nodes require more
> than one memory region, with the first memory region used for DMA
> allocations at runtime. The remaining memory regions are reserved
> and are used for the loading and running of the R5F remote processors.
> The R5F processors can also optionally use any internal on-chip SRAM
> memories either for executing code or using it as fast-access data.
> 
> The added example illustrates the DT nodes for the single R5FSS device
> present on K3 AM65x family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2:
>  - Renamed "lockstep-mode" property to "ti,cluster-mode"

I don't think that's a move in the right direction given this is at 
least partially a standard feature.

As I said before, I'm very hesistant to accept anything here given I 
know the desires and activity to define 'system Devicetrees' of which 
TI is participating. While maybe an rproc node is sufficient for a 
DSP, it seems multiple vendors have R cores and want to define them in 
system DT.

Though the system DT effort has not yet given any thought to what is the 
view of one processor or instance to another instance (which is what 
this binding is). We'll still need something defined for that, but I'd 
expect that to be dependent on what is defined for system DT.

Rob
