Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9C524655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="TcBR/Nf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAUWYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:24:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39965 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAUWYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:24:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so2282425pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7zoLTLkT4FRPpbHEk3PRh1Uf6zx0h1ZbdETeYpzu34=;
        b=TcBR/Nf2zex+WbZ+HvpriATJYWG4FdY9xDweikRmWGBtS4CZWv+47/bDt+CV5kKSi/
         7DSXjX6aud5eUmJw6QY+3Dz+Qzi3NTDKWBy4GnOBntx+OSzLgazoHkj8FkcERZvTUjuN
         /gppPWa1GyFKqoKWtsrQ/CvofmKJ55cLzTQOhDoWg0COxDk8WU3a7bBZzB8XRaN804mA
         Xrk+ned0WqoIQPjbhjULXTb1RCc8mhxES3BiKJf6FkfLafVEu/9soQBGmquOIoS82oWw
         dPcbta7hsRaIov7t9aoK82lteJRv8BmlPgw2njwJOUGQ/SzMHEyuyMIuZhbZ3blAnYjo
         OSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7zoLTLkT4FRPpbHEk3PRh1Uf6zx0h1ZbdETeYpzu34=;
        b=K+8bmGXjLPZQjSDInfELI5rumJAh07luAfWxCZAkXd5PH5vuC0U2rKvAqjMEdh1IRI
         EA+OiDzAHs1mVH1a+q1FjbayFSO+rp+wbHGBv/xd66l02TieyO4eewRYm5GG1lmlUtBq
         cm9OBSs77bvZCgQludt4fmGhvDl7LPRZnvDrcu5UW4Gzoi/QU0xtPt6i+RH+cMmRdkXz
         tziq6aSJHOhEsQrEmlbEdbYv2QMfKcPGWkF+NN7A99n0lNLachO9tWDHIleEw1TKo4kV
         PVNPkyhFJkCXRCiPIdla+fmzC5xlaOPQZ9S9IjMAYOLQRpGBouTQKQ/fgdsgzUHEBFXg
         7dkQ==
X-Gm-Message-State: APjAAAXv4WHPm1Q1ZpmfJsHkackVhNDJr8D07TGIFxF+KVJgzb3G6X8X
        sinsvgrDMMCra3tuwsLeTIlnwA==
X-Google-Smtp-Source: APXvYqxFARC+hUQHitMqA8VCva1q6WgoKntCtzw9K72ZO50v/in7d0ZjkWBpU9yQP9sxdOqMI0i58w==
X-Received: by 2002:a63:5243:: with SMTP id s3mr7416825pgl.449.1579645445908;
        Tue, 21 Jan 2020 14:24:05 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u128sm44956335pfu.60.2020.01.21.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:24:05 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:23:56 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Laurent Vivier <laurent@vivier.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 05/12] net/sonic: Fix receive buffer handling
Message-ID: <20200121142356.2b17ad74@hermes.lan>
In-Reply-To: <e20133bf43ec6f5967a3330dacaf38f653bf3061.1579641728.git.fthain@telegraphics.com.au>
References: <cover.1579641728.git.fthain@telegraphics.com.au>
        <e20133bf43ec6f5967a3330dacaf38f653bf3061.1579641728.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 08:22:08 +1100
Finn Thain <fthain@telegraphics.com.au> wrote:

>  
> +/* Return the array index corresponding to a given Receive Buffer pointer. */
> +
> +static inline int index_from_addr(struct sonic_local *lp, dma_addr_t addr,
> +				  unsigned int last)

Why the blank line between comment and the start of the function?

Also, the kernel standard is not to use the inline keyword on functions
and let the compiler decide to inline if it wants to. The compiler is much
smarter at knowing the architectural limitations than humans are.
