Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9D4C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8FB20731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840699;
	bh=XRkGPLFzWBn7iQjoQPmh5T65FcJ2DxF1R62VPasflg4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Hb8gRX6WASiFRg3ArFXDZtsuhmSe9nyrkB5MgTmlmbSf4N8N1j0LuzZAA2SRJnD3e
	 +R6VXFS+85lWPHsEtu8ic9sUDx04tEMdmxx0SBbvQb+55wLwz4NnZgV24ZmnUjaKX4
	 HAlxtLDJ8jmxOATo/PsGZeVIoCI4poWQ7rJ/LQw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIKQLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:11:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43928 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIKPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:38:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id n13so10372849edo.10;
        Fri, 11 Sep 2020 08:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DjrxY7Lk4EK6rFC1XPIpw7t8L5lPZ8egTPE4yUmjhU=;
        b=dHWKLfnxULNo7qbHjI0Vl5pTzWxwvGJsfDn7EbYsZNGdSIgM4lqFZHs9MioN1nLjCu
         nWcpoOnXY+0+81J8eMH87a1HvJB1KGzBgmuCEbjIENtmzuc1gwhT6YNvbKagw1fK1379
         BKFLN030erqeQ7p6rQjvDlJxQcyvewqTR/y9PsuQefu/pHny9q/dFzMazpi7LmGVyIJD
         n+0gdnG+BWHrC8wL9sJ/h2iOXQZL2eAMBc9Xb4rjeAxAvtitZ/P7k2LKheBuWsTt0I1z
         3XzZ4E3qJanGhwE2AYLSwLk+vTQqhmuoWX12NechABRCniX+MwRNiYMYjkWeurUcHJa3
         HuLg==
X-Gm-Message-State: AOAM53393D9UAbOokkbY0gPJycakIxLjbrRtopIBz8a4ol6nE53YFSYu
        ED+rYHBuGJ53Na7Otb7L+3z5jTtMvnbaPQ==
X-Google-Smtp-Source: ABdhPJx1oFowCxvi4gz9N5G5FJwtdy3gLuMaWdJJuUaR6LNVTy9hGMGrP1GbxlAQ+8eJwfAJUzN1Yw==
X-Received: by 2002:a05:6402:8:: with SMTP id d8mr2549402edu.15.1599838685470;
        Fri, 11 Sep 2020 08:38:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id bm2sm1951756edb.30.2020.09.11.08.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 08:38:04 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:38:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Remove JZ4780 DMA driver entry
Message-ID: <20200911153802.GA18279@kozik-lap>
References: <20200817184131.907-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817184131.907-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:41:30PM +0200, Krzysztof Kozlowski wrote:
> The entry for MIPS Ingenic JZ4780 DMA driver is not up to date anymore.
> Zubair Lutfullah Kakakhel's email bounces and no maintenance is
> provided.
> 
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  MAINTAINERS | 5 -----
>  1 file changed, 5 deletions(-)
> 

Hi all,

Any comments on these two patches?

Best regards,
Krzysztof

