Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B88205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hOZtlEBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgEMVWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgEMVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:22:08 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D0C05BD09
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:22:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so184801ion.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tGOgO3DH7KY7eGZj+l93dH69/CZG3Xhtwrztz8Xi5EY=;
        b=hOZtlEBO2LKyP8bHzFDDLBLE+AyP3GW51R2Bgu0+e70rfUZ9rIiczo3pB8s/u3VM70
         K0T9RD7NVB7brgPgne9G7Y9DKSqMwc34kmUSNaN1+tKmQKMyi7b2a/DSMwe/zY5/KEhq
         fQSq0XIBJbkr+PAekXcISSvdYkIgp1CyKT8+VJYoZrJ8KYzz0lTZCE6/MFJ87T2KQroR
         EtSZS930x4uhhtysV1nP2Ob/eQgc7gMe8HsNnHtxeeVeS/yekgc2kD61tz8HifWs7qcn
         aDv4sBzqEuxANANls7LL4SbixAH4tEKQkZN+1IFCsDhaPLM0Ftld10Il4H8V74Y2oTRm
         cjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tGOgO3DH7KY7eGZj+l93dH69/CZG3Xhtwrztz8Xi5EY=;
        b=Qwa02XasLOSoXTOnTRsPdGUs3L1wvBWkZOlh/dp0QWo1ow3ZQDS78d2yNuSsA2GZyg
         AuoTT2CBLpw3stDTulO4W8o4EEl1tweN0SRz4O1+gVdrfhmujdpt4gdiuGgxbcSWTSXX
         i/eZNMwMDDh8er+ZKBAG2zg+o9ViCZXyR5XthEpqRZvWhxRe7Zyyg1hl+5iptTE5i1Bh
         +1EhzXKUYgnNsB1nBIEVefQljvmrrQPE2nkrsCo0uft7v6dZUg2zbNRMg8GFMuvB/exV
         wJX/brph31fwCZeIJ9RW1ahuSL9M8BUqaJQGsdrbFl9/ddk/PuOivYpaUTa7Npy7v5xO
         m+gQ==
X-Gm-Message-State: AGi0PuaI5O4cvLT0yDRU5ec0OQVdcGBH2SZHQFwNbdTaLjSeyrmQhwTO
        zYDsqsJpsACdgB4oepYGVchJPQ==
X-Google-Smtp-Source: ABdhPJxZH8ktcsDq2DKyrfz9mzAZuFt485i9jtYbwe1JvROnYtyNj3dkM5M5qWN962L5ecYak/nF8Q==
X-Received: by 2002:a05:6638:277:: with SMTP id x23mr1463557jaq.122.1589404927597;
        Wed, 13 May 2020 14:22:07 -0700 (PDT)
Received: from localhost ([2601:8c4:0:32f::7b7])
        by smtp.gmail.com with ESMTPSA id j90sm272733ilg.70.2020.05.13.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:22:06 -0700 (PDT)
Date:   Wed, 13 May 2020 14:22:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] spi: dt-bindings: sifive: Add missing 2nd register
 region
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.2005131421010.18879@viisi.sifive.com>
References: <20200512204543.22090-1-robh@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Rob Herring wrote:

> The 'reg' description and example have a 2nd register region for memory
> mapped flash, but the schema says there is only 1 region. Fix this.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack, dependency for patch 5.

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> 


- Paul
