Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE50C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EDA206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAtQAwvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405260AbgFYNxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:53:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E7C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:53:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so5945717wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYoZcrzGFRdaStmvr5BOkIKNL3anG7XJu45/FDtHx8o=;
        b=GAtQAwvuy/EiFCc5qUSZ+0tL5aqXdZ1mWw3DwSz5jvtGEPn5F/VAcL3C6tPmRNvSYu
         CeiI6iJ38VhkJYFbnoVSLw4+yTUmLFsbZNjQvjFwOXrDmiFi2HDtGhOPt65M6ULh2zJK
         2akP2Apxt/LB1ghunywo6Z4UI/0xy1ZwQgt3VR1bisWoV0TyGRA5yZNgf2x0bNHCrtz5
         bc0YHKwxA5W7fC0pIAQsYDuwzSIx23CYOc2dyrt+lM1rJ7GcCm0J570bVi9CP9e5xi/T
         O6LA2IDjmiD4AloydaIeRSznTgPdiFntVIMENhdmj6/ZCRD74V8mfHsZ6RSjdCoyGSlM
         M2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYoZcrzGFRdaStmvr5BOkIKNL3anG7XJu45/FDtHx8o=;
        b=P2sKEMxq28iRm9fyMRsub3Oi+KKZBLBJd0FRZf765xdV66iqzmxeamPjlwYIr4/7/w
         f+yGRrAI1RyQ55amJxrN0xaAjOfICwWzgEPtcGxw/bl+b/r1fMeZHDfZfy26zUxBFHvX
         sxnz/cJrz1zpK/FhZ6qrM60U//Wse+1htBdZn68moYK3Kz++VBaFzaF+ZTrLn+6Bj+hF
         oebQMyvs/bQcbeqjgTnDVExsPJ9HrmsCG8XRWOAgChjM0DUkFFljVIKLe1tgZskn4h1G
         V6CGSgpjwyQozIZc/4q6lbPmWKQ4vXtyFQgh7qDwfl4WwrczmgCSkacB2HwtFhkkZ2X8
         G7cw==
X-Gm-Message-State: AOAM533BPM9YJiCsjVzMhmnzLGCPdsFceurfJN9NpBgzEDiS3pa94WRi
        NbAnkOCg5BQl9tO8pclKQAklTw==
X-Google-Smtp-Source: ABdhPJxA1B3Qv8sXzELwr+4by0M3c4VykokWKkxoP4jiOzZpxvtER8sB2Q8z6vk+MxGhiFhIArT4HQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr37790780wru.27.1593093189448;
        Thu, 25 Jun 2020 06:53:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u20sm11320118wmm.15.2020.06.25.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:53:08 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:53:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix locking issues with governors
Message-ID: <20200625135305.GB242742@google.com>
References: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
 <20200625111452.GA200288@google.com>
 <CAJZ5v0gdJ2gtxjpzHCZ6C0LCZ0SYeR1LZcb=CwjrS2aa86fmdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdJ2gtxjpzHCZ6C0LCZ0SYeR1LZcb=CwjrS2aa86fmdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Jun 2020 at 15:32:43 (+0200), Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 1:14 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Hey Viresh
> >
> > On Thursday 25 Jun 2020 at 16:24:16 (+0530), Viresh Kumar wrote:
> > > The locking around governors handling isn't adequate currently. The list
> > > of governors should never be traversed without locking in place. Also we
> > > must make sure the governor isn't removed while it is still referenced
> > > by code.
> >
> > Thanks for having a look at this!
> >
> > This solves the issue for the reference to policy->last_governor, but
> > given that your patch is based on top of
> > 20200623142138.209513-3-qperret@google.com, 'default_governor' needs a
> > similar treatment I think.
> 
> So I would prefer to rebase the $subject patch from Viresh on top of
> the current mainline, apply it first and rebase the "default governor"
> series on top of it - and include the changes needed for the default
> governor handling in there.

Right, and Viresh's patch might be -stable material too? In any case,
making it standalone makes a lot of sense.

Thanks,
Quentin
