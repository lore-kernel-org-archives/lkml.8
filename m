Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A3DC4BA1C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528F424670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582735709;
	bh=AyV+rEVApn0d86MUGYS3G+Ev4cJkOIvxqRx9o7bXNf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=olmqquWV6OT3uqj0v7dam2oCVal+AKzX6YjL0fw2wN7Ej/AahVvxnPf+UD7YxbXL1
	 0F6/Y+RCGUMsKCYqYDpX1x1RQ1N4AaGefnmOSt8LJgQTTZXC4fXWX9iA7NEwypse7O
	 YgsQCHBrSG5Toe9KMMHev+nS7zZmesiotNLGyGxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBZQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:48:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41036 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:48:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so135559oie.8;
        Wed, 26 Feb 2020 08:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wYb2SPyfU9sT5dHwc2B+qBWDt2ccSquWhAdxVh14F+o=;
        b=SXMlzPt4EBNdDzcLdHsSxdjqBlopqdyt42xwiO410qYBE+cAhq9LMmb3RC2vXB/QO5
         i/mrj5dPD7DzymKLElX5r4PqDE9wf4iWBWOnT3AbOoTbkV3trxdSGChzAbwI8gkZFBHg
         YwNLi1LzvcGVDYsw1956S49Os3V7ICIpARWFgOzhRoMMEhArKe0PawF8b+FC5x6q329O
         meg7vXWrYgRZkuEVQPuXLLuGbUhUDc3XCG6jDBye1ViaA/iOkl/L1jTwpCNa/p+7ZWcK
         FE1IYleCDMIArJ38mShEmbBjHjA3au4E4WwCkBj6xqzqUdJGg1GJ0utxro/CtNmqVAnM
         IIrg==
X-Gm-Message-State: APjAAAXVP8awnQRlec7K9kRkbHMfFNTkB/dQwgzjviFurOrAXPHK+ilG
        XNRdLRdwaZPjJot116bfzQ==
X-Google-Smtp-Source: APXvYqzqWkKvdNyvC73lIfPwrzjTstV2xUgnU7vLxawHZqyFVI4GcqFEaXpJ+Hms53LlnWG+uylBPA==
X-Received: by 2002:a54:4f14:: with SMTP id e20mr3776108oiy.84.1582735706721;
        Wed, 26 Feb 2020 08:48:26 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k201sm978469oih.43.2020.02.26.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:48:26 -0800 (PST)
Received: (nullmailer pid 20055 invoked by uid 1000);
        Wed, 26 Feb 2020 16:48:25 -0000
Date:   Wed, 26 Feb 2020 10:48:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v4 1/5] dt-bindings: hwmon: Document adt7475 binding
Message-ID: <20200226164825.GA19992@bogus>
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
 <20200221041631.10960-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221041631.10960-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 17:16:27 +1300, Chris Packham wrote:
> 
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Add binding for adi,adt7475 and variants.
> Remove from trivial-devices.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - split conversion to yaml from addition of new properties
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 57 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  8 ---
>  2 files changed, 57 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
