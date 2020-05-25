Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47732C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4CE206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B590zO3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbgEYRqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEYRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:46:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6730C061A0E;
        Mon, 25 May 2020 10:46:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h16so15616158eds.5;
        Mon, 25 May 2020 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2KRprdRyB1yLX29l69jCxYiW4AT+hs2oi/96CNyvenM=;
        b=B590zO3AQoBBkFJzWHIXt5ubgZD4o6+e6lpZZJV0AbyqbCeYLPh8fQBwHMxjr3YMcv
         O5ZSm5joKRLceTCesSEQ7lhcPGdmXE1ayCLUKIVgsCfk6H0mV5gd5EVFYbZXhIF2CcFd
         S33SUQufMt7f1Qp/SrBBKieXWFK3b2jczNwKdJwFpWpqcWK4bxL9ixmrfMfBgfdX0Bhu
         +u2FAvIiaUHsoiYf+1yQVcL6X7OFWT6dcSM9o0srEHCUsj1s8mx2FfNJ4B/bHy5n4cBY
         qxBzAw8+XXSSTqW5LIbb62jT/u4ejQn1+kGhYhhPgFjyfeNyyU+cYkuyYrlXBrOF7iuo
         hDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2KRprdRyB1yLX29l69jCxYiW4AT+hs2oi/96CNyvenM=;
        b=CG88kxlIbHrCUj1g2gHzrfgoHLhK/aVioq2r0zVrI+By/4kEZSQ3PR2DnlkneSS8Oy
         GIjgX30s/U+vbapoHEZrv18GSWPXWPeTSalnsiQDl8fZAZZgUSnoz706c0TIc8X3yQmr
         ig1EKWEtawaI9xPdOLwoNORos5GI2mcDnvU6WoBVq66YVmKxaZ4X2BG2iP4jt93xMyYr
         HoAljvepORIjsxBF+cEt4B9oXBFY7ABXhA4VND6B8npkThEyQpPPm25GYjeOFxZnRVVK
         967e0UeMC+qH4VxpUb9PD6S3B3RPFAucbq6Nm+WoJOPI/ZLTwCWXZWwndSmd2d88Gxjo
         TwXA==
X-Gm-Message-State: AOAM532Nx+nHGZXPRGZoiBbjBVOWyu6MWDJTsTpRGoHCeW76364q3pLr
        vrLQ1tEMe0Q121uyBomWgls=
X-Google-Smtp-Source: ABdhPJz+bee4gQUCxpFDoDoRvWXNXBbI3KSAtguwWg8ba8/ycFK3oPuYu89ZSVa0nb+Vvy+8q1PRtg==
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr16964780edt.120.1590428781469;
        Mon, 25 May 2020 10:46:21 -0700 (PDT)
Received: from felia ([2001:16b8:2dfa:6900:4b6:3b49:50f6:6c03])
        by smtp.gmail.com with ESMTPSA id y16sm15922308ejq.82.2020.05.25.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:46:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 25 May 2020 19:46:03 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: reference to Linux Foundation NDA program obsolete?
In-Reply-To: <20200525094154.7c9f4bd6@lwn.net>
Message-ID: <alpine.DEB.2.21.2005251942300.12135@felia>
References: <alpine.DEB.2.21.2005240722560.5201@felia> <20200525094154.7c9f4bd6@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 May 2020, Jonathan Corbet wrote:

> On Sun, 24 May 2020 07:33:29 +0200 (CEST)
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > The link is dead; internet search only showed some references from 
> > meeting minutes in 2008, but nothing more since then.
> > 
> > Has this LF NDA program simply been phased out?
> 
> That's a good question...I'm asking around at the LF, will let you know
> once I get an answer.  It could well be that the page just got lost in the
> reshuffling of the LF web site - an annual event, as far as I can tell.
> 

I gave it another try and looked through the LF webpage, but NDA only 
appears in Linux FouNDAtion, StaNDArds, and OpeNDAylight; none of them are 
the NDAs we are looking for...

Lukas 
