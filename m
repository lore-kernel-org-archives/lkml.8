Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DACC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128BE206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GE6hZSHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgC2DlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:41:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40031 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgC2DlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 23:41:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so6887939pgj.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 20:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xLRXSwctrN+g/A7faUz4KygmUCYEecXvInTS5xTJybg=;
        b=GE6hZSHaGhtYNUiDIYQc24xmmpser2aGHJcMvGkJ6HBrCCg/O9Nex79+mAj1xTOUi2
         4bjKaOF0N6hVFGQYuI2t6btWGfOONQW/aSMwlG7xtRBQIkx0wCa8e1Bqbm7bJ9qO6RYQ
         o/Y15aKSs1ZBmk0mexWFqaU/Cqw1Rx+Xg/Lf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xLRXSwctrN+g/A7faUz4KygmUCYEecXvInTS5xTJybg=;
        b=jxVlDTyezzhPnTYjfgTUcbcH3v2B7ungoOPb40QDJRL800eSeXKm6ylGMwXG6wHxR2
         5ttLwgzH5Y1JZq+J2VT7LByxr4OkiN2TS1uRB3N41avfM9O5S/tD1F3/39mOKpqqqmdM
         EL2BKxDZOZxTosAknysewzfv2RsGetyxOFSEVg6ogekUn6GSuYNNT54p6BAtzcRFZmKK
         PMLgLSBEvpadR1O8Hjdr3lrmRmBB8KyOoq03cYv6wiMYailziNPdEPzDA/sK9DQKuQzN
         ew42uWO06TWLsXNiSJlYvFjWQ339tFdgbKoOavSZziAQWVfJaJ+UvWRQtnuA4xKstJwr
         PEMQ==
X-Gm-Message-State: ANhLgQ2DR8o/wcH4Ixl03z6y43uHm7ku6V+Fc6ItGNmZdRDsrJe0Ojuu
        EkugoljDwk078MCMM7qVGGURvXunEbY=
X-Google-Smtp-Source: ADFU+vsXRF1EEVHi21Y2taSz4pRkgd6xKBQsLo3PoI/NeYKg+C1e5+ty+LU4ATMEluQcbxmCnUw6ng==
X-Received: by 2002:aa7:8f3a:: with SMTP id y26mr6776914pfr.180.1585453262206;
        Sat, 28 Mar 2020 20:41:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm5733960pfi.192.2020.03.28.20.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 20:41:01 -0700 (PDT)
Date:   Sat, 28 Mar 2020 20:41:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] x86/speculation: Allow overriding seccomp speculation
 disable
Message-ID: <202003282036.B15608F@keescook>
References: <20200312231222.81861-1-andi@firstfloor.org>
 <87sgi1rcje.fsf@nanos.tec.linutronix.de>
 <202003211916.8078081E0@keescook>
 <20200326141046.giyacwh46bfcbvjy@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326141046.giyacwh46bfcbvjy@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:10:47AM -0700, Andi Kleen wrote:
> SECCOMP_FILTER_FLAG_SPEC_ALLOW doesn't completely solve the problem because
> it enables everything, including cross process defenses, like Spectre.

Fair point. It is a much bigger hammer that I was considering.

> I'm not aware of anything else that is not a browser that would rely on the
> seccomp heuristic. Are you?

My memory was that a bunch of container folks were glad to have it for
their workloads. But I'd agree, between browsers and containers, the
lifetime is a bit shorter. (Though what about browsers in cars, hmpf.)

> Anyways back to the opt-in:
> 
> Anyways one way to keep your design goals would be to split the SECCOMP
> flags into flags for SSBD and SPECTRE. Then at least the web browser
> could reenable it

How about relaxing the SSBD side of the "AUTO" setting? I've run out of
time today to go look and see if that's even possible, or if it's bolted
together like SECCOMP_FILTER_FLAG_SPEC_ALLOW is...

-- 
Kees Cook
