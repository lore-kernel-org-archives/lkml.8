Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C328AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38CC20691
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFnSTTkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGSRfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:35:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6EC0619D2;
        Sun, 19 Jul 2020 10:35:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s189so9202584pgc.13;
        Sun, 19 Jul 2020 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1hm1sNECA9uytNSHgqhyhAHgDexMNtTL9LjjuUPhKA=;
        b=gFnSTTkwEmitje3dvvITeq7hEI2++5VrfoyF19GJEuXwliXdkWxv5vE/2nD/RUC8YS
         iumpIqMzhLYTlfbdpDqHeQxklv+ieVmmwE6Htf2XWJz121/p6/wawHhNPi5/dt0sAqCR
         bTBT0ei7JCRlgWBC0/R/Q2Vo3aXmsLrWf6KpHZTZ71PzVghQJ2NM9+frXxmXAkDyU7z2
         6gXEHWNzPbW8MwVdXkB2U+HYpju/9jAy5XfRiphp5QeHeNrCq14RxTF4tAaByrUd5rbV
         XLiG8l6BZNSWTI86/hPpsXCOrnjDAYxbNL9NOfAx9Fsa2hsr9nlgPg1BaizPUOM/AD7Q
         MKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1hm1sNECA9uytNSHgqhyhAHgDexMNtTL9LjjuUPhKA=;
        b=VdOvCAWaxDWuqCVyXRQ8V74WNWnmJ2MR9b/PUvAf0SWaQIqA73ASMDUEANkjuqWgjf
         97QLQjliFGVEYNBUaVqA9cQTGulsYkAI9DETFg0Dhm4d1Iokj0Mj6wbat9mVWawPvFq9
         aZ5pvOWo50+QpytP/tQtk9R2rRcKwjQJqm0oo6ApHRSz1L9xi5nu3DeS4uNJWUhRER1D
         +UZXZx+8lnVIJ8cU5U4VwxIRfBBo359rGHVhzHyoPPCy00SVxkDoXOYf8Vku45BWkzEY
         eWf1ziDPfOQ26cKh/QBsPHZREv/y8O6OU1K4qCV/FcNyacf6XDcy8F74DwMXfTekxM4t
         VVjQ==
X-Gm-Message-State: AOAM533GiSCmX8PM69BakB7G8cyInHMhuwtfQ8XxnVmcI7oaDrsK1fT0
        oOFloAll+DmRTO5w7SAb0h0=
X-Google-Smtp-Source: ABdhPJxB78V7wj2N+mFe4MiOdRkXpeymFq62bnozS6DmMGsrvbb9ndRJmqvs8simQbLVQ2UNJLZarQ==
X-Received: by 2002:a62:647:: with SMTP id 68mr5391597pfg.45.1595180144520;
        Sun, 19 Jul 2020 10:35:44 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id g7sm13830785pfh.210.2020.07.19.10.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 10:35:43 -0700 (PDT)
Date:   Sun, 19 Jul 2020 23:05:31 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: net: decnet: TODO Items
Message-ID: <20200719173531.GA8585@blackclown>
References: <20200717061816.GA12159@blackclown>
 <20200719100649.3719add8@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719100649.3719add8@hermes.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 10:06:49AM -0700, Stephen Hemminger wrote:
> On Fri, 17 Jul 2020 11:48:16 +0530
> Suraj Upadhyay <usuraj35@gmail.com> wrote:
> 
> > Hi Maintainers and Developers,
> > 	I am interested in the DECnet TODO list.
> > I just need a quick response whether they are worth doing or not
> > for the amount of development happening in this subsystem is extremely
> > low and I can't help but question whether I should indulge in any of
> > the listed works or not.
> > 
> > Thanks,
> > 
> > Suraj Upadhyay.
> > 
> 
> The was a push to move decnet into staging and kill it.
> But last time there were still some users.

It's understandable that it has grown obsolete now.

Thanks for your response.

Suraj Upadhyay.

