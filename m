Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9027F2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591136071;
	bh=+dxvJIrjntJH0nAf4MP7QjSNZZOP42me2PX93dArUCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UFtZbp+oVmLA+jMnvZkS7GArIlCnkN0qzc0ZYECHd8MfkZotM06KDsSs0uduFmruE
	 8jPGxuTYBS2EGb7jim/KIXmM757/ulh5YtEg2VS2ueusJrLfUCTOMgLNLPDdt28/q4
	 gfVbbdJ7SmYqCkHwZy+/GJHATd0+coZkLutPGbLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFBWOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:14:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 15:14:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so156265ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLGNp0bYqdgoODnvR5dT8Alq+1KnKRZvTkwH6Z7/c6A=;
        b=M2QrFy/uhcAqgs+stRlkgrzMXz/FWWJpJ5dKW1BGDexrTXGHHVMZmsouEZMEH+k6At
         40O3iTvokENTGG6qULnrnjBRquHj5u8RPumGZHE1lWNorzc8sz3ZcexmrYgX+oqMyTE4
         bIaWbyJDbvrfvBVKL8D2l1wicRwTaRrctwaZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLGNp0bYqdgoODnvR5dT8Alq+1KnKRZvTkwH6Z7/c6A=;
        b=jQHNq4q0cg5/aUf1JWS9wneP/BITxjyyfzKynYXHHhfp4ePD+wfMGNrfcGL04GP3h0
         UgWdgfvtgLJW1yK+ptKA7o+FodPCtq2pcAK9uZUpwQB2w9UkDM3hhai+sDR4J4F/PNgk
         /V4GziDB56MLhJpnH07F/2unjWB198cVHdcUDuzmO3Ahuh+M8HBBTAAlCrXIdac0WEt2
         dDWfMfWJdYVJPffInim4UdDQh26usGW6PnaN4NmPL7ynXfkpFDnKEYKIgNsJUTdDNw75
         yRV7GT8GouLA+kwxCZDwbhM5HmwvfQH1wrpo5wAtcP2cIKebM19GQBrTZZ/6XJBCVtB/
         BCsQ==
X-Gm-Message-State: AOAM531xq3a/8QHwwftaZwY2LaP4CRWzi9+KfK69ri9QwMWHL1HBjE+Q
        MJ5idDQB4BhgHOBhbakDRl6dRkyqcWA=
X-Google-Smtp-Source: ABdhPJz5XDzJq1aepJ4f0hbS/KjyLBlAYDEr/Bgh9MAJ8ffRwWgFKMmFO9G1ZRxC/5dSQee+58P4hw==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr595467ljg.383.1591136066790;
        Tue, 02 Jun 2020 15:14:26 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h10sm37241ljl.121.2020.06.02.15.14.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 15:14:26 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u16so18122lfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 15:14:25 -0700 (PDT)
X-Received: by 2002:a05:6512:7b:: with SMTP id i27mr294066lfo.30.1591136065530;
 Tue, 02 Jun 2020 15:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
In-Reply-To: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 15:14:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=winp5YQv7rFmUe2z=xYSuzF9t1mMt+_C_1iFwxjoqG6gw@mail.gmail.com>
Message-ID: <CAHk-=winp5YQv7rFmUe2z=xYSuzF9t1mMt+_C_1iFwxjoqG6gw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:06 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I've pushed a merged by me tree here, which I think gets them all
> correct, but please let me know if you think different.
> https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-5.8-merged

Ok, I get the same result, except my resolution to the simple encoder
issue was slightly different. I removed the simple helper header
include too as part of basically undoing the whole simple encoder
conversion.

But other than that we're identical, which is a good sign. Apparently
the drm mis-merge in the middle got fixed up.

             Linus
