Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18930C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB85A206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdnmIgR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHWBMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 21:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHWBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:12:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30200C061573;
        Sat, 22 Aug 2020 18:12:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s15so2300483qvv.7;
        Sat, 22 Aug 2020 18:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zmZAbPXam+xew8f7//a5w1zl+0kTn5vbHyjmo1sTOkI=;
        b=ZdnmIgR6dNuI2h9jgSUoq2tWe4LodrCOz4PGyapeW6D4cebozygG/76VKNMfV8mf6a
         h7siDSz5a1voUp66ZjSZGPGvZ14a7El3+qbMvpYctb8+uBRBGJZuegn3XDAx/VmzFR0d
         02HvjORoUKkeTw+LmkGwLTSIPsuDyYtd1PldnImFJcQuLUbyCSJXCMmeeU84Atmj05hc
         0LU6IUaOiMSjKs/Wf/UpYh9rE1OrlmMZa01e2IqA0Kbtr16hX/OzmYV3Ha/VegvMXNll
         nF+NzIwU+NKe3RAofISM/fPKShhFCFF2QwsVJ+IfeitS6W91yKKJNC/E57MJo8L6hkMK
         hVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmZAbPXam+xew8f7//a5w1zl+0kTn5vbHyjmo1sTOkI=;
        b=MS0atgvvYOQwGxfJrXvvP6+7f6gZt7s8HZVOxYUYnD3/6lb9YIOUs3cyv+dzCSlVeG
         EzzL/P4tAOXmmjBZuTvUNNoOMVHRQlHfWAxSLBofMD5nX+M/WizJCTxqqYRhBRTuOwYi
         Pc7MTfGnbrItNbCA5MfccusqbWNi8mF6HjjH6+jenU9l5etDLDnj20FbXqRMd9jebaZW
         rMOe5IaGafj8CUGYeZhrHAb1za1xU4QcZRuqQGbgZW7lucMb14IMPSnYzyTMYt3TkOls
         ovnlnC4kNnPjCdTBKnAkzBzjrJJ30La8D2D4GeAcHvrnQLcBA0uO7pN2qKvx2/xnOeAZ
         AO1w==
X-Gm-Message-State: AOAM5318LV5ntBf/aDO5iaN2Oi3OZEGJlfTccKsYdycIRkyqXHSSP9Xy
        xIWwAZQjlrsGHU8XbxF7YwYw+s6hW/Xj2Q==
X-Google-Smtp-Source: ABdhPJzl+pQ4MIq2n+SmdTaiIEmxPJThGf7imwgj5zNQ7dQuBHJrcbv83MuqpSHAzrghmbZbP7JY3Q==
X-Received: by 2002:ad4:510c:: with SMTP id g12mr8276191qvp.106.1598145162330;
        Sat, 22 Aug 2020 18:12:42 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w32sm7814934qtw.66.2020.08.22.18.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2020 18:12:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4A26127C0054;
        Sat, 22 Aug 2020 21:12:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 22 Aug 2020 21:12:40 -0400
X-ME-Sender: <xms:h8JBX3Ayvfh_5495Mkfj9rTEr_8Pj5vTEPkX6sMBJTJmCm7Edx0Ttg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpegsohhquhhn
    rdhfvghnghesghhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeduveekgfektddtte
    fhvdejjeekgeffkeefgedtieeufefhhfekhefgkeeukeeileenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:h8JBX9g1FctsbaFbXAVDW0rzWmEnz8_snN17xl-FEq1J3z3nUC4nGQ>
    <xmx:h8JBXylV6HAeerABv0DmNQToJA-720_3KBMmuSDJSyZoCnZxvhVMeA>
    <xmx:h8JBX5yEHiTm1lKo-a07LeVdGQ4-08vV5PrAOKLm3gqnkBUi7NJcXg>
    <xmx:iMJBXyMMpNKX1AzEhNx1LPawftlepn4YvDnEotrNF4Hr0fbSC9dn6Q>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74E0E328005D;
        Sat, 22 Aug 2020 21:12:39 -0400 (EDT)
Date:   Sun, 23 Aug 2020 09:12:37 +0800
From:   boqun.feng@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 00/19] lockdep: Support deadlock detection for recursive
 read locks
Message-ID: <20200823011237.GD79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
 <20200821195641.GV3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821195641.GV3982@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:56:41PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 07, 2020 at 03:42:19PM +0800, Boqun Feng wrote:
> > Hi Peter and Waiman,
> > 
> > As promised, this is the updated version of my previous lockdep patchset
> > for recursive read lock support. It's based on v5.8. Previous versions
> > can be found at:
> 
> OK, this all looks really nice.
> 
> I've stuck it in my locking/core branch for testing, I've had to fix a
> few minor rejects (my bad for being to slow), made a few minor edits and
> fixed that one masking thing.
> 

Thanks!

Regards,
Boqun

> It seems to boot with the selftests all green, haven't done much else
> with it yet, we'll see.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> 
> Thanks!
