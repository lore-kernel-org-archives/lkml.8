Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B87C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03694217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579787647;
	bh=x9M6eavIAvvEGrUwxYKyP2DGivVJnbwadKIHya2ucWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OWp1kexiApFhfOF7Y12yilAdaf0FfGLr5fLPElJHDcsgm9FIkr0j8hZJ7/8FoEGT0
	 oYAp2MxrfnrB0RglxrtLxy26C64FfTc5cdmBNjXM7Zq1vzUA7xnfAfDXgK12xst8No
	 DJ4rBsHSlsWXNGkXomoiRSgCpfYgfZ5b1BSZ5Mn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgAWNyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:54:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35079 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgAWNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so2967510oik.2;
        Thu, 23 Jan 2020 05:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/qM3etQQpBSLTEqBLeVd9eY87SXmbEFDzRP+5up0C8=;
        b=E385wjK+G12yazTclPY7ZOl88Tk4da5PqvLPOjo3KkXIe4BSXxaC0PILlA1RFCcYez
         481NYK0bpigIzfWbVZCEAHqDTHCIvbmygfneG5V4qAe2mLrp86AiY3yyWBHP5H5aEIHI
         UXD0BQt1JeqvdwIa+Nbfm2iJXfTCrdrzoA2z7q+gi4ezpgV4Q94EqeCoGKDtyw77lykn
         0SBDcm7i4D21p3TCHP679ogWWyLv9oTrsqBokaZ1FCDuwu7HZKleJavbxrGX0Dltr4yl
         O0n0j8iwMqRpCvJD4yg4pDFqusbMRRD4NUKQ/Sg5EskD7s89Qjd+7HwuEVYzQVTbV5EK
         VM3Q==
X-Gm-Message-State: APjAAAVl8c4nm0a9Yz+HZ2Xr5H6cMvNUZsLPFl+gBlV0LreYBckFK5fy
        Ukx9uiHnR6qP8PNOQT+qdNgXkR8=
X-Google-Smtp-Source: APXvYqxbmVw4pPuJNM4zzDBdpevfcNsr9BgaGlQWY114ibeMBYPE5XKl4w2rJlu5/DKjrG/8rQ80/Q==
X-Received: by 2002:a05:6808:1c6:: with SMTP id x6mr10556492oic.49.1579787643963;
        Thu, 23 Jan 2020 05:54:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm808746oty.48.2020.01.23.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:54:03 -0800 (PST)
Received: (nullmailer pid 4960 invoked by uid 1000);
        Thu, 23 Jan 2020 13:54:02 -0000
Date:   Thu, 23 Jan 2020 07:54:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt: bindings: brcmnand: Add support for flash-edu
Message-ID: <20200123135402.GA4763@bogus>
References: <20200122204111.47554-1-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122204111.47554-1-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 15:41:09 -0500, Kamal Dasu wrote:
> Adding support for EBI DMA unit (EDU).
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
