Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3529C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14A62078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239596;
	bh=1KT+vWhBgSpztqjzGMDQ4D4S8JwxH2WCmGD+wQfbPAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H4tM6TK77ofRVE9LaqnVajsBpbutC9XKVmQ17Cm9Tf9yA4WT4oh5JbOjgakR/KbZJ
	 lfguMDioJcz3jafddHudsPmpBQIGdfSQtY3cakjPP69lGO1bgBWw3CE9HHZE90zpXK
	 GVmfvlwfA0pL/jckfGwmb5HRLVtsTseFXg0oghcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgFOQqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbgFOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:46:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945BBC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so20050843ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=ZWk3x5iEjnyTLq8IMemOkgARbFQCw/Q53/428riLywNB6u9f+bQvXVcEgFAYoeyppV
         fCCBULVD7KWfArLFv0AgIvtaFvWI/tVW+Ez2gZY7mm3zfsO/bpanBZ32Aq/zacBlYhG6
         8bUzNz2BvrW4v3rb3iq/l8f6ouqvyn24pdFzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=G8qDX+XcsxEaa8MLmjStQoPhHHziZx6jCTMmW6iBy2axFcT95DxUF2vZjRf4SImJKr
         Hs6joANmiDvpc63d43Tpq0uperdXlqqpKtzAz5yPka9XgY+v4MEXSqjxvGOBmK1sp4L+
         y/iGt24JoQoP3eC+BYr9oeGrrrhbsHvoRfFOA0teazYldwsCR+c0AVWURrn8he5i1FZe
         8x1YX+i6zYVg+tTiLquhJkzuRq3+B3T3dhSC4MnVA0B2y9islY/XSKc8/Y5vPb6hpsqW
         aD4hpUi2xmlCt3LSFo/4MfAmbqFgV9fpMYSmC/d26AwNRpuI9O3YmK1lV1kWLN7/LeT5
         4c9Q==
X-Gm-Message-State: AOAM531z8IGg/05v5K+l5ZtHCAuap7NIBKchUwG0Wr2rpQC7hoHbFuQI
        hG0OJDWpDTf3u7AbapYbi1S0hFYyP5M=
X-Google-Smtp-Source: ABdhPJyKzLIPijsUXI035d/6wgimrFNKTu1+sSbEkZgmtRNngQllheUh8mqAsMIvLQAVdIei41t0Yw==
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr12077725ljp.415.1592239590299;
        Mon, 15 Jun 2020 09:46:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p19sm4641367lfc.91.2020.06.15.09.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d27so5382774lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr5160341lfl.152.1592239588691;
 Mon, 15 Jun 2020 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-11-hch@lst.de>
In-Reply-To: <20200615121257.798894-11-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:46:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Subject: Re: [PATCH 10/13] integrity/ima: switch to using __kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> __kernel_read has a bunch of additional sanity checks, and this moves
> the set_fs out of non-core code.

Wel, you also seem to be removing this part:

> -       if (!(file->f_mode & FMODE_READ))
> -               return -EBADF;

which you didn't add in the previous patch that implemented __kernel_read().

It worries me that you're making these kinds of transformations where
the comments imply it's a no-op, but the actual code doesn't agree.

Especially when it's part of one large patch series and each commit
looks trivial.

This kind of series needs more care. Maybe that test isn't necessary,
but it isn't obvious, and I really don't like how you completely
glossed over totally changing what the code did.

               Linus
