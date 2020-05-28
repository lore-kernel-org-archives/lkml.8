Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F9AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7222072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590688452;
	bh=+Ve9zokIrQzTVNOgy8RCXY3l+nBlJOKxQ+nR8Acns7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UxX6ZEmRkDm3XB5NRXcqVuYsJKOn5P8IuEHUG99sjrae5adf7g2Uj3boaQ7Y3/esM
	 rcsYl8lIdYTHDMhMB1fGSyWJnf/JcFzmo4dFSSdwcJTotInJAiOTqGfUhm2elz6ZND
	 U5ptz+n6sTAFBhKnGP02y/ZbEI1ZLH+peUmjrIr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405665AbgE1RyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:54:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35117 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405636AbgE1RyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:54:08 -0400
Received: by mail-io1-f68.google.com with SMTP id s18so17067655ioe.2;
        Thu, 28 May 2020 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXLE+hw0w6RsVL8ujWxDddinVNOPcbe8oeBiGx4U4y0=;
        b=Omn6ncrsA0wqpeEsY8d0dQtfshZ75h0jp1aP0iJPskVjw81XLu3Y14+8wRXuh9KKZb
         6I8VH+UWsG5itUGKzBjPGzTG4hANxG0HsHw7VTIslxefe8hlVT78a6dJf5u+e2UjAx3Q
         P1arSfMORRfTWNO0Mdno2coA3/fBt3zA3LgYUNb4ntsh0byL0QNKmF/HLRqgR1qjppCk
         xYbEvgso1TCfgLXzynpmxQHVuJ+UONWPYFX0J+pwR7/l/FKCI1i8TL8hF1VJNr+dR3w5
         nOvJGx/+dBNwu5ni2cWAg3ebpdCpUofPo+0cqHLRbWydLftsys/9WhY7OCYZz4yrrvv7
         yv1w==
X-Gm-Message-State: AOAM530/jZclg2tR55RypHGddv3Ud/lJSQzc17In+wSy8ey/wgWZLSgF
        w2WcSjEETWenWFWQcYub/w==
X-Google-Smtp-Source: ABdhPJzdsnGxr8r+P/rlFxY5YLuI/SYV2Z9WGs0abHlvHKPzWqYRrgz+p4NnKzOb6gC0k77vqvF6Xg==
X-Received: by 2002:a5d:965a:: with SMTP id d26mr3299182ios.33.1590688447831;
        Thu, 28 May 2020 10:54:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v14sm3418726ilm.66.2020.05.28.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:54:07 -0700 (PDT)
Received: (nullmailer pid 399169 invoked by uid 1000);
        Thu, 28 May 2020 17:54:06 -0000
Date:   Thu, 28 May 2020 11:54:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: power: supply: Cleanup
 charger-manager bindings
Message-ID: <20200528175406.GA391088@bogus>
References: <20200514230435.11798-1-xc-racer2@live.ca>
 <BN6PR04MB0660E57423994D19C84370A3A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660E57423994D19C84370A3A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:04:35PM -0700, Jonathan Bakker wrote:
> The bindings for charger-manager were very unclear and didn't
> specify allowable values in many cases.  Clean these up to show
> what each value does and make sure all properties are documented
> here rather than using wildcards.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  .../bindings/power/supply/charger-manager.txt | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)

I guess you're just documenting what already exists, but I think this is 
not really a binding we want to continue using...

Acked-by: Rob Herring <robh@kernel.org>
