Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD27FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0E720786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgEG9rX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHRUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:08:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1902C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so10485221pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=GgEG9rX0CVa7+ePbq5nMU/CNYUi+2BFK3ShbA/WmzDeaqQmywgCc13epPFdB6FGzJj
         PvUunIk9PF/5CUEYbmg6f4sOwcmkbKu9OxYlJ6LaNwke2x+fD6sLSkFRzNClnnjeBX38
         8Rgdk2DtkxLnI2lh1JKe4qna0fjXUs9peD4gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5rgvljds/G/gY7M0g3ZdQCzMRXyD0pLsTTaDQidR0w=;
        b=DY377msuYhjKoZ6UCvRlPEOp0O+bqtUt77lqvu5rmuOMYH+TCxT5Rdv1643RoLFMIL
         tqi/SPfuFGz3CRyq883llsLymNE2L49HN6aQ2SHo6ZX/4VyDnUH1GnYzNsXxVWhaC7EH
         GW17jN58uP4nGcddJc6ubERIqnwaV7qj13FoTer86XC0++UU2Fo+lNpYoZDsV2+AYiC6
         X9HdOYLIjOFHFEROM0W37/xY+LTleYeUGzWVhvppRBag67RKTkGJ+I/eqvr9le8LsHzV
         LWIZc9BOaj60FRmri/w/svDFwFcKfhPdAkVbZMuUf9/SFkSQI3c5TGsyzl2y3a77vX/g
         H7iQ==
X-Gm-Message-State: AOAM532kypy/x8ZAHJ8VS7sfF2y2K3Iy/HKNQ5upfeyChNZcb3xMjnlM
        ymqkcnmCAT9BYzl4vuLqxPOz7A==
X-Google-Smtp-Source: ABdhPJyBLGaxMiD9h5m7lNfe0Fp88P8FDv0Rv1bI+H6lZvwzTGY3m5NIOU4EVZdC+BdDYxt8ElPefQ==
X-Received: by 2002:a62:aa05:: with SMTP id e5mr16597138pff.159.1597781310313;
        Tue, 18 Aug 2020 13:08:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m62sm738843pje.18.2020.08.18.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:08:29 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181308.A4A6674@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
 <202008181244.BBDA7DAB@keescook>
 <20200818195539.GB32691@lst.de>
 <202008181258.CEC4B8B3@keescook>
 <20200818200016.GA681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818200016.GA681@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:00:16PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:59:05PM -0700, Kees Cook wrote:
> > > I didn't see a problem bisecting, do you have something particular in
> > > mind?
> > 
> > Oh, I misunderstood this patch to be a fix for compilation. Is this just
> > a correctness fix?
> 
> It prepares for using the definition from assembly, which is done in
> the next patch.

Ah! Okay; thanks.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
