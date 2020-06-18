Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1810C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0852207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO1D6wC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgFRTGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgFRTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:06:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E350C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:06:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so3322888pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pn8auUjHKcQTwjIRYtErKdN45ftSs5d94rtNVEKBPVk=;
        b=OO1D6wC1GDI98hxs8P9LrWIjUtdriAI1LmZvZwyjbYMUmEBDkLKTLfPo/GAIzWbAkt
         Pj1uhUGUCWCJBR3MNKVGhlaKsOPPZ1Ltm4lIWmMxRI+eJNSbGd9OuNpruk8kCnFB3G1n
         nyEETZqWCf3GP2aFiqwNAgfGoWCp4YIQwTfNFxJ0oHOuvo/QGOvITgK5JHhEQI/b7BDq
         a1D5hpma/qIj81ufFQntdZYAFqeWehGdOHPoiCmTEKVFFw/OEi9OeP8k+uu6HIWLuZr4
         Awn8VU5lBj5FqeBPrZ599JUFcbmjmG4Om7z8cGDkU+xciPtnsy5laPK/3Nw9PdsGTf1e
         fYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pn8auUjHKcQTwjIRYtErKdN45ftSs5d94rtNVEKBPVk=;
        b=fwvvHRpH8w6ouEqRMejhNGCWaQj4SSLz660mh/8oErriZ/9AntNtmtZSyS7bfcdZPm
         dYF+AUD1LPDqqpMdq9wJNfe39tOWSkMJeXiKbIZ/ozxW3esMIB4f3BCSaIZgyG+KSPDM
         p30zNjygA9lbhgFsbcHyBMOWVOkkFqv3B8A3IiiQAZYE7cLzQiIv8vQyQkxZyrFtsjYx
         HTk1PctqWg3HttDWZjWyLMG5Eh6wbeMIJK1BvKf/eQQdtt0N3Iajltx5CxHNohy4RImu
         R6AkHVODFJrQuQwWLGkP7Q0aqlWXZz3udVJA+FSNqYEwdBEnJQ8u+LrcuF6zsn4OCwlU
         ueYg==
X-Gm-Message-State: AOAM533YJw/7HaSciiarv4pSMb2kaUEHliVFDAETOTulyQkpgGeoZZd6
        NBLDO60FlGSYijmRlPPMoMQ=
X-Google-Smtp-Source: ABdhPJw6rTs2bGti1tEFSo17L3iq0JeqzxzZ5P9M1vy8U6/gjuGqNM8CuPFMQLrVqT+OESHWVCgRwQ==
X-Received: by 2002:aa7:9384:: with SMTP id t4mr4755401pfe.162.1592507198830;
        Thu, 18 Jun 2020 12:06:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 12sm3664885pfb.3.2020.06.18.12.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 12:06:38 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:06:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200618190637.GB217485@roeck-us.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net>
 <20200618175733.GA26895@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618175733.GA26895@home.goodmis.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:57:33PM -0400, Steven Rostedt wrote:
> On Tue, Jun 09, 2020 at 02:25:09PM -0700, Guenter Roeck wrote:
> > > 
> > > Still occurring on Linus' tree.  This needs to be fixed.  (And not by removing
> > > support for randstruct; that's not a "fix"...)
> > > 
> > 
> > How about the hack below ?
> 
> My test suite failed due to this bug (on my allmodconfig test).
> 
> Your hack appears to fix it. I've applied it to my "fixes" patches applied to
> my test suite before building my kernels.
> 
Ah, I would have hoped that this was by now fixed upstream. Apparently that
is not the case. Guess Linus is using an old version of gcc (or maybe clang)
for his test builds, and everyone doing test builds is now using this or a
similar hack. For my part, I disabled CONFIG_GCC_PLUGIN_RANDSTRUCT.

Guenter
