Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF34207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOvf70PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgEZQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEZQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:20:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA46C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:20:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci23so36334pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tLFWEc70kSJC3xDiyEWNVnyhuZzVWGIzcJ1Nk8rcOc0=;
        b=lOvf70PKmmBPmGfNSvXTYx9cNld/SJ4GdwXQvxyEWWWH1t24w5+WMVVyi9NbSTFCuo
         UK25Jfcc2kwV14PFFGZMUXnXGG/ZHoFAzR8a9RxeKmOFXG09X+v7nlHd/ZSRWUHPzodk
         QJfCvytXjqlRnpksslKFGoPUsAsLRdnDs5BS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLFWEc70kSJC3xDiyEWNVnyhuZzVWGIzcJ1Nk8rcOc0=;
        b=n/TgTFhRDqw39yxgvFmcQ2hWY/xIdFQRgNzYwE+6z5y7J1puLlTELuozxZBFyQj6lj
         4gzIGf4umI+84DvFATSVcPKCmNXojj99HMzL3Af380KN9KmWJkZ7ywR/PpNm5sPoV9u5
         pxpiduX8mMLUty+Bb8/nBuyBIcGnrC48AcADUAIQa+4zY65Bd7WI+Dm9z7EpqWvqk+9B
         gd5K234Cq4ivcOs3EXLFONtBBgzZt0cSsHZ59Aek5TSohLE52HLJ4+XXh4hvDiMoPLJf
         S1xuizN+zG+wbYKALGhzb3scOMcekmMxWq/qdpNTCG6iZvmXaxktPLjm71CY4b48y4dP
         gcOw==
X-Gm-Message-State: AOAM532BEaPJluy4rcz6RZKWRf/5Z+17HhkAm81ZVLixROCM2IuTH0pK
        Q6NWqO2XuK7MxT8tfamVVcLynw==
X-Google-Smtp-Source: ABdhPJxEYTpmqGrCSWR6f1rzHdEg5LhA1BVPPbzcg+Vydop3DHCm/xEy4uzlTCOqImNwTjC3mqZ4Rg==
X-Received: by 2002:a17:90a:fb96:: with SMTP id cp22mr27442990pjb.201.1590510033184;
        Tue, 26 May 2020 09:20:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b63sm46799pfg.86.2020.05.26.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:20:32 -0700 (PDT)
Date:   Tue, 26 May 2020 09:20:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] x86: Pin cr4 FSGSBASE
Message-ID: <202005260918.72DE289@keescook>
References: <20200526052848.605423-1-andi@firstfloor.org>
 <20200526065618.GC2580410@kroah.com>
 <20200526154835.GW499505@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526154835.GW499505@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:48:35AM -0700, Andi Kleen wrote:
> On Tue, May 26, 2020 at 08:56:18AM +0200, Greg KH wrote:
> > On Mon, May 25, 2020 at 10:28:48PM -0700, Andi Kleen wrote:
> > > +		if (val & X86_CR4_FSGSBASE) {
> > > +			WARN_ONCE(1, "CR4 unexpectedly set FSGSBASE!?\n");
> > 
> > What about those systems that panic-on-warn?
> 
> I assume they're ok with "panic on root hole"

Exactly. :) The pinning infrastructure is pretty small; will that just
get backported? (Also, we can probably rework the pinning to avoid the
special-casing and use a mask/value pair to notice a bit getting turned
_on_ as well...)

-- 
Kees Cook
