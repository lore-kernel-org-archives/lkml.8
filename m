Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D69C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE72C20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIiw6gt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391310AbgFYWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390431AbgFYWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:01:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46446C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:01:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so3674394pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rDFk2OWmiIBPponEif6b99uhsXlzec3IL7liMlZkHmg=;
        b=KIiw6gt6JU+4joSDvP4F/LBtxnJjqe8krk9mLT+GwJhD0kCC7KOsa41NFZgdlzsSij
         3Be2/qJ9N5uTrkC0AMCct5k8b4puFLxS0qNyV30+mJmly8C8Dxec8VpvKusTwGaPR22O
         vlnk0G0JSKE1ZA+01R8vs0edSEJf5TBN22cCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDFk2OWmiIBPponEif6b99uhsXlzec3IL7liMlZkHmg=;
        b=RJdtM/9nvJQjVNxmZ6p8g4BmCKADg48MkvmmhuP923orMxL7zboJWD1+RZAISOgMyR
         E+5bxp4fGlIfoRZPPryc01X18DWp/ic6Q8Z8YaTby0h+xw3JzaYBLz/uYqn9yU8fOkrU
         UkrCTUhSwRsFrtXErbRt1slV5Cua7S7R60IAfnTP/i29ZMwnQUFNy+8TPdtW9I+lNN+R
         0aY9MYs1iXSbASdQMMP7gG41kxJycEgf+SerH/577gqQkOoniIoJ3XJ1A7rg7yNwSr2a
         jEgJkiyB2Tbf34Sa/Y1yGX19d9SD+56HodmodZ/IPAfO2v15GClo5zfOEO8xmpzrS6SY
         LHFg==
X-Gm-Message-State: AOAM531nN0KP+yBVFOHOq1jIx9gtjvSExwRqCa5Y9nsYGfoSaB+mS4U7
        YZGINziZP4O+UmrMLCSWGTDASA==
X-Google-Smtp-Source: ABdhPJxStbaeXykQ6tT6VGI60CM0/+o93cLnkj437jkn5ZiUaDLHitqR++5CEqw6jWFgrPEqsIMGcg==
X-Received: by 2002:a05:6a00:228b:: with SMTP id f11mr12258223pfe.71.1593122492774;
        Thu, 25 Jun 2020 15:01:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm21718055pgl.12.2020.06.25.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 15:01:31 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:01:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thorsten Glaser <tg@debian.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] process '/usr/bin/rsync' started with executable stack
Message-ID: <202006251458.91D1E27A@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam>
 <202006241238.E9CB1CE85B@keescook>
 <20200625100429.GB2571@kadam>
 <202006251253.2893D4F67@keescook>
 <Pine.BSM.4.64L.2006252115450.4838@herc.mirbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSM.4.64L.2006252115450.4838@herc.mirbsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 09:16:10PM +0000, Thorsten Glaser wrote:
> Kees Cook dixit:
> 
> >3) fix the use of trampolines in klibc
> 
> AIUI done in klibc, but post-2.0.7

Ah-ha, I see it. Ben got it fixed in Feb. :)

https://git.kernel.org/pub/scm/libs/klibc/klibc.git/commit/?id=9d8d648e604026b32cad00a84ed6c29cbd157641

I don't see it in Debian? I remain confused, but there's hope!
https://salsa.debian.org/kernel-team/klibc/-/commits/master

-- 
Kees Cook
