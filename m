Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C015C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959A206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582734658;
	bh=Yjfv3vEeeM6oMcrZPjmkEgk/4Z8UtEfA6ZcAKmN5n3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eM89NW4Xl0vgnMDnEhVORa3GcVe1XH7AhJzWkSgxnTG7MzoS0RP62UuXPQPE6IK4m
	 G/KjNwcL1deC/tDNwukgR8rUaDrsVo2ShWUMInVvn8PFGgV5zd9OsjDLD5/d/uBf38
	 W6BWo6uf9u1ZA3baXomF9J5r2mc1Q+xHIkfj2lXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBZQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:30:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40833 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:30:56 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so79450oii.7;
        Wed, 26 Feb 2020 08:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACI9a0q/BgBWalLw0K2YIrmMcsUsmnK2gwfSs/vtPsM=;
        b=a4uMtxyJ8IeuixiuhCZfXkR5LESIy/KizK7mCbkMPvJuS08MHSVWMX/OG34Ojl8FPz
         7IaRWLRWp4kqROXlyQ6BPvgID46inDRzrlYtIKhd3yRI9/XwWsYhqNyeXWvNGglUkdGz
         Jiotf9/+iHBMWdyu3oK/Qk6+th6Ph2fqHSjenDN3ipEwhWVwjELABY5Cs7EtXgBIn5zR
         W513jzd9KSAvAEq1Fh6bxOfnApYezJ3srghIp644RADyhcTYBJd2lODVFfJHhE3rn/wu
         idab83vrmCQJWz/I5vn/KmrNbZWDeYddC67xEswzOSom4E+ha95g8oF+VnSXzRWIFIU2
         mDjQ==
X-Gm-Message-State: APjAAAVj0hZkkrN77P4Xtw08YI0CzEstEcMkFmqSb4agMrorIjmDlrAF
        h3dGWbmXjE107GXTOhwkfaTUpOSt7g==
X-Google-Smtp-Source: APXvYqwK0Rc7BM7k+hjejM3j3aYFkebquxvpYKt0YbE8+SJreIg9fwmtnodQ6siCckcxVnFX0VTn2g==
X-Received: by 2002:aca:4d06:: with SMTP id a6mr3839205oib.27.1582734655656;
        Wed, 26 Feb 2020 08:30:55 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n19sm951525oig.57.2020.02.26.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:30:55 -0800 (PST)
Received: (nullmailer pid 26591 invoked by uid 1000);
        Wed, 26 Feb 2020 16:30:54 -0000
Date:   Wed, 26 Feb 2020 10:30:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-i3c@lists.infradead.org,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH 3/7] i2c: allow DT nodes without 'compatible'
Message-ID: <20200226163054.GA26533@bogus>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
 <20200220172403.26062-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220172403.26062-4-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 18:23:59 +0100, Wolfram Sang wrote:
> Sometimes, we have unknown devices in a system and still want to block
> their address. For that, we allow DT nodes with only a 'reg' property.
> These devices will be bound to the "dummy" driver but with the name
> "reserved". That way, we can distinguish them and even hand them over to
> the "dummy" driver later when they are really requested using
> i2c_new_ancillary_device().
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 1 -
>  Documentation/devicetree/bindings/i2c/i2c.txt        | 4 +++-
>  drivers/i2c/i2c-core-base.c                          | 1 +
>  drivers/i2c/i2c-core-of.c                            | 8 +++-----
>  drivers/i2c/i2c-core.h                               | 1 +
>  5 files changed, 8 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
