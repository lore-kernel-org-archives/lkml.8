Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C520702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3FRfqC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404321AbgFYLxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgFYLxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A6C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:53:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so5625550wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L4pFCzHJgLhT16AIpG64Yl9/rDj1/+gYvG4jvCw9F50=;
        b=n3FRfqC1licA7sUvOVNsmYWGO4K/7vUEPRhyqo4fBRqJTuRXkEEQHh7uwPCnN+FcSf
         ENydElYHJy9PUQYU9sfu1loBq5H0SIftbO5Sht4ahrm0xfMnJWRT8ci/38Brp/clygPK
         L+kiUfWAo1teGmyfYs8LGk4Be7IorgzrIWkIJkU3+o97MGk2rpkBjG0TTaRxtyGh3tTs
         EeCP+GkZCM3t1EJHFzQFkTYrnf8HsuUcHNDQc4lZ7iWF+4scXEzFr1ns/1MxaOcUwWTj
         JPmiymJ2xlffeNK125ctWiPcqf8r9RQ46JpCxIewZ2tZTAghyq1qmdPz+xuCXqYbiZRg
         gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4pFCzHJgLhT16AIpG64Yl9/rDj1/+gYvG4jvCw9F50=;
        b=pV804WnO8MtXZIDmzawRafO6JkW3GKve7Ejlul3+qkCtPKtybyESeYFTDMLRoVEuTg
         Z2Q4YFk8IsJBLoUNRFOmMkwMzDUzgUCrZBXh33nptbEx1z54yOfn0+5ZUpJEqGlZg8xE
         iUzTc6FWK7EpHT9RZS8+PqaFsmoAhnPES1k8+tvDV4/XTbdAWCLUiu20Vrtu0Zcl0owd
         iIux64l8Qn5qEYo/XT2pgg1hQ9eRORX/Kc4c1+R85+26Vc5r3Qr+SBD0yYjqIiJhHvWz
         ASev/bM1YVam6ks7+GqlwdpmUxb9axX1fLOSTS8G6Z4QsGZH0t6rk1q5nakOJpDM5ebF
         4ulw==
X-Gm-Message-State: AOAM530WuTBAQNYNVklf/uyZILydKrBwRAE/3hJp1UYX5NK9q3B/Z/ku
        O1N+tsN2IVJGrShoRlSDS5aXBg==
X-Google-Smtp-Source: ABdhPJzB3iG4QLOlxIPODy0q2tWS2+hoPSsNM/MppS52ewBi9bFqIsOWO5K4QEbJ3JGH6DNum7H2Og==
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr3196690wmt.154.1593086002391;
        Thu, 25 Jun 2020 04:53:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 104sm32104033wrl.25.2020.06.25.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:53:21 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:53:18 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200625115318.GA219598@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
 <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > This change is not right IMO. This part handles the set-policy case,
> > where there are no governors. Right now this code, for some reasons
> > unknown to me, forcefully uses the default governor set to indicate
> > the policy, which is not a great idea in my opinion TBH. This doesn't
> > and shouldn't care about governor modules and should only be looking
> > at strings instead of governor pointer.
> 
> Sounds right.
> 
> > Rafael, I even think we should remove this code completely and just
> > rely on what the driver has sent to us. Using the selected governor
> > for set policy drivers is very confusing and also we shouldn't be
> > forced to compiling any governor for the set-policy case.
> 
> Well, AFAICS the idea was to use the default governor as a kind of
> default policy proxy, but I agree that strings should be sufficient
> for that.

I agree with all the above. I'd much rather not rely on the default
governor name to populate the default policy, too, so +1 from me.

Thanks,
Quentin
