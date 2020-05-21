Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAEDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE03F20709
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQODjFoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgEUDYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgEUDYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:24:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D980C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:24:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so2458613pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWnBjl1zYC8g8arTkDhsLL1NSSPTMEKdZHG0NVZD9M8=;
        b=dQODjFoCNsXPgZtIsjjHamdC4Pu+mSJd0GckTyPx551zr98aODM5dJFMdkhXgPjklf
         VYPAt85gs5oCBBSY8ECg8cFn31wUYDRLAAh9PNMfsCMF8a+/KTkDsHPt9m0Jc9PtxSpU
         8wZgJVSDe5kxAm3oAtQuqWMfKgxPEZGlO2rzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWnBjl1zYC8g8arTkDhsLL1NSSPTMEKdZHG0NVZD9M8=;
        b=mKu8fCIBXxiUDKVyHq6fCfvy4cyeWcH5164/ixOnWFwAYmfBJPaHGaUxL2TS89euiI
         ybSpODVqwy2QKi1QTgmdAbGy5B2gd47TqorT8nDVV7BG5nfvkN00XZAktZQRwQsqC2EI
         WvX3fa371XfrrhRQh9+tTr+RLq+BE4Ydp1NAOFuNTI0sAzxJeFNZwhPv+gxkh0NeRydv
         NuhjSdd4cwlYSbNFjZiNKpZYfGFvqkajBoLfjNRIZTV6ChbN1O+UMCrPIpzypBMQm3OW
         SDAUw/iWsgvDejWXFqbhD0e1BgeHGGmf2Tx3p+ycUd++j1yC/yuqNwcID80fU9qRKY98
         qTsw==
X-Gm-Message-State: AOAM5320dDEtA9h1KGJ1kJ6w1b+H74eJtO+j2UKpvg2pGcPApIN7cAVp
        ogwFjHke/vXR1mQZoAkS77x36ssqZS9WDA==
X-Google-Smtp-Source: ABdhPJwEXKl6A+KQbb5Fp68HNAuocmXXpqB85QaVdfl5nI9EFTDUjgRqSfp1CPCQYOESq1iPuYQ3Xw==
X-Received: by 2002:a63:f242:: with SMTP id d2mr7158481pgk.212.1590031458617;
        Wed, 20 May 2020 20:24:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s206sm3325954pfc.31.2020.05.20.20.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 20:24:16 -0700 (PDT)
Date:   Wed, 20 May 2020 20:24:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
Message-ID: <202005202022.588918E61@keescook>
References: <20200518221904.GA22274@embeddedor>
 <202005181529.C0CB448FBB@keescook>
 <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:52:21PM -0500, Li Yang wrote:
> On Mon, May 18, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
> > Hm, looking at this code, I see a few other things that need to be
> > fixed:
> >
> > 1) drivers/tty/serial/ucc_uart.c does not do a be32_to_cpu() conversion
> >    on the length test (understandably, a little-endian system has never run
> >    this code since it's ppc specific), but it's still wrong:
> >
> >         if (firmware->header.length != fw->size) {
> >
> >    compare to the firmware loader:
> >
> >         length = be32_to_cpu(hdr->length);
> >
> > 2) drivers/soc/fsl/qe/qe.c does not perform bounds checking on the
> >    per-microcode offsets, so the uploader might send data outside the
> >    firmware buffer. Perhaps:
> 
> We do validate the CRC for each microcode, it is unlikely the CRC
> check can pass if the offset or length is not correct.  But you are
> probably right that it will be safer to check the boundary and fail

Right, but a malicious firmware file could still match CRC but trick the
kernel code.

> quicker before we actually start the CRC check.  Will you come up with
> a formal patch or you want us to deal with it?

It sounds like Gustavo will be sending one, though I don't think either
of us have the hardware to test it with, so if you could do that part,
that would be great! :)

-- 
Kees Cook
