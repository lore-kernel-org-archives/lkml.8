Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77693C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4843C2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586898092;
	bh=iAaI96UO9jO0nmyHDUvCt1c5ZT2a84A5TIYscM+YLpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oIlGosMgU3a6VqoYFOSqBs4MrU8iv7DZ+n2trvFlvOpxzlk+P07C59DY5HkbzZOR+
	 LvUSXqVjWKt/cak3tsm1HCIjqC4NJoo37k2IOIYKMLASf2HIkMe0rT4ayBN+/lhTw2
	 +Wq2tgn1Qk1z+T1qPbBmBaZi4lSysVvjLPJv5v4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633556AbgDNVBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:01:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43223 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633541AbgDNVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so11700668oih.10;
        Tue, 14 Apr 2020 14:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tnI9OFnswT+j7ufoqi84C+8316n65ZdA2j48i1vU10=;
        b=uOzhGkswrjuWE4gpstlr+MZoBaKrHDK0U0WXesXuKFu6b3hpWtJi+nIufd7BrKPi7z
         li/4h0edLbp9DQ2oXRwz03PUTEE1F/dDUZ4aY/sH/ztcz5DKRZKbt8CEUzP8sdp5xIGH
         awyyMgZxrR2VCTU9vdYcnbWbNsJ4bUhYgbjlBmT/OpQccOdJ67QRq2x9fmYpfX7/WgsH
         hQZhWsnME4pqerew1tnKCpSI82qjEkhMW3/v+LsfV/w26Qgg86ldr/BFWNT769tvgO7j
         bp6YCP+YxoZX7MSQ83BiXtXHjRzV6Jmq9OL/L5AOwNdm6GNcgJjkNrQR1kfC66btbP6n
         Xm/Q==
X-Gm-Message-State: AGi0PuZRLHdfVWXfv29L25uwF1kf3GIqcKe9SKwPOBry2vx6Qqo7fuUE
        PdHFxfjRoXaMhS0e9Jk3Bm2du2M=
X-Google-Smtp-Source: APiQypI88cfV+Vx4EqdyKBvxYVVd0MKPigaGXZDKD8HyL53QwsqxG0yMTlV8exKkTgUJ2NGdCF/Omw==
X-Received: by 2002:aca:c385:: with SMTP id t127mr16945398oif.49.1586898066938;
        Tue, 14 Apr 2020 14:01:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s10sm332886oig.56.2020.04.14.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:01:06 -0700 (PDT)
Received: (nullmailer pid 2708 invoked by uid 1000);
        Tue, 14 Apr 2020 21:01:04 -0000
Date:   Tue, 14 Apr 2020 16:01:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/33] docs: dt: fix broken reference to
 phy-cadence-torrent.yaml
Message-ID: <20200414210104.GA2508@bogus>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
 <3f1cf6d74e392f3ee9f894d82cb7ee29d04c1b6d.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1cf6d74e392f3ee9f894d82cb7ee29d04c1b6d.1586881715.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 18:48:34 +0200, Mauro Carvalho Chehab wrote:
> This file was removed, and another file was added instead of
> it, on two separate commits.
> 
> Splitting a single logical change (doc conversion) on two
> patches is a bad thing, as it makes harder to discover what
> crap happened.
> 
> Anyway, this patch fixes the broken reference, making it
> pointing to the new location of the file.
> 
> Fixes: 922003733d42 ("dt-bindings: phy: Remove Cadence MHDP PHY dt binding")
> Fixes: c6d8eef38b7f ("dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
