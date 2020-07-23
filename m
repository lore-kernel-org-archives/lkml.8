Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D47A207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525780;
	bh=m0YD9vZWoaOyt7S+phVIzJZ92p81rgRrNd9k4MtenYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bgua/StI+oJvayMk2p2vtRUnt4FBvqQFvBRHXzfhdS2183gNqdOUVdQE7IEBzbhxb
	 584ijiQ0VOySIw2GEtDpNssEMJbBRiFlse+EpSoL/p2uUIw4S5LLdfLfjpr1O9aHXj
	 bDHPhsPIGBErAVRSidlOUFQBxBAgWlMAu3gdRmHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgGWRgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:36:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37334 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgGWRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:36:18 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so7131911iob.4;
        Thu, 23 Jul 2020 10:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVB+vIUtjaaHPulso6pqHodFPKr8jx+epmHWtmKS4+E=;
        b=YqnGeGuGlg2m2Ncw8hHRXsQCXJm9tB9sjsqNvMhPT4MhxAdQPgH7Hvp/KQzjEQOGrq
         XjWlJZCt89ihqWPOywCu4FWkKEGyI3etV589F7OSDn9WVgWTKSHb/BC5Xx/E01MWQAwe
         unmaxTzmdt4Fo++cJKUwmF5a3I0cMRfVaFNkpOHgiABZz+U1GZOg0TfW/Mo0GhsGEUU/
         sz5p40qYVSux80fRVg15547fBA3UDGj4YPrvTNoJw1nF0JvKqySaFw3wQO89cy8PK+Vn
         nRVeUkHfmIn6tMo9s9+M52ZOMnITB4ok7xd+M89ZCJmyP52HVvKxqJq2KGo6tyVWkmjW
         YsOw==
X-Gm-Message-State: AOAM531Op6CZx4PcodI99WvgC0tO/NiVKztOCynd/W6OhG4EED9KbPgj
        cTKcnvDUHfdqRMsx5o3/cg==
X-Google-Smtp-Source: ABdhPJyjHCEGi+BzXFpL9NnYenkOEeH2KtSTzv9WSYzqvQH5l+b0aE+BfqJOL1KR7fPeaWNNUfBqXQ==
X-Received: by 2002:a05:6602:154d:: with SMTP id h13mr6114131iow.210.1595525777983;
        Thu, 23 Jul 2020 10:36:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w74sm1789076ilk.24.2020.07.23.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:36:17 -0700 (PDT)
Received: (nullmailer pid 581186 invoked by uid 1000);
        Thu, 23 Jul 2020 17:36:16 -0000
Date:   Thu, 23 Jul 2020 11:36:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: add Zkmagic A95X Z2
 description
Message-ID: <20200723173616.GA581157@bogus>
References: <20200718105343.5152-1-jbx6244@gmail.com>
 <20200718105343.5152-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718105343.5152-3-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 12:53:42 +0200, Johan Jonker wrote:
> Add Zkmagic A95X Z2 description for a board with rk3318 processor.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
