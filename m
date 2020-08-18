Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46305207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCKa9l+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHRPHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:07:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EEC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:07:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so18622832wrf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kz3kTcwHF2a+OrN5byUdnh38//L2z+SfVrhYCq8FFBo=;
        b=VCKa9l+59jL2AIGwzpE1bLZ9zsBeyMEYVRlQhSWSPl+5pYlXgfdOKQ3pR52dclz7DE
         tBGoXFJ1lfUTKTrbr0VsQ6/8ubwrLcOIQt+iambwKD4vO94aBADs+hQIWWpNrxtrXhEG
         Pq8vgtvBRd9k7SLvIun5McFrdZnoWsOhNZuDwixZ53kUUAlM0h0HNX3OglBjsqbGpgp6
         0Jnp+k5TGdbjcdeDScBaqjfiEvJD9aVEvzp3QnJI9r/fzzPLFPVyg6sOapdlmbR25xYW
         RA+gcEKSmrvaB+n8nKHJAa/P5c8OpPf8IKTEuxn1A8DE5FwXyKKsdvDbj8hAvwO+psUw
         mUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kz3kTcwHF2a+OrN5byUdnh38//L2z+SfVrhYCq8FFBo=;
        b=hCT/9L3mvXeFphTz0Io0JpsQTV3it0Eq8ebPKRBgHTd2nnHKzZbUxp42ppvHQGsOKR
         sW3NW5zj/lOE4K4pszENqBT+LCH5/nFihjcYu7U0n45aroCWoOo7l5wLs4nk2WUAcAzg
         HThFr8OqLPTyU9qTTpvchUkwHd7/aM4RktDIJIuCYh6weRn18eOpjlyqFkxcubKf88Kd
         VnBczNiXX/kistMHhZ13M41rMpogOTtn5g0BE1eHRvMoFDD1O/kiCIDph7zjT50y2SUW
         ZMgupmO31750PgsLMgfxqcAAd8XV0/P/gTeIenTBZaDxJQTkEGCRNF8RNWdnoYAD/xwr
         xuHg==
X-Gm-Message-State: AOAM532JL37MC/y7S6fTSw2JotMIybqPQAAWD7xAVMH/19PQq7WHGcYp
        A6KrGo8qcw65pADQV2TFf00=
X-Google-Smtp-Source: ABdhPJy/3VCGV4xF9tBIceW/kpcTFoTQQBkQNN7HbLL1XZZ1S4/04oQ+0xEn6uOZQ6BiXPKA5U2UYg==
X-Received: by 2002:adf:e712:: with SMTP id c18mr21633963wrm.92.1597763218793;
        Tue, 18 Aug 2020 08:06:58 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v8sm275614wmb.24.2020.08.18.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:06:58 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Tue, 18 Aug 2020 16:06:56 +0100
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Use standard BIT() macro
Message-ID: <20200818150656.4ikg6fwzmmnwqapx@medion>
References: <20200818134922.409195-1-alex.dewar90@gmail.com>
 <baecb36e-1f82-1e0e-6460-d6759a9193c1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baecb36e-1f82-1e0e-6460-d6759a9193c1@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:29:02AM -0700, Randy Dunlap wrote:
> On 8/18/20 6:49 AM, Alex Dewar wrote:
> > Currently emxx_udc.h defines bit values using local macros. Use the
> > standard one instead.
> > 
> > Also, combine bit values with bitwise-or rather than addition, as
> > suggested by Coccinelle.
> > 
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> 
> Hi,
> 
> Does this build?  Just checking.
> 
> Looks like it would need this:
> 
> #include <linux/bits.h>
> 
> since it (indirectly) provides definition of the BIT() macro.

Yeah, it builds, because emxx_udc.c includes emxx_udc.h after a bunch of
standard headers. I agree that it would probably be cleaner to have the
include in there explicitly, though.

Best,
Alex

> 
> > ---
> >  drivers/staging/emxx_udc/emxx_udc.h | 456 +++++++++++++---------------
> >  1 file changed, 211 insertions(+), 245 deletions(-)
> 
> 
> thanks.
> -- 
> ~Randy
> 
