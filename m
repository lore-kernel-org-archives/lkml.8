Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494CC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A877924649
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG/zVHrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCABFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:05:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35765 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCABFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 20:05:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so3711888pfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 17:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6tdlRwhxnyZEWwuLH4PLixMPMWPMz9rGgac+7l9DrM=;
        b=qG/zVHrJQGVqcWQhUH7nh59uCtgBcJWotapetD92scZrDfp5NpEPnnfe1TOsEHoknF
         /Ir6XrlNTFFwhgXSIcNzWsGucYWKnceHv6HyyOjNvyf5Sg06bJqIwvwtOolxOTcvyUPC
         OO6ysqI7RQ8ilEVPW8nVryKZzsllOm3i0oMpIeUgYx9j4bpMO4HMNSpSEeSJAgNZkU20
         j/V8nT4dcADTSLORq/8tIAvKJdnIbvcXVR0SjlLBuNaikebiW6ZIxp/qFsZ+We8oUXc4
         rwqJBK24mTK1ZmlGE2o6q9Y2I942ry4uZSlMoiEMyGMk0qd9eLa7uT5I4jQ2h+JA6v88
         /obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6tdlRwhxnyZEWwuLH4PLixMPMWPMz9rGgac+7l9DrM=;
        b=UPAoawnxZVDQdnHSqC16Utl2wBHfTQGxnd7DObPNutGObJ+zEH8H27Ofe/qX0pl2YB
         kQiGIthfAfiNwJjYDAmyrvAFHqgoR6/0mp7aM98n5NucyYShvtJDWFZBptZIo4LS01Sn
         qSNcAsFwXEoPFn/L2FAsxdbgh9f7dcz9tLbWC0PxhCW7udPncY6ShOoFX+CkOpEuI0En
         AoDpwonF6pYkKiSDCrp+WoayWoYw37yd5wXkj3kmFMIbOHWQ7MZ30sM9sDYnsqHNnk21
         6z72yrhcHEDjjmX0gHY7kdt1VxhG3/znBmcV9MbIhoqBuJskq1mMxHE0ENyUPwOlKg6I
         nvqw==
X-Gm-Message-State: APjAAAUmi+4ilho+7Q7jqhk4YijHxnr8x9a8pkzOOdSqdzYgm+j5X+kv
        MIzmjI7BxbyX7r37VcOWewc=
X-Google-Smtp-Source: APXvYqwyTmRZPdHolfsz0yBlZRCOjl2fjnRsxUF/EdNeWw3zOQeDLvwAl+vLtoXYoa06mUeEpS1p7A==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr11607333pgg.129.1583024714106;
        Sat, 29 Feb 2020 17:05:14 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id w17sm15581725pfi.56.2020.02.29.17.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 17:05:13 -0800 (PST)
Date:   Sun, 1 Mar 2020 06:35:11 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200301010511.GA5195@afzalpc>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
 <20200229131553.GA4985@afzalpc>
 <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 01, 2020 at 10:11:51AM +1100, Finn Thain wrote:
> On Sat, 29 Feb 2020, afzal mohammed wrote:

> > [...] 
> > Specific to m68k, following changes has been made based on m68 family
> > ;) feedback,
> > 
> 
> None of my comments were specific to any architecture.

One thing i had in my background, but realize now that didn't express
anywhere in my mails, in essence what Geert mentioned, i.e. being
legacy code, i did not give a treatment that would have been given to
adding new code.

But m68k subthread has been a very lively one and as not many changes,
felt it was not fair from my side not to handle almost as though it is
a new code addition.

There has been conflicting opinions, so i had to take a call one way
or other, including one against what i did not feel natural, mentioned
below, please let me know if further changes are required.

> > 3. s/pr_err/pr_debug
> 
> Please just ignore my opinion on that, since it contradicts the 
> maintainer's guidance/preference.

Yes, i will be remove this change.

Regards
afzal
