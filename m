Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B0AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1FB2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590699346;
	bh=eqihPMMt+oNR0rRyKMVMv1BE/iVjcayMwUfa6ga8Uxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RKPD6zPEH8BokgmCNLo3qiQhydP8cE83rD/chgThmAX1MknBUX/fiPcxSXof8/pwk
	 yTs+GwpbU/6zN1ySMHkwxhITcfnkjxgtVoPyElt+hSZh7/E3iRclM1dT6pj5xnsExb
	 9lFGPNz5IdE/8U4cVjGlGzIn+h7vgwrrKS4Wk4Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407421AbgE1Uzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:55:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42266 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407319AbgE1Uzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:55:39 -0400
Received: by mail-il1-f195.google.com with SMTP id 18so308124iln.9;
        Thu, 28 May 2020 13:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=co0bFkPKp24lRBDvuZ5U/iJn6g3CsyyoCXEDKVfEQ34=;
        b=mbuUUCxeAaiT5zftTourAOoyWxYryuwQMQyDjBxsA3NeIQe+mjorCGNAw+OdLP98vT
         PPEAfSCAeiVbYRoQDeMcIrMPRiacTYJZv1najh1UZ/2nRWdjAaQJtP7J8xmVYdBRhCSt
         Bbu/CISuWgr5alDl5hSDHQrtmMX9sLXU9CAvAbL0arYknbF97Jo9qegbQljqB3FEBihU
         GUVUNsBPBemfXCPYCx7cPErYMIIYKqn7hL5mqCx5APY+foW5Sr1Z8HZmznAyrb7lW0qH
         Fn4wHt1Fnjao2prYTOEDn4BkaqFIgkaFNnCLN1id7T5OM/FxsvNpy/nKQbvwxIaW/TA6
         WeWg==
X-Gm-Message-State: AOAM530ZYdOLxLEuVBmWkOZl33JEzwRZOCgCV+dH4atXrVCw9Jo+oEKc
        tu178fohrSIyxLiGpixO5a/9woI=
X-Google-Smtp-Source: ABdhPJx9ZgXPcpSU2t/L/e5bmvRBAW6vHsG5IQbSyGNkSZNW/T5WFuqyyVZYxxh9F19xhMfWxLuS9A==
X-Received: by 2002:a92:c7d2:: with SMTP id g18mr4779118ilk.168.1590699336590;
        Thu, 28 May 2020 13:55:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z24sm2872845ioe.18.2020.05.28.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:55:36 -0700 (PDT)
Received: (nullmailer pid 660142 invoked by uid 1000);
        Thu, 28 May 2020 20:55:35 -0000
Date:   Thu, 28 May 2020 14:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add MikroTik
Message-ID: <20200528205535.GA660031@bogus>
References: <cover.1589824955.git.noodles@earth.li>
 <aae96cddb2d1426482cae7f6fc4d1dc0aecfde5d.1589824955.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aae96cddb2d1426482cae7f6fc4d1dc0aecfde5d.1589824955.git.noodles@earth.li>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 19:09:30 +0100, Jonathan McDowell wrote:
> MikroTik (SIA Mikrotīkls) is a Latvian company who develop routers and
> wireless ISP systems.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
