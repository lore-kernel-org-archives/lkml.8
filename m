Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28242C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0834420700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uADltm6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgEZXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgEZXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:53:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE299C061A0F;
        Tue, 26 May 2020 16:53:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id i17so866407pli.13;
        Tue, 26 May 2020 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zn2rot0EJVC/F9TI89vcU1F8o/pKxmCqY4XQMCAo+m4=;
        b=uADltm6w1G/hYcnF1MHKtRnFgwgv5Xb+punhDnVMashu2D+HjRzJ+OMqecC8RX2TRm
         qxmh18DzVqCeIdI+cDXDOBhTJcp2DtcILt7iFWcwb9tgDNCzOro6vT6McugFrhlvfzm3
         6DemceEQS7p4ZG6k6nqZBuci7Qk8ASf/tdb78a5tOCBBJYyGGL+UWyQZlvEGfWRV8pxo
         d9RuO3ZOSlYjPMiFtuQziIwBoSyOioJgQVbo9rLX7/cSQ7oqt16ZnYqA0AMo7P5W/xc8
         rQ3ppd/oEVezQ4YatafPZaP2pUCAb+tZMdSyZ0dGnpxFDDNIdqwNJ2VbYfzldwIMPJdf
         BvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zn2rot0EJVC/F9TI89vcU1F8o/pKxmCqY4XQMCAo+m4=;
        b=qfuYYi2g2V8iQe3lNTUuxeLXNkkYAh+7VnlK/PGhoPWcji8dLOUyLvzccO8jG/c9XV
         e0PlnhDAJBk/RwULl8ZCRCvdKzLqHZSizHca/0JJiPj0fh1Qr3w1H02P1eGvRtNC0ikY
         E+fhbsR0yjariQOufB3HD6b4QhPPnfDXoEy4imbre90J5qWXCV37AsQgw1ADjdo1sT1c
         5lgW5jWHYL8jGwoyt0v0ckS1qL/6EzRzfcrYXx6lFsGY2jHui8220WZhAFLKxJvIw/cO
         kRJWVKwuaWs5nJcA1Ak2M4JhhcRqcgTCZ6nkWohYKNXbggtq1GBypTrKWc3gq3ciV2sn
         hfHw==
X-Gm-Message-State: AOAM530Rd68kYVkMFkOVxkrgTq/u9cbBmaVt41Mp2wa5O53xLxpOVtrS
        bLtUQnrqot/ExV3tUtmz1jY=
X-Google-Smtp-Source: ABdhPJxBp1OGT4pycrI1+BFnzgLt3BtXbfG+QglwOXmGSDwmTanTZ9BjZzlOfeU7FZlAmz5To1PenA==
X-Received: by 2002:a17:902:c40c:: with SMTP id k12mr3229652plk.11.1590537191974;
        Tue, 26 May 2020 16:53:11 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y14sm494417pjr.31.2020.05.26.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:53:11 -0700 (PDT)
Date:   Tue, 26 May 2020 16:53:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 1/2] clk: bcm2835: Fix return type of
 bcm2835_register_gate
Message-ID: <20200526235308.GA2330247@ubuntu-s3-xlarge-x86>
References: <20200516080806.1459784-1-natechancellor@gmail.com>
 <159053652408.88029.5210144839543172586@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159053652408.88029.5210144839543172586@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:42:04PM -0700, Stephen Boyd wrote:
> Quoting Nathan Chancellor (2020-05-16 01:08:06)
> > bcm2835_register_gate is used as a callback for the clk_register member
> > of bcm2835_clk_desc, which expects a struct clk_hw * return type but
> > bcm2835_register_gate returns a struct clk *.
> > 
> > This discrepancy is hidden by the fact that bcm2835_register_gate is
> > cast to the typedef bcm2835_clk_register by the _REGISTER macro. This
> > turns out to be a control flow integrity violation, which is how this
> > was noticed.
> > 
> > Change the return type of bcm2835_register_gate to be struct clk_hw *
> > and use clk_hw_register_gate to do so. This should be a non-functional
> > change as clk_register_gate calls clk_hw_register_gate anyways but this
> > is needed to avoid issues with further changes.
> > 
> > Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration and OF APIs")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1028
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Thanks. Applied to clk-next.
> 
> > 
> > base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9
> 
> Please don't base on some random linux-next commit though.

Sorry, should have just used clk-next directly instead of the HEAD of
linux-next at the time. Just hard to keep track of all of the different
maintainer trees so it is easier to just use linux-next.

I do forget to use the output of --scm from
get_maintainer.pl though, I should use that more often.

Thank you for picking it up!

Nathan
