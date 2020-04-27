Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06BC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155AC206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="di+1djng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD0T5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgD0T5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:57:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BAC0610D5;
        Mon, 27 Apr 2020 12:57:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s3so15248740eji.6;
        Mon, 27 Apr 2020 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GJDhC8dz1UCAtH/BxA6Y2i5c6CSS8QiVlm7CC6ceN1Q=;
        b=di+1djngWKc+yBC2sVVRtlvVb6+ghANoyasyRkhw59rY5kpK2yn8m+5cT/EWBPGfrB
         GDuYLd4+X4e1KRbKKeySJsNuJU0mG9bZSHX9gELo/O8G7ngaYWb6+89q/0Mpfw5RmztG
         P5vOYApZ2rU41U0UNhigD0R5qbWi8SeZ2C9vz2ScOfqKzuFAT+ePFKkDgrzA//TTsrIN
         BB1YJ4tNXtfMecXR+iuvRftLru3ySi98XzLTmWSSSzlaMNrDF1+uTBW1C2NBZtUOBE01
         8bNa+HMyzrr4Cwttlqy8QSwECGILgikMpQzN14ZGPzCjpAJ1vJKURyvDw80JpzHRxDE5
         lrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GJDhC8dz1UCAtH/BxA6Y2i5c6CSS8QiVlm7CC6ceN1Q=;
        b=R5MmhZz55L6T8epSv8HZMCSv2ovJ/l5r9fpclHgDFf6+P9yyPccCcPSLPYhDKBWn3m
         oHFZbu8D7FCWI7g4e67PHzTKTtuEd994iljIrZdMiregWXJicFco34zZSrg0v3ll6CR5
         WyVECVVpKw0aw+Dp/RaX6RWFLtbmFZmpvB9XGqwO4ksllYQqXJVEeV9XKLig/EkVO6ha
         /jXTjmPYj7lXra824b3ut4iCTbdUwfspq004uyjo7mBOzPzNagsRELJ+BCqe8b3bjKww
         pMJWrcSgeAN9ecVGwWK0EtJ1i77uKd7FWxMT99CGpOPiYBRM/2Ik3yp4h2dhP3aj2Rvq
         uydw==
X-Gm-Message-State: AGi0Pub0blRpE0kF0MlA0G+I/JjJGLzDDt3GEbgfCvcUlY0FWO8bqhz9
        4TeiO/qpcmcEokpxvD1LNl3upYzWa7llClR6AnGKIl//tQQ=
X-Google-Smtp-Source: APiQypI/5x/k2ZEjeKzMnLvdY3+3lcwsOP3UmM0K9r50UkqbSjltr0j9Ig/Pn9uMY8rY/7QNMyS4rQpX/u8NmqSdeHQ=
X-Received: by 2002:a17:907:2098:: with SMTP id pv24mr21801601ejb.22.1588017463681;
 Mon, 27 Apr 2020 12:57:43 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Apr 2020 21:57:33 +0200
Message-ID: <CAFBinCBHuPLS8BDzO4Gb86TG3tNTtqmW5BSWy8jhPuN3STOTUA@mail.gmail.com>
Subject: clk_hw.init and -EPROBE_DEFER / driver re-load
To:     sboyd@kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen et al.

I am working on a driver for the "SDHC" controller on older Amlogic Meson SoCs.
This has some clock controller bits built into.
Using CCF for the whole rate management makes things a lot easier, so
I decided to use that instead of poking register bits manually.
The code can be seen here: [0] - but don't take it too seriously
because I have to move some of that in the next patch revision.

I solved an "interesting" problem where I'm not sure if it works as
intended (which is what I assumed) or if there's an actual problem (as
suggested by Jerome).

The flow in the driver is basically:
(the clk_hws are defined as "static" variables inside the driver)
1) fetch related OF properties
2) initialize and register the built-in (into the MMC controller
driver) clock controller part
3) initialize the MMC controller

Step 3) can fail for example because one of the regulators is not ready.
In this case I'm de-registering the clock controller part again.
Finally the driver returns -EPROBE_DEFER
(so far everything is working fine)

However, once the regulator (in this example) becomes ready the the
same flow as above is being executed.
Only this time the clock controller registration fails because
hw->init is NULL (before it had the values which I defined in the
driver).
This is due to the following line in __clk_register():
  hw->init = NULL;

My way to "solve" this is to clone the clk_hws while registering the
clock controller.
Unfortunately this means that I can't easily use clk_hw references to
describe the parent/child relation between these clocks.

I'm not sure if my way of defining the clk_hws is wrong, there's a bug
in CCF, this is a new feature request or something completely
different :-)
My motivation is to understand how I should to consider this behavior
for my next version of the MMC controller patches.

Any feedback is welcome!


Thank you,
Martin


[0] https://patchwork.kernel.org/patch/11463357/
