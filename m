Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB62C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43532063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597702475;
	bh=fiLz46qR+zGbY9eL9yZHW2kpRCNWJra89xxyDniDJGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e9rmUcYiLIva0i0XRZScnxrzj1W15Urz/gFJZO6e+rRmCcTggl0qFUEcxc7oKdkbV
	 HGUGe2iE7YbdLDAcyaQ1PUCbW3hM4u0Gw6sPMGti9dKEmrQj6a1FIg5CtpuCUsF39r
	 FjgDhXiPRm4LTcdBVXgkBdJRkISYzfaYKs146+LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgHQWOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:14:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34242 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgHQWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:14:32 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so19315460iod.1;
        Mon, 17 Aug 2020 15:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foBu7vlYY/G29ni82ikVQp52e4x8u1lhbM6/dC3GFtY=;
        b=k1P+JgJqnjWNF/DtYeF+mRALWeR/7mCXHAP6Tnr1wMrre/lZNwQUOMQmvcIC9H2VTZ
         8Oxcay+Bh60O4AsycrQROCoh4W6tv9zieLNDjaXOEEFWbm0yA2xewzGhw1ldhgC1bEX/
         US8IAFkpZQQsU8y107EG478s0VEvzYyhnxOALqAHEXZci+m26dMN9pJoUugU7yazYBn2
         aAj9A5eI8c1ZCmpxi69RyLl63QhzMcYUlwEJqUHhhKEwLZqeogVln44odXaiX1uYArZm
         lHBqvv15iLhmR933ampsTw5FoH4Y1w1G8sbxw/NK+4H1eGHfziXDYhP4dd0tMXkbftqR
         W3dw==
X-Gm-Message-State: AOAM532iZgWqy1snZ48tkKvU3s7xA7PrmES0cn2/G39OWwsr6hOKmLBk
        /DLTa2gLUf20Y3RiXOnMfyCyzFM6oQ==
X-Google-Smtp-Source: ABdhPJyA+kTDNTLm1m9z8omYZQPX6Cegf0zN6kn5qehicaoRObp94mVMFnsOOcKT1dPXdV0V6bSOMQ==
X-Received: by 2002:a6b:15c3:: with SMTP id 186mr14101098iov.161.1597702471632;
        Mon, 17 Aug 2020 15:14:31 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s85sm10665693ilk.77.2020.08.17.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:14:31 -0700 (PDT)
Received: (nullmailer pid 1670911 invoked by uid 1000);
        Mon, 17 Aug 2020 22:14:29 -0000
Date:   Mon, 17 Aug 2020 16:14:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, nsekhar@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yamonkar@cadence.com,
        tomi.valkeinen@ti.com, jsarha@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/13] dt-bindings: phy: Add PHY_TYPE_QSGMII definition
Message-ID: <20200817221429.GA1670859@bogus>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
 <1596800767-784-5-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596800767-784-5-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 13:45:58 +0200, Swapnil Jakhade wrote:
> Add definition for QSGMII phy type.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  include/dt-bindings/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
