Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83780C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564E42076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587068166;
	bh=AiNPZ2VgZl2CSCjt2mS5/A1PD/WVdJmhWFR07XM6x5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBaEjYkOugBsQy1f/JUmYns0yNUz1ByhsYlbBYzTVY/VKnRbiR7VOy3IV8GffsfpJ
	 PH5nib6/4lA2I4iYNS1oZHLHr9/74Jy3Z109po0exkdkZqaW5Jo+Hzrvvm/ob2dq/F
	 tTOJT2LtBftHiXelmIbPayIXk6stbl50oKTqL6NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDPUQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:16:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34541 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDPUPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:15:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so4216784otr.1;
        Thu, 16 Apr 2020 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1P8yKmsIvoKMG/emgLl0/MHDjpc5RU9WDXXNgLV3Wdo=;
        b=LWW5qgAFjuo+3fS+wvZ1U4JIwNcyZHsNC8/qo/vnefr6qX8pGIl9tRUI3zZcV0/GTv
         kepo4ykmj0Kr1D2Y1twXaTFZ+eJNac7EGVjU2waoGf5SIC+WN31oLR9QAFXE0l1mxuk9
         f702y5JTcCN2gthlhwkfRNOMuUTLaRa2Ioinsl5ubE0VWnGRhJ5VAHYqGilq0L88xT6d
         d95ZG3Dddl3ieaB93hXNjfVPkyC9+bO/Ky2ynLbwI+v86OqcsZQU4Nhhtmzrmha1811L
         sANy8eppo2zc5gMKkzHhy7EXGtcACXuUKowng9NCgTfqcG9UgsXc/IdAU6+TwvlTL2BS
         vwgw==
X-Gm-Message-State: AGi0PuaXYrmstcmOBv/7waGXcVOM/fO4K8dGjYpFf/mezG8qS2LICYee
        BhRxa5Z47B7+0gOqfYxtZw==
X-Google-Smtp-Source: APiQypJYATkzNqD1aOs3NsiPGqQoj9fe+miZIzifCuLxvAFoelYIaGEuOG4n+UvKF/rnltbQaG+fIg==
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr16346328otl.5.1587068147529;
        Thu, 16 Apr 2020 13:15:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c81sm7140920oib.35.2020.04.16.13.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:15:47 -0700 (PDT)
Received: (nullmailer pid 6335 invoked by uid 1000);
        Thu, 16 Apr 2020 20:15:46 -0000
Date:   Thu, 16 Apr 2020 15:15:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 29/35] MAINTAINERS: dt: fix pointers for ARM Integrator,
 Versatile and RealView
Message-ID: <20200416201546.GA6021@bogus>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <d8b0656cb3f1eacb10ca6168babb235d59a853a1.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b0656cb3f1eacb10ca6168babb235d59a853a1.1586359676.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:46:21PM +0200, Mauro Carvalho Chehab wrote:
> There's a conversion from a plain text binding file into 4 yaml ones.
> The old file got removed, causing this new warning:
> 
> 	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm-boards
> 
> Address it by replacing the old reference by the new ones
> 
> Fixes: 4b900070d50d ("dt-bindings: arm: Add Versatile YAML schema")
> Fixes: 2d483550b6d2 ("dt-bindings: arm: Drop the non-YAML bindings")
> Fixes: 7db625b9fa75 ("dt-bindings: arm: Add RealView YAML schema")
> Fixes: 4fb00d9066c1 ("dt-bindings: arm: Add Versatile Express and Juno YAML schema")
> Fixes: 33fbfb3eaf4e ("dt-bindings: arm: Add Integrator YAML schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied.

Rob
