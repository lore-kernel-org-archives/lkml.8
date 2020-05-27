Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE06C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7323F208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590605266;
	bh=bZCmPc2USyfP4yx+lw2F42nqfj+D+VBXl/s9jzDLbNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wUlpjBSL0MEriSHbIdBIyxOsEJsMHn0+8wWgRL8KkMJeO5VGelCtY1U1AW/2bp0Cd
	 npAr5cHioz8T9OncnLV2LMi3xRJsWstT2RsFvCGg+bFANL6JIVvv2sATejAQrHngg1
	 b13MXakATpkf6zpBrqCNVGewlygzy6//iMJIc0u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgE0Sri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBF0C008633;
        Wed, 27 May 2020 11:40:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p20so13784543iop.11;
        Wed, 27 May 2020 11:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gmh7khEi867Q1p2K+E8wmj2hjP4yzjtOYXkIcMdbpVQ=;
        b=I1As+XBMvRg9gijph5P2Lk7peH1/VQ9mvVuSVDYsQmZqW+g/qzOyBKyOuAY2ndgkK2
         NQVHPFY8PUwD9B9OD/+ZgaSR0dLHqDZgi12+Hxn4OQ7ONBwQ8exV0/aFyFvg+6V7rVFH
         PI1d94KghP3QGVxPiifi0PCP8QCAS+4NDbcw+dxRIzilsXkJVqXcm8ZWfr6bSrIvhJVO
         zClTRJNP3dCaTgo25pyo6a6ExwHOgWBBhx/X7XUFr4bJJceDXjLsijyPvbtTd5cc2uSb
         x8iObz5XCvqV7tDAz6qpH0KIT1eRo2zptXwPXXNs4XgunLFX9Dsz8Jb1Xo9uXaru8Vfp
         M9jg==
X-Gm-Message-State: AOAM533ClhfmymtKNPVEzxqf+Hjjm4ZAQE6LVI6a0/vJPeEC6RAmE/yZ
        dNqDZgb5N3ECkskiUToFbw==
X-Google-Smtp-Source: ABdhPJym2U/ruXzq2JydPVxf7p+4P3gKGasMHeicBfOWFBEuOBkVOSd/wSxZqTlL5k6KdoxnjRd20g==
X-Received: by 2002:a02:a19d:: with SMTP id n29mr7072088jah.85.1590604843286;
        Wed, 27 May 2020 11:40:43 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm2040958ila.57.2020.05.27.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:40:41 -0700 (PDT)
Received: (nullmailer pid 2529615 invoked by uid 1000);
        Wed, 27 May 2020 18:40:40 -0000
Date:   Wed, 27 May 2020 12:40:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of: Fix a refcounting bug in __of_attach_node_sysfs()
Message-ID: <20200527184040.GA2529559@bogus>
References: <20200520120414.GE172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520120414.GE172354@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 15:04:14 +0300, Dan Carpenter wrote:
> The problem in this code is that if kobject_add() fails, then it should
> call of_node_put(np) to drop the reference count.  I've actually moved
> the of_node_get(np) later in the function to avoid needing to do clean
> up.
> 
> Fixes: 5b2c2f5a0ea3 ("of: overlay: add missing of_node_get() in __of_attach_node_sysfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: move the of_node_get() instead of doing clean up.  Also the v1 had a
>     confusing typo in the commit message.
> 
>  drivers/of/kobj.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
