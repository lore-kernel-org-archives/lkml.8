Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD0C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0A24688
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579101584;
	bh=PnzcP27LfYCVzByWbD2VDd/+SERrtyi5cqWlfzgqPa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SyVsHU3AcbIzGEExWKHH2T8RH4LLI+Kdd7s8dtUg0fXUqINixamEKqddtG2Pcd7HP
	 ugeeuCGM1nYIfrz4as7TpKKRjUGC1v+Ddgrs3leypzccu3WNfqedB6bra2sriBow73
	 /7UUjRW8QURV92xidH90ZIE3Ted2O/8eAAIXUzu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAOPTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:19:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37088 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:19:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id z64so15723023oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eb54G3sc1CCAx4sR/HWrdZKKEAIXwHpDF1vWmKUoplc=;
        b=OnPTbD1haLHelbpAdpbZt27RgcIk4ftv/qoYk5qta5unjyoHICHFJVRkww79w3KhKn
         gTm1o/vnwmf0sAwwh7siNaPKyqrMAXO5TsPpcmTCrIP4MybMzfVH5RkxNxQ3UvKZpvOR
         nGPJsUCNpkMIh2gKtvzOZ5pfpi53KT1Bgw9zaZrfpQQiK3fjwkymIRDesdGd+Zt0V1yt
         92CZgE/qZ7N4o3cI5NIl1LZO9d6Kla/5z2adenhMm8dCkA6hLfNObwdMtegUm3LxQ+Qd
         cozYput5GKIGyAPoF1EouzJ2c1z8yt8pQ+iiGKp7xKzT/80CPEs75ntlqgXCa7zEZ5jx
         Iucw==
X-Gm-Message-State: APjAAAU6EkxNcnP4QBKMoxSJlKfppQN8ddhBv7RHPA0AZPuwIb1R/azI
        k4Yw7mn5e9kRoQAEUVy69otRFnY=
X-Google-Smtp-Source: APXvYqxWS83GR5VRamCag89RDmAPBVWC+seN7NATjopto0BWeAQxglLz66ZUakS0be1Jlhi71Gi8mA==
X-Received: by 2002:aca:ab50:: with SMTP id u77mr234523oie.36.1579101582272;
        Wed, 15 Jan 2020 07:19:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm6593377oto.60.2020.01.15.07.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:19:40 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:19:38 -0600
Date:   Wed, 15 Jan 2020 09:19:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add MT6397 Pin Controller
Message-ID: <20200115151938.GA8182@bogus>
References: <20200110145952.9720-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145952.9720-1-matthias.bgg@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 15:59:51 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The MT6397 mfd includes a pin controller. Add binding
> a description for it.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
