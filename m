Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF6A20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsKsRAKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOSUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEOSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:20:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C902C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:20:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d207so14476873wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=r2v1HguAOYkGPOHVSu5q41MOEyABhbj96sKt0yb+hYo=;
        b=KsKsRAKMbozzpCcA41vMWaMdfV8+vdQDKWIBlCHpmFpsCy/S04i77lqp3l8SDKB1Ud
         B3B8h9lWoKoWJvop3peTRdXKEtxKQvM463t0EiRiZQapWcXIjQFC8+cEX6NQyOQ2v1Rx
         byuQY+ReICOLVP8757m6uf/dqqKcJpEKgHD3rtoNKl1vi42VJ+h6ysd+JxvF2UwDpWj1
         clB62bsLYVk4PirFwEF8Er8CN+dIGUHoT/rfSaz995Mx7mzRLBMrqnoV5Uce4co5J+xq
         iJwtyXqt6v2xnhHS8nyZTai+dTYsS/TdEsLhY4D39cFwkd5aecohGB0SNZb0k53PBu+7
         rd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=r2v1HguAOYkGPOHVSu5q41MOEyABhbj96sKt0yb+hYo=;
        b=f8RGuTc8HtT/MWASmle6S5kHy8lNl4/lH6Va8jIGWTN3M5+BMse/BRT7Tt45riJKOd
         SJuNC8JwpPgld9dnEY35lqlxrTDKmy+EZYxkNmsSHz4Zc6vYxuWjLiA4f729Qs79MccY
         kHq4toU6j97pN235IrKoGhcLmw9YgwN7ZquUMn+kp8Co2Gcv3NamPWyT81FDz5lgcJmE
         jl5+SHRIo2Lhi080RQLbP221PBc+PWPprxadGgbu3vddjkWpBXNyoL08+vKMdngjFPXe
         2NtrY2YdjygjhwuK+gP4BdT9DjsJC+v1KIkr6EGsjQ997ZbH0xOqKuyOB7hPGuRQ7VRX
         +Hcg==
X-Gm-Message-State: AOAM532/rL03aM8qMd9df8utFlsq9G4WDfKXuEdpiMPG6q6kc8c3knmU
        hhzDU/kBTzSJAUK/aNOQZBzeVnuf
X-Google-Smtp-Source: ABdhPJzWhjquskfTi26VBpyQv4z2UMMBqrc7UhzEKH6DGtZSY7Gn1aa5cMEayXg/FBgTa6k3gGTE+g==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr5117441wmj.40.1589566814938;
        Fri, 15 May 2020 11:20:14 -0700 (PDT)
Received: from akira-laptop ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id g6sm4710505wrp.75.2020.05.15.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:20:14 -0700 (PDT)
Message-ID: <cc8dfc3e9b33951d43fbd6fb8d4bac0d07b3d2d5.camel@gmail.com>
Subject: Re: [PATCH v7 1/9] w1_therm: adding code comments and code
 reordering
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     rdunlap@infradead.org, zbr@ioremap.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 20:20:12 +0200
In-Reply-To: <20200515142926.GA2438037@kroah.com>
References: <20200511203535.409599-1-akira215corp@gmail.com>
         <20200515142926.GA2438037@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 15 mai 2020 à 16:29 +0200, Greg KH a écrit :
> On Mon, May 11, 2020 at 10:35:35PM +0200, Akira Shimahara wrote:
> > Adding code comments to split code in dedicated parts. After the global
> > declarations (defines, macros and function declarations), code is organized
> > as follow :
> >  - Device and family dependent structures and functions
> >  - Interfaces functions
> >  - Helpers functions
> >  - Hardware functions
> >  - Sysfs interface functions
> > 
> > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > ---
> > Main motivation on the first patch of this serie is to clean up the code,
> > document it and reorder it to prepare the next patches, which are clearer
> > after this.
> > 
> > One main point is to keep all device/family dependent code gather at the
> > beginning to ease adding new devices if required.
> 
> Thanks for sticking with this.  Nice work, all now queued up.
> 
> greg k-h

Hi, 

I also would like to thanks you all for your time and your involvment to help
these patch to be pushed up.

Akira Shimahara

