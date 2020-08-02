Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377ED2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAH6OwZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHBOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHBOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:54:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973AC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 07:54:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so21368936wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GtZTe+zRQJF3kuX+ITlnrw72fV/WhLEabJ1cE7HpuaA=;
        b=mAH6OwZcfTn1yh3vVPPM1qvCyOVZKbVRx0DNWRRSIP+LZw0kifLqagZc5+m4cwhjDE
         Andzb+K8iUQnJqs53lugdULyZsNwgINWsoWIB3ewvpm0xtVd4nS3nd6BnBCBZVObsWc1
         LYtMH1o0j6v9STBL6mAcZm6d8t/Yb4fy6M+CCGYYu3/kBSJhBGfxlsoBWO8mVtID8JBQ
         j3BTAYhTdGaXz37uucHC07xAq0Wa3xRCc5kSSkQzKR2BZrCh/BMVsSRpj4oAXfWnpZ8l
         Pp4qEd+j1XKBe9gcLRwj1Jcr7D+1XVEuo0JR0SpfYCpojEdK/g2qtHk/HeucG0h8m/in
         zmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GtZTe+zRQJF3kuX+ITlnrw72fV/WhLEabJ1cE7HpuaA=;
        b=fSOQQrk2qRQO0KO5IJUY0uPpTC71ryboIEjuF8vNJrY6fxzJNI3/Tdz0dxjCQ105nu
         jVktw54w4BNrPap9s/Oz1/s4WuqO1qYn/UWMoZgnYALVJtmGPjmMB3EFsB597lHq46k2
         asdokyNp93cEMsPCi5/4B7OIjmfxlAtE09U+cFPqmHy7zhf0pTmR27kOOEnHddhudRpj
         B+tyQLce2+Ac3mEFxz1+sUM55z7Y7HW96EBpt7QWeWKdGH/Rzq/Gbr9BCUeoFZLT/0aX
         t5WMMi9wYKPFim/sXaBbbUl3lTv6DCpeSPZPXI6Cxx5ve4H+1WI0ofXwfrX0gzDCCsNx
         JjLQ==
X-Gm-Message-State: AOAM531YMCG3ZXh8LJS/ExoXUFy6Lu1Ob1lDB6oTUa8lN69HQCH8L31h
        u1VgJn/vucmHUII7vZ713A==
X-Google-Smtp-Source: ABdhPJw/ElSVRxuxsekh74zCGizzDHbG1OlPtERY3ntq5drV0ig34G5okeWyGN38Z/bHc6TMMXA51w==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr11008061wrn.51.1596380094959;
        Sun, 02 Aug 2020 07:54:54 -0700 (PDT)
Received: from localhost.localdomain (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g3sm22770859wrb.59.2020.08.02.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:54:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules@gmail.com>
Date:   Sun, 2 Aug 2020 15:54:53 +0100 (BST)
X-X-Sender: jules@localhost
To:     Joe Perches <joe@perches.com>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Checkpatch tool errors clean up
In-Reply-To: <46c11b84dcf83d185ba771f92d2348aa82621dec.camel@perches.com>
Message-ID: <alpine.LFD.2.23.451.2008021553270.85114@localhost>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com> <46c11b84dcf83d185ba771f92d2348aa82621dec.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Aug 2020, Joe Perches wrote:

> On Sat, 2020-08-01 at 19:45 +0100, Jules Irenge wrote:
> > Hi
> > I am proposing these 4 patches. 
> > I am currently learning the core kernel the hard way. 
> > I will appreciate any feedback negative or positive.
> > Thanks 
> 
> Generally, whitespace only changes outside of drivers/staging
> are not encouraged.
> 
> > Jules Irenge (4):
> >   acct: Add required space between variable and operator
> >   audit: uninitialize global variable audit_sig_sid
> >   audit: uninitialize static variables
> >   context_tracking: uninitialize static variables
> > 
> >  kernel/acct.c             |  2 +-
> >  kernel/audit.c            | 10 +++++-----
> >  kernel/context_tracking.c |  2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> 

Thanks, I take good note.

Kind regards,
Jules
