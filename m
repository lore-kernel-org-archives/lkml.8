Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96184C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCB2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZeSu88rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHTBo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:44:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B761C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:44:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r19so276491qvw.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDDnMK4h5MqrABrJlp8QSE24w6CUN2EJwzH9w5HlgTk=;
        b=ZeSu88rRmOVOFsKZMIkPfFK1lon84nKwM22J7Ci5blJIcuMjhxhrMDfKDzBcrLBObg
         5G+zNb+8HK6+UMRTBH3e39+9trLZP1sqNDsrdsF9FWhPA2n3u0NDiT2w+MKPsqhjpGqw
         UKSpG9UUaDuSjGOSkr8wT6f94tNYtp/cX4SR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDDnMK4h5MqrABrJlp8QSE24w6CUN2EJwzH9w5HlgTk=;
        b=QxbjgjgaroHXJs+vLhUOd0gLZd6Sa/50VkKN0lC7AM9GfQoD7SWHxlvPS9rJ0/r+m6
         MdhZyGVaEmEa6ivCRp7VePwuQnDFRJXIGcCWTGM/oVt/Ve2X/yut+MASPp4bGYNdCmau
         /uwga1UOAcnqDVmZVtlS/NVDu0jv/lQ5hlvGHLclNKstfRZLLy+J+U0WbMN7acbJ54lu
         5cJdKoW8pYDYTtzEpZXhGpCWs0UP3VkX8BjeoKKfMgjDsqRlL53S2sscpji94exMF4Xo
         2ougk+O08Ik38pfLBJNQytaTqOBWwg9vucuNiwOOOqNr8cikPMAi8YFdiI52PrgSBxx5
         m3nw==
X-Gm-Message-State: AOAM531m5PDDD/fOO3dAJ73IbU9Cj1yhfLj2WOzOelf9y+ebFL0pATz4
        sYhDb/1jaTnWWR4rWZET9oIQ5k7rUDWlYw==
X-Google-Smtp-Source: ABdhPJwt5aP3+ayenQU/okMYJ9OjwFREU3xfoo4bR+bMtRQYEz3Nsyy7lR1q0QIN7W+d+HgNIZeE9w==
X-Received: by 2002:a0c:da07:: with SMTP id x7mr1124350qvj.66.1597887897077;
        Wed, 19 Aug 2020 18:44:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b2sm1103304qto.82.2020.08.19.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 18:44:56 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:44:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH RFC 00/12] Core-sched v6+: kernel protection and hotplug
 fixes
Message-ID: <20200820014456.GD1492280@google.com>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
 <202008191116.1A1F51186D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008191116.1A1F51186D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:26:48AM -0700, Kees Cook wrote:
> On Fri, Aug 14, 2020 at 11:18:56PM -0400, Joel Fernandes (Google) wrote:
> > This series is continuation of main core-sched v6 series [1] and adds support
> 
> - Is this really "RFC"? Seeing multiple authors implies this is looking
>   to get merged. :)

This mini series was inspired by discussions/concerns mostly by Thomas so
that's why I kept it as RFC since I thought more comments will come.

> - Is this on top of the v6 core-sched series (or instead of)? (That
>   series doesn't seem to be RFC any more either, IMO, if it's at v6.) If
>   this replaces that series, isn't this v7? I don't see the v6
>   core-sched series in -next anywhere?

Yes, it was just a continuation of that. Actually I screwed up, I should have
just posted the whole v6 again with these patches with appropriate
subject-prefix. That would prevent confusion.

> - Whatever the case, please include the series version in the "[PATCH vN ...]"
>   portion of the Subject, otherwise things like "b4" don't really know what's
>   happening.

Got it.

> Sorry for the drive-by comments, but I was really confused trying to
> understand how this fit together. :)

No problem, your comments are very valid so they are welcome :)

thanks,

 - Joel


> -- 
> Kees Cook
